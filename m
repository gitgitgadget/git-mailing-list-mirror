From: Paul Jackson <pj@sgi.com>
Subject: [PATCH] fix mktemp (remove mktemp ;)
Date: Sat, 16 Apr 2005 16:27:43 -0700 (PDT)
Message-ID: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Cc: Petr Baudis <pasky@ucw.cz>, Paul Jackson <pj@sgi.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:25:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwf1-0004Fr-Mb
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVDPX2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVDPX2v
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:28:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:19664 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261195AbVDPX2g (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:28:36 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx2.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H17taD004730;
	Sat, 16 Apr 2005 18:08:05 -0700
Received: from sam.engr.sgi.com (sam.engr.sgi.com [163.154.6.103])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id j3GNRhlU15239612;
	Sat, 16 Apr 2005 16:27:46 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Remove mktemp usage - it doesn't work on
some Mandrakes, nor on my SuSE 8.2 with
mktemp-1.5-531.

Replace with simple use of $$ (pid).
I've been using this same pattern for
20 years on many production scripts;
it's fast, solid and simple.

More robust tmp file removal, using trap,
so that scripts interrupted by signals
HUP, INT, QUIT or PIPE will cleanup.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: git-pasky-0.4/README
===================================================================
--- git-pasky-0.4.orig/README	2005-04-16 13:16:54.000000000 -0700
+++ git-pasky-0.4/README	2005-04-16 13:17:01.000000000 -0700
@@ -116,7 +116,6 @@ Software requirements:
 	C compiler
 	bash
 	basic shell environment (sed, gred, textutils, ...)
-	mktemp 1.5+ (Mandrake users beware!)
 	diff, patch
 
 
Index: git-pasky-0.4/gitcommit.sh
===================================================================
--- git-pasky-0.4.orig/gitcommit.sh	2005-04-12 10:39:14.000000000 -0700
+++ git-pasky-0.4/gitcommit.sh	2005-04-16 13:17:49.000000000 -0700
@@ -60,7 +60,9 @@ for file in $commitfiles; do
 	echo $file;
 done
 echo "Enter commit message, terminated by ctrl-D on a separate line:"
-LOGMSG=`mktemp -t gitci.XXXXXX`
+t=${TMPDIR:-/usr/tmp}/gitapply.$$
+trap 'rm -f $t.?; trap 0; exit 0' 0 1 2 3 15
+LOGMSG=$t.1
 if [ "$merged" ]; then
 	cat .git/merged | sed 's/^/Merging: /' >>$LOGMSG
 	cat .git/merged | sed 's/^/Merging: /'
@@ -86,7 +88,6 @@ if [ "$treeid" = "$(tree-id)" ] && [ ! "
 fi
 
 newhead=$(commit-tree $treeid $oldhead $merged <$LOGMSG)
-rm $LOGMSG
 rm -f .git/add-queue .git/rm-queue .git/merged
 
 if [ "$newhead" ]; then
Index: git-pasky-0.4/gitapply.sh
===================================================================
--- git-pasky-0.4.orig/gitapply.sh	2005-04-13 02:21:14.000000000 -0700
+++ git-pasky-0.4/gitapply.sh	2005-04-16 13:16:13.000000000 -0700
@@ -8,9 +8,11 @@
 #
 # Takes the diff on stdin.
 
-gonefile=$(mktemp -t gitapply.XXXXXX)
-todo=$(mktemp -t gitapply.XXXXXX)
-patchfifo=$(mktemp -t gitapply.XXXXXX)
+t=${TMPDIR:-/usr/tmp}/gitapply.$$
+trap 'rm -f $t.?; trap 0; exit 0' 0 1 2 3 15
+gonefile=$t.1
+todo=$t.2
+patchfifo=$t.3
 rm $patchfifo && mkfifo -m 600 $patchfifo
 
 show-files --deleted >$gonefile
@@ -74,4 +76,3 @@ while [ "$1" ]; do
 done
 '
 
-rm $pathfifo $todo $gonefile
Index: git-pasky-0.4/gitdiff-do
===================================================================
--- git-pasky-0.4.orig/gitdiff-do	2005-04-16 13:13:59.000000000 -0700
+++ git-pasky-0.4/gitdiff-do	2005-04-16 13:18:29.000000000 -0700
@@ -32,7 +32,9 @@ mkbanner () {
 	[ "$labelapp" ] && label="$label  ($labelapp)"
 }
 
-diffdir=$(mktemp -d -t gitdiff.XXXXXX)
+t=${TMPDIR:-/usr/tmp}/gitdiff.$$
+trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
+diffdir=$t.1
 diffdir1="$diffdir/$id1"
 diffdir2="$diffdir/$id2"
 mkdir "$diffdir1" "$diffdir2"

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
