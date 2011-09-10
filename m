From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] Add tools to avoid the use of unnormalized refnames.
Date: Sat, 10 Sep 2011 08:50:43 +0200
Message-ID: <1315637443-14012-8-git-send-email-mhagger@alum.mit.edu>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 08:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2HPe-0001xv-SD
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 08:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab1IJGv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 02:51:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:33360 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756736Ab1IJGvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 02:51:09 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A6ol8x024666;
	Sat, 10 Sep 2011 08:50:53 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181144>

Change normalize_refname() to only allow unnormalized refnames if its
dst parameter is non-NULL.  Callers who want to support unnormalized
refnames will need the unnormalized copy, and callers unprepared to
deal with a normalized copy shouldn't pretend to accept unnormalized
refnames.

Change check_ref_format() to reject unnormalized refnames.

Add a new temporary function, check_ref_format_unsafe(), which accepts
unnormalized refnames like the old check_ref_format().  Change callers
to use this function so that their behavior is preserved, even though
in many cases it is brokenness that is being preserved.  Callers
should be fixed to use one of the new functions, then
check_ref_format_unsafe() should be removed.

Add options --normalize and --no-normalize to "git check-ref-format"
to access the new functionality and use the new options to add tests.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |   13 ++++++++-
 builtin/check-ref-format.c             |   34 ++++++++++++++-----------
 builtin/checkout.c                     |    2 +-
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    2 +-
 builtin/replace.c                      |    2 +-
 builtin/show-ref.c                     |    2 +-
 builtin/tag.c                          |    2 +-
 connect.c                              |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    2 +-
 notes-merge.c                          |    4 +-
 refs.c                                 |   17 ++++++++++---
 refs.h                                 |   41 +++++++++++++++++++++++--------
 remote.c                               |   17 +++++++------
 sha1_name.c                            |    2 +-
 t/t1402-check-ref-format.sh            |    3 ++
 transport.c                            |    4 ++-
 walker.c                               |    2 +-
 19 files changed, 101 insertions(+), 54 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index f2d21c7..25a7c43 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git check-ref-format' [--print]
-       [--[no-]allow-onelevel] [--refspec-pattern] <refname>
+       [--[no-]allow-onelevel] [--refspec-pattern] [--[no-]normalize]
+       <refname>
 'git check-ref-format' --branch <branchname-shorthand>
 
 DESCRIPTION
@@ -71,7 +72,7 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
 With the `--print` option, if 'refname' is acceptable, it prints the
-canonicalized name of a hypothetical reference with that name.  That is,
+normalized name of a hypothetical reference with that name.  That is,
 it prints 'refname' with any extra `/` characters removed.
 
 With the `--branch` option, it expands the ``previous branch syntax''
@@ -95,6 +96,14 @@ OPTIONS
 	of a one full pathname component (e.g., `foo/*/bar` but not
 	`foo/bar*`).
 
+--normalize::
+--no-normalize::
+	Controls whether <refname> is allowed to contain extra `/`
+	characters at the beginning and between name components.  If
+	this option is set, such extra slashes are stripped out of the
+	value printed by the `--print` option.  The default is
+	`--normalize`.
+
 EXAMPLES
 --------
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 4c202af..fc1ffd2 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -23,22 +23,12 @@ static int check_ref_format_branch(const char *arg)
 	return 0;
 }
 
-static int check_ref_format_print(const char *arg, int flags)
-{
-	int refnamelen = strlen(arg) + 1;
-	char *refname = xmalloc(refnamelen);
-
-	if (normalize_refname(refname, refnamelen, arg, flags))
-		return 1;
-	printf("%s\n", refname);
-	return 0;
-}
-
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int print = 0;
 	int flags = 0;
+	int normalize = 1;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -55,13 +45,27 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags &= ~REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--refspec-pattern"))
 			flags |= REFNAME_REFSPEC_PATTERN;
