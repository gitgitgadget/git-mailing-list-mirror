From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 18:39:05 +0000
Message-ID: <200702191839.05784.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 19:42:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJDT8-0004C6-1Y
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 19:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbXBSSmO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 13:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbXBSSmO
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 13:42:14 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbXBSSmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 13:42:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so635128uga
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 10:42:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=f8ZfWlsQ0EpdcZJxf3HVW41zFPh2Aimr/f8wgvw/AOJqHb71wRh2JkqEY9r6axtQfs8ry70QiwX5iuuRgP1CEXt32FdkXimdGMgru+Nh8m9gnA+KxxVf1iBzDPlpz49ec/ZSEvgPVRxVeWPBzH5+JenBFsEs1q9iLo3bDKWLcn4=
Received: by 10.67.28.4 with SMTP id f4mr7000788ugj.1171910524617;
        Mon, 19 Feb 2007 10:42:04 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id i39sm9611886ugd.2007.02.19.10.42.00;
        Mon, 19 Feb 2007 10:42:02 -0800 (PST)
X-TUID: 955cf2e0f4790d51
X-UID: 245
X-Length: 29292
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40137>

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
 builtin-branch.c        |   28 ++++++++++++++--------------
 builtin-describe.c      |    2 +-
 builtin-fmt-merge-msg.c |    5 +++--
 builtin-fsck.c          |    2 +-
 builtin-init-db.c       |   15 ++++++++-------
 builtin-name-rev.c      |   10 +++++-----
 builtin-pack-refs.c     |    2 +-
 builtin-push.c          |    8 ++++----
 builtin-show-branch.c   |   34 +++++++++++++++++-----------------
 builtin-show-ref.c      |    6 +++---
 connect.c               |   18 +++++++++---------
 fetch-pack.c            |    6 +++---
 http-fetch.c            |    7 ++++---
 http-push.c             |    4 ++--
 local-fetch.c           |    3 ++-
 path.c                  |    5 +++--
 receive-pack.c          |    4 ++--
 reflog-walk.c           |    6 +++---
 refs.c                  |   26 +++++++++++++-------------
 refs.h                  |   17 +++++++++++++++++
 setup.c                 |    5 +++--
 sha1_name.c             |   10 +++++-----
 wt-status.c             |    5 +++--
 23 files changed, 126 insertions(+), 102 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index d0e7209..928f1fe 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -85,12 +85,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds)
 
 	switch (kinds) {
 	case REF_REMOTE_BRANCH:
-		fmt = "refs/remotes/%s";
+		fmt = PATH_REFS_REMOTES "%s";
 		remote = "remote ";
 		force = 1;
 		break;
 	case REF_LOCAL_BRANCH:
-		fmt = "refs/heads/%s";
+		fmt = PATH_REFS_HEADS "%s";
 		remote = "";
 		break;
 	default:
@@ -178,15 +178,15 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
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
@@ -318,7 +318,7 @@ static void create_branch(const char *name, const char *start_name,
 	char ref[PATH_MAX], msg[PATH_MAX + 20];
 	int forcing = 0;
 
-	snprintf(ref, sizeof ref, "refs/heads/%s", name);
+	snprintf(ref, sizeof ref, PATH_REFS_HEADS "%s", name);
 	if (check_ref_format(ref))
 		die("'%s' is not a valid branch name.", name);
 
@@ -366,13 +366,13 @@ static void rename_branch(const char *oldname, const char *newname, int force)
 	if (!oldname)
 		die("cannot rename the current branch while not on any.");
 
-	if (snprintf(oldref, sizeof(oldref), "refs/heads/%s", oldname) > sizeof(oldref))
+	if (snprintf(oldref, sizeof(oldref), PATH_REFS_HEADS "%s", oldname) > sizeof(oldref))
 		die("Old branchname too long");
 
 	if (check_ref_format(oldref))
 		die("Invalid branch name: %s", oldref);
 
-	if (snprintf(newref, sizeof(newref), "refs/heads/%s", newname) > sizeof(newref))
+	if (snprintf(newref, sizeof(newref), PATH_REFS_HEADS "%s", newname) > sizeof(newref))
 		die("New branchname too long");
 
 	if (check_ref_format(newref))
@@ -476,9 +476,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		detached = 1;
 	}
 	else {
-		if (strncmp(head, "refs/heads/", 11))
-			die("HEAD not found below refs/heads!");
-		head += 11;
+		if (strncmp(head, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+			die("HEAD not found below " PATH_REFS_HEADS "!");
+		head += STRLEN_PATH_REFS_HEADS;
 	}
 
 	if (delete)
diff --git a/builtin-describe.c b/builtin-describe.c
index bcc6456..0f78363 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -52,7 +52,7 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * If --tags, then any tags are used.
 	 * Otherwise only annotated tags are used.
 	 */
-	if (!strncmp(path, "refs/tags/", 10)) {
+	if (!strncmp(path, PATH_TAGS, STRLEN_PATH_TAGS)) {
 		if (object->type == OBJ_TAG)
 			prio = 2;
 		else
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
@@ -280,8 +281,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	current_branch = resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
-	if (!strncmp(current_branch, "refs/heads/", 11))
-		current_branch += 11;
+	if (!strncmp(current_branch, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+		current_branch += STRLEN_PATH_REFS_HEADS;
 
 	while (fgets(line, sizeof(line), in)) {
 		i++;
diff --git a/builtin-fsck.c b/builtin-fsck.c
index 6da3814..0109816 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -546,7 +546,7 @@ static int fsck_head_link(void)
 
 	if (!head_points_at || !(flag & REF_ISSYMREF))
 		return error("HEAD is not a symbolic ref");
-	if (strncmp(head_points_at, "refs/heads/", 11))
+	if (strncmp(head_points_at, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
 	if (is_null_sha1(sha1))
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 12e43d0..4e5c881 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "builtin.h"
+#include "refs.h"
 
 #ifndef DEFAULT_GIT_TEMPLATE_DIR
 #define DEFAULT_GIT_TEMPLATE_DIR "/usr/share/git-core/templates/"
@@ -193,11 +194,11 @@ static int create_default_files(const char *git_dir, const char *template_path)
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
@@ -216,11 +217,11 @@ static int create_default_files(const char *git_dir, const char *template_path)
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
 
@@ -231,7 +232,7 @@ static int create_default_files(const char *git_dir, const char *template_path)
 	strcpy(path + len, "HEAD");
 	reinit = !read_ref("HEAD", sha1);
 	if (!reinit) {
-		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
+		if (create_symref("HEAD", PATH_REFS_HEADS "master", NULL) < 0)
 			exit(1);
 	}
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 36f1ba6..47a0f6d 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -85,7 +85,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 	struct name_ref_data *data = cb_data;
 	int deref = 0;
 
-	if (data->tags_only && strncmp(path, "refs/tags/", 10))
+	if (data->tags_only && strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS))
 		return 0;
 
 	if (data->ref_filter && fnmatch(data->ref_filter, path, 0))
@@ -101,10 +101,10 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
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
index 3de9b3e..ac7543d 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -36,7 +36,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
 	/* Do not pack the symbolic refs */
 	if ((flags & REF_ISSYMREF))
 		return 0;
-	is_tag_ref = !strncmp(path, "refs/tags/", 10);
+	is_tag_ref = !strncmp(path, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS);
 
 	/* ALWAYS pack refs that were already packed or are tags */
 	if (!cb->all && !is_tag_ref && !(flags & REF_ISPACKED))
diff --git a/builtin-push.c b/builtin-push.c
index c45649e..caeb9ae 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -30,9 +30,9 @@ static void add_refspec(const char *ref)
 static int expand_one_ref(const char *ref, const unsigned char *sha1, int flag, void *cb_data)
 {
 	/* Ignore the "refs/" at the beginning of the refname */
-	ref += 5;
+	ref += STRLEN_PATH_REFS;
 
-	if (!strncmp(ref, "tags/", 5))
+	if (!strncmp(ref, PATH_TAGS, STRLEN_PATH_TAGS))
 		add_refspec(xstrdup(ref));
 	return 0;
 }
@@ -123,9 +123,9 @@ static void set_refspecs(const char **refs, int nr)
 				int len;
 				if (nr <= ++i)
 					die("tag shorthand without <tag>");
-				len = strlen(refs[i]) + 11;
+				len = strlen(refs[i]) + STRLEN_PATH_REFS_TAGS + 1;
 				tag = xmalloc(len);
-				strcpy(tag, "refs/tags/");
+				strcpy(tag, PATH_REFS_TAGS);
 				strcat(tag, refs[i]);
 				ref = tag;
 			}
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 0d94e40..9995780 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -377,36 +377,36 @@ static int append_ref(const char *refname, const unsigned char *sha1,
 static int append_head_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
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
 	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	unsigned char tmp[20];
-	int ofs = 13;
-	if (strncmp(refname, "refs/remotes/", ofs))
+	int ofs = STRLEN_PATH_REFS_REMOTES;
+	if (strncmp(refname, PATH_REFS_REMOTES, ofs))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
 	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
-		ofs = 5;
+		ofs = STRLEN_PATH_REFS;
 	return append_ref(refname + ofs, sha1, 0);
 }
 
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	if (strncmp(refname, "refs/tags/", 10))
+	if (strncmp(refname, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS))
 		return 0;
-	return append_ref(refname + 5, sha1, 0);
+	return append_ref(refname + STRLEN_PATH_REFS, sha1, 0);
 }
 
 static const char *match_ref_pattern = NULL;
@@ -435,9 +435,9 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 		return 0;
 	if (fnmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (!strncmp("refs/heads/", refname, 11))
+	if (!strncmp(PATH_REFS_HEADS, refname, STRLEN_PATH_REFS_HEADS))
 		return append_head_ref(refname, sha1, flag, cb_data);
-	if (!strncmp("refs/tags/", refname, 10))
+	if (!strncmp(PATH_REFS_TAGS, refname, STRLEN_PATH_REFS_TAGS))
 		return append_tag_ref(refname, sha1, flag, cb_data);
 	return append_ref(refname, sha1, 0);
 }
@@ -462,12 +462,12 @@ static int rev_is_head(char *head, int headlen, char *name,
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
 
@@ -777,7 +777,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				has_head++;
 		}
 		if (!has_head) {
-			int pfxlen = strlen("refs/heads/");
+			int pfxlen = STRLEN_PATH_REFS_HEADS;
 			append_one_rev(head + pfxlen);
 		}
 	}
diff --git a/builtin-show-ref.c b/builtin-show-ref.c
index 853f13f..2c20cde 100644
--- a/builtin-show-ref.c
+++ b/builtin-show-ref.c
@@ -28,8 +28,8 @@ static int show_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	if (tags_only || heads_only) {
 		int match;
 
-		match = heads_only && !strncmp(refname, "refs/heads/", 11);
-		match |= tags_only && !strncmp(refname, "refs/tags/", 10);
+		match = heads_only && !strncmp(refname, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS);
+		match |= tags_only && !strncmp(refname, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS);
 		if (!match)
 			return 0;
 	}
@@ -224,7 +224,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		unsigned char sha1[20];
 
 		while (*pattern) {
-			if (!strncmp(*pattern, "refs/", 5) &&
+			if (!strncmp(*pattern, PATH_REFS, STRLEN_PATH_REFS) &&
 			    resolve_ref(*pattern, sha1, 1, NULL)) {
 				if (!quiet)
 					show_one(*pattern, sha1);
diff --git a/connect.c b/connect.c
index 7844888..8701de0 100644
--- a/connect.c
+++ b/connect.c
@@ -11,23 +11,23 @@ static int check_ref(const char *name, int len, unsigned int flags)
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
@@ -196,8 +196,8 @@ static int count_refspec_match(const char *pattern,
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
@@ -284,7 +284,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 		case 1:
 			break;
 		case 0:
-			if (!memcmp(rs[i].dst, "refs/", 5)) {
+			if (!memcmp(rs[i].dst, PATH_REFS, STRLEN_PATH_REFS)) {
 				int len = strlen(rs[i].dst) + 1;
 				matched_dst = xcalloc(1, sizeof(*dst) + len);
 				memcpy(matched_dst->name, rs[i].dst, len);
@@ -305,7 +305,7 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 				errs = 1;
 				error("dst refspec %s does not match any "
 				      "existing ref on the remote and does "
-				      "not start with refs/.", rs[i].dst);
+				      "not start with " PATH_REFS ".", rs[i].dst);
 			}
 			break;
 		default:
diff --git a/fetch-pack.c b/fetch-pack.c
index c787106..14a74d2 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -342,11 +342,11 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 
 	for (ref = *refs; ref; ref = next) {
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_ref_format(ref->name + 5))
+		if (!memcmp(ref->name, PATH_REFS, STRLEN_PATH_REFS) &&
+		    check_ref_format(ref->name + STRLEN_PATH_REFS))
 			; /* trash */
 		else if (fetch_all &&
-			 (!depth || strncmp(ref->name, "refs/tags/", 10) )) {
+			 (!depth || strncmp(ref->name, PATH_REFS_TAGS, STRLEN_PATH_REFS_TAGS) )) {
 			*newtail = ref;
 			ref->next = NULL;
 			newtail = &ref->next;
diff --git a/http-fetch.c b/http-fetch.c
index 9f790a0..79ef85a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -3,6 +3,7 @@
 #include "pack.h"
 #include "fetch.h"
 #include "http.h"
+#include "refs.h"
 
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
@@ -938,14 +939,14 @@ static char *quote_ref_url(const char *base, const char *ref)
 	int len, baselen, ch;
 
 	baselen = strlen(base);
-	len = baselen + 6; /* "refs/" + NUL */
+	len = baselen + STRLEN_PATH_REFS + 1; /* "refs/" + NUL */
 	for (cp = ref; (ch = *cp) != 0; cp++, len++)
 		if (needs_quote(ch))
 			len += 2; /* extra two hex plus replacement % */
 	qref = xmalloc(len);
 	memcpy(qref, base, baselen);
-	memcpy(qref + baselen, "refs/", 5);
-	for (cp = ref, dp = qref + baselen + 5; (ch = *cp) != 0; cp++) {
+	memcpy(qref + baselen, PATH_REFS, STRLEN_PATH_REFS);
+	for (cp = ref, dp = qref + baselen + STRLEN_PATH_REFS; (ch = *cp) != 0; cp++) {
 		if (needs_quote(ch)) {
 			*dp++ = '%';
 			*dp++ = hex((ch >> 4) & 0xF);
diff --git a/http-push.c b/http-push.c
index b128c01..37d2f50 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1922,7 +1922,7 @@ static void get_local_heads(void)
 static void get_dav_remote_heads(void)
 {
 	remote_tail = &remote_refs;
-	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
+	remote_ls(PATH_REFS, (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
 }
 
 static int is_zero_sha1(const unsigned char *sha1)
@@ -2066,7 +2066,7 @@ static void update_remote_info_refs(struct remote_lock *lock)
 	buffer.buffer = xcalloc(1, 4096);
 	buffer.size = 4096;
 	buffer.posn = 0;
-	remote_ls("refs/", (PROCESS_FILES | RECURSIVE),
+	remote_ls(PATH_REFS, (PROCESS_FILES | RECURSIVE),
 		  add_remote_info_ref, &buffer);
 	if (!aborted) {
 		if_header = xmalloc(strlen(lock->token) + 25);
diff --git a/local-fetch.c b/local-fetch.c
index 7cfe8b3..7b80a31 100644
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
index c5d25a4..dfbae16 100644
--- a/path.c
+++ b/path.c
@@ -11,6 +11,7 @@
  * which is what it's designed for.
  */
 #include "cache.h"
+#include "refs.h"
 
 static char bad_path[] = "/bad-path/";
 
@@ -103,7 +104,7 @@ int validate_headref(const char *path)
 	/* Make sure it is a "refs/.." symlink */
 	if (S_ISLNK(st.st_mode)) {
 		len = readlink(path, buffer, sizeof(buffer)-1);
-		if (len >= 5 && !memcmp("refs/", buffer, 5))
+		if (len >= 5 && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS))
 			return 0;
 		return -1;
 	}
@@ -127,7 +128,7 @@ int validate_headref(const char *path)
 		len -= 4;
 		while (len && isspace(*buf))
 			buf++, len--;
-		if (len >= 5 && !memcmp("refs/", buf, 5))
+		if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buf, STRLEN_PATH_REFS))
 			return 0;
 	}
 
diff --git a/receive-pack.c b/receive-pack.c
index 7311c82..6fd9f60 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -109,7 +109,7 @@ static int update(struct command *cmd)
 	struct ref_lock *lock;
 
 	cmd->error_string = NULL;
-	if (!strncmp(name, "refs/", 5) && check_ref_format(name + 5)) {
+	if (!strncmp(name, PATH_REFS, STRLEN_PATH_REFS) && check_ref_format(name + STRLEN_PATH_REFS)) {
 		cmd->error_string = "funny refname";
 		return error("refusing to create funny ref '%s' locally",
 			     name);
@@ -125,7 +125,7 @@ static int update(struct command *cmd)
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
 	    !is_null_sha1(old_sha1) &&
-	    !strncmp(name, "refs/heads/", 11)) {
+	    !strncmp(name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS)) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
diff --git a/reflog-walk.c b/reflog-walk.c
index c983858..c05a404 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -55,11 +55,11 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 	}
 	if (reflogs->nr == 0) {
 		int len = strlen(ref);
-		char *refname = xmalloc(len + 12);
-		sprintf(refname, "refs/%s", ref);
+		char *refname = xmalloc(len + STRLEN_PATH_REFS_HEADS + 1);
+		sprintf(refname, PATH_REFS "%s", ref);
 		for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		if (reflogs->nr == 0) {
-			sprintf(refname, "refs/heads/%s", ref);
+			sprintf(refname, PATH_REFS_HEADS "%s", ref);
 			for_each_reflog_ent(refname, read_one_reflog, reflogs);
 		}
 		free(refname);
diff --git a/refs.c b/refs.c
index 6387703..997b360 100644
--- a/refs.c
+++ b/refs.c
@@ -261,7 +261,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
 		if (S_ISLNK(st.st_mode)) {
 			len = readlink(path, buffer, sizeof(buffer)-1);
-			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
+			if (len >= STRLEN_PATH_REFS && !memcmp(PATH_REFS, buffer, STRLEN_PATH_REFS)) {
 				buffer[len] = 0;
 				strcpy(ref_buffer, buffer);
 				ref = ref_buffer;
@@ -413,22 +413,22 @@ int head_ref(each_ref_fn fn, void *cb_data)
 
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
+	return do_for_each_ref(PATH_REFS_HEADS, fn, STRLEN_PATH_REFS_HEADS, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref("refs/remotes/", fn, 13, cb_data);
+	return do_for_each_ref(PATH_REFS_REMOTES, fn, STRLEN_PATH_REFS_REMOTES, cb_data);
 }
 
 /* NEEDSWORK: This is only used by ssh-upload and it should go; the
@@ -440,7 +440,7 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
 	if (check_ref_format(ref))
 		return -1;
-	return read_ref(mkpath("refs/%s", ref), sha1);
+	return read_ref(mkpath(PATH_REFS "%s", ref), sha1);
 }
 
 /*
@@ -657,7 +657,7 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 	char refpath[PATH_MAX];
 	if (check_ref_format(ref))
 		return NULL;
-	strcpy(refpath, mkpath("refs/%s", ref));
+	strcpy(refpath, mkpath(PATH_REFS "%s", ref));
 	return lock_ref_sha1_basic(refpath, old_sha1, NULL);
 }
 
@@ -828,12 +828,12 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		goto rollback;
 	}
 
-	if (!strncmp(oldref, "refs/heads/", 11) &&
-			!strncmp(newref, "refs/heads/", 11)) {
+	if (!strncmp(oldref, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS) &&
+			!strncmp(newref, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS)) {
 		char oldsection[1024], newsection[1024];
 
-		snprintf(oldsection, 1024, "branch.%s", oldref + 11);
-		snprintf(newsection, 1024, "branch.%s", newref + 11);
+		snprintf(oldsection, 1024, "branch.%s", oldref + STRLEN_PATH_REFS_HEADS);
+		snprintf(newsection, 1024, "branch.%s", newref + STRLEN_PATH_REFS_HEADS);
 		if (git_config_rename_section(oldsection, newsection) < 0)
 			return 1;
 	}
@@ -894,8 +894,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	log_file = git_path("logs/%s", ref_name);
 
 	if (log_all_ref_updates &&
-	    (!strncmp(ref_name, "refs/heads/", 11) ||
-	     !strncmp(ref_name, "refs/remotes/", 13) ||
+	    (!strncmp(ref_name,  PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS) ||
+	     !strncmp(ref_name, PATH_REFS_REMOTES, STRLEN_PATH_REFS_HEADS) ||
 	     !strcmp(ref_name, "HEAD"))) {
 		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
diff --git a/refs.h b/refs.h
index acedffc..a986b42 100644
--- a/refs.h
+++ b/refs.h
@@ -13,6 +13,23 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
+#define PATH_OBJECTS             "objects/"
+#define STRLEN_PATH_OBJECTS      8
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
index e9d3f5a..782fc07 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "refs.h"
 
 const char *prefix_path(const char *prefix, int len, const char *path)
 {
@@ -154,12 +155,12 @@ static int is_git_directory(const char *suspect)
 			return 0;
 	}
 	else {
-		strcpy(path + len, "/objects");
+		strcpy(path + len, "/" PATH_OBJECTS);
 		if (access(path, X_OK))
 			return 0;
 	}
 
-	strcpy(path + len, "/refs");
+	strcpy(path + len, "/" PATH_REFS);
 	if (access(path, X_OK))
 		return 0;
 
diff --git a/sha1_name.c b/sha1_name.c
index a7efa96..add6123 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -237,11 +237,11 @@ static int ambiguous_path(const char *path, int len)
 
 static const char *ref_fmt[] = {
 	"%.*s",
-	"refs/%.*s",
-	"refs/tags/%.*s",
-	"refs/heads/%.*s",
-	"refs/remotes/%.*s",
-	"refs/remotes/%.*s/HEAD",
+	PATH_REFS "%.*s",
+	PATH_REFS_TAGS "%.*s",
+	PATH_REFS_HEADS "%.*s",
+	PATH_REFS_REMOTES "%.*s",
+	PATH_REFS_REMOTES "%.*s/HEAD",
 	NULL
 };
 
diff --git a/wt-status.c b/wt-status.c
index 2879c3d..9f2705c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -7,6 +7,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "diffcore.h"
+#include "refs.h"
 
 int wt_status_use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
@@ -298,8 +299,8 @@ void wt_status_print(struct wt_status *s)
 	if (s->branch) {
 		const char *on_what = "On branch ";
 		const char *branch_name = s->branch;
-		if (!strncmp(branch_name, "refs/heads/", 11))
-			branch_name += 11;
+		if (!strncmp(branch_name, PATH_REFS_HEADS, STRLEN_PATH_REFS_HEADS))
+			branch_name += STRLEN_PATH_REFS_HEADS;
 		else if (!strcmp(branch_name, "HEAD")) {
 			branch_name = "";
 			on_what = "Not currently on any branch.";
-- 
1.5.0.rc4.gb4d2
