From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/5] Call mkpathdup() rather than xstrdup(mkpath(...))
Date: Tue, 04 Sep 2012 18:31:14 +0100
Message-ID: <50463AE2.3010604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 21:07:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8yTA-0001jC-H9
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 21:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636Ab2IDTHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 15:07:18 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:40944 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932617Ab2IDTHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 15:07:16 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 19CCC128076;
	Tue,  4 Sep 2012 20:07:15 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 11DB2128075;	Tue,  4 Sep 2012 20:07:14 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tch.inty.net (Postfix) with ESMTP;	Tue,  4 Sep 2012 20:07:13 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204772>


In addition to updating the xstrdup(mkpath(...)) call sites with
mkpathdup(), we also fix a memory leak (in merge_3way()) caused by
neglecting to free the memory allocated to the 'base_name' variable.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/branch.c  |  2 +-
 builtin/clone.c   |  4 ++--
 builtin/prune.c   |  2 +-
 merge-recursive.c | 13 +++++++------
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..bdf8495 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -196,7 +196,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 
 		free(name);
 
-		name = xstrdup(mkpath(fmt, bname.buf));
+		name = mkpathdup(fmt, bname.buf);
 		if (read_ref(name, sha1)) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
diff --git a/builtin/clone.c b/builtin/clone.c
index e314b0b..c819757 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -236,7 +236,7 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	/* Beware: real_path() and mkpath() return static buffer */
 	ref_git = xstrdup(real_path(item->string));
 	if (is_directory(mkpath("%s/.git/objects", ref_git))) {
-		char *ref_git_git = xstrdup(mkpath("%s/.git", ref_git));
+		char *ref_git_git = mkpathdup("%s/.git", ref_git);
 		free(ref_git);
 		ref_git = ref_git_git;
 	} else if (!is_directory(mkpath("%s/objects", ref_git)))
@@ -700,7 +700,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_dir = xstrdup(dir);
 	else {
 		work_tree = dir;
-		git_dir = xstrdup(mkpath("%s/.git", dir));
+		git_dir = mkpathdup("%s/.git", dir);
 	}
 
 	if (!option_bare) {
diff --git a/builtin/prune.c b/builtin/prune.c
index 6cb9944..685f8a0 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -169,7 +169,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 
 	prune_packed_objects(show_only);
 	remove_temporary_files(get_object_directory());
-	s = xstrdup(mkpath("%s/pack", get_object_directory()));
+	s = mkpathdup("%s/pack", get_object_directory());
 	remove_temporary_files(s);
 	free(s);
 	return 0;
diff --git a/merge-recursive.c b/merge-recursive.c
index 7866ca1..d882060 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -844,14 +844,14 @@ static int merge_3way(struct merge_options *o,
 	if (strcmp(a->path, b->path) ||
 	    (o->ancestor != NULL && strcmp(a->path, one->path) != 0)) {
 		base_name = o->ancestor == NULL ? NULL :
-			xstrdup(mkpath("%s:%s", o->ancestor, one->path));
-		name1 = xstrdup(mkpath("%s:%s", branch1, a->path));
-		name2 = xstrdup(mkpath("%s:%s", branch2, b->path));
+			mkpathdup("%s:%s", o->ancestor, one->path);
+		name1 = mkpathdup("%s:%s", branch1, a->path);
+		name2 = mkpathdup("%s:%s", branch2, b->path);
 	} else {
 		base_name = o->ancestor == NULL ? NULL :
-			xstrdup(mkpath("%s", o->ancestor));
-		name1 = xstrdup(mkpath("%s", branch1));
-		name2 = xstrdup(mkpath("%s", branch2));
+			mkpathdup("%s", o->ancestor);
+		name1 = mkpathdup("%s", branch1);
+		name2 = mkpathdup("%s", branch2);
 	}
 
 	read_mmblob(&orig, one->sha1);
@@ -861,6 +861,7 @@ static int merge_3way(struct merge_options *o,
 	merge_status = ll_merge(result_buf, a->path, &orig, base_name,
 				&src1, name1, &src2, name2, &ll_opts);
 
+	free(base_name);
 	free(name1);
 	free(name2);
 	free(orig.ptr);
-- 
1.7.12
