X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [RFC/PATCH] Change "refs/" references to symbolic constants
Date: Thu, 14 Dec 2006 16:44:05 +0000
Message-ID: <200612141644.06167.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 16:44:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 6cb76117ed50f171
X-UID: 194
X-Length: 26520
Content-Disposition: inline
X-OriginalArrivalTime: 14 Dec 2006 16:46:07.0758 (UTC) FILETIME=[5A3D5AE0:01C71F9F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34369>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gutgv-0001Nb-5I for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751721AbWLNQoN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWLNQoN
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:44:13 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:34193 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1750847AbWLNQoL (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 11:44:11 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 14 Dec 2006 16:46:07 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gutgl-0000lW-00 for <git@vger.kernel.org>; Thu, 14 Dec
 2006 16:44:07 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Changed repeated use of the same constants for the ref paths to be
symbolic constants.  I've defined them in refs.h

  refs/ is now PATH_REFS
  refs/heads/ is now PATH_REFS_HEADS
  refs/tags/ is now PATH_REFS_TAGS
  refs/remotes/ is now PATH_REFS_REMOTES

I've changed all references to them and made constants for the string
lengths as well.  This has clarified the code in some places; for
example:

 - len = strlen(refs[i]) + 11;
 + len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;

In this case 11 isn't STRLEN_PATH_REFS_HEADS, as it is in most other
cases, it's TAGS + 1.  With the change to symbolic constants it's much
clearer what is happening.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---

I chose to add the constants to refs.h; unfortunately that meant adding
some #include "refs.h" around the place.

Is that wise?  Would I be better putting the constants in cache.h?

I'm tempted to add a constant for "objects/" as well, to complete the set.
Would there be any objections?

 builtin-branch.c        |   24 ++++++++++++------------
 builtin-fmt-merge-msg.c |    5 +++--
 builtin-init-db.c       |   15 ++++++++-------
 builtin-name-rev.c      |   10 +++++-----
 builtin-pack-refs.c     |    2 +-
 builtin-push.c          |    8 ++++----
 builtin-show-branch.c   |   28 ++++++++++++++--------------
 builtin-show-ref.c      |    4 ++--
 connect.c               |   18 +++++++++---------
 describe.c              |    2 +-
 fetch-pack.c            |    4 ++--
 fsck-objects.c          |    2 +-
 http-fetch.c            |    5 +++--
 http-push.c             |    4 ++--
 local-fetch.c           |    3 ++-
 path.c                  |    5 +++--
 receive-pack.c          |    4 ++--
 refs.c                  |   16 ++++++++--------
 refs.h                  |   15 +++++++++++++++
 setup.c                 |    5 +++--
 sha1_name.c             |   10 +++++-----
 wt-status.c             |    3 ++-
 22 files changed, 107 insertions(+), 85 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 560309c..1f4b6f0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -105,7 +105,7 @@ static void delete_branches(int argc, const char **argv, 
int force)
 		if (!strcmp(head, argv[i]))
 			die("Cannot delete the branch you are currently on.");
 
-		name = xstrdup(mkpath("refs/heads/%s", argv[i]));
+		name = xstrdup(mkpath(PATH_REFS_HEADS "%s", argv[i]));
 		if (!resolve_ref(name, sha1, 1, NULL))
 			die("Branch '%s' not found.", argv[i]);
 
@@ -161,15 +161,15 @@ static int append_ref(const char *refname, const 
unsigned char *sha1, int flags,
 	int len;
 
 	/* Detect kind */
-	if (!strncmp(refname, "refs/heads/", 11)) {
+	if (!strncmp(refname, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS)) {
 		kind = REF_LOCAL_BRANCH;
-		refname += 11;
-	} else if (!strncmp(refname, "refs/remotes/", 13)) {
+		refname += STRLEN_PATH_REFS_HEADS;
+	} else if (!strncmp(refname, PATH_REFS_REMOTES, STRLEN_PATH_REFS_REMOTES)) {
 		kind = REF_REMOTE_BRANCH;
-		refname += 13;
-	} else if (!strncmp(refname, "refs/tags/", 10)) {
+		refname += STRLEN_PATH_REFS_REMOTES;
+	} else if (!strncmp(refname, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS)) {
 		kind = REF_TAG;
-		refname += 10;
+		refname += STRLEN_PATH_REFS_TAGS;
 	}
 
 	/* Don't add types the caller doesn't want */
@@ -290,7 +290,7 @@ static void create_branch(const char *name, const char 
*start,
 	unsigned char sha1[20];
 	char ref[PATH_MAX], msg[PATH_MAX + 20];
 
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	snprintf(ref, sizeof ref, PATH_REFS_HEADS "%s", name);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid branch name.", name);
 
@@ -324,13 +324,13 @@ static void rename_branch(const char *oldname, const 
char *newname, int force)
 	char oldref[PATH_MAX], newref[PATH_MAX], logmsg[PATH_MAX*2 + 100];
 	unsigned char sha1[20];
 
-	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > 
sizeof(oldref))
+	if (snprintf(oldref, sizeof(oldref), PATH_REFS_HEADS "%s", oldname) > 
sizeof(oldref))
 		die("Old branchname too long");
 
 	if (check_ref_format(oldref))
 		die("Invalid branch name: %s", oldref);
 
-	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > 
sizeof(newref))
+	if (snprintf(newref, sizeof(newref), PATH_REFS_HEADS "%s", newname) > 
sizeof(newref))
 		die("New branchname too long");
 
 	if (check_ref_format(newref))
@@ -430,8 +430,8 @@ int cmd_branch(int argc, const char **argv, const char 
*prefix)
 	head = xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
-	if (strncmp(head, "refs/heads/", 11))
-		die("HEAD not found below refs/heads!");
+	if (strncmp(head, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+		die("HEAD not found below " PATH_REFS_HEADS "!");
 	head += 11;
 
 	if (delete)
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 87d3d63..d0615b5 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "tag.h"
+#include "refs.h"
 
 static const char *fmt_merge_msg_usage =
 	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
@@ -280,8 +281,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const 
char *prefix)
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (!strncmp(current_branch, "refs/heads/", 11))
-		current_branch += 11;
+	if (!strncmp(current_branch, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+		current_branch += STRLEN_PATH_REFS_HEADS;
 
 	while (fgets(line, sizeof(line), in)) {
 		i++;
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 235a0ee..df343ea 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
@@ -182,11 +183,11 @@ static void create_default_files(const char *git_dir, 
const char *template_path)
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strcpy(path + len, "refs");
+	strcpy(path + len, PATH_REFS);
 	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/heads");
+	strcpy(path + len, PATH_REFS_HEADS);
 	safe_create_dir(path, 1);
-	strcpy(path + len, "refs/tags");
+	strcpy(path + len, PATH_REFS_TAGS);
 	safe_create_dir(path, 1);
 
 	/* First copy the templates -- we might have the default
@@ -205,11 +206,11 @@ static void create_default_files(const char *git_dir, 
const char *template_path)
 	if (shared_repository) {
 		path[len] = 0;
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs");
+		strcpy(path + len, PATH_REFS);
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs/heads");
+		strcpy(path + len, PATH_REFS_HEADS);
 		adjust_shared_perm(path);
-		strcpy(path + len, "refs/tags");
+		strcpy(path + len, PATH_REFS_TAGS);
 		adjust_shared_perm(path);
 	}
 
@@ -219,7 +220,7 @@ static void create_default_files(const char *git_dir, 
const char *template_path)
 	 */
 	strcpy(path + len, "HEAD");
 	if (read_ref("HEAD", sha1) < 0) {
-		if (create_symref("HEAD", "refs/heads/master") < 0)
+		if (create_symref("HEAD", PATH_REFS_HEADS "master") < 0)
 			exit(1);
 	}
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 618aa31..ef66b1f 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -81,7 +81,7 @@ static int name_ref(const char *path, const unsigned char 
*sha1, int flags, void
 	int tags_only = *(int*)cb_data;
 	int deref = 0;
 
-	if (tags_only && strncmp(path, "refs/tags/", 10))
+	if (tags_only && strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS))
 		return 0;
 
 	while (o && o->type == OBJ_TAG) {
@@ -94,10 +94,10 @@ static int name_ref(const char *path, const unsigned char 
*sha1, int flags, void
 	if (o && o->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *)o;
 
-		if (!strncmp(path, "refs/heads/", 11))
-			path = path + 11;
-		else if (!strncmp(path, "refs/", 5))
-			path = path + 5;
+		if (!strncmp(path, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+			path = path + STRLEN_PATH_REFS_HEADS;
+		else if (!strncmp(path, PATH_REFS, STRLEN_PATH_REFS))
+			path = path + STRLEN_PATH_REFS;
 
 		name_rev(commit, xstrdup(path), 0, 0, deref);
 	}
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 8dc5b9e..c15f629 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -36,7 +36,7 @@ static int handle_one_ref(const char *path, const unsigned 
char *sha1,
 	/* Do not pack the symbolic refs */
 	if ((flags & REF_ISSYMREF))
 		return 0;
-	is_tag_ref = !strncmp(path, "refs/tags/", 10);
+	is_tag_ref = !strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS);
 	if (!cb->all && !is_tag_ref)
 		return 0;
 
diff --git a/builtin-push.c b/builtin-push.c
index b7412e8..de3eb46 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -30,9 +30,9 @@ static void add_refspec(const char *ref)
 static int expand_one_ref(const char *ref, const unsigned char *sha1, int 
flag, void *cb_data)
 {
 	/* Ignore the "refs/" at the beginning of the refname */
-	ref += 5;
+	ref += STRLEN_PATH_REFS;
 
-	if (!strncmp(ref, "tags/", 5))
+	if (!strncmp(ref, PATH_TAGS, STRLEN_PATH_TAGS))
 		add_refspec(xstrdup(ref));
 	return 0;
 }
@@ -68,9 +68,9 @@ static void set_refspecs(const char **refs, int nr)
 					if (nr <= ++i)
 						die("tag <tag> shorthand without <tag>");
 					if (pass) {
-						len = strlen(refs[i]) + 11;
+						len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;
 						tag = xmalloc(len);
-						strcpy(tag, "refs/tags/");
+						strcpy(tag, PATH_REFS_TAGS);
 						strcat(tag, refs[i]);
 						refspec[cnt] = tag;
 					}
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index fb1a400..d598d2d 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -372,22 +372,22 @@ static int append_ref(const char *refname, const 
unsigned char *sha1, int flag,
 static int append_head_ref(const char *refname, const unsigned char *sha1, 
int flag, void *cb_data)
 {
 	unsigned char tmp[20];
-	int ofs = 11;
-	if (strncmp(refname, "refs/heads/", ofs))
+	int ofs = STRLEN_PATH_REFS_HEADS;
+	if (strncmp(refname, PATH_REFS_HEADS, ofs))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
-		ofs = 5;
+		ofs = STRLEN_PATH_REFS;
 	return append_ref(refname + ofs, sha1, flag, cb_data);
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int 
flag, void *cb_data)
 {
-	if (strncmp(refname, "refs/tags/", 10))
+	if (strncmp(refname, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS))
 		return 0;
-	return append_ref(refname + 5, sha1, flag, cb_data);
+	return append_ref(refname + STRLEN_PATH_REFS, sha1, flag, cb_data);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -416,9 +416,9 @@ static int append_matching_ref(const char *refname, const 
unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!strncmp("refs/heads/", refname, 11))
+	if (!strncmp(PATH_REFS_HEADS, refname, STRLEN_PATH_REFS_HEADS))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!strncmp("refs/tags/", refname, 10))
+	if (!strncmp(PATH_REFS_TAGS, refname, STRLEN_PATH_REFS_TAGS))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, flag, cb_data);
 }
@@ -443,12 +443,12 @@ static int rev_is_head(char *head, int headlen, char 
*name,
 	if ((!head[0]) ||
 	    (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
 		return 0;
-	if (!strncmp(head, "refs/heads/", 11))
-		head += 11;
-	if (!strncmp(name, "refs/heads/", 11))
-		name += 11;
-	else if (!strncmp(name, "heads/", 6))
-		name += 6;
+	if (!strncmp(head, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+		head += STRLEN_PATH_REFS_HEADS;
+	if (!strncmp(name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+		name += STRLEN_PATH_REFS_HEADS;
+	else if (!strncmp(name, PATH_HEADS, STRLEN_PATH_HEADS))
+		name += STRLEN_PATH_HEADS;
 	return !strcmp(head, name);
 }
 
@@ -659,7 +659,7 @@ int cmd_show_branch(int ac, const char **av, const char 
*prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int pfxlen = strlen("refs/heads/");
+			int pfxlen = STRLEN_PATH_REFS_HEADS;
 			append_one_rev(head + pfxlen);
 		}
 	}
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 0739798..29ec05c 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -18,8 +18,8 @@ static int show_ref(const char *refname, const unsigned char 
*sha1, int flag, vo
 	if (tags_only || heads_only) {
 		int match;
 
-		match = heads_only && !strncmp(refname, "refs/heads/", 11);
-		match |= tags_only && !strncmp(refname, "refs/tags/", 10);
+		match = heads_only && !strncmp(refname, PATH_REFS_HEADS, 
STRLEN_PATH_REFS_HEADS);
+		match |= tags_only && !strncmp(refname, PATH_REFS_TAGS, 
STRLEN_PATH_REFS_TAGS);
 		if (!match)
 			return 0;
 	}
diff --git a/connect.c b/connect.c
index f7edba8..49bfa37 100644
--- a/connect.c
+++ b/connect.c
@@ -17,23 +17,23 @@ static int check_ref(const char *name, int len, unsigned 
int flags)
 	if (!flags)
 		return 1;
 
-	if (len < 5 || memcmp(name, "refs/", 5))
+	if (len < STRLEN_PATH_REFS || memcmp(name, PATH_REFS, STRLEN_PATH_REFS))
 		return 0;
 
 	/* Skip the "refs/" part */
-	name += 5;
-	len -= 5;
+	name += STRLEN_PATH_REFS;
+	len -= STRLEN_PATH_REFS;
 
 	/* REF_NORMAL means that we don't want the magic fake tag refs */
 	if ((flags & REF_NORMAL) && check_ref_format(name) < 0)
 		return 0;
 
 	/* REF_HEADS means that we want regular branch heads */
-	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
+	if ((flags & REF_HEADS) && !memcmp(name, PATH_HEADS, STRLEN_PATH_HEADS))
 		return 1;
 
 	/* REF_TAGS means that we want tags */
-	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
+	if ((flags & REF_TAGS) && !memcmp(name, PATH_TAGS, STRLEN_PATH_TAGS))
 		return 1;
 
 	/* All type bits clear means that we are ok with anything */
@@ -202,8 +202,8 @@ static int count_refspec_match(const char *pattern,
 		 */
 		if (namelen != patlen &&
 		    patlen != namelen - 5 &&
-		    strncmp(name, "refs/heads/", 11) &&
-		    strncmp(name, "refs/tags/", 10)) {
+		    strncmp(name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS) &&
+		    strncmp(name, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS)) {
 			/* We want to catch the case where only weak
 			 * matches are found and there are multiple
 			 * matches, and where more than one strong
@@ -290,7 +290,7 @@ static int match_explicit_refs(struct ref *src, struct ref 
*dst,
 		case 1:
 			break;
 		case 0:
-			if (!memcmp(rs[i].dst, "refs/", 5)) {
+			if (!memcmp(rs[i].dst, PATH_REFS, STRLEN_PATH_REFS)) {
 				int len = strlen(rs[i].dst) + 1;
 				matched_dst = xcalloc(1, sizeof(*dst) + len);
 				memcpy(matched_dst->name, rs[i].dst, len);
@@ -311,7 +311,7 @@ static int match_explicit_refs(struct ref *src, struct ref 
*dst,
 				errs = 1;
 				error("dst refspec %s does not match any "
 				      "existing ref on the remote and does "
-				      "not start with refs/.", rs[i].dst);
+				      "not start with " PATH_REFS ".", rs[i].dst);
 			}
 			break;
 		default:
diff --git a/describe.c b/describe.c
index f4029ee..e3b0baa 100644
--- a/describe.c
+++ b/describe.c
@@ -66,7 +66,7 @@ static int get_name(const char *path, const unsigned char 
*sha1, int flag, void
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	if (!strncmp(path, "refs/tags/", 10)) {
+	if (!strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS)) {
 		if (object->type == OBJ_TAG)
 			prio = 2;
 		else
diff --git a/fetch-pack.c b/fetch-pack.c
index 743eab7..e67b2fe 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -307,8 +307,8 @@ static void filter_refs(struct ref **refs, int nr_match, 
char **match)
 
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5))
+		if (!memcmp(ref->name, PATH_REFS, STRLEN_PATH_REFS) &&
+		    check_ref_format(ref->name + STRLEN_PATH_REFS))
 			; /* trash */
 		else if (fetch_all) {
 			*newtail = ref;
diff --git a/fsck-objects.c b/fsck-objects.c
index 46b628c..f9b1218 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -463,7 +463,7 @@ static int fsck_head_link(void)
 
 	if (!head_points_at || !(flag & REF_ISSYMREF))
 		return error("HEAD is not a symbolic ref");
-	if (strncmp(head_points_at, "refs/heads/", 11))
+	if (strncmp(head_points_at, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
 	if (is_null_sha1(sha1))
diff --git a/http-fetch.c b/http-fetch.c
index 396552d..2c02690 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "fetch.h"
 #include "http.h"
+#include "refs.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
@@ -943,8 +944,8 @@ static char *quote_ref_url(const char *base, const char 
*ref)
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "refs/", 5);
-	for (cp = ref, dp = qref + baselen + 5; (ch = *cp) != 0; cp++) {
+	memcpy(qref + baselen, PATH_REFS, STRLEN_PATH_REFS);
+	for (cp = ref, dp = qref + baselen + STRLEN_PATH_REFS; (ch = *cp) != 0; 
cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
diff --git a/http-push.c b/http-push.c
index ecefdfd..6f17acf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1919,7 +1919,7 @@ static void get_local_heads(void)
 static void get_dav_remote_heads(void)
 {
 	remote_tail = &remote_refs;
-	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), 
process_ls_ref, NULL);
+	remote_ls(PATH_REFS, (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), 
process_ls_ref, NULL);
 }
 
 static int is_zero_sha1(const unsigned char *sha1)
@@ -2063,7 +2063,7 @@ static void update_remote_info_refs(struct remote_lock 
*lock)
 	buffer.buffer = xcalloc(1, 4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
-	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
+	remote_ls(PATH_REFS, (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer);
 	if (!aborted) {
 		if_header = xmalloc(strlen(lock->token) + 25);
diff --git a/local-fetch.c b/local-fetch.c
index 7b6875c..99c5cb2 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "fetch.h"
+#include "refs.h"
 
 static int use_link;
 static int use_symlink;
@@ -174,7 +175,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	int ifd;
 
 	if (ref_name_start < 0) {
-		sprintf(filename, "%s/refs/", path);
+		sprintf(filename, "%s/" PATH_REFS, path);
 		ref_name_start = strlen(filename);
 	}
 	strcpy(filename + ref_name_start, ref);
diff --git a/path.c b/path.c
index d2c076d..10be22c 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "refs.h"
 #include <pwd.h>
 
 static char bad_path[] = "/bad-path/";
@@ -103,7 +104,7 @@ int validate_symref(const char *path)
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= 5 && !memcmp("refs/", buffer, 5))
+		if (len >= 5 && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS))
 			return 0;
 		return -1;
 	}
@@ -126,7 +127,7 @@ int validate_symref(const char *path)
 	len -= 4;
 	while (len && isspace(*buf))
 		buf++, len--;
-	if (len >= 5 && !memcmp("refs/", buf, 5))
+	if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buf, STRLEN_PATH_REFS))
 		return 0;
 	return -1;
 }
diff --git a/receive-pack.c b/receive-pack.c
index e76d9ae..0d22120 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -105,7 +105,7 @@ static int update(struct command *cmd)
 	struct ref_lock *lock;
 
 	cmd->error_string = NULL;
-	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5)) {
+	if (!strncmp(name, PATH_REFS, STRLEN_PATH_REFS) && check_ref_format(name + 
STRLEN_PATH_REFS)) {
 		cmd->error_string = "funny refname";
 		return error("refusing to create funny ref '%s' locally",
 			     name);
@@ -121,7 +121,7 @@ static int update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !strncmp(name, "refs/heads/", 11)) {
+	    !strncmp(name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS)) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
diff --git a/refs.c b/refs.c
index a02957c..6fb81a7 100644
--- a/refs.c
+++ b/refs.c
@@ -263,7 +263,7 @@ const char *resolve_ref(const char *ref, unsigned char 
*sha1, int reading, int *
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
+			if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, 
STRLEN_PATH_REFS)) {
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
@@ -458,22 +458,22 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/", fn, 0, cb_data);
+	return do_for_each_ref(PATH_REFS, fn, 0, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/tags/", fn, 10, cb_data);
+	return do_for_each_ref(PATH_REFS_TAGS, fn, STRLEN_PATH_REFS_TAGS, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/heads/", fn, 11, cb_data);
+	return do_for_each_ref(PATH_REFS_HEADS, fn, STRLEN_PATH_REFS_HEADS, 
cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
+	return do_for_each_ref(PATH_REFS_REMOTES, fn, STRLEN_PATH_REFS_REMOTES, 
cb_data);
 }
 
 /* NEEDSWORK: This is only used by ssh-upload and it should go; the
@@ -485,7 +485,7 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
 	if (check_ref_format(ref))
 		return -1;
-	return read_ref(mkpath("refs/%s", ref), sha1);
+	return read_ref(mkpath(PATH_REFS "%s", ref), sha1);
 }
 
 /*
@@ -702,7 +702,7 @@ struct ref_lock *lock_ref_sha1(const char *ref, const 
unsigned char *old_sha1)
 	char refpath[PATH_MAX];
 	if (check_ref_format(ref))
 		return NULL;
-	strcpy(refpath, mkpath("refs/%s", ref));
+	strcpy(refpath, mkpath(PATH_REFS "%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, NULL);
 }
 
@@ -917,7 +917,7 @@ static int log_ref_write(struct ref_lock *lock,
 	const char *committer;
 
 	if (log_all_ref_updates &&
-	    !strncmp(lock->ref_name, "refs/heads/", 11)) {
+	    !strncmp(lock->ref_name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS)) {
 		if (safe_create_leading_directories(lock->log_file) < 0)
 			return error("unable to create directory for %s",
 				lock->log_file);
diff --git a/refs.h b/refs.h
index 51aab1e..cd7c428 100644
--- a/refs.h
+++ b/refs.h
@@ -13,6 +13,21 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
+#define PATH_REFS                "refs/"
+#define STRLEN_PATH_REFS         5
+#define PATH_HEADS               "heads/"
+#define STRLEN_PATH_HEADS        6
+#define PATH_TAGS                "tags/"
+#define STRLEN_PATH_TAGS         5
+#define PATH_REMOTES             "remotes/"
+#define STRLEN_PATH_REMOTES      8
+#define PATH_REFS_HEADS          PATH_REFS PATH_HEADS
+#define STRLEN_PATH_REFS_HEADS   (STRLEN_PATH_REFS+STRLEN_PATH_HEADS)
+#define PATH_REFS_TAGS           PATH_REFS PATH_TAGS
+#define STRLEN_PATH_REFS_TAGS    (STRLEN_PATH_REFS+STRLEN_PATH_TAGS)
+#define PATH_REFS_REMOTES        PATH_REFS PATH_REMOTES
+#define STRLEN_PATH_REFS_REMOTES (STRLEN_PATH_REFS+STRLEN_PATH_REMOTES)
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
diff --git a/setup.c b/setup.c
index 2afdba4..ea2c4b7 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
@@ -142,7 +143,7 @@ const char **get_pathspec(const char *prefix, const char 
**pathspec)
  */
 static int is_toplevel_directory(void)
 {
-	if (access(".git/refs/", X_OK) ||
+	if (access(".git/" PATH_REFS, X_OK) ||
 	    access(getenv(DB_ENVIRONMENT) ?
 		   getenv(DB_ENVIRONMENT) : ".git/objects/", X_OK) ||
 	    validate_symref(".git/HEAD"))
@@ -167,7 +168,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			die("'$%s' too big", GIT_DIR_ENVIRONMENT);
 		memcpy(path, getenv(GIT_DIR_ENVIRONMENT), len);
 		
-		strcpy(path + len, "/refs");
+		strcpy(path + len, PATH_REFS);
 		if (access(path, X_OK))
 			goto bad_dir_environ;
 		strcpy(path + len, "/HEAD");
diff --git a/sha1_name.c b/sha1_name.c
index 6d7cd78..b81c7fc 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -239,11 +239,11 @@ static int get_sha1_basic(const char *str, int len, 
unsigned char *sha1)
 {
 	static const char *fmt[] = {
 		"%.*s",
-		"refs/%.*s",
-		"refs/tags/%.*s",
-		"refs/heads/%.*s",
-		"refs/remotes/%.*s",
-		"refs/remotes/%.*s/HEAD",
+		PATH_REFS "%.*s",
+		PATH_REFS_TAGS "%.*s",
+		PATH_REFS_HEADS "%.*s",
+		PATH_REFS_REMOTES "%.*s",
+		PATH_REFS_REMOTES "%.*s/HEAD",
 		NULL
 	};
 	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
diff --git a/wt-status.c b/wt-status.c
index 6e9414d..bac8634 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
+#include "refs.h"
 
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
@@ -271,7 +272,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
-	if (s->branch && strcmp(s->branch, "refs/heads/master"))
+	if (s->branch && strcmp(s->branch, PATH_REFS_HEADS "master"))
 		color_printf_ln(color(WT_STATUS_HEADER),
 			"# On branch %s", s->branch);
 
-- 
1.4.4.1.g3ece-dirty
