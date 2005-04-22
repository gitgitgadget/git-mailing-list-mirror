From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: [PATCH] Eliminate use of mktemp's "-t" option
Date: Thu, 21 Apr 2005 23:13:00 -0400
Message-ID: <42686BBC.9050703@dwheeler.com>
References: <20050422015521.GK493@shell0.pdx.osdl.net> <20050422024010.GE7443@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090700090600000000020503"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 05:07:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOoV9-00005r-8L
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 05:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVDVDLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 23:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVDVDLM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 23:11:12 -0400
Received: from cujo.runbox.com ([193.71.199.138]:54726 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261929AbVDVDKw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 23:10:52 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DOoZ9-0007AD-OU; Fri, 22 Apr 2005 05:10:51 +0200
Received: from [70.18.249.32] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DOoZ9-0000P2-A9; Fri, 22 Apr 2005 05:10:51 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422024010.GE7443@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090700090600000000020503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It turns out that mktemp's "-t" option, while useful, isn't
available on many systems (Mandrake & Red Hat Linux 9 at least,
and probably piles of others).  So, here's a portability
patch that removes all use of mktemp's "-t" option.
Unlike the quick hack I posted earlier, this should be
"clean everywhere" (assuming you have mktemp).

This is a patch against git-pasky 0.6.3.

This is my first attempt to _post_ a patch using git itself,
and I'm not entirely sure how you want it.   Let me know
if you have a problem with it!

--- David A. Wheeler



--------------090700090600000000020503
Content-Type: text/plain;
 name="rm-mktemp-dash-t.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rm-mktemp-dash-t.patch"

commit 5f926b684025b83e34386bf8e4ef30a97e2ae5ec
tree 61059575269ed1027cfb66543251e182f87d1064
parent dd69ca5f806c8b10bb29ecb8d77c88be007c981c
author David A. Wheeler <dwheeler@dwheeler.com> 1114138972 -0400
committer David A. Wheeler <dwheeler@dwheeler.com> 1114138972 -0400

    Eliminated use of mktemp's "-t" option; older mktemps don't support it.

Index: README
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/README  (mode:100644 sha1:a71b5fbdbdac0bf2e2d021e422b9f49dd5481165)
+++ 61059575269ed1027cfb66543251e182f87d1064/README  (mode:100644 sha1:80952e2f67b28f64c10cfb913df375a5dd244cd9)
@@ -141,7 +141,7 @@
 	C compiler
 	bash
 	basic shell environment (sed, grep, textutils, ...)
-	mktemp 1.5+ (Mandrake users beware!)
+	mktemp
 	diff, patch
 	libssl
 	rsync
Index: gitapply.sh
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/gitapply.sh  (mode:100755 sha1:7703809dc0743c6e4c1fa5b7d922a4efc16b4276)
+++ 61059575269ed1027cfb66543251e182f87d1064/gitapply.sh  (mode:100755 sha1:14a13ff23cff2a80f9a44c053002f837fec13e2c)
@@ -8,9 +8,13 @@
 #
 # Takes the diff on stdin.
 
-gonefile=$(mktemp -t gitapply.XXXXXX)
-todo=$(mktemp -t gitapply.XXXXXX)
-patchfifo=$(mktemp -t gitapply.XXXXXX)
+if [ -z "$TMPDIR"]; then
+	TMPDIR=/tmp
+fi
+
+gonefile=$(mktemp "$TMPDIR/gitapply.XXXXXX")
+todo=$(mktemp "$TMPDIR/gitapply.XXXXXX")
+patchfifo=$(mktemp "$TMPDIR/gitapply.XXXXXX")
 rm $patchfifo && mkfifo -m 600 $patchfifo
 
 show-files --deleted >$gonefile
Index: gitcommit.sh
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/gitcommit.sh  (mode:100755 sha1:a13bef2c84492ed75679d7d52bb710df35544f8a)
+++ 61059575269ed1027cfb66543251e182f87d1064/gitcommit.sh  (mode:100755 sha1:ee777605dccdc9737cf743f4f8c96b9bacd97f10)
@@ -16,6 +16,9 @@
 	exit 1
 }
 
