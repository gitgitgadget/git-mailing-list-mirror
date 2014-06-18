From: Jeff King <peff@peff.net>
Subject: [PATCH 04/16] refactor skip_prefix to return a boolean
Date: Wed, 18 Jun 2014 15:44:19 -0400
Message-ID: <20140618194417.GD22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLmU-0008ET-Dg
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbaFRToW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:44:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:46940 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754256AbaFRToV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:44:21 -0400
Received: (qmail 30004 invoked by uid 102); 18 Jun 2014 19:44:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:44:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:44:19 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252036>

The skip_prefix function returns a pointer to the content
past the prefix, or NULL if the prefix was not found. While
this is nice and simple, in practice it makes it hard to use
for two reasons:

  1. When you want to conditionally skip or keep the string
     as-is, you have to introduce a second temporary
     variable. For example:

       tmp = skip_prefix(buf, "foo");
       if (tmp)
	       buf = tmp;

  2. It is verbose to check the outcome in a conditional, as
     you need extra parentheses to silence compiler
     warnings. For example:

       if ((cp = skip_prefix(buf, "foo"))
	       /* do something with cp */

Both of these make it harder to use for long if-chains, and
we tend to use starts_with instead. However, the first line
of "do something" is often to then skip forward in buf past
the prefix, either using a magic constant or with an extra
strlen (which is generally computed at compile time, but
means we are repeating ourselves).

This patch refactors skip_prefix to return a simple boolean,
and to provide the pointer value as an out-parameter. If the
prefix is not found, the out-parameter is untouched. This
lets you write:

  if (skip_prefix(arg, "foo ", &arg))
	  do_foo(arg);
  else if (skip_prefix(arg, "bar ", &arg))
	  do_bar(arg);

Signed-off-by: Jeff King <peff@peff.net>
---
The diffstat is misleading. We actually save lines, except that I added
documentation for the function. :)

 advice.c                   |  5 ++++-
 branch.c                   |  4 ++--
 builtin/branch.c           |  6 +++---
 builtin/clone.c            | 11 +++++++----
 builtin/commit.c           |  5 ++---
 builtin/fmt-merge-msg.c    |  2 +-
 builtin/push.c             |  7 +++----
 builtin/remote.c           |  4 +---
 column.c                   |  5 +++--
 commit.c                   |  6 ++----
 config.c                   |  3 +--
 credential-cache--daemon.c |  6 ++----
 credential.c               |  3 +--
 fsck.c                     | 14 +++++---------
 git-compat-util.h          | 26 ++++++++++++++++++++++----
 parse-options.c            | 16 +++++++++-------
 transport.c                |  4 +++-
 urlmatch.c                 |  3 +--
 18 files changed, 72 insertions(+), 58 deletions(-)

