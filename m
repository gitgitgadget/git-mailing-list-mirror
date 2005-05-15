From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Sun, 15 May 2005 09:29:56 +0100
Message-ID: <tnx3bsoki2j.fsf@arm.com>
References: <tnx64xm5b2b.fsf@arm.com> <20050514110941.GB3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 10:31:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXEWO-0000Rs-FX
	for gcvg-git@gmane.org; Sun, 15 May 2005 10:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVEOIau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 04:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVEOIau
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 04:30:50 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:45968 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261548AbVEOIaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 04:30:13 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j4F8U1fj005698;
	Sun, 15 May 2005 09:30:02 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA27435;
	Sun, 15 May 2005 09:30:06 +0100 (BST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050514110941.GB3905@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 13:09:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Sat, May 14, 2005 at 12:58:04PM CEST, I got a letter
> where Catalin Marinas <catalin.marinas@arm.com> told me that...
>> This patch adds a simple command that shows the unmerged changes on a
>> branch. I find it quite useful to be able to see the diff or the log
>> before merging (gnuarch has something similar with "missing").
>
> I'd prefer this to be functionality builtin to cg-log and cg-mkpatch.
> Perhaps some
>
> 	cg-log -m $branch2 [$branch1]
>
> to show stuff in branch2 not yet merged to branch1.

See the attached patch. Let me know if you want it implemented
differently. I also added the "-m" option to cg-diff.

-- 
Catalin


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=patch-m-option

"-m" option added to cg-diff, cg-log and cg-mkpatch

This option takes two optional parameters, branch2 and branch1, and shows
the changes in branch2 not yet merged to branch1. Branch2 defaults to
origin and branch1 to HEAD.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

---
commit 1a9bf2d3a0478344ae4019ac0725426627c32658
tree 3e889a5c03d7df9f82d7a649e02fef2ebdbb9f75
parent fa6e9eb368e949e78c4e66217461cf624b52b0a2
author Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Sun, 15 May 2005 09:25:49 +0100
committer Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Sun, 15 May 2005 09:25:49 +0100

 cg-diff    |   19 +++++++++++++++++++
 cg-help    |    6 +++---
 cg-log     |   19 +++++++++++++++++++
 cg-mkpatch |   19 +++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

Index: cg-diff
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-diff  (mode:100755)
+++ 3e889a5c03d7df9f82d7a649e02fef2ebdbb9f75/cg-diff  (mode:100755)
@@ -14,6 +14,9 @@
 # -p instead of one ID denotes a parent commit to the specified ID
 # (which must not be a tree, obviously).
 #
+# -m [branch2] [branch1] shows the changes in branch2 (defaulting to
+# origin) not yet merged to branch1 (defaulting to HEAD)
+#
 # Outputs a diff converting the first tree to the second one.
 
 . ${COGITO_LIB}cg-Xlib
@@ -31,6 +34,22 @@
 	parent=1
 fi
 
+if [ "$1" = "-m" ]; then
+	branch=HEAD
+	id2=origin
+	shift
+	if [ "$1" ]; then
+		id2=$1
+		shift
+	fi
+	if [ "$1" ]; then
+		branch=$1
+		shift
+	fi
+	id1=$(git-merge-base "$branch" "$id2")
+	[ "$id1" ] || die "Unable to determine the merge base"
+fi
+
 if [ "$1" = "-r" ]; then
 	shift
 	id1=$(echo "$1": | cut -d : -f 1)
Index: cg-help
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-help  (mode:100755)
+++ 3e889a5c03d7df9f82d7a649e02fef2ebdbb9f75/cg-help  (mode:100755)
@@ -26,14 +26,14 @@
 	cg-cancel
 	cg-clone	[-s] SOURCE_LOC [DESTDIR]
 	cg-commit	[-m"Commit message"]... [-e | -E] [FILE]... < log message
-	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [BNAME] [BNAME]] [FILE]...
 	cg-export	DEST [TREE_ID]
 	cg-help		[COMMAND]
 	cg-init
-	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] ] [-m [BNAME] [BNAME]] [FILE]...
 	cg-ls		[TREE_ID]
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
-	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]
+	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]] [-m [BNAME] [BNAME]]
 	cg-patch			< patch on stdin
 	cg-pull		[BNAME]
 	cg-restore	[FILE]...
Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ 3e889a5c03d7df9f82d7a649e02fef2ebdbb9f75/cg-log  (mode:100755)
@@ -22,6 +22,9 @@
 # (HEAD by default), or id1:id2 representing an (id1;id2] range
 # of commits to show.
 #
+# -m [branch2] [branch1] shows the changes in branch2 (defaulting to
+# origin) not yet merged to branch1 (defaulting to HEAD)
+#
 # The rest of arguments are took as filenames; cg-log then displays
 # only changes in those files.
 
@@ -94,6 +97,22 @@
 
 log_start=
 log_end=
+if [ "$1" = "-m" ]; then
+	branch=HEAD
+	log_end=origin
+	shift
+	if [ "$1" ]; then
+		log_end=$1
+		shift
+	fi
+	if [ "$1" ]; then
+		branch=$1
+		shift
+	fi
+	log_start=$(git-merge-base "$branch" "$log_end")
+	[ "$log_start" ] || die "Unable to determine the merge base"
+fi
+
 if [ "$1" = "-r" ]; then
 	shift
 	log_start="$1"
Index: cg-mkpatch
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-mkpatch  (mode:100755)
+++ 3e889a5c03d7df9f82d7a649e02fef2ebdbb9f75/cg-mkpatch  (mode:100755)
@@ -9,6 +9,9 @@
 #
 # Takes an -r followed with ID defaulting to HEAD, or id1:id2, forming
 # a range (id1;id2]. (Use "id1:" to take just everything from id1 to HEAD.)
+#
+# -m [branch2] [branch1] shows the changes in branch2 (defaulting to
+# origin) not yet merged to branch1 (defaulting to HEAD)
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -65,6 +68,22 @@
 
 log_start=
 log_end=
+if [ "$1" = "-m" ]; then
+	branch=HEAD
+	log_end=origin
+	shift
+	if [ "$1" ]; then
+		log_end=$1
+		shift
+	fi
+	if [ "$1" ]; then
+		branch=$1
+		shift
+	fi
+	log_start=$(git-merge-base "$branch" "$log_end")
+	[ "$log_start" ] || die "Unable to determine the merge base"
+fi
+
 if [ "$1" = "-r" ]; then
 	shift
 	log_start="$1"

--=-=-=--

