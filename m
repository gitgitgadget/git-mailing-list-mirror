From: Jeff King <peff@peff.net>
Subject: [PATCH 17/17] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 17:44:13 -0400
Message-ID: <20140610214412.GQ19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:44:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTqA-0008FP-BM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754111AbaFJVoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:44:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:41448 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754401AbaFJVoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:44:14 -0400
Received: (qmail 20085 invoked by uid 102); 10 Jun 2014 21:44:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:44:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:44:13 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251261>

Most callsites which use the commit buffer try to use the
cached version attached to the commit, rather than
re-reading from disk. Unfortunately, that interface provides
only a pointer to the NUL-terminated buffer, with no
indication of the original length.

For the most part, this doesn't matter. People do not put
NULs in their commit messages, and the log code is happy to
treat it all as a NUL-terminated string. However, some code
paths do care. For example, when checking signatures, we
want to be very careful that we verify all the bytes to
avoid malicious trickery.

This patch just adds an optional "size" out-pointer to
get_commit_buffer and friends. The existing callers all pass
NULL (there did not seem to be any obvious sites where we
could avoid an immediate strlen() call, though perhaps with
some further refactoring we could).

Signed-off-by: Jeff King <peff@peff.net>
---
Since v1, fixes dubious use of strbuf as pointed out by Christian.

 builtin/blame.c         | 14 ++++++++++++-
 builtin/fast-export.c   |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/index-pack.c    |  2 +-
 builtin/log.c           |  2 +-
 builtin/rev-list.c      |  2 +-
 commit.c                | 54 ++++++++++++++++++++++++++++++++-----------------
 commit.h                |  8 ++++----
 fsck.c                  |  2 +-
 log-tree.c              |  2 +-
 merge-recursive.c       |  2 +-
 notes-merge.c           |  2 +-
 object.c                |  4 ++--
 pretty.c                |  4 ++--
 sequencer.c             |  2 +-
 sha1_name.c             |  2 +-
 16 files changed, 68 insertions(+), 38 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index cde19eb..53f43ab 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2266,6 +2266,18 @@ static void append_merge_parents(struct commit_list **tail)
 }
 
 /*
+ * This isn't as simple as passing sb->buf and sb->len, because we
+ * want to transfer ownership of the buffer to the commit (so we
+ * must use detach).
+ */
+static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
+{
+	size_t len;
+	void *buf = strbuf_detach(sb, &len);
+	set_commit_buffer(c, buf, len);
+}
+
+/*
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
  */
@@ -2313,7 +2325,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		    ident, ident, path,
 		    (!contents_from ? path :
 		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
+	set_commit_buffer_from_strbuf(commit, &msg);
 
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 7ee5e08..05d161f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -289,7 +289,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev)
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	commit_buffer = get_commit_buffer(commit);
+	commit_buffer = get_commit_buffer(commit, NULL);
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
 		die ("Could not find author in commit %s",
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 01f6d59..ef8b254 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -236,7 +236,7 @@ static void record_person(int which, struct string_list *people,
 	const char *field;
 
 	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
-	buffer = get_commit_buffer(commit);
+	buffer = get_commit_buffer(commit, NULL);
 	name = strstr(buffer, field);
 	if (!name)
 		return;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 995df39..25e3e9b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -786,7 +786,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			}
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
-				detach_commit_buffer(commit);
+				detach_commit_buffer(commit, NULL);
 			}
 			obj->flags |= FLAG_CHECKED;
 		}
