From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/22] Change check_ref_format() to take a flags argument
Date: Thu, 15 Sep 2011 23:10:25 +0200
Message-ID: <1316121043-29367-5-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:11:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JDm-0006Fp-8Y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934975Ab1IOVLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:11:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:40067 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934951Ab1IOVLC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:11:02 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J8i-00019o-3k; Thu, 15 Sep 2011 23:06:32 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181504>

Change check_ref_format() to take a flags argument that indicates what
is acceptable in the reference name (analogous to "git
check-ref-format"'s "--allow-onelevel" and "--refspec-pattern").  This
is more convenient for callers and also fixes a failure in the test
suite (and likely elsewhere in the code) by enabling "onelevel" and
"refspec-pattern" to be allowed independently of each other.

Also rename check_ref_format() to check_refname_format() to make it
obvious that it deals with refnames rather than references themselves.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/check-ref-format.c    |   21 +---------------
 builtin/checkout.c            |    2 +-
 builtin/fetch-pack.c          |    2 +-
 builtin/receive-pack.c        |    2 +-
 builtin/replace.c             |    2 +-
 builtin/show-ref.c            |    2 +-
 builtin/tag.c                 |    4 +-
 connect.c                     |    2 +-
 environment.c                 |    2 +-
 fast-import.c                 |    7 +----
 git_remote_helpers/git/git.py |    2 +-
 notes-merge.c                 |    5 ++-
 pack-refs.c                   |    2 +-
 refs.c                        |   42 ++++++++++++++-----------------
 refs.h                        |   17 +++++++++----
 remote.c                      |   53 +++++++++++------------------------------
 sha1_name.c                   |    4 +-
 t/t1402-check-ref-format.sh   |    6 +----
 transport.c                   |   16 +++---------
 walker.c                      |    2 +-
 20 files changed, 69 insertions(+), 126 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 7295954..8f41696 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -53,9 +53,6 @@ static void refname_format_print(const char *arg)
 	printf("%s\n", refname);
 }
 
-#define REFNAME_ALLOW_ONELEVEL 1
-#define REFNAME_REFSPEC_PATTERN 2
-
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -83,24 +80,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
 
-	switch (check_ref_format(argv[i])) {
-	case CHECK_REF_FORMAT_OK:
-		break;
-	case CHECK_REF_FORMAT_ERROR:
+	if (check_refname_format(argv[i], flags))
 		return 1;
-	case CHECK_REF_FORMAT_ONELEVEL:
-		if (!(flags & REFNAME_ALLOW_ONELEVEL))
-			return 1;
-		else
-			break;
-	case CHECK_REF_FORMAT_WILDCARD:
-		if (!(flags & REFNAME_REFSPEC_PATTERN))
-			return 1;
-		else
-			break;
-	default:
-		die("internal error: unexpected value from check_ref_format()");
-	}
 
 	if (print)
 		refname_format_print(argv[i]);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3bb6525..574d2b6 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,7 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->name = arg;
 	setup_branch_path(new);
 
