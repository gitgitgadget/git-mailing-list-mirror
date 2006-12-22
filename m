From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Make git-show-branch options similar to git-branch.
Date: Fri, 22 Dec 2006 08:58:39 -0500
Message-ID: <20061222135839.GB26084@179.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Dec 22 14:58:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxkv5-0005lS-7t
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 14:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbWLVN6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 08:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754843AbWLVN6k
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 08:58:40 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:49043 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845AbWLVN6j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 08:58:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by silverinsanity.com (Postfix) with ESMTP id 4E9DF1FFC02B
	for <git@vger.kernel.org>; Fri, 22 Dec 2006 13:58:39 +0000 (UTC)
Received: from Mutt by mutt-smtp-wrapper.pl 1.2  (www.zdo.com/articles/mutt-smtp-wrapper.shtml)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35176>

Branch has "-r" for remote branches and "-a" for local and remote.
Seems logical to mirror that in show-branch.  Also removes the
dubiously useful "--tags" option (as part of changing the meaning for
"--all").

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

 Similar to my eariler patch but instead of wanting to add --remotes
 for completeness I now want to add it to mirror "git branch".  By the
 prinicple of least surprise, "git branch -a" and "git show-branch -a"
 should display the same refs.  (Same for "-r".)

 Documentation/git-show-branch.txt |   10 +++++---
 builtin-show-branch.c             |   40 ++++++++++++++++++++++++-------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 948ff10..dafacd4 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,7 +8,7 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git-show-branch' [--all] [--heads] [--tags] [--topo-order] [--current]
+'git-show-branch' [--all] [--remotes] [--topo-order] [--current]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics] [<rev> | <glob>]...
 
@@ -37,9 +37,11 @@ OPTIONS
 	branches under $GIT_DIR/refs/heads/topic, giving
 	`topic/*` would show all of them.
 
---all --heads --tags::
-	Show all refs under $GIT_DIR/refs, $GIT_DIR/refs/heads,
-	and $GIT_DIR/refs/tags, respectively.
+-r|--remotes::
+	Show the remote-tracking branches.
+
+-a|--all::
+	Show both remote-tracking branches and local branches.
 
 --current::
 	With this option, the command includes the current
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index b9d9781..c67f2fa 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--sparse] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n] <branch>";
+"git-show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n] <branch>";
 
 static int default_num;
 static int default_alloc;
@@ -383,6 +383,20 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 	return append_ref(refname + ofs, sha1, flag, cb_data);
 }
 
+static int append_remote_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	unsigned char tmp[20];
+	int ofs = 13;
+	if (strncmp(refname, "refs/remotes/", ofs))
+		return 0;
+	/* If both heads/foo and tags/foo exists, get_sha1 would
+	 * get confused.
+	 */
+	if (get_sha1(refname + ofs, tmp) || hashcmp(tmp, sha1))
+		ofs = 5;
+	return append_ref(refname + ofs, sha1, flag, cb_data);
+}
+
 static int append_tag_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	if (strncmp(refname, "refs/tags/", 10))
@@ -423,16 +437,16 @@ static int append_matching_ref(const char *refname, const unsigned char *sha1, i
 	return append_ref(refname, sha1, flag, cb_data);
 }
 
-static void snarf_refs(int head, int tag)
+static void snarf_refs(int head, int remotes)
 {
 	if (head) {
 		int orig_cnt = ref_name_cnt;
 		for_each_ref(append_head_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
-	if (tag) {
+	if (remotes) {
 		int orig_cnt = ref_name_cnt;
-		for_each_ref(append_tag_ref, NULL);
+		for_each_ref(append_remote_ref, NULL);
 		sort_ref_range(orig_cnt, ref_name_cnt);
 	}
 }
@@ -554,7 +568,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	struct commit_list *list = NULL, *seen = NULL;
 	unsigned int rev_mask[MAX_REVS];
 	int num_rev, i, extra = 0;
-	int all_heads = 0, all_tags = 0;
+	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
 	int lifo = 1;
 	char head[128];
@@ -586,12 +600,10 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			ac--; av++;
 			break;
 		}
-		else if (!strcmp(arg, "--all"))
-			all_heads = all_tags = 1;
-		else if (!strcmp(arg, "--heads"))
-			all_heads = 1;
-		else if (!strcmp(arg, "--tags"))
-			all_tags = 1;
+		else if (!strcmp(arg, "--all") || !strcmp(arg, "-a"))
+			all_heads = all_remotes = 1;
+		else if (!strcmp(arg, "--remotes") || !strcmp(arg, "-r"))
+			all_remotes = 1;
 		else if (!strcmp(arg, "--more"))
 			extra = 1;
 		else if (!strcmp(arg, "--list"))
@@ -636,11 +648,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		usage(show_branch_usage);
 
 	/* If nothing is specified, show all branches by default */
-	if (ac + all_heads + all_tags == 0)
+	if (ac + all_heads + all_remotes == 0)
 		all_heads = 1;
 
-	if (all_heads + all_tags)
-		snarf_refs(all_heads, all_tags);
+	if (all_heads + all_remotes)
+		snarf_refs(all_heads, all_remotes);
 	if (reflog) {
 		int reflen;
 		if (!ac)
-- 
1.4.4.GIT
