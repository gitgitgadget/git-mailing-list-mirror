From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Mon, 16 May 2005 09:33:44 +0100
Message-ID: <tnxis1jk1sn.fsf@arm.com>
References: <tnx64xm5b2b.fsf@arm.com> <20050514110941.GB3905@pasky.ji.cz>
	<tnx3bsoki2j.fsf@arm.com>
	<pan.2005.05.15.17.36.37.623874@smurf.noris.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 10:41:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXb9y-0006w3-HN
	for gcvg-git@gmane.org; Mon, 16 May 2005 10:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVEPIiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 04:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVEPIht
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 04:37:49 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:62677 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261487AbVEPIep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 04:34:45 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j4G8Xofj002474;
	Mon, 16 May 2005 09:33:50 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA05529;
	Mon, 16 May 2005 09:33:54 +0100 (BST)
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Matthias Urlichs <smurf@smurf.noris.de> wrote:
>> +	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [BNAME] [BNAME]] [FILE]...
>
> That should be
>
> [-m [BNAME [BNAME]]]

You are right.

> though I'd suggest something more mnemonic than two BNAMEs.

Another try, see attached.

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
commit 54c787f373557940617bca2c206c731d04c7e07b
tree d46bb25bdadb369e6cbf28ca25ffaeb4b41f7381
parent fa6e9eb368e949e78c4e66217461cf624b52b0a2
author Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Mon, 16 May 2005 09:30:08 +0100
committer Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Mon, 16 May 2005 09:30:08 +0100

 cg-diff    |   19 +++++++++++++++++++
 cg-help    |    8 +++++---
 cg-log     |   19 +++++++++++++++++++
 cg-mkpatch |   19 +++++++++++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)

Index: cg-diff
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-diff  (mode:100755)
+++ d46bb25bdadb369e6cbf28ca25ffaeb4b41f7381/cg-diff  (mode:100755)
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
+++ d46bb25bdadb369e6cbf28ca25ffaeb4b41f7381/cg-help  (mode:100755)
@@ -26,14 +26,16 @@
 	cg-cancel
 	cg-clone	[-s] SOURCE_LOC [DESTDIR]
 	cg-commit	[-m"Commit message"]... [-e | -E] [FILE]... < log message
-	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [SRC_BNAME [DST_BNAME]]] \\
+			[FILE]...
 	cg-export	DEST [TREE_ID]
 	cg-help		[COMMAND]
 	cg-init
-	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] ] \\
+			[-m [SRC_BNAME [DST_BNAME]]] [FILE]...
 	cg-ls		[TREE_ID]
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
-	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]
+	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]] [-m [SRC_BNAME [DST_BNAME]]]
 	cg-patch			< patch on stdin
 	cg-pull		[BNAME]
 	cg-restore	[FILE]...
Index: cg-log
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ d46bb25bdadb369e6cbf28ca25ffaeb4b41f7381/cg-log  (mode:100755)
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
+++ d46bb25bdadb369e6cbf28ca25ffaeb4b41f7381/cg-mkpatch  (mode:100755)
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

