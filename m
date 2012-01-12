From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] tree_entry_interesting: make recursive mode default
Date: Thu, 12 Jan 2012 11:09:31 +0700
Message-ID: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
References: <20120111063104.GA3153@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 05:09:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlBz7-0003ZV-IS
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 05:09:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517Ab2ALEJs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 23:09:48 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53214 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2ALEJr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 23:09:47 -0500
Received: by iabz25 with SMTP id z25so2091133iab.19
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 20:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZmZJ9G6YsWrfb7Z+hTpNOgFSSBVVeEpMTonCdHdljPM=;
        b=UA4GB6n3OdDjr9WB4BNtDkdv+MvPOuknsjSVUhwOijdPFKfG2RTSA2fd4Pi9x7Wfkh
         fJd0gSCK73TGV+N8lyuJDLvbjSa92uSCnb9xx67koj0GJWQ3V09rOV3zyjgWTO1vxQn1
         ZLFKeZsgTWvhYgMBMcqe2HH0y564aP0z2yi0c=
Received: by 10.50.214.38 with SMTP id nx6mr9660431igc.19.1326341386721;
        Wed, 11 Jan 2012 20:09:46 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id r5sm6341184igl.3.2012.01.11.20.09.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Jan 2012 20:09:45 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 12 Jan 2012 11:09:32 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <20120111063104.GA3153@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188428>

There is a bit of history behind this. Some time ago, t_e_i() only
supported prefix matching. diff-tree supported recursive and
non-recursive mode but it did not make any difference to prefix
matching.

Later on, t_e_i() gained limited recursion support to unify a similar
matching code used by git-grep. It introduced two new fields in struct
pathspec: max_depth and recursive. "recursive" field functions as a
feature switch so that this feature is off by default.

Some time after that, t_e_i() further gained wildcard support. With
wildcard matching, recursive and non-recursive diff-tree
mattered. "recursive" field was reused to distinguish recursion in
diff-tree.

This choice has a side effect that by default wildcard matching is in
non-recursive mode, which is not true. All current call sites except
"diff-tree without -r" (grep, traverse_commit_list, tree-walk and
general tree diff) prefer recursive mode.

This patch decouples the use of recursive field. The max_depth feature
switch is now controlled by max_depth_valid field. diff-tree recursion
is controlled by nonrecursive_diff_tree, which makes it recursive by
default.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Junio, log/diff family takes wildcards just fine (even before this
 patch, just less reliable). If it's not mentioned in release notes
 before, perhaps it's worth a line in 1.7.9 annoucement.

 builtin/grep.c           |    2 +-
 cache.h                  |    3 ++-
 dir.c                    |    4 ++--
 t/t4010-diff-pathspec.sh |    8 ++++++++
 tree-diff.c              |    3 +--
 tree-walk.c              |    8 ++++----
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..c081bf4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1051,7 +1051,7 @@ int cmd_grep(int argc, const char **argv, const c=
har *prefix)
 	paths =3D get_pathspec(prefix, argv + i);
 	init_pathspec(&pathspec, paths);
 	pathspec.max_depth =3D opt.max_depth;
-	pathspec.recursive =3D 1;
+	pathspec.max_depth_valid =3D 1;
=20
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
diff --git a/cache.h b/cache.h
index 10afd71..f58e05a 100644
--- a/cache.h
+++ b/cache.h
@@ -526,7 +526,8 @@ struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
 	unsigned int has_wildcard:1;
-	unsigned int recursive:1;
+	unsigned int max_depth_valid:1;
+	unsigned int nonrecursive_diff_tree:1;
 	int max_depth;
 	struct pathspec_item {
 		const char *match;
diff --git a/dir.c b/dir.c
index 0a78d00..5af3567 100644
--- a/dir.c
+++ b/dir.c
@@ -258,7 +258,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 	int i, retval =3D 0;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
 			return MATCHED_RECURSIVELY;
=20
 		if (within_depth(name, namelen, 0, ps->max_depth))
@@ -275,7 +275,7 @@ int match_pathspec_depth(const struct pathspec *ps,
 		if (seen && seen[i] =3D=3D MATCHED_EXACTLY)
 			continue;
 		how =3D match_pathspec_item(ps->items+i, prefix, name, namelen);
-		if (ps->recursive && ps->max_depth !=3D -1 &&
+		if (ps->max_depth_valid && ps->max_depth !=3D -1 &&
 		    how && how !=3D MATCHED_FNMATCH) {
 			int len =3D ps->items[i].len;
 			if (name[len] =3D=3D '/')
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index fbc8cd8..af5134b 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -48,6 +48,14 @@ test_expect_success \
      compare_diff_raw current expected'
=20
 cat >expected <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be=
0328a19b29f18cdcb49338d516 M	path1/file1
+EOF
+test_expect_success \
+    '"*file1" should show path1/file1' \
+    'git diff-index --cached $tree -- "*file1" >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
 :100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be=
0328a19b29f18cdcb49338d516 M	file0
 EOF
 test_expect_success \
diff --git a/tree-diff.c b/tree-diff.c
index 28ad6db..164693f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -137,8 +137,7 @@ int diff_tree(struct tree_desc *t1, struct tree_des=
c *t2,
 	enum interesting t2_match =3D entry_not_interesting;
=20
 	/* Enable recursion indefinitely */
-	opt->pathspec.recursive =3D DIFF_OPT_TST(opt, RECURSIVE);
-	opt->pathspec.max_depth =3D -1;
+	opt->pathspec.nonrecursive_diff_tree =3D !DIFF_OPT_TST(opt, RECURSIVE=
);
=20
 	strbuf_init(&base, PATH_MAX);
 	strbuf_add(&base, base_str, baselen);
diff --git a/tree-walk.c b/tree-walk.c
index f82dba6..04f1b81 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -588,7 +588,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 		entry_not_interesting : all_entries_not_interesting;
=20
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth =3D=3D -1)
+		if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
 				    !!S_ISDIR(entry->mode),
@@ -609,7 +609,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 			if (!match_dir_prefix(base_str, match, matchlen))
 				goto match_wildcards;
=20
-			if (!ps->recursive || ps->max_depth =3D=3D -1)
+			if (!ps->max_depth_valid || ps->max_depth =3D=3D -1)
 				return all_entries_interesting;
=20
 			return within_depth(base_str + matchlen + 1,
@@ -634,7 +634,7 @@ enum interesting tree_entry_interesting(const struc=
t name_entry *entry,
 				 * Match all directories. We'll try to
 				 * match files later on.
 				 */
-				if (ps->recursive && S_ISDIR(entry->mode))
+				if (!ps->nonrecursive_diff_tree && S_ISDIR(entry->mode))
 					return entry_interesting;
 			}
=20
@@ -662,7 +662,7 @@ match_wildcards:
 		 * Match all directories. We'll try to match files
 		 * later on.
 		 */
-		if (ps->recursive && S_ISDIR(entry->mode))
+		if (!ps->nonrecursive_diff_tree && S_ISDIR(entry->mode))
 			return entry_interesting;
 	}
 	return never_interesting; /* No matches */
--=20
1.7.3.1.256.g2539c.dirty