diff --git a/builtin/log.c b/builtin/log.c
index 2c74260..c599eac 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -919,7 +919,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 				&need_8bit_cte);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
-		const char *buf = get_commit_buffer(list[i]);
+		const char *buf = get_commit_buffer(list[i], NULL);
 		if (has_non_ascii(buf))
 			need_8bit_cte = 1;
 		unuse_commit_buffer(list[i], buf);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 3fcbf21..ff84a82 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -106,7 +106,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && get_cached_commit_buffer(commit)) {
+	if (revs->verbose_header && get_cached_commit_buffer(commit, NULL)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/commit.c b/commit.c
index e289c78..a036e18 100644
--- a/commit.c
+++ b/commit.c
@@ -245,22 +245,31 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
 
-define_commit_slab(buffer_slab, void *);
+struct commit_buffer {
+	void *buffer;
+	unsigned long size;
+};
+define_commit_slab(buffer_slab, struct commit_buffer);
 static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
 
-void set_commit_buffer(struct commit *commit, void *buffer)
+void set_commit_buffer(struct commit *commit, void *buffer, unsigned long size)
 {
-	*buffer_slab_at(&buffer_slab, commit) = buffer;
+	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	v->buffer = buffer;
+	v->size = size;
 }
 
-const void *get_cached_commit_buffer(const struct commit *commit)
+const void *get_cached_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	return *buffer_slab_at(&buffer_slab, commit);
+	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	if (sizep)
+		*sizep = v->size;
+	return v->buffer;
 }
 
-const void *get_commit_buffer(const struct commit *commit)
+const void *get_commit_buffer(const struct commit *commit, unsigned long *sizep)
 {
-	const void *ret = get_cached_commit_buffer(commit);
+	const void *ret = get_cached_commit_buffer(commit, sizep);
 	if (!ret) {
 		enum object_type type;
 		unsigned long size;
@@ -271,29 +280,38 @@ const void *get_commit_buffer(const struct commit *commit)
 		if (type != OBJ_COMMIT)
 			die("expected commit for %s, got %s",
 			    sha1_to_hex(commit->object.sha1), typename(type));
+		if (sizep)
+			*sizep = size;
 	}
 	return ret;
 }
 
 void unuse_commit_buffer(const struct commit *commit, const void *buffer)
 {
-	void *cached = *buffer_slab_at(&buffer_slab, commit);
-	if (cached != buffer)
+	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	if (v->buffer != buffer)
 		free((void *)buffer);
 }
 
 void free_commit_buffer(struct commit *commit)
 {
-	void **b = buffer_slab_at(&buffer_slab, commit);
-	free(*b);
-	*b = NULL;
+	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	free(v->buffer);
+	v->buffer = NULL;
+	v->size = 0;
 }
 
-const void *detach_commit_buffer(struct commit *commit)
+const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 {
-	void **b = buffer_slab_at(&buffer_slab, commit);
-	void *ret = *b;
-	*b = NULL;
+	struct commit_buffer *v = buffer_slab_at(&buffer_slab, commit);
+	void *ret;
+
+	ret = v->buffer;
+	if (sizep)
+		*sizep = v->size;
+
+	v->buffer = NULL;
+	v->size = 0;
 	return ret;
 }
 
@@ -374,7 +392,7 @@ int parse_commit(struct commit *item)
 	}
 	ret = parse_commit_buffer(item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		set_commit_buffer(item, buffer);
+		set_commit_buffer(item, buffer, size);
 		return 0;
 	}
 	free(buffer);
@@ -589,7 +607,7 @@ static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
 	const char *buf, *line_end, *ident_line;
-	const char *buffer = get_commit_buffer(commit);
+	const char *buffer = get_commit_buffer(commit, NULL);
 	struct ident_split ident;
 	char *date_end;
 	unsigned long date;
diff --git a/commit.h b/commit.h
index e1c2569..61559a9 100644
--- a/commit.h
+++ b/commit.h
@@ -54,20 +54,20 @@ void parse_commit_or_die(struct commit *item);
  * Associate an object buffer with the commit. The ownership of the
  * memory is handed over to the commit, and must be free()-able.
  */
-void set_commit_buffer(struct commit *, void *buffer);
+void set_commit_buffer(struct commit *, void *buffer, unsigned long size);
 
 /*
  * Get any cached object buffer associated with the commit. Returns NULL
  * if none. The resulting memory should not be freed.
  */
-const void *get_cached_commit_buffer(const struct commit *);
+const void *get_cached_commit_buffer(const struct commit *, unsigned long *size);
 
 /*
  * Get the commit's object contents, either from cache or by reading the object
  * from disk. The resulting memory should not be modified, and must be given
  * to unuse_commit_buffer when the caller is done.
  */
