From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 6/6] Add a REFNAME_ALLOW_UNNORMALIZED flag to check_ref_format()
Date: Fri,  9 Sep 2011 13:46:18 +0200
Message-ID: <1315568778-3592-7-git-send-email-mhagger@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 13:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1zYK-0005zY-4d
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 13:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933530Ab1IILqy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 07:46:54 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:46261 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933494Ab1IILqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 07:46:43 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R1zTb-0002Qy-V5; Fri, 09 Sep 2011 13:42:31 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181057>

Let the callers of check_ref_format() (and normalize_refname()) decide
whether to accept unnormalized refnames via a new
REFNAME_ALLOW_UNNORMALIZED flag.  Change callers to set this flag,
which preserves their current behavior.  (There are likely places
where this flag can be removed.)

Add analogous options --allow-unnormalized and --no-allow-unnormalized
options to "git check-ref-format" and add tests.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/git-check-ref-format.txt |    9 ++++++++-
 builtin/check-ref-format.c             |    6 +++++-
 builtin/checkout.c                     |    2 +-
 builtin/fetch-pack.c                   |    2 +-
 builtin/receive-pack.c                 |    3 ++-
 builtin/replace.c                      |    2 +-
 builtin/show-ref.c                     |    2 +-
 builtin/tag.c                          |    2 +-
 connect.c                              |    2 +-
 environment.c                          |    2 +-
 fast-import.c                          |    2 +-
 notes-merge.c                          |    4 ++--
 refs.c                                 |   11 +++++++----
 refs.h                                 |    5 ++++-
 remote.c                               |    8 +++++---
 sha1_name.c                            |    2 +-
 t/t1402-check-ref-format.sh            |    3 +++
 transport.c                            |    5 ++++-
 walker.c                               |    2 +-
 19 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index f2d21c7..fac44ec 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -71,7 +71,7 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
 With the `--print` option, if 'refname' is acceptable, it prints the
-canonicalized name of a hypothetical reference with that name.  That is,
+normalized name of a hypothetical reference with that name.  That is,
 it prints 'refname' with any extra `/` characters removed.
 
 With the `--branch` option, it expands the ``previous branch syntax''
@@ -95,6 +95,13 @@ OPTIONS
 	of a one full pathname component (e.g., `foo/*/bar` but not
 	`foo/bar*`).
 
+--allow-unnormalized::
+--no-allow-unnormalized::
+	Controls whether <refname> is allowed to contain extra `/`
+	characters at the beginning and between name components.
+	These extra slashes are stripped out of the value printed by
+	the `--print` option.)  The default is `--allow-unnormalized`.
+
 EXAMPLES
 --------
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 4c202af..ba0456c 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -38,7 +38,7 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	int print = 0;
-	int flags = 0;
+	int flags = REFNAME_ALLOW_UNNORMALIZED;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(builtin_check_ref_format_usage);
@@ -55,6 +55,10 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags &= ~REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--refspec-pattern"))
 			flags |= REFNAME_REFSPEC_PATTERN;
+		else if (!strcmp(argv[i], "--allow-unnormalized"))
+			flags |= REFNAME_ALLOW_UNNORMALIZED;
+		else if (!strcmp(argv[i], "--no-allow-unnormalized"))
+			flags &= ~REFNAME_ALLOW_UNNORMALIZED;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2882116..18c3270 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -882,7 +882,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 	new->name = arg;
 	setup_branch_path(new);
 
-	if (!check_ref_format(new->path, 0) &&
+	if (!check_ref_format(new->path, REFNAME_ALLOW_UNNORMALIZED) &&
 	    resolve_ref(new->path, branch_rev, 1, NULL))
 		hashcpy(rev, branch_rev);
 	else
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 411aa7d..a4416e4 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -544,7 +544,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
 		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5, 0))
+		    check_ref_format(ref->name + 5, REFNAME_ALLOW_UNNORMALIZED))
 			; /* trash */
 		else if (args.fetch_all &&
 			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4e880ef..e3159c5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -356,7 +356,8 @@ static const char *update(struct command *cmd)
 	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
-	if (prefixcmp(name, "refs/") || check_ref_format(name + 5, 0)) {
+	if (prefixcmp(name, "refs/") ||
+			check_ref_format(name + 5, REFNAME_ALLOW_UNNORMALIZED)) {
 		rp_error("refusing to create funny ref '%s' remotely", name);
 		return "funny refname";
 	}
diff --git a/builtin/replace.c b/builtin/replace.c
index 15f0e5e..4490656 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -94,7 +94,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 		     "refs/replace/%s",
 		     sha1_to_hex(object)) > sizeof(ref) - 1)
 		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_ref_format(ref, 0))
+	if (check_ref_format(ref, REFNAME_ALLOW_UNNORMALIZED))
 		die("'%s' is not a valid ref name.", ref);
 
 	if (!resolve_ref(ref, prev, 1, NULL))
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 375a14b..dba92b2 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -145,7 +145,7 @@ static int exclude_existing(const char *match)
 			if (strncmp(ref, match, matchlen))
 				continue;
 		}
