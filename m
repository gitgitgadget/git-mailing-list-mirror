From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH cogito] "cg-whatsnew" command
Date: Thu, 19 May 2005 09:24:20 +0100
Message-ID: <tnxwtpv4o97.fsf@arm.com>
References: <tnx64xm5b2b.fsf@arm.com> <20050514110941.GB3905@pasky.ji.cz>
	<tnx3bsoki2j.fsf@arm.com>
	<pan.2005.05.15.17.36.37.623874@smurf.noris.de>
	<tnxis1jk1sn.fsf@arm.com> <20050518223034.GH10358@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 10:27:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYgMO-0003Vi-Ew
	for gcvg-git@gmane.org; Thu, 19 May 2005 10:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262470AbVESI1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 04:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVESI1I
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 04:27:08 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37293 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262472AbVESIZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 04:25:25 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j4J8OQeS028186;
	Thu, 19 May 2005 09:24:26 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA04139;
	Thu, 19 May 2005 09:24:30 +0100 (BST)
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050518223034.GH10358@pasky.ji.cz> (Petr Baudis's message of
 "Thu, 19 May 2005 00:30:34 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

Petr Baudis <pasky@ucw.cz> wrote:
> Unfortunately I can't comment on it well when it's not either in the
> body or as text/plain attachment.

It was attached as text/x-patch.

> I think the -m usage doesn't make much sense now. What about dropping
> branch1 and instead using what the user passed as the -r argument?

See attached (text/plain this time).

It is also possible not to give any argument to -m and use the -r ones
entirely (not implemented in the attached patch).

-- 
Catalin


--=-=-=
Content-Disposition: inline; filename=patch-m-option

"-m" option added to cg-diff, cg-log and cg-mkpatch

This option takes a branch name as an optional parameter and shows the
changes on this branch not yet merged to HEAD or to the first argument
passed to "-r".

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

---
Index: cg-diff
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-diff  (mode:100755)
+++ uncommitted/cg-diff  (mode:100755)
@@ -14,6 +14,9 @@
 # -p instead of one ID denotes a parent commit to the specified ID
 # (which must not be a tree, obviously).
 #
+# -m [branch] shows the changes in branch (defaulting to origin)
+# not yet merged to HEAD (or the first argument passed to -r)
+#
 # Outputs a diff converting the first tree to the second one.
 
 . ${COGITO_LIB}cg-Xlib
@@ -49,6 +52,18 @@
 	id1=$(parent-id "$id2" | head -n 1)
 fi
 
+if [ "$1" = "-m" ]; then
+	[ "$id1" = " " ] && id1=HEAD
+	id2=origin
+	shift
+	if [ "$1" ]; then
+		id2=$1
+		shift
+	fi
+	id1=$(git-merge-base "$id1" "$id2")
+	[ "$id1" ] || die "Unable to determine the merge base"
+fi
+
 
 filter=
 if [ "$*" ]; then
Index: cg-help
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-help  (mode:100755)
+++ uncommitted/cg-help  (mode:100755)
@@ -26,14 +26,14 @@
 	cg-cancel
 	cg-clone	[-s] SOURCE_LOC [DESTDIR]
 	cg-commit	[-m"Commit message"]... [-e | -E] [FILE]... < log message
-	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-diff		[-p] [-r FROM_ID[:TO_ID]] [-m [BNAME]] [FILE]...
 	cg-export	DEST [TREE_ID]
 	cg-help		[COMMAND]
 	cg-init
-	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] [FILE]...
+	cg-log		[-c] [-f] [-r FROM_ID[:TO_ID]] [-m [BNAME]] [FILE]...
 	cg-ls		[TREE_ID]
 	cg-merge	[-c] [-b BASE_ID] FROM_ID
-	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]]
+	cg-mkpatch	[-s] [-r FROM_ID[:TO_ID]] [-m [BNAME]]
 	cg-patch			< patch on stdin
 	cg-pull		[BNAME]
 	cg-restore	[FILE]...
Index: cg-log
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -22,6 +22,9 @@
 # (HEAD by default), or id1:id2 representing an (id1;id2] range
 # of commits to show.
 #
+# -m [branch] shows the changes in branch (defaulting to origin)
+# not yet merged to HEAD (or the first argument passed to -r)
+#
 # The rest of arguments are took as filenames; cg-log then displays
 # only changes in those files.
 
@@ -110,6 +113,18 @@
 	shift
 fi
 
+if [ "$1" = "-m" ]; then
+	[ "$log_start" ] || log_start=HEAD
+	log_end=origin
+	shift
+	if [ "$1" ]; then
+		log_end=$1
+		shift
+	fi
+	log_start=$(git-merge-base "$log_start" "$log_end")
+	[ "$log_start" ] || die "Unable to determine the merge base"
+fi
+
 if [ "$log_end" ]; then
 	id1="$(commit-id $log_start)" || exit 1
 	id2="$(commit-id $log_end)" || exit 1
Index: cg-mkpatch
===================================================================
--- ca5fef50fb68a3afbb35e1a48ac622f7a964f021/cg-mkpatch  (mode:100755)
+++ uncommitted/cg-mkpatch  (mode:100755)
@@ -9,6 +9,9 @@
 #
 # Takes an -r followed with ID defaulting to HEAD, or id1:id2, forming
 # a range (id1;id2]. (Use "id1:" to take just everything from id1 to HEAD.)
+#
+# -m [branch] shows the changes in branch (defaulting to origin)
+# not yet merged to HEAD (or the first argument passed to -r)
 
 . ${COGITO_LIB}cg-Xlib
 
@@ -80,6 +83,18 @@
 	shift
 fi
 
+if [ "$1" = "-m" ]; then
+	[ "$log_start" ] || log_start=HEAD
+	log_end=origin
+	shift
+	if [ "$1" ]; then
+		log_end=$1
+		shift
+	fi
+	log_start=$(git-merge-base "$log_start" "$log_end")
+	[ "$log_start" ] || die "Unable to determine the merge base"
+fi
+
 if [ "$log_end" ]; then
 	id1=$(commit-id $log_start) || exit 1
 	id2=$(commit-id $log_end) || exit 1

--=-=-=--