-const void *get_commit_buffer(const struct commit *);
+const void *get_commit_buffer(const struct commit *, unsigned long *size);
 
 /*
  * Tell the commit subsytem that we are done with a particular commit buffer.
@@ -86,7 +86,7 @@ void free_commit_buffer(struct commit *);
  * Disassociate any cached object buffer from the commit, but do not free it.
  * The buffer (or NULL, if none) is returned.
  */
-const void *detach_commit_buffer(struct commit *);
+const void *detach_commit_buffer(struct commit *, unsigned long *sizep);
 
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
diff --git a/fsck.c b/fsck.c
index 8223780..a7233c8 100644
--- a/fsck.c
+++ b/fsck.c
@@ -339,7 +339,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	const char *buffer = get_commit_buffer(commit);
+	const char *buffer = get_commit_buffer(commit, NULL);
 	int ret = fsck_commit_buffer(commit, buffer, error_func);
 	unuse_commit_buffer(commit, buffer);
 	return ret;
diff --git a/log-tree.c b/log-tree.c
index e9ef8ab..4447021 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -588,7 +588,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!get_cached_commit_buffer(commit))
+	if (!get_cached_commit_buffer(commit, NULL))
 		return;
 
 	if (opt->show_notes) {
diff --git a/merge-recursive.c b/merge-recursive.c
index 0dd6039..d38a3b2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -190,7 +190,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 			printf(_("(bad commit)\n"));
 		else {
 			const char *title;
-			const char *msg = get_commit_buffer(commit);
+			const char *msg = get_commit_buffer(commit, NULL);
 			int len = find_commit_subject(msg, &title);
 			if (len)
 				printf("%.*s\n", len, title);
diff --git a/notes-merge.c b/notes-merge.c
index e804db2..fd5fae2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -672,7 +672,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	DIR *dir;
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
-	const char *buffer = get_commit_buffer(partial_commit);
+	const char *buffer = get_commit_buffer(partial_commit, NULL);
 	const char *msg = strstr(buffer, "\n\n");
 	int baselen;
 
diff --git a/object.c b/object.c
index 67b6e35..9c31e9a 100644
--- a/object.c
+++ b/object.c
@@ -197,8 +197,8 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
-			if (!get_cached_commit_buffer(commit)) {
-				set_commit_buffer(commit, buffer);
+			if (!get_cached_commit_buffer(commit, NULL)) {
+				set_commit_buffer(commit, buffer, size);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
diff --git a/pretty.c b/pretty.c
index 8fd60cd..280d7d0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -613,7 +613,7 @@ const char *logmsg_reencode(const struct commit *commit,
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	const char *msg = get_commit_buffer(commit);
+	const char *msg = get_commit_buffer(commit, NULL);
 	char *out;
 
 	if (!output_encoding || !*output_encoding) {
@@ -642,7 +642,7 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * the cached copy from get_commit_buffer, we need to duplicate it
 		 * to avoid munging the cached copy.
 		 */
-		if (msg == get_cached_commit_buffer(commit))
+		if (msg == get_cached_commit_buffer(commit, NULL))
 			out = xstrdup(msg);
 		else
 			out = (char *)msg;
diff --git a/sequencer.c b/sequencer.c
index 5609ab3..d83f810 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -666,7 +666,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 	int subject_len;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		const char *commit_buffer = get_commit_buffer(cur->item);
+		const char *commit_buffer = get_commit_buffer(cur->item, NULL);
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
diff --git a/sha1_name.c b/sha1_name.c
index 0a65d23..c2c938c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -869,7 +869,7 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1,
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(commit->object.sha1))
 			continue;
-		buf = get_commit_buffer(commit);
+		buf = get_commit_buffer(commit, NULL);
 		p = strstr(buf, "\n\n");
 		matches = p && !regexec(&regex, p + 2, 0, NULL, 0);
 		unuse_commit_buffer(commit, buf);
-- 
2.0.0.729.g520999f
