From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] show-branch: always include the current branch.
Date: Wed, 11 Jan 2006 16:05:50 -0800
Message-ID: <7vace2joo1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 12 01:06:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewpz7-0002S8-CP
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbWALAFy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWALAFx
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:05:53 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31370 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964819AbWALAFw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:05:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060112000348.YEHH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 19:03:48 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14535>

By default, the command includes the current branch to the list
of revs to be shown, even when it is not given on the command
line.  A new flag, --no-current, disables it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 * Currently in "pu".

 Documentation/git-show-branch.txt |   13 ++++++++--
 show-branch.c                     |   49 ++++++++++++++++++++++++++-----------
 2 files changed, 46 insertions(+), 16 deletions(-)

95a7c01ab91b71f72b6d5d60da7659b2b625fa6d
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 9cc44a8..90e2a5c 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -7,7 +7,10 @@ git-show-branch - Show branches and thei
 
 SYNOPSIS
 --------
-'git-show-branch [--all] [--heads] [--tags] [--topo-order] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [<rev> | <glob>]...'
+[verse]
+git-show-branch [--all] [--heads] [--tags] [--topo-order] [--no-current]
+	[--more=<n> | --list | --independent | --merge-base]
+	[--no-name | --sha1-name] [<rev> | <glob>]...
 
 DESCRIPTION
 -----------
@@ -38,6 +41,11 @@ OPTIONS
 	Show all refs under $GIT_DIR/refs, $GIT_DIR/refs/heads,
 	and $GIT_DIR/refs/tags, respectively.
 
+--no-current::
+	By default, the command includes the current branch to
+	the list of revs to be shown even when it is not given
+	on the command line.  This flag disables it.
+
 --topo-order::
         By default, the branches and their commits are shown in
         reverse chronological order.  This option makes them
@@ -133,7 +141,8 @@ it, having the following in the configur
 ------------
 
 With this,`git show-branch` without extra parameters would show
-only the primary branches.
+only the primary branches.  In addition, if you happen to be on
+your topic branch, it is shown as well.
 
 
 
diff --git a/show-branch.c b/show-branch.c
index f43c406..9f7e188 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [<refs>...]";
+"git-show-branch [--no-current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [<refs>...]";
 
 static int default_num = 0;
 static int default_alloc = 0;
@@ -435,12 +435,12 @@ static void snarf_refs(int head, int tag
 	}
 }
 
-static int rev_is_head(char *head_path, int headlen,
-		       char *name,
+static int rev_is_head(char *head_path, int headlen, char *name,
 		       unsigned char *head_sha1, unsigned char *sha1)
 {
 	int namelen;
-	if ((!head_path[0]) || memcmp(head_sha1, sha1, 20))
+	if ((!head_path[0]) ||
+	    (head_sha1 && sha1 && memcmp(head_sha1, sha1, 20)))
 		return 0;
 	namelen = strlen(name);
 	if ((headlen < namelen) ||
@@ -545,6 +545,7 @@ int main(int ac, char **av)
 	int sha1_name = 0;
 	int shown_merge_point = 0;
 	int topo_order = 0;
+	int no_current_branch = 0;
 
 	git_config(git_show_branch_config);
 	setup_git_directory();
@@ -573,6 +574,8 @@ int main(int ac, char **av)
 			extra = -1;
 		else if (!strcmp(arg, "--no-name"))
 			no_name = 1;
+		else if (!strcmp(arg, "--no-current"))
+			no_current_branch = 1;
 		else if (!strcmp(arg, "--sha1-name"))
 			sha1_name = 1;
 		else if (!strncmp(arg, "--more=", 7))
@@ -604,6 +607,34 @@ int main(int ac, char **av)
 		ac--; av++;
 	}
 
+	head_path_p = resolve_ref(git_path("HEAD"), head_sha1, 1);
+	if (head_path_p) {
+		head_path_len = strlen(head_path_p);
+		memcpy(head_path, head_path_p, head_path_len + 1);
+	}
+	else {
+		head_path_len = 0;
+		head_path[0] = 0;
+	}
+
+	if (!merge_base && !no_current_branch && head_path_p) {
+		int has_head = 0;
+		for (i = 0; !has_head && i < ref_name_cnt; i++) {
+			/* We are only interested in adding the branch
+			 * HEAD points at.
+			 */
+			if (rev_is_head(head_path,
+					head_path_len,
+					ref_name[i],
+					head_sha1, NULL))
+				has_head++;
+		}
+		if (!has_head) {
+			int pfxlen = strlen(git_path("refs/heads/"));
+			append_one_rev(head_path + pfxlen);
+		}
+	}
+
 	if (!ref_name_cnt) {
 		fprintf(stderr, "No revs to be shown.\n");
 		exit(0);
@@ -639,16 +670,6 @@ int main(int ac, char **av)
 	if (0 <= extra)
 		join_revs(&list, &seen, num_rev, extra);
 
-	head_path_p = resolve_ref(git_path("HEAD"), head_sha1, 1);
-	if (head_path_p) {
-		head_path_len = strlen(head_path_p);
-		memcpy(head_path, head_path_p, head_path_len + 1);
-	}
-	else {
-		head_path_len = 0;
-		head_path[0] = 0;
-	}
-
 	if (merge_base)
 		return show_merge_base(seen, num_rev);
 
-- 
1.1.1-g8ecb