+if [ -z "$TMPDIR"]; then
+	TMPDIR=/tmp
+fi
 
 [ -s .git/blocked ] && die "committing blocked: $(cat .git/blocked)"
 
@@ -67,7 +70,7 @@
 fi
 
 echo "Enter commit message, terminated by ctrl-D on a separate line:"
-LOGMSG=$(mktemp -t gitci.XXXXXX)
+LOGMSG=$(mktemp "$TMPDIR/gitci.XXXXXX")
 if [ "$merging" ]; then
 	echo -n 'Merge with ' >>$LOGMSG
 	echo -n 'Merge with '
@@ -111,7 +114,7 @@
 if [ ! "$customfiles" ]; then
 	rm -f .git/add-queue .git/rm-queue
 else
-	greptmp=$(mktemp -t gitci.XXXXXX)
+	greptmp=$(mktemp "$TMPDIR/gitci.XXXXXX")
 	for file in $customfiles; do
 		if [ -s .git/add-queue ]; then
 			fgrep -vx "$file" .git/add-queue >$greptmp
Index: gitdiff-do
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/gitdiff-do  (mode:100755 sha1:218dfabeb4a5dcbd2cf58bd6f672f385690ec397)
+++ 61059575269ed1027cfb66543251e182f87d1064/gitdiff-do  (mode:100755 sha1:caf20ae034b8dc9f88922ee9f82809bb32a56231)
@@ -32,7 +32,11 @@
 	[ "$labelapp" ] && label="$label  ($labelapp)"
 }
 
-diffdir=$(mktemp -d -t gitdiff.XXXXXX)
+if [ -z "$TMPDIR"]; then
+	TMPDIR=/tmp
+fi
+
+diffdir=$(mktemp -d "$TMPDIR/gitdiff.XXXXXX")
 diffdir1="$diffdir/$id1"
 diffdir2="$diffdir/$id2"
 mkdir "$diffdir1" "$diffdir2"
Index: gitdiff.sh
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/gitdiff.sh  (mode:100755 sha1:195c3b9962c764855ec6168a78babf5867ea3046)
+++ 61059575269ed1027cfb66543251e182f87d1064/gitdiff.sh  (mode:100755 sha1:278511a3f491ed7d5e41bbd642acfd9b5a1d8257)
@@ -80,6 +80,10 @@
 	shift
 fi
 
+if [ -z "$TMPDIR"]; then
+	TMPDIR=/tmp
+fi
+
 if [ "$parent" ]; then
 	id2="$id1"
 	id1=$(parent-id "$id2" | head -n 1)
@@ -88,7 +92,7 @@
 
 if [ "$id2" = " " ]; then
 	if [ "$id1" != " " ]; then
-		export GIT_INDEX_FILE=$(mktemp -t gitdiff.XXXXXX)
+		export GIT_INDEX_FILE=$(mktemp "$TMPDIR/gitdiff.XXXXXX")
 		read-tree $(gitXnormid.sh "$id1")
 		update-cache --refresh
 	fi
Index: gitmerge.sh
===================================================================
--- 6a612d42afdba20fd2150e319a689ed451b010e4/gitmerge.sh  (mode:100755 sha1:683755729b6f689ea43c692712fad6e51eeac354)
+++ 61059575269ed1027cfb66543251e182f87d1064/gitmerge.sh  (mode:100755 sha1:1c733bbdb9fe54c41787d962d0f55bb5f67d4c63)
@@ -19,6 +19,10 @@
 	exit 1
 }
 
+if [ -z "$TMPDIR"]; then
+	TMPDIR=/tmp
+fi
+
 head=$(commit-id)
 
 
@@ -58,7 +62,7 @@
 	echo "Fast-forwarding $base -> $branch" >&2
 	echo -e "\ton top of $head..." >&2
 
-	patchfile=$(mktemp -t gitmerge.XXXXXX)
+	patchfile=$(mktemp "$TMPDIR/gitmerge.XXXXXX")
 	gitdiff.sh >$patchfile
 
 	read-tree -m $(tree-id $branch)

--------------090700090600000000020503--