-	if (check_ref_format(new->path) == CHECK_REF_FORMAT_OK &&
+	if (!check_refname_format(new->path, 0) &&
 	    resolve_ref(new->path, branch_rev, 1, NULL))
 		hashcpy(rev, branch_rev);
 	else
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 412bd32..b51e478 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -544,7 +544,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5))
+		    check_refname_format(ref->name + 5, 0))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ae164da..0600efa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -356,7 +356,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_ref_format(name + 5)) {
+	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index fe3a647..517fa10 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -94,7 +94,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_ref_format(ref))
+	if (check_refname_format(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
 
 	if (!resolve_ref(ref, prev, 1, NULL))
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 45f0340..fafb6dd 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -145,7 +145,7 @@ static int exclude_existing(const char *match)
 			if (strncmp(ref, match, matchlen))
 				continue;
 		}
-		if (check_ref_format(ref)) {
+		if (check_refname_format(ref, 0)) {
 			warning("ref '%s' ignored", ref);
 			continue;
 		}
diff --git a/builtin/tag.c b/builtin/tag.c
index 667515e..48be745 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -407,12 +407,12 @@ static int parse_msg_arg(const struct option *opt, const char *arg, int unset)
 static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 {
 	if (name[0] == '-')
-		return CHECK_REF_FORMAT_ERROR;
+		return -1;
 
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
 
-	return check_ref_format(sb->buf);
+	return check_refname_format(sb->buf, 0);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
diff --git a/connect.c b/connect.c
index ee1d4b4..51990fa 100644
--- a/connect.c
+++ b/connect.c
@@ -22,7 +22,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	len -= 5;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_ref_format(name) < 0)
+	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/environment.c b/environment.c
index e96edcf..8174b70 100644
--- a/environment.c
+++ b/environment.c
@@ -106,7 +106,7 @@ static char *expand_namespace(const char *raw_namespace)
 		if (strcmp((*c)->buf, "/") != 0)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
-	if (check_ref_format(buf.buf) != CHECK_REF_FORMAT_OK)
+	if (check_refname_format(buf.buf, 0))
 		die("bad git namespace path \"%s\"", raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
diff --git a/fast-import.c b/fast-import.c
index 742e7da..f9347f5 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -722,13 +722,8 @@ static struct branch *new_branch(const char *name)
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
-	switch (check_ref_format(name)) {
-	case 0: break; /* its valid */
-	case CHECK_REF_FORMAT_ONELEVEL:
-		break; /* valid, but too few '/', allow anyway */
-	default:
+	if (check_refname_format(name, REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
-	}
 
 	b = pool_calloc(1, sizeof(struct branch));
 	b->name = pool_strdup(name);
diff --git a/git_remote_helpers/git/git.py b/git_remote_helpers/git/git.py
index a383e6c..007a1bf 100644
--- a/git_remote_helpers/git/git.py
+++ b/git_remote_helpers/git/git.py
@@ -54,7 +54,7 @@ def valid_git_ref (ref_name):
     # The following is a reimplementation of the git check-ref-format
     # command.  The rules were derived from the git check-ref-format(1)
     # manual page.  This code should be replaced by a call to
-    # check_ref_format() in the git library, when such is available.
+    # check_refname_format() in the git library, when such is available.
     if ref_name.endswith('/') or \
        ref_name.startswith('.') or \
        ref_name.count('/.') or \
diff --git a/notes-merge.c b/notes-merge.c
index e1aaf43..3bbcc9d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -570,7 +570,8 @@ int notes_merge(struct notes_merge_options *o,
 	/* Dereference o->local_ref into local_sha1 */
 	if (!resolve_ref(o->local_ref, local_sha1, 0, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
-	else if (!check_ref_format(o->local_ref) && is_null_sha1(local_sha1))
+	else if (!check_refname_format(o->local_ref, 0) &&
+		is_null_sha1(local_sha1))
 		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
 	else if (!(local = lookup_commit_reference(local_sha1)))
 		die("Could not parse local commit %s (%s)",
@@ -583,7 +584,7 @@ int notes_merge(struct notes_merge_options *o,
 		 * Failed to get remote_sha1. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
-		if (!check_ref_format(o->remote_ref)) {
+		if (!check_refname_format(o->remote_ref, 0)) {
 			hashclr(remote_sha1);
 			remote = NULL;
 		} else {
diff --git a/pack-refs.c b/pack-refs.c
index 1290570..23bbd00 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -72,7 +72,7 @@ static void try_remove_empty_parents(char *name)
 	for (i = 0; i < 2; i++) { /* refs/{heads,tags,...}/ */
 		while (*p && *p != '/')
 			p++;
-		/* tolerate duplicate slashes; see check_ref_format() */
+		/* tolerate duplicate slashes; see check_refname_format() */
 		while (*p == '/')
 			p++;
 	}
diff --git a/refs.c b/refs.c
index fd29d89..aaa8730 100644
--- a/refs.c
+++ b/refs.c
@@ -872,10 +872,9 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
-int check_ref_format(const char *ref)
+int check_refname_format(const char *ref, int flags)
 {
 	int ch, level, last;
-	int ret = CHECK_REF_FORMAT_OK;
 	const char *cp = ref;
 
 	level = 0;
@@ -884,41 +883,42 @@ int check_ref_format(const char *ref)
 			; /* tolerate duplicated slashes */
 		if (!ch)
 			/* should not end with slashes */
-			return CHECK_REF_FORMAT_ERROR;
+			return -1;
 
 		/* we are at the beginning of the path component */
 		if (ch == '.')
-			return CHECK_REF_FORMAT_ERROR;
+			return -1;
 		if (bad_ref_char(ch)) {
-			if (ch == '*' && (!*cp || *cp == '/') &&
-			    ret == CHECK_REF_FORMAT_OK)
-				ret = CHECK_REF_FORMAT_WILDCARD;
+			if ((flags & REFNAME_REFSPEC_PATTERN) && ch == '*' &&
+				(!*cp || *cp == '/'))
+				/* Accept one wildcard as a full refname component. */
+				flags &= ~REFNAME_REFSPEC_PATTERN;
 			else
-				return CHECK_REF_FORMAT_ERROR;
+				return -1;
 		}
 
 		last = ch;
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			if (bad_ref_char(ch))
-				return CHECK_REF_FORMAT_ERROR;
+				return -1;
 			if (ch == '/')
 				break;
 			if (last == '.' && ch == '.')
-				return CHECK_REF_FORMAT_ERROR;
+				return -1;
 			if (last == '@' && ch == '{')
-				return CHECK_REF_FORMAT_ERROR;
+				return -1;
 			last = ch;
 		}
 		level++;
 		if (!ch) {
 			if (ref <= cp - 2 && cp[-2] == '.')
-				return CHECK_REF_FORMAT_ERROR;
-			if (level < 2)
-				return CHECK_REF_FORMAT_ONELEVEL;
+				return -1;
+			if (level < 2 && !(flags & REFNAME_ALLOW_ONELEVEL))
+				return -1;
 			if (has_extension(ref, ".lock"))
-				return CHECK_REF_FORMAT_ERROR;
-			return ret;
+				return -1;
+			return 0;
 		}
 	}
 }
@@ -1103,7 +1103,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
-	if (check_ref_format(ref))
+	if (check_refname_format(ref, 0))
 		return NULL;
 	strcpy(refpath, mkpath("refs/%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
@@ -1111,13 +1111,9 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
-	switch (check_ref_format(ref)) {
-	default:
+	if (check_refname_format(ref, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
-	case 0:
-	case CHECK_REF_FORMAT_ONELEVEL:
-		return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
-	}
+	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 }
 
 static struct lock_file packlock;
diff --git a/refs.h b/refs.h
index dfb086e..48540c0 100644
--- a/refs.h
+++ b/refs.h
@@ -97,11 +97,18 @@ int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long, voi
  */
 extern int for_each_reflog(each_ref_fn, void *);
 
-#define CHECK_REF_FORMAT_OK 0
-#define CHECK_REF_FORMAT_ERROR (-1)
-#define CHECK_REF_FORMAT_ONELEVEL (-2)
-#define CHECK_REF_FORMAT_WILDCARD (-3)
-extern int check_ref_format(const char *target);
+#define REFNAME_ALLOW_ONELEVEL 1
+#define REFNAME_REFSPEC_PATTERN 2
+
+/*
+ * Return 0 iff ref has the correct format for a refname according to
+ * the rules described in Documentation/git-check-ref-format.txt.  If
+ * REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
+ * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
+ * allow a "*" wildcard character in place of one of the name
+ * components.
+ */
+extern int check_refname_format(const char *ref, int flags);
 
 extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *ref, int strict);
diff --git a/remote.c b/remote.c
index b8ecfa5..6fcf809 100644
--- a/remote.c
+++ b/remote.c
@@ -493,23 +493,6 @@ static void read_config(void)
 }
 
 /*
- * We need to make sure the remote-tracking branches are well formed, but a
- * wildcard refspec in "struct refspec" must have a trailing slash. We
- * temporarily drop the trailing '/' while calling check_ref_format(),
- * and put it back.  The caller knows that a CHECK_REF_FORMAT_ONELEVEL
- * error return is Ok for a wildcard refspec.
- */
-static int verify_refname(char *name, int is_glob)
-{
-	int result;
-
-	result = check_ref_format(name);
-	if (is_glob && result == CHECK_REF_FORMAT_WILDCARD)
-		result = CHECK_REF_FORMAT_OK;
-	return result;
-}
-
-/*
  * This function frees a refspec array.
  * Warning: code paths should be checked to ensure that the src
  *          and dst pointers are always freeable pointers as well
@@ -532,13 +515,13 @@ static void free_refspecs(struct refspec *refspec, int nr_refspec)
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
-	int st;
 	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
 
 	for (i = 0; i < nr_refspec; i++) {
 		size_t llen;
 		int is_glob;
 		const char *lhs, *rhs;
+		int flags;
 
 		is_glob = 0;
 
@@ -576,6 +559,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 		rs[i].pattern = is_glob;
 		rs[i].src = xstrndup(lhs, llen);
+		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 		if (fetch) {
 			/*
@@ -585,26 +569,20 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 */
 			if (!*rs[i].src)
 				; /* empty is ok */
-			else {
-				st = verify_refname(rs[i].src, is_glob);
-				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
-					goto invalid;
-			}
+			else if (check_refname_format(rs[i].src, flags))
+				goto invalid;
 			/*
 			 * RHS
 			 * - missing is ok, and is same as empty.
 			 * - empty is ok; it means not to store.
 			 * - otherwise it must be a valid looking ref.
 			 */
-			if (!rs[i].dst) {
+			if (!rs[i].dst)
 				; /* ok */
-			} else if (!*rs[i].dst) {
+			else if (!*rs[i].dst)
 				; /* ok */
-			} else {
-				st = verify_refname(rs[i].dst, is_glob);
-				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
-					goto invalid;
-			}
+			else if (check_refname_format(rs[i].dst, flags))
+				goto invalid;
 		} else {
 			/*
 			 * LHS
@@ -616,8 +594,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if (!*rs[i].src)
 				; /* empty is ok */
 			else if (is_glob) {
-				st = verify_refname(rs[i].src, is_glob);
-				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				if (check_refname_format(rs[i].src, flags))
 					goto invalid;
 			}
 			else
@@ -630,14 +607,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 * - otherwise it must be a valid looking ref.
 			 */
 			if (!rs[i].dst) {
-				st = verify_refname(rs[i].src, is_glob);
-				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				if (check_refname_format(rs[i].src, flags))
 					goto invalid;
 			} else if (!*rs[i].dst) {
 				goto invalid;
 			} else {
-				st = verify_refname(rs[i].dst, is_glob);
-				if (st && st != CHECK_REF_FORMAT_ONELEVEL)
+				if (check_refname_format(rs[i].dst, flags))
 					goto invalid;
 			}
 		}
@@ -1427,8 +1402,8 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
-			int st = check_ref_format((*rmp)->peer_ref->name + 5);
-			if (st && st != CHECK_REF_FORMAT_ONELEVEL) {
+			if (check_refname_format((*rmp)->peer_ref->name + 5,
+				REFNAME_ALLOW_ONELEVEL)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
 				      (*rmp)->peer_ref->name);
@@ -1620,7 +1595,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 	int len;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_ref_format(refname + 5))
+	if (check_refname_format(refname + 5, 0))
 		return 0;
 
 	len = strlen(refname) + 1;
diff --git a/sha1_name.c b/sha1_name.c
index ff5992a..143fd97 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -972,9 +972,9 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 {
 	strbuf_branchname(sb, name);
 	if (name[0] == '-')
-		return CHECK_REF_FORMAT_ERROR;
+		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-	return check_ref_format(sb->buf);
+	return check_refname_format(sb->buf, 0);
 }
 
 /*
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index f551eef..1cad88f 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -87,11 +87,7 @@ valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
 ref='*'
 invalid_ref "$ref"
-
-#invalid_ref "$ref" --allow-onelevel
-test_expect_failure "ref name '$ref' is invalid with options --allow-onelevel" \
-	"test_must_fail git check-ref-format --allow-onelevel '$ref'"
-
+invalid_ref "$ref" --allow-onelevel
 invalid_ref "$ref" --refspec-pattern
 valid_ref "$ref" '--refspec-pattern --allow-onelevel'
 
diff --git a/transport.c b/transport.c
index fa279d5..feb2ff5 100644
--- a/transport.c
+++ b/transport.c
@@ -754,18 +754,10 @@ void transport_verify_remote_names(int nr_heads, const char **heads)
 			continue;
 
 		remote = remote ? (remote + 1) : local;
-		switch (check_ref_format(remote)) {
-		case 0: /* ok */
-		case CHECK_REF_FORMAT_ONELEVEL:
-			/* ok but a single level -- that is fine for
-			 * a match pattern.
-			 */
-		case CHECK_REF_FORMAT_WILDCARD:
-			/* ok but ends with a pattern-match character */
-			continue;
-		}
-		die("remote part of refspec is not a valid name in %s",
-		    heads[i]);
+		if (check_refname_format(remote,
+				REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))
+			die("remote part of refspec is not a valid name in %s",
+				heads[i]);
 	}
 }
 
diff --git a/walker.c b/walker.c
index dce7128..be389dc 100644
--- a/walker.c
+++ b/walker.c
@@ -190,7 +190,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 {
 	if (!get_sha1_hex(target, sha1))
 		return 0;
-	if (!check_ref_format(target)) {
+	if (!check_refname_format(target, 0)) {
 		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
 			hashcpy(sha1, ref->old_sha1);
-- 
1.7.6.8.gd2879
