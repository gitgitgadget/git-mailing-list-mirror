From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] git-branch: add support for --merged and --unmerged
Date: Thu, 17 Apr 2008 11:37:03 +0200
Message-ID: <12084250231245-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 11:21:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmQCs-0007s1-NB
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 11:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765056AbYDQJOA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 05:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765042AbYDQJN7
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 05:13:59 -0400
Received: from mail43.e.nsc.no ([193.213.115.43]:47237 "EHLO mail43.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764802AbYDQJNz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 05:13:55 -0400
X-Greylist: delayed 1884 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Apr 2008 05:13:55 EDT
Received: from localhost.localdomain (ti0025a380-0176.bb.online.no [88.89.68.176])
	by mail43.nsc.no (8.13.8/8.13.5) with ESMTP id m3H8gHHX027151;
	Thu, 17 Apr 2008 10:42:20 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.1.1.g1e61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79777>

These options filter the output from git branch to only include branches
whose tip is either merged or not merged into HEAD.

The use-case for these options is when working with integration of branches
from many remotes: `git branch --unmerged -a` will show a nice list of merge
candidates while `git branch --merged -a` will show the progress of your
integration work.

Also, a plain `git branch --merged` is a quick way to find local branches
which you might want to delete.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-branch.txt |    4 +++-
 builtin-branch.c             |   29 ++++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6f07a17..2693519 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git-branch' [--color | --no-color] [-r | -a]
+'git-branch' [--color | --no-color] [-r | -a] [--merged | --unmerged]
 	   [-v [--abbrev=<length> | --no-abbrev]]
 	   [--contains <commit>]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
@@ -24,6 +24,8 @@ and option `-a` shows both.
 With `--contains <commit>`, shows only the branches that
 contains the named commit (in other words, the branches whose
 tip commits are descendant of the named commit).
+With `--merged`, only branches merged into HEAD will be listed,
+and with `--unmerged` only branches not merged into HEAD will be listed.
 
 In its second form, a new branch named <branchname> will be created.
 It will start out with a head equal to the one given as <start-point>.
diff --git a/builtin-branch.c b/builtin-branch.c
index 5bc4526..7c91ff0 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -15,7 +15,7 @@
 #include "branch.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git-branch [options] [-r | -a]",
+	"git-branch [options] [-r | -a] [--merged | --unmerged]",
 	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
 	"git-branch [options] [-r] (-d | -D) <branchname>",
 	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
@@ -30,6 +30,8 @@ static const char * const builtin_branch_usage[] = {
 static const char *head;
 static unsigned char head_sha1[20];
 
+static int merged, unmerged;
+
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
 	"\033[m",	/* reset */
@@ -204,6 +206,22 @@ static int has_commit(const unsigned char *sha1, struct commit_list *with_commit
 	return 0;
 }
 
+static int is_merged(const unsigned char *sha1, const char *refname)
+{
+	static struct commit *head_commit;
+	struct commit *branch;
+
+	if (!head_commit) {
+		head_commit = lookup_commit_reference(head_sha1);
+		if (!head_commit)
+			die("Unable to lookup HEAD");
+	}
+	branch = lookup_commit_reference(sha1);
+	if (!branch)
+		die("Unable to lookup branch %s", refname);
+	return in_merge_bases(branch, &head_commit, 1);
+}
+
 static int append_ref(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct ref_list *ref_list = (struct ref_list*)(cb_data);
@@ -231,6 +249,12 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if ((kind & ref_list->kinds) == 0)
 		return 0;
 
+	if (unmerged == 1 && is_merged(sha1, refname))
+		return 0;
+
+	if (merged == 1 && !is_merged(sha1, refname))
+		return 0;
+
 	/* Resize buffer */
 	if (ref_list->index >= ref_list->alloc) {
 		ref_list->alloc = alloc_nr(ref_list->alloc);
@@ -444,6 +468,9 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', NULL, &force_create, "force creation (when already exists)"),
+		OPT_BIT(0, "unmerged", &unmerged, "list only unmerged branches", 1),
+		OPT_BIT(0, "merged", &merged, "list only merged branches", 1),
+
 		OPT_END(),
 	};
 
-- 
1.5.3.1.1.g1e61