+		else if (!strcmp(argv[i], "--normalize"))
+			normalize = 1;
+		else if (!strcmp(argv[i], "--no-normalize"))
+			normalize = 0;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
-	if (print)
-		return check_ref_format_print(argv[i], flags);
-	else
-		return !!check_ref_format(argv[i], flags);
+	if (normalize) {
+		int refnamelen = strlen(argv[i]) + 1;
+		char *refname = xmalloc(refnamelen);
+		if (normalize_refname(refname, refnamelen, argv[i], flags))
+			return 1;
+		if (print)
+			printf("%s\n", refname);
+	} else {
+		if (check_ref_format(argv[i], flags))
+			return 1;
+		if (print)
+			printf("%s\n", argv[i]);
+	}
+	return 0;
 }
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2882116..cf16ac3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,7 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->name = arg;
 	setup_branch_path(new);
 
-	if (!check_ref_format(new->path, 0) &&
+	if (!check_ref_format_unsafe(new->path, 0) &&
 	    resolve_ref(new->path, branch_rev, 1, NULL))
 		hashcpy(rev, branch_rev);
 	else
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 411aa7d..640e1ac 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -544,7 +544,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5, 0))
+		    check_ref_format_unsafe(ref->name + 5, 0))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4e880ef..24d917b 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -356,7 +356,7 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_ref_format(name + 5, 0)) {
+	if (prefixcmp(name, "refs/") || check_ref_format_unsafe(name + 5, 0)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 15f0e5e..ac6b154 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -94,7 +94,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_ref_format(ref, 0))
+	if (check_ref_format_unsafe(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
 
 	if (!resolve_ref(ref, prev, 1, NULL))
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 375a14b..ba5f66f 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -145,7 +145,7 @@ static int exclude_existing(const char *match)
 			if (strncmp(ref, match, matchlen))
 				continue;
 		}
-		if (check_ref_format(ref, 0)) {
+		if (check_ref_format_unsafe(ref, 0)) {
 			warning("ref '%s' ignored", ref);
 			continue;
 		}
diff --git a/builtin/tag.c b/builtin/tag.c
index 7aceaab..10ee87c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -412,7 +412,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
 
-	return check_ref_format(sb->buf, 0);
+	return check_ref_format_unsafe(sb->buf, 0);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
diff --git a/connect.c b/connect.c
index 292a9e2..3fea6b1 100644
--- a/connect.c
+++ b/connect.c
@@ -22,7 +22,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	len -= 5;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_ref_format(name, 0))
+	if ((flags & REF_NORMAL) && check_ref_format_unsafe(name, 0))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/environment.c b/environment.c
index 8acbb87..ec293e8 100644
--- a/environment.c
+++ b/environment.c
@@ -106,7 +106,7 @@ static char *expand_namespace(const char *raw_namespace)
 		if (strcmp((*c)->buf, "/") != 0)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
-	if (check_ref_format(buf.buf, 0))
+	if (check_ref_format_unsafe(buf.buf, 0))
 		die("bad git namespace path \"%s\"", raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
diff --git a/fast-import.c b/fast-import.c
index 4d55ee6..70271f0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -722,7 +722,7 @@ static struct branch *new_branch(const char *name)
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
-	if (check_ref_format(name, REFNAME_ALLOW_ONELEVEL))
+	if (check_ref_format_unsafe(name, REFNAME_ALLOW_ONELEVEL))
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
 	b = pool_calloc(1, sizeof(struct branch));
diff --git a/notes-merge.c b/notes-merge.c
index bb8d7c8..7e7dd3a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -570,7 +570,7 @@ int notes_merge(struct notes_merge_options *o,
 	/* Dereference o->local_ref into local_sha1 */
 	if (!resolve_ref(o->local_ref, local_sha1, 0, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
-	else if (!check_ref_format(o->local_ref, 0) &&
+	else if (!check_ref_format_unsafe(o->local_ref, 0) &&
 		is_null_sha1(local_sha1))
 		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
 	else if (!(local = lookup_commit_reference(local_sha1)))
@@ -584,7 +584,7 @@ int notes_merge(struct notes_merge_options *o,
 		 * Failed to get remote_sha1. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
-		if (!check_ref_format(o->remote_ref, 0)) {
+		if (!check_ref_format_unsafe(o->remote_ref, 0)) {
 			hashclr(remote_sha1);
 			remote = NULL;
 		} else {
diff --git a/refs.c b/refs.c
index 6985a3f..26720e8 100644
--- a/refs.c
+++ b/refs.c
@@ -879,8 +879,11 @@ int normalize_refname(char *dst, int dstlen, const char *ref, int flags)
 
 	ch = *cp;
 	do {
-		while (ch == '/')
-			ch = *++cp; /* tolerate leading and repeated slashes */
+		if (dst) {
+			/* tolerate leading and repeated slashes */
+			while (ch == '/')
+				ch = *++cp;
+		}
 
 		/*
 		 * We are at the start of a path component.  Record
@@ -947,6 +950,12 @@ int normalize_refname(char *dst, int dstlen, const char *ref, int flags)
 	return 0;
 }
 
+int check_ref_format_unsafe(const char *ref, int flags)
+{
+	char unused[PATH_MAX];
+	return normalize_refname(unused, sizeof(unused), ref, flags);
+}
+
 int check_ref_format(const char *ref, int flags)
 {
 	return normalize_refname(NULL, 0, ref, flags);
@@ -1132,7 +1141,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
-	if (check_ref_format(ref, 0))
+	if (check_ref_format_unsafe(ref, 0))
 		return NULL;
 	strcpy(refpath, mkpath("refs/%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
@@ -1140,7 +1149,7 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
-	if (check_ref_format(ref, REFNAME_ALLOW_ONELEVEL))
+	if (check_ref_format_unsafe(ref, REFNAME_ALLOW_ONELEVEL))
 		return NULL;
 	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 }
diff --git a/refs.h b/refs.h
index 8a15f83..bdfd230 100644
--- a/refs.h
+++ b/refs.h
@@ -102,24 +102,43 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 /*
  * Check that ref is a valid refname according to the rules described
- * in Documentation/git-check-ref-format.txt and normalize it by
- * stripping out superfluous "/" characters.  If dst != NULL, write
- * the normalized refname to dst, which must be an allocated character
- * array with length dstlen (typically at least as long as ref).  dst
- * may point at the same memory as ref.  Return 0 iff the refname was
- * OK and fit into dst.  If REFNAME_ALLOW_ONELEVEL is set in flags,
- * then accept one-level reference names.  If REFNAME_REFSPEC_PATTERN
- * is set in flags, then allow a "*" wildcard characters in place of
- * one of the name components.
+ * in Documentation/git-check-ref-format.txt.  If
+ * REFNAME_ALLOW_ONELEVEL is set in flags, then accept reference names
+ * with only a single component.  If REFNAME_REFSPEC_PATTERN is set in
+ * flags, then allow a "*" wildcard character in place of one of the
+ * name components.
+ *
+ * The handling of normalized/unnormalized refnames is determined by
+ * dst:
+ *
+ * - If dst is non-NULL, then it must be an allocated character array
+ *   with length dstlen.  Usually dstlen should be at least
+ *   strlen(ref)+1.  Dst may point at the same memory as ref.  In this
+ *   case, write a normalized copy of ref to dst, stripping out
+ *   superfluous "/" characters.
+ *
+ * - If dst is NULL, verify that the reference is already normalized
+ *   and do no copying.
+ *
+ * Return 0 iff the refname was OK and fit into dst.
  */
 extern int normalize_refname(char *dst, int dstlen, const char *ref, int flags);
 
 /*
- * Return 0 iff ref has the correct format for a refname.  See
- * normalize_refname() for details.
+ * Return 0 iff ref has the correct format for a refname and is
+ * correctly normalized.  See normalize_refname() for details.
  */
 extern int check_ref_format(const char *ref, int flags);
 
+/*
+ * Return 0 iff ref has the correct format for a refname, *without*
+ * requiring it to be normalized.  This function is unsafe because
+ * unnormalized refnames should not be used; please use
+ * normalize_refname() if you want to accept unnormalized refnames or
+ * check_ref_format() if you only want to accept normalized refnames.
+ */
+extern int check_ref_format_unsafe(const char *ref, int flags);
+
 extern const char *prettify_refname(const char *refname);
 extern char *shorten_unambiguous_ref(const char *ref, int strict);
 
diff --git a/remote.c b/remote.c
index 7059885..00e7523 100644
--- a/remote.c
+++ b/remote.c
@@ -559,7 +559,8 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 		rs[i].pattern = is_glob;
 		rs[i].src = xstrndup(lhs, llen);
-		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
+		flags = REFNAME_ALLOW_ONELEVEL |
+			(is_glob ? REFNAME_REFSPEC_PATTERN : 0);
 
 		if (fetch) {
 			/*
@@ -569,7 +570,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 */
 			if (!*rs[i].src)
 				; /* empty is ok */
-			else if (check_ref_format(rs[i].src, flags))
+			else if (check_ref_format_unsafe(rs[i].src, flags))
 				goto invalid;
 			/*
 			 * RHS
@@ -581,7 +582,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 				; /* ok */
 			else if (!*rs[i].dst)
 				; /* ok */
-			else if (check_ref_format(rs[i].dst, flags))
+			else if (check_ref_format_unsafe(rs[i].dst, flags))
 				goto invalid;
 		} else {
 			/*
@@ -594,7 +595,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			if (!*rs[i].src)
 				; /* empty is ok */
 			else if (is_glob) {
-				if (check_ref_format(rs[i].src, flags))
+				if (check_ref_format_unsafe(rs[i].src, flags))
 					goto invalid;
 			}
 			else
@@ -607,12 +608,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 			 * - otherwise it must be a valid looking ref.
 			 */
 			if (!rs[i].dst) {
-				if (check_ref_format(rs[i].src, flags))
+				if (check_ref_format_unsafe(rs[i].src, flags))
 					goto invalid;
 			} else if (!*rs[i].dst) {
 				goto invalid;
 			} else {
-				if (check_ref_format(rs[i].dst, flags))
+				if (check_ref_format_unsafe(rs[i].dst, flags))
 					goto invalid;
 			}
 		}
@@ -1402,7 +1403,7 @@ int get_fetch_map(const struct ref *remote_refs,
 
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
-			if (check_ref_format((*rmp)->peer_ref->name + 5,
+			if (check_ref_format_unsafe((*rmp)->peer_ref->name + 5,
 				REFNAME_ALLOW_ONELEVEL)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
@@ -1595,7 +1596,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 	int len;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_ref_format(refname + 5, 0))
+	if (check_ref_format_unsafe(refname + 5, 0))
 		return 0;
 
 	len = strlen(refname) + 1;
diff --git a/sha1_name.c b/sha1_name.c
index 975ec3b..8458454 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -974,7 +974,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-	return check_ref_format(sb->buf, 0);
+	return check_ref_format_unsafe(sb->buf, 0);
 }
 
 /*
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 419788f..411c271 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -30,9 +30,12 @@ invalid_ref '/'
 invalid_ref '/' --allow-onelevel
 valid_ref 'foo/bar/baz'
 valid_ref 'refs///heads/foo'
+invalid_ref 'refs///heads/foo' --no-normalize
 invalid_ref 'heads/foo/'
 valid_ref '/heads/foo'
+invalid_ref '/heads/foo' --no-normalize
 valid_ref '///heads/foo'
+invalid_ref '///heads/foo' --no-normalize
 invalid_ref './foo'
 invalid_ref './foo/bar'
 invalid_ref 'foo/./bar'
diff --git a/transport.c b/transport.c
index 225d9b8..e00610d 100644
--- a/transport.c
+++ b/transport.c
@@ -754,7 +754,9 @@ void transport_verify_remote_names(int nr_heads, const char **heads)
 			continue;
 
 		remote = remote ? (remote + 1) : local;
-		if (check_ref_format(remote, REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))
+		if (check_ref_format_unsafe(remote,
+				     REFNAME_ALLOW_ONELEVEL|
+				     REFNAME_REFSPEC_PATTERN))
 			die("remote part of refspec is not a valid name in %s",
 				heads[i]);
 	}
diff --git a/walker.c b/walker.c
index e5d8eb2..a1c1ee2 100644
--- a/walker.c
+++ b/walker.c
@@ -190,7 +190,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 {
 	if (!get_sha1_hex(target, sha1))
 		return 0;
-	if (!check_ref_format(target, 0)) {
+	if (!check_ref_format_unsafe(target, 0)) {
 		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
 			hashcpy(sha1, ref->old_sha1);
-- 
1.7.6.8.gd2879
