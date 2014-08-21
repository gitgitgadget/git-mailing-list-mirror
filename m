From: Jeff King <peff@peff.net>
Subject: [PATCH] teach fast-export an --anonymize option
Date: Thu, 21 Aug 2014 03:01:30 -0400
Message-ID: <20140821070130.GA15930@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 09:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKMNO-0003xQ-BF
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 09:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbaHUHBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 03:01:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:56028 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751207AbaHUHBc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 03:01:32 -0400
Received: (qmail 917 invoked by uid 102); 21 Aug 2014 07:01:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 02:01:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 03:01:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255597>

Sometimes users want to report a bug they experience on
their repository, but they are not at liberty to share the
contents of the repository. It would be useful if they could
produce a repository that has a similar shape to its history
and tree, but without leaking any information. This
"anonymized" repository could then be shared with developers
(assuming it still replicates the original problem).

This patch implements an "--anonymize" option to
fast-export, which generates a stream that can recreate such
a repository. Producing a single stream makes it easy for
the caller to verify that they are not leaking any useful
information. You can get an overview of what will be shared
by running a command like:

  git fast-export --anonymize --all |
  perl -pe 's/\d+/X/g' |
  sort -u |
  less

which will show every unique line we generate, modulo any
numbers (each anonymized token is assigned a number, like
"User 0", and we replace it consistently in the output).

In addition to anonymizing, this produces test cases that
are relatively small (compared to the original repository)
and fast to generate (compared to using filter-branch, or
modifying the output of fast-export yourself). Here are
numbers for git.git:

  $ time git fast-export --anonymize --all \
         --tag-of-filtered-object=drop >output
  real    0m2.883s
  user    0m2.828s
  sys     0m0.052s

  $ gzip output
  $ ls -lh output.gz | awk '{print $5}'
  2.9M

Signed-off-by: Jeff King <peff@peff.net>
---
I haven't used this for anything real yet. It was a fun exercise, and I
do think it should work in practice. I'd be curious to hear a success
report of somebody actually debugging something with this.

In theory we could anonymize in a reversible way (e.g., by encrypting
each token with a key, and then not sharing the key), but it's a lot
more complicated and I don't think it buys us much. The one thing I'd
really like is to be able to test packing on an anonymized repository,
but two objects which delta well together will not have their encrypted
contents delta (unless you use something weak like ECB mode, in which
case the contents are not really as anonymized as you would hope).