diff --git a/advice.c b/advice.c
index c50ebdf..9b42033 100644
--- a/advice.c
+++ b/advice.c
@@ -61,9 +61,12 @@ void advise(const char *advice, ...)
 
 int git_default_advice_config(const char *var, const char *value)
 {
-	const char *k = skip_prefix(var, "advice.");
+	const char *k;
 	int i;
 
+	if (!skip_prefix(var, "advice.", &k))
+		return 0;
+
 	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
 		if (strcmp(k, advice_config[i].name))
 			continue;
diff --git a/branch.c b/branch.c
index 660097b..46e8aa8 100644
--- a/branch.c
+++ b/branch.c
@@ -50,11 +50,11 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = skip_prefix(remote, "refs/heads/");
+	const char *shortname = NULL;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-	if (shortname
+	if (skip_prefix(remote, "refs/heads/", &shortname)
 	    && !strcmp(local, shortname)
 	    && !origin) {
 		warning(_("Not setting branch %s as its own upstream."),
diff --git a/builtin/branch.c b/builtin/branch.c
index 652b1d2..0591b22 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -294,13 +294,13 @@ static char *resolve_symref(const char *src, const char *prefix)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *dst, *cp;
+	const char *dst;
 
 	dst = resolve_ref_unsafe(src, sha1, 0, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
-	if (prefix && (cp = skip_prefix(dst, prefix)))
-		dst = cp;
+	if (prefix)
+		skip_prefix(dst, prefix, &dst);
 	return xstrdup(dst);
 }
 
diff --git a/builtin/clone.c b/builtin/clone.c
index b12989d..a5b2d9d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -584,11 +584,11 @@ static void update_remote_refs(const struct ref *refs,
 static void update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
-	if (our && starts_with(our->name, "refs/heads/")) {
+	const char *head;
+	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
-			const char *head = skip_prefix(our->name, "refs/heads/");
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0,
 				   UPDATE_REFS_DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
@@ -703,9 +703,12 @@ static void write_refspec_config(const char* src_ref_prefix,
 					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
 						branch_top->buf, option_branch);
 			} else if (remote_head_points_at) {
+				const char *head = remote_head_points_at->name;
+				if (!skip_prefix(head, "refs/heads/", &head))
+					die("BUG: remote HEAD points at non-head?");
+
 				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
-						branch_top->buf,
-						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+						branch_top->buf, head);
 			}
 			/*
 			 * otherwise, the next "git fetch" will
diff --git a/builtin/commit.c b/builtin/commit.c
index 5e2221c..ec75341 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1020,7 +1020,7 @@ static int message_is_empty(struct strbuf *sb)
 static int template_untouched(struct strbuf *sb)
 {
 	struct strbuf tmpl = STRBUF_INIT;
-	char *start;
+	const char *start;
 
 	if (cleanup_mode == CLEANUP_NONE && sb->len)
 		return 0;
@@ -1029,8 +1029,7 @@ static int template_untouched(struct strbuf *sb)
 		return 0;
 
 	stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
-	start = (char *)skip_prefix(sb->buf, tmpl.buf);
-	if (!start)
+	if (!skip_prefix(sb->buf, tmpl.buf, &start))
 		start = sb->buf;
 	strbuf_release(&tmpl);
 	return rest_is_empty(sb, start - sb->buf);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 72378e6..3c19241 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -297,7 +297,7 @@ static void credit_people(struct strbuf *out,
 	if (!them->nr ||
 	    (them->nr == 1 &&
 	     me &&
-	     (me = skip_prefix(me, them->items->string)) != NULL &&
+	     skip_prefix(me, them->items->string, &me) &&
 	     starts_with(me, " <")))
 		return;
 	strbuf_addf(out, "\n%c %s ", comment_line_char, label);
diff --git a/builtin/push.c b/builtin/push.c
index f8dfea4..f50e3d5 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -127,11 +127,10 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	 * them the big ugly fully qualified ref.
 	 */
 	const char *advice_maybe = "";
-	const char *short_upstream =
-		skip_prefix(branch->merge[0]->src, "refs/heads/");
+	const char *short_upstream = branch->merge[0]->src;
+
+	skip_prefix(short_upstream, "refs/heads/", &short_upstream);
 
-	if (!short_upstream)
-		short_upstream = branch->merge[0]->src;
 	/*
 	 * Don't show advice for people who explicitly set
 	 * push.default.
diff --git a/builtin/remote.c b/builtin/remote.c
index c9102e8..a8efe3d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -250,9 +250,7 @@ static struct string_list branch_list;
 
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
-	const char *abbrev = skip_prefix(name, prefix);
-	if (abbrev)
-		return abbrev;
+	skip_prefix(name, prefix, &name);
 	return name;
 }
 #define abbrev_branch(name) abbrev_ref((name), "refs/heads/")
diff --git a/column.c b/column.c
index 1a468de..ca878bc 100644
--- a/column.c
+++ b/column.c
@@ -336,8 +336,9 @@ static int column_config(const char *var, const char *value,
 int git_column_config(const char *var, const char *value,
 		      const char *command, unsigned int *colopts)
 {
-	const char *it = skip_prefix(var, "column.");
-	if (!it)
+	const char *it;
+
+	if (!skip_prefix(var, "column.", &it))
 		return 0;
 
 	if (!strcmp(it, "ui"))
diff --git a/commit.c b/commit.c
index 881be3b..dfc0eb0 100644
--- a/commit.c
+++ b/commit.c
@@ -556,8 +556,7 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		ident_line = skip_prefix(buf, "author ");
-		if (!ident_line) {
+		if (!skip_prefix(buf, "author ", &ident_line)) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
@@ -1183,8 +1182,7 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
-		if (!found) {
+		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
diff --git a/config.c b/config.c
index a1aef1c..ba882a1 100644
--- a/config.c
+++ b/config.c
@@ -138,8 +138,7 @@ int git_config_include(const char *var, const char *value, void *data)
 	if (ret < 0)
 		return ret;
 
-	type = skip_prefix(var, "include.");
-	if (!type)
+	if (!skip_prefix(var, "include.", &type))
 		return ret;
 
 	if (!strcmp(type, "path"))
diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index 390f194..3b370ca 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -109,14 +109,12 @@ static int read_request(FILE *fh, struct credential *c,
 	const char *p;
 
 	strbuf_getline(&item, fh, '\n');
-	p = skip_prefix(item.buf, "action=");
-	if (!p)
+	if (!skip_prefix(item.buf, "action=", &p))
 		return error("client sent bogus action line: %s", item.buf);
 	strbuf_addstr(action, p);
 
 	strbuf_getline(&item, fh, '\n');
-	p = skip_prefix(item.buf, "timeout=");
-	if (!p)
+	if (!skip_prefix(item.buf, "timeout=", &p))
 		return error("client sent bogus timeout line: %s", item.buf);
 	*timeout = atoi(p);
 
diff --git a/credential.c b/credential.c
index e54753c..4d79d32 100644
--- a/credential.c
+++ b/credential.c
@@ -40,8 +40,7 @@ static int credential_config_callback(const char *var, const char *value,
 	struct credential *c = data;
 	const char *key, *dot;
 
-	key = skip_prefix(var, "credential.");
-	if (!key)
+	if (!skip_prefix(var, "credential.", &key))
 		return 0;
 
 	if (!value)
diff --git a/fsck.c b/fsck.c
index abed62b..bdbea2b 100644
--- a/fsck.c
+++ b/fsck.c
@@ -278,20 +278,18 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 
 static int fsck_commit(struct commit *commit, fsck_error error_func)
 {
-	const char *buffer = commit->buffer, *tmp;
+	const char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	int parents = 0;
 	int err;
 
-	buffer = skip_prefix(buffer, "tree ");
-	if (!buffer)
+	if (!skip_prefix(buffer, "tree ", &buffer))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
 		return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
 	buffer += 41;
-	while ((tmp = skip_prefix(buffer, "parent "))) {
-		buffer = tmp;
+	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
 		buffer += 41;
@@ -318,14 +316,12 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
 		if (p || parents)
 			return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
 	}
-	buffer = skip_prefix(buffer, "author ");
-	if (!buffer)
+	if (!skip_prefix(buffer, "author ", &buffer))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
 		return err;
-	buffer = skip_prefix(buffer, "committer ");
-	if (!buffer)
+	if (!skip_prefix(buffer, "committer ", &buffer))
 		return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, error_func);
 	if (err)
diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..556c839 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -349,13 +349,31 @@ extern void set_die_is_recursing_routine(int (*routine)(void));
 extern int starts_with(const char *str, const char *prefix);
 extern int ends_with(const char *str, const char *suffix);
 
-static inline const char *skip_prefix(const char *str, const char *prefix)
+/*
+ * If "str" begins with "prefix", return 1. If out is non-NULL,
+ * it it set to str + strlen(prefix) (i.e., the prefix is skipped).
+ *
+ * Otherwise, returns 0 and out is left untouched.
+ *
+ * Examples:
+ *
+ *   [extract branch name, fail if not a branch]
+ *   if (!skip_prefix(ref, "refs/heads/", &branch)
+ *	return -1;
+ *
+ *   [skip prefix if present, otherwise use whole string]
+ *   skip_prefix(name, "refs/heads/", &name);
+ */
+static inline int skip_prefix(const char *str, const char *prefix,
+			      const char **out)
 {
 	do {
-		if (!*prefix)
-			return str;
+		if (!*prefix) {
+			*out = str;
+			return 1;
+		}
 	} while (*str++ == *prefix++);
-	return NULL;
+	return 0;
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
diff --git a/parse-options.c b/parse-options.c
index b536896..e7dafa8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -231,7 +231,8 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 			continue;
 
 again:
-		rest = skip_prefix(arg, long_name);
+		if (!skip_prefix(arg, long_name, &rest))
+			rest = NULL;
 		if (options->type == OPTION_ARGUMENT) {
 			if (!rest)
 				continue;
@@ -280,12 +281,13 @@ is_abbreviated:
 				continue;
 			}
 			flags |= OPT_UNSET;
-			rest = skip_prefix(arg + 3, long_name);
-			/* abbreviated and negated? */
-			if (!rest && starts_with(long_name, arg + 3))
-				goto is_abbreviated;
-			if (!rest)
-				continue;
+			if (!skip_prefix(arg + 3, long_name, &rest)) {
+				/* abbreviated and negated? */
+				if (starts_with(long_name, arg + 3))
+					goto is_abbreviated;
+				else
+					continue;
+			}
 		}
 		if (*rest) {
 			if (*rest != '=')
diff --git a/transport.c b/transport.c
index 325f03e..59c9727 100644
--- a/transport.c
+++ b/transport.c
@@ -192,7 +192,9 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 
 static const char *rsync_url(const char *url)
 {
-	return !starts_with(url, "rsync://") ? skip_prefix(url, "rsync:") : url;
+	if (!starts_with(url, "rsync://"))
+		skip_prefix(url, "rsync:", &url);
+	return url;
 }
 
 static struct ref *get_refs_via_rsync(struct transport *transport, int for_push)
diff --git a/urlmatch.c b/urlmatch.c
index ec87cba..3d4c54b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -483,8 +483,7 @@ int urlmatch_config_entry(const char *var, const char *value, void *cb)
 	int user_matched = 0;
 	int retval;
 
-	key = skip_prefix(var, collect->section);
-	if (!key || *(key++) != '.') {
+	if (!skip_prefix(var, collect->section, &key) || *(key++) != '.') {
 		if (collect->cascade_fn)
 			return collect->cascade_fn(var, value, cb);
 		return 0; /* not interested */
-- 
2.0.0.566.gfe3e6b2