-		if (check_ref_format(ref, 0)) {
+		if (check_ref_format(ref, REFNAME_ALLOW_UNNORMALIZED)) {
 			warning("ref '%s' ignored", ref);
 			continue;
 		}
diff --git a/builtin/tag.c b/builtin/tag.c
index 7aceaab..50d2018 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -412,7 +412,7 @@ static int strbuf_check_tag_ref(struct strbuf *sb, const char *name)
 	strbuf_reset(sb);
 	strbuf_addf(sb, "refs/tags/%s", name);
 
-	return check_ref_format(sb->buf, 0);
+	return check_ref_format(sb->buf, REFNAME_ALLOW_UNNORMALIZED);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
diff --git a/connect.c b/connect.c
index 292a9e2..d50f217 100644
--- a/connect.c
+++ b/connect.c
@@ -22,7 +22,7 @@ static int check_ref(const char *name, int len, unsigned int flags)
 	len -= 5;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
-	if ((flags & REF_NORMAL) && check_ref_format(name, 0))
+	if ((flags & REF_NORMAL) && check_ref_format(name, REFNAME_ALLOW_UNNORMALIZED))
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
diff --git a/environment.c b/environment.c
index 8acbb87..2a41c03 100644
--- a/environment.c
+++ b/environment.c
@@ -106,7 +106,7 @@ static char *expand_namespace(const char *raw_namespace)
 		if (strcmp((*c)->buf, "/") != 0)
 			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
 	strbuf_list_free(components);
-	if (check_ref_format(buf.buf, 0))
+	if (check_ref_format(buf.buf, REFNAME_ALLOW_UNNORMALIZED))
 		die("bad git namespace path \"%s\"", raw_namespace);
 	strbuf_addch(&buf, '/');
 	return strbuf_detach(&buf, NULL);
diff --git a/fast-import.c b/fast-import.c
index 4d55ee6..d8e9fe2 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -722,7 +722,7 @@ static struct branch *new_branch(const char *name)
 
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
-	if (check_ref_format(name, REFNAME_ALLOW_ONELEVEL))
+	if (check_ref_format(name, REFNAME_ALLOW_ONELEVEL|REFNAME_ALLOW_UNNORMALIZED))
 		die("Branch name doesn't conform to GIT standards: %s", name);
 
 	b = pool_calloc(1, sizeof(struct branch));
diff --git a/notes-merge.c b/notes-merge.c
index bb8d7c8..c09ce7c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -570,7 +570,7 @@ int notes_merge(struct notes_merge_options *o,
 	/* Dereference o->local_ref into local_sha1 */
 	if (!resolve_ref(o->local_ref, local_sha1, 0, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
-	else if (!check_ref_format(o->local_ref, 0) &&
+	else if (!check_ref_format(o->local_ref, REFNAME_ALLOW_UNNORMALIZED) &&
 		is_null_sha1(local_sha1))
 		local = NULL; /* local_sha1 == null_sha1 indicates unborn ref */
 	else if (!(local = lookup_commit_reference(local_sha1)))
@@ -584,7 +584,7 @@ int notes_merge(struct notes_merge_options *o,
 		 * Failed to get remote_sha1. If o->remote_ref looks like an
 		 * unborn ref, perform the merge using an empty notes tree.
 		 */
-		if (!check_ref_format(o->remote_ref, 0)) {
+		if (!check_ref_format(o->remote_ref, REFNAME_ALLOW_UNNORMALIZED)) {
 			hashclr(remote_sha1);
 			remote = NULL;
 		} else {
diff --git a/refs.c b/refs.c
index 6985a3f..c2a7c01 100644
--- a/refs.c
+++ b/refs.c
@@ -879,8 +879,11 @@ int normalize_refname(char *dst, int dstlen, const char *ref, int flags)
 
 	ch = *cp;
 	do {
-		while (ch == '/')
-			ch = *++cp; /* tolerate leading and repeated slashes */
+		if (flags && REFNAME_ALLOW_UNNORMALIZED) {
+			/* tolerate leading and repeated slashes */
+			while (ch == '/')
+				ch = *++cp;
+		}
 
 		/*
 		 * We are at the start of a path component.  Record
@@ -1132,7 +1135,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 {
 	char refpath[PATH_MAX];
-	if (check_ref_format(ref, 0))
+	if (check_ref_format(ref, REFNAME_ALLOW_UNNORMALIZED))
 		return NULL;
 	strcpy(refpath, mkpath("refs/%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
@@ -1140,7 +1143,7 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
-	if (check_ref_format(ref, REFNAME_ALLOW_ONELEVEL))
+	if (check_ref_format(ref, REFNAME_ALLOW_ONELEVEL|REFNAME_ALLOW_UNNORMALIZED))
 		return NULL;
 	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 }
diff --git a/refs.h b/refs.h
index 8a15f83..f203726 100644
--- a/refs.h
+++ b/refs.h
@@ -99,6 +99,7 @@ extern int for_each_reflog(each_ref_fn, void *);
 
 #define REFNAME_ALLOW_ONELEVEL 1
 #define REFNAME_REFSPEC_PATTERN 2
+#define REFNAME_ALLOW_UNNORMALIZED 4
 
 /*
  * Check that ref is a valid refname according to the rules described
@@ -110,7 +111,9 @@ extern int for_each_reflog(each_ref_fn, void *);
  * OK and fit into dst.  If REFNAME_ALLOW_ONELEVEL is set in flags,
  * then accept one-level reference names.  If REFNAME_REFSPEC_PATTERN
  * is set in flags, then allow a "*" wildcard characters in place of
- * one of the name components.
+ * one of the name components.  If REFNAME_ALLOW_UNNORMALIZED is set
+ * in flags, then allow extra "/" characters at the start of the
+ * refname or between name components.
  */
 extern int normalize_refname(char *dst, int dstlen, const char *ref, int flags);
 
diff --git a/remote.c b/remote.c
index 7059885..87da1e9 100644
--- a/remote.c
+++ b/remote.c
@@ -559,7 +559,9 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 		rs[i].pattern = is_glob;
 		rs[i].src = xstrndup(lhs, llen);
-		flags = REFNAME_ALLOW_ONELEVEL | (is_glob ? REFNAME_REFSPEC_PATTERN : 0);
+		flags = REFNAME_ALLOW_ONELEVEL |
+			(is_glob ? REFNAME_REFSPEC_PATTERN : 0) |
+			REFNAME_ALLOW_UNNORMALIZED;
 
 		if (fetch) {
 			/*
@@ -1403,7 +1405,7 @@ int get_fetch_map(const struct ref *remote_refs,
 	for (rmp = &ref_map; *rmp; ) {
 		if ((*rmp)->peer_ref) {
 			if (check_ref_format((*rmp)->peer_ref->name + 5,
-				REFNAME_ALLOW_ONELEVEL)) {
+				REFNAME_ALLOW_ONELEVEL|REFNAME_ALLOW_UNNORMALIZED)) {
 				struct ref *ignore = *rmp;
 				error("* Ignoring funny ref '%s' locally",
 				      (*rmp)->peer_ref->name);
@@ -1595,7 +1597,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 	int len;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_ref_format(refname + 5, 0))
+	if (check_ref_format(refname + 5, REFNAME_ALLOW_UNNORMALIZED))
 		return 0;
 
 	len = strlen(refname) + 1;
diff --git a/sha1_name.c b/sha1_name.c
index 975ec3b..6a5d104 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -974,7 +974,7 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 	if (name[0] == '-')
 		return -1;
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
-	return check_ref_format(sb->buf, 0);
+	return check_ref_format(sb->buf, REFNAME_ALLOW_UNNORMALIZED);
 }
 
 /*
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index 6848bfb..a1d4c5b 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -27,9 +27,12 @@ invalid_ref() {
 
 valid_ref 'foo/bar/baz'
 valid_ref 'refs///heads/foo'
+invalid_ref 'refs///heads/foo' --no-allow-unnormalized
 invalid_ref 'heads/foo/'
 valid_ref '/heads/foo'
+invalid_ref '/heads/foo' --no-allow-unnormalized
 valid_ref '///heads/foo'
+invalid_ref '///heads/foo' --no-allow-unnormalized
 invalid_ref './foo'
 invalid_ref './foo/bar'
 invalid_ref 'foo/./bar'
diff --git a/transport.c b/transport.c
index 225d9b8..65209af 100644
--- a/transport.c
+++ b/transport.c
@@ -754,7 +754,10 @@ void transport_verify_remote_names(int nr_heads, const char **heads)
 			continue;
 
 		remote = remote ? (remote + 1) : local;
-		if (check_ref_format(remote, REFNAME_ALLOW_ONELEVEL|REFNAME_REFSPEC_PATTERN))
+		if (check_ref_format(remote,
+				     REFNAME_ALLOW_ONELEVEL|
+				     REFNAME_REFSPEC_PATTERN|
+				     REFNAME_ALLOW_UNNORMALIZED))
 			die("remote part of refspec is not a valid name in %s",
 				heads[i]);
 	}
diff --git a/walker.c b/walker.c
index e5d8eb2..f0dbe58 100644
--- a/walker.c
+++ b/walker.c
@@ -190,7 +190,7 @@ static int interpret_target(struct walker *walker, char *target, unsigned char *
 {
 	if (!get_sha1_hex(target, sha1))
 		return 0;
-	if (!check_ref_format(target, 0)) {
+	if (!check_ref_format(target, REFNAME_ALLOW_UNNORMALIZED)) {
 		struct ref *ref = alloc_ref(target);
 		if (!walker->fetch_ref(walker, ref)) {
 			hashcpy(sha1, ref->old_sha1);
-- 
1.7.6.8.gd2879