I think most interesting cases involve things like commit traversal, and
that should still work here, even with made-up contents. Some weird
cases involving trees would not work if they depend on the filenames
(e.g., things that impact sort order). We could allow finer-grained
control, like "--anonymize=commits,blobs" if somebody was OK sharing
their filenames. I did not go that far here, but it should be pretty
easy to build on top.

 Documentation/git-fast-export.txt |   6 +
 builtin/fast-export.c             | 280 ++++++++++++++++++++++++++++++++++++--
 t/t9351-fast-export-anonymize.sh  | 117 ++++++++++++++++
 3 files changed, 392 insertions(+), 11 deletions(-)
 create mode 100755 t/t9351-fast-export-anonymize.sh

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 221506b..0ec7cad 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -105,6 +105,12 @@ marks the same across runs.
 	in the commit (as opposed to just listing the files which are
 	different from the commit's first parent).
 
+--anonymize::
+	Replace all paths, blob contents, commit and tag messages,
+	names, and email addresses in the output with anonymized data,
+	while still retaining the shape of history and of the stored
+	tree.
+
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
 	be specified.
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 92b4624..acd2838 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -18,6 +18,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "remote.h"
+#include "blob.h"
 
 static const char *fast_export_usage[] = {
 	N_("git fast-export [rev-list-opts]"),
@@ -34,6 +35,7 @@ static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
 static struct refspec *refspecs;
 static int refspecs_nr;
+static int anonymize;
 
 static int parse_opt_signed_tag_mode(const struct option *opt,
 				     const char *arg, int unset)
@@ -81,6 +83,76 @@ static int has_unshown_parent(struct commit *commit)
 	return 0;
 }
 
+struct anonymized_entry {
+	struct hashmap_entry hash;
+	const char *orig;
+	size_t orig_len;
+	const char *anon;
+	size_t anon_len;
+};
+
+static int anonymized_entry_cmp(const void *va, const void *vb,
+				const void *data)
+{
+	const struct anonymized_entry *a = va, *b = vb;
+	return a->orig_len != b->orig_len ||
+		memcmp(a->orig, b->orig, a->orig_len);
+}
+
+/*
+ * Basically keep a cache of X->Y so that we can repeatedly replace
+ * the same anonymized string with another. The actual generation
+ * is farmed out to the generate function.
+ */
+static const char *anonymize_mem(struct hashmap *map,
+				 char *(*generate)(const char *, size_t *),
+				 const char *orig, size_t *len)
+{
+	struct anonymized_entry key, *ret;
+
+	if (!map->cmpfn)
+		hashmap_init(map, anonymized_entry_cmp, 0);
+
+	hashmap_entry_init(&key, memhash(orig, *len));
+	key.orig = orig;
+	key.orig_len = *len;
+	ret = hashmap_get(map, &key, NULL);
+
+	if (!ret) {
+		ret = xmalloc(sizeof(*ret));
+		hashmap_entry_init(&ret->hash, key.hash.hash);
+		ret->orig = xstrdup(orig);
+		ret->orig_len = *len;
+		ret->anon = generate(orig, len);
+		ret->anon_len = *len;
+		hashmap_put(map, ret);
+	}
+
+	*len = ret->anon_len;
+	return ret->anon;
+}
+
+/*
+ * We anonymize each component of a path individually,
+ * so that paths a/b and a/c will share a common root.
+ * The paths are cached via anonymize_mem so that repeated
+ * lookups for "a" will yield the same value.
+ */
+static void anonymize_path(struct strbuf *out, const char *path,
+			   struct hashmap *map,
+			   char *(*generate)(const char *, size_t *))
+{
+	while (*path) {
+		const char *end_of_component = strchrnul(path, '/');
+		size_t len = end_of_component - path;
+		const char *c = anonymize_mem(map, generate, path, &len);
+		strbuf_add(out, c, len);
+		path = end_of_component;
+		if (*path)
+			strbuf_addch(out, *path++);
+	}
+}
+
 /* Since intptr_t is C99, we do not use it here */
 static inline uint32_t *mark_to_ptr(uint32_t mark)
 {
@@ -119,6 +191,26 @@ static void show_progress(void)
 		printf("progress %d objects\n", counter);
 }
 
+/*
+ * Ideally we would want some transformation of the blob data here
+ * that is unreversible, but would still be the same size and have
+ * the same data relationship to other blobs (so that we get the same
+ * delta and packing behavior as the original). But the first and last
+ * requirements there are probably mutually exclusive, so let's take
+ * the easy way out for now, and just generate arbitrary content.
+ *
+ * There's no need to cache this result with anonymize_mem, since
+ * we already handle blob content caching with marks.
+ */
+static char *anonymize_blob(unsigned long *size)
+{
+	static int counter;
+	struct strbuf out = STRBUF_INIT;
+	strbuf_addf(&out, "anonymous blob %d", counter++);
+	*size = out.len;
+	return strbuf_detach(&out, NULL);
+}
+
 static void export_blob(const unsigned char *sha1)
 {
 	unsigned long size;
@@ -137,12 +229,19 @@ static void export_blob(const unsigned char *sha1)
 	if (object && object->flags & SHOWN)
 		return;
 
-	buf = read_sha1_file(sha1, &type, &size);
-	if (!buf)
-		die ("Could not read blob %s", sha1_to_hex(sha1));
-	if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
-		die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
-	object = parse_object_buffer(sha1, type, size, buf, &eaten);
+	if (anonymize) {
+		buf = anonymize_blob(&size);
+		object = (struct object *)lookup_blob(sha1);
+		eaten = 0;
+	} else {
+		buf = read_sha1_file(sha1, &type, &size);
+		if (!buf)
+			die ("Could not read blob %s", sha1_to_hex(sha1));
+		if (check_sha1_signature(sha1, buf, size, typename(type)) < 0)
+			die("sha1 mismatch in blob %s", sha1_to_hex(sha1));
+		object = parse_object_buffer(sha1, type, size, buf, &eaten);
+	}
+
 	if (!object)
 		die("Could not read blob %s", sha1_to_hex(sha1));
 
@@ -190,7 +289,7 @@ static int depth_first(const void *a_, const void *b_)
 	return (a->status == 'R') - (b->status == 'R');
 }
 
-static void print_path(const char *path)
+static void print_path_1(const char *path)
 {
 	int need_quote = quote_c_style(path, NULL, NULL, 0);
 	if (need_quote)
@@ -201,6 +300,28 @@ static void print_path(const char *path)
 		printf("%s", path);
 }
 
+static char *anonymize_path_component(const char *path, size_t *len)
+{
+	static int counter;
+	struct strbuf out = STRBUF_INIT;
+	strbuf_addf(&out, "path%d", counter++);
+	return strbuf_detach(&out, len);
+}
+
+static void print_path(const char *path)
+{
+	if (!anonymize)
+		print_path_1(path);
+	else {
+		static struct hashmap paths;
+		static struct strbuf anon = STRBUF_INIT;
+
+		anonymize_path(&anon, path, &paths, anonymize_path_component);
+		print_path_1(anon.buf);
+		strbuf_reset(&anon);
+	}
+}
+
 static void show_filemodify(struct diff_queue_struct *q,
 			    struct diff_options *options, void *data)
 {
@@ -241,7 +362,9 @@ static void show_filemodify(struct diff_queue_struct *q,
 		case DIFF_STATUS_ADDED:
 			/*
 			 * Links refer to objects in another repositories;
-			 * output the SHA-1 verbatim.
+			 * output the SHA-1 verbatim. We don't anonymize
+			 * these at all; they are not reversible and
+			 * probably not a big deal to share.
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
@@ -279,6 +402,109 @@ static const char *find_encoding(const char *begin, const char *end)
 	return bol;
 }
 
+static char *anonymize_ref_component(const char *old, size_t *len)
+{
+	static int counter;
+	struct strbuf out = STRBUF_INIT;
+	strbuf_addf(&out, "ref%d", counter++);
+	return strbuf_detach(&out, len);
+}
+
+static const char *anonymize_refname(const char *refname)
+{
+	/*
+	 * If any of these prefixes is found, we will leave it intact
+	 * so that tags remain tags and so forth. We also leave "master"
+	 * as a special case, since it does not reveal anything interesting.
+	 */
+	static const char *prefixes[] = {
+		"refs/heads/master",
+		"refs/heads/",
+		"refs/tags/",
+		"refs/remotes/",
+		"refs/"
+	};
+	static struct hashmap refs;
+	static struct strbuf anon = STRBUF_INIT;
+	int i;
+
+	strbuf_reset(&anon);
+	for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
+		if (skip_prefix(refname, prefixes[i], &refname)) {
+			strbuf_addstr(&anon, prefixes[i]);
+			break;
+		}
+	}
+
+	anonymize_path(&anon, refname, &refs, anonymize_ref_component);
+	return anon.buf;
+}
+
+/*
+ * We do not even bother to cache commit messages, as they are unlikely
+ * to be repeated verbatim, and it is not that interesting when they are.
+ */
+static char *anonymize_commit_message(const char *old)
+{
+	static int counter;
+	return xstrfmt("subject %d\n\nbody\n", counter++);
+}
+
+static struct hashmap idents;
+static char *anonymize_ident(const char *old, size_t *len)
+{
+	static int counter;
+	struct strbuf out = STRBUF_INIT;
+	strbuf_addf(&out, "User %d <user%d@example.com>", counter, counter);
+	counter++;
+	return strbuf_detach(&out, len);
+}
+
+/*
+ * Our strategy here is to anonymize the names and email addresses,
+ * but keep timestamps intact, as they influence things like traversal
+ * order (and by themselves should not be too revealing).
+ */
+static void anonymize_ident_line(const char **beg, const char **end)
+{
+	static struct strbuf buffers[] = { STRBUF_INIT, STRBUF_INIT };
+	static unsigned which_buffer;
+
+	struct strbuf *out;
+	struct ident_split split;
+	const char *end_of_header;
+
+	out = &buffers[which_buffer++];
+	which_buffer %= ARRAY_SIZE(buffers);
+	strbuf_reset(out);
+
+	/* skip "committer", "author", "tagger", etc */
+	end_of_header = strchr(*beg, ' ');
+	if (!end_of_header)
+		die("BUG: malformed line fed to anonymize_ident_line: %.*s",
+		    (int)(*end - *beg), *beg);
+	end_of_header++;
+	strbuf_add(out, *beg, end_of_header - *beg);
+
+	if (!split_ident_line(&split, end_of_header, *end - end_of_header) &&
+	    split.date_begin) {
+		const char *ident;
+		size_t len;
+
+		len = split.mail_end - split.name_begin;
+		ident = anonymize_mem(&idents, anonymize_ident,
+				      split.name_begin, &len);
+		strbuf_add(out, ident, len);
+		strbuf_addch(out, ' ');
+		strbuf_add(out, split.date_begin, split.tz_end - split.date_begin);
+	} else {
+		strbuf_addstr(out, "Malformed Ident <malformed@example.com> 0 -0000");
+	}
+
+	*beg = out->buf;
+	*end = out->buf + out->len;
+}
+
 static void handle_commit(struct commit *commit, struct rev_info *rev)
 {
 	int saved_output_format = rev->diffopt.output_format;
@@ -287,6 +513,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	const char *encoding, *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
+	const char *refname;
 	int i;
 
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
@@ -326,13 +553,22 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 		if (!S_ISGITLINK(diff_queued_diff.queue[i]->two->mode))
 			export_blob(diff_queued_diff.queue[i]->two->sha1);
 
+	refname = commit->util;
+	if (anonymize) {
+		refname = anonymize_refname(refname);
+		anonymize_ident_line(&committer, &committer_end);
+		anonymize_ident_line(&author, &author_end);
+	}
+
 	mark_next_object(&commit->object);
-	if (!is_encoding_utf8(encoding))
+	if (anonymize)
+		reencoded = anonymize_commit_message(message);
+	else if (!is_encoding_utf8(encoding))
 		reencoded = reencode_string(message, "UTF-8", encoding);
 	if (!commit->parents)
-		printf("reset %s\n", (const char*)commit->util);
+		printf("reset %s\n", refname);
 	printf("commit %s\nmark :%"PRIu32"\n%.*s\n%.*s\ndata %u\n%s",
-	       (const char *)commit->util, last_idnum,
+	       refname, last_idnum,
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer,
 	       (unsigned)(reencoded
@@ -363,6 +599,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	show_progress();
 }
 
+static char *anonymize_tag(const char *old, size_t *len)
+{
+	static int counter;
+	struct strbuf out = STRBUF_INIT;
+	strbuf_addf(&out, "tag message %d", counter++);
+	return strbuf_detach(&out, len);
+}
+
 static void handle_tail(struct object_array *commits, struct rev_info *revs)
 {
 	struct commit *commit;
@@ -419,6 +663,17 @@ static void handle_tag(const char *name, struct tag *tag)
 	} else {
 		tagger++;
 		tagger_end = strchrnul(tagger, '\n');
+		if (anonymize)
+			anonymize_ident_line(&tagger, &tagger_end);
+	}
+
+	if (anonymize) {
+		name = anonymize_refname(name);
+		if (message) {
+			static struct hashmap tags;
+			message = anonymize_mem(&tags, anonymize_tag,
+						message, &message_size);
+		}
 	}
 
 	/* handle signed tags */
@@ -584,6 +839,8 @@ static void handle_tags_and_duplicates(void)
 			handle_tag(name, (struct tag *)object);
 			break;
 		case OBJ_COMMIT:
+			if (anonymize)
+				name = anonymize_refname(name);
 			/* create refs pointing to already seen commits */
 			commit = (struct commit *)object;
 			printf("reset %s\nfrom :%d\n\n", name,
@@ -719,6 +976,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
 		OPT_STRING_LIST(0, "refspec", &refspecs_list, N_("refspec"),
 			     N_("Apply refspec to exported refs")),
+		OPT_BOOL(0, "anonymize", &anonymize, N_("anonymize output")),
 		OPT_END()
 	};
 
diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
new file mode 100755
index 0000000..f76ffe4
--- /dev/null
+++ b/t/t9351-fast-export-anonymize.sh
@@ -0,0 +1,117 @@
+#!/bin/sh
+
+test_description='basic tests for fast-export --anonymize'
+. ./test-lib.sh
+
+test_expect_success 'setup simple repo' '
+	test_commit base &&
+	test_commit foo &&
+	git checkout -b other HEAD^ &&
+	mkdir subdir &&
+	test_commit subdir/bar &&
+	test_commit subdir/xyzzy &&
+	git tag -m "annotated tag" mytag
+'
+
+test_expect_success 'export anonymized stream' '
+	git fast-export --anonymize --all >stream
+'
+
+# this also covers commit messages
+test_expect_success 'stream omits path names' '
+	! fgrep base stream &&
+	! fgrep foo stream &&
+	! fgrep subdir stream &&
+	! fgrep bar stream &&
+	! fgrep xyzzy stream
+'
+
+test_expect_success 'stream allows master as refname' '
+	fgrep master stream
+'
+
+test_expect_success 'stream omits other refnames' '
+	! fgrep other stream
+'
+
+test_expect_success 'stream omits identities' '
+	! fgrep "$GIT_COMMITTER_NAME" stream &&
+	! fgrep "$GIT_COMMITTER_EMAIL" stream &&
+	! fgrep "$GIT_AUTHOR_NAME" stream &&
+	! fgrep "$GIT_AUTHOR_EMAIL" stream
+'
+
+test_expect_success 'stream omits tag message' '
+	! fgrep "annotated tag" stream
+'
+
+# NOTE: we chdir to the new, anonymized repository
+# after this. All further tests should assume this.
+test_expect_success 'import stream to new repository' '
+	git init new &&
+	cd new &&
+	git fast-import <../stream
+'
+
+test_expect_success 'result has two branches' '
+	git for-each-ref --format="%(refname)" refs/heads >branches &&
+	test_line_count = 2 branches &&
+	other_branch=$(grep -v refs/heads/master branches)
+'
+
+test_expect_success 'repo has original shape' '
+	cat >expect <<-\EOF &&
+	> subject 3
+	> subject 2
+	< subject 1
+	- subject 0
+	EOF
+	git log --format="%m %s" --left-right --boundary \
+		master...$other_branch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'root tree has original shape' '
+	cat >expect <<-\EOF &&
+	blob
+	tree
+	EOF
+	git ls-tree $other_branch >root &&
+	cut -d" " -f2 <root >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'paths in subdir ended up in one tree' '
+	cat >expect <<-\EOF &&
+	blob
+	blob
+	EOF
+	tree=$(grep tree root | cut -f2) &&
+	git ls-tree $other_branch:$tree >tree &&
+	cut -d" " -f2 <tree >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'tag points to branch tip' '
+	git rev-parse $other_branch >expect &&
+	git for-each-ref --format="%(*objectname)" | grep . >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'idents are shared' '
+	git log --all --format="%an <%ae>" >authors &&
+	sort -u authors >unique &&
+	test_line_count = 1 unique &&
+	git log --all --format="%cn <%ce>" >committers &&
+	sort -u committers >unique &&
+	test_line_count = 1 unique &&
+	! test_cmp authors committers
+'
+
+test_expect_success 'commit timestamps are retained' '
+	git log --all --format="%ct" >timestamps &&
+	sort -u timestamps >unique &&
+	test_line_count = 4 unique
+'
+
+test_done
-- 
2.1.0.346.ga0367b9
