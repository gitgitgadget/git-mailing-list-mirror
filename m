From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add git-apply-patch-script.
Date: Sun, 01 May 2005 00:21:58 -0700
Message-ID: <7vfyx7za09.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<7vis231y7y.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504302224510.2296@ppc970.osdl.org>
	<7vr7grzcqu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 09:16:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS8gk-000177-6a
	for gcvg-git@gmane.org; Sun, 01 May 2005 09:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261547AbVEAHWM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 03:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVEAHWM
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 03:22:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30105 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261547AbVEAHWA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 03:22:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501072200.VUDD12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 03:22:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vr7grzcqu.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 30 Apr 2005 23:22:49 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I said:

     - Stop attempting to be compatible with cg-patch, and drop
       (mode:XXXXXX) bits from the diff.

     - Do keep the /dev/null change for created and deleted case.

     - No "Index:" line, no "Mode change:" line, anywhere in the
       output.  Anything that wants the mode bits and sha1 hash can
       do things from GIT_EXTERNAL_DIFF mechanism.  Maybe document
       suggested usage better.

This adds an example script git-apply-patch-script, that can be
used as the GIT_EXTERNAL_DIFF to apply changes between two trees
directly on the current work tree, like this:

 GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p <tree> <tree>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Makefile               |    4 +--
git-apply-patch-script |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
2 files changed, 62 insertions(+), 2 deletions(-)

# - [PATCH] Rework built-in diff to make its output more dense.
# + [PATCH] Add git-apply-patch-script.
--- k/Makefile
+++ l/Makefile
@@ -12,8 +12,8 @@ CFLAGS=-g -O2 -Wall
 CC=gcc
 AR=ar
 
-SCRIPTS=git-merge-one-file-script git-prune-script git-pull-script \
-	git-tag-script
+SCRIPTS=git-apply-patch-script git-merge-one-file-script git-prune-script \
+	git-pull-script git-tag-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
Created: git-apply-patch-script (mode:100755)
--- /dev/null
+++ l/git-apply-patch-script
@@ -0,0 +1,60 @@
+#!/bin/sh
+# Copyright (C) 2005 Junio C Hamano
+#
+# Applying diff between two trees to the work tree can be
+# done with the following single command:
+#
+# GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p $tree1 $tree2
+#
+
+case "$#" in
+2)    exit 1 ;; # do not feed unmerged diff to me!
+esac
+name="$1" tmp1="$2" hex1="$3" mode1="$4" tmp2="$5" hex2="$6" mode2="$7"
+case "$mode1" in *7??) mode1=+x ;; *6??) mode1=-x ;; esac
+case "$mode2" in *7??) mode2=+x ;; *6??) mode2=-x ;; esac
+
+if test -f "$name.orig" || test -f "$name.rej"
+then
+    echo >&2 "Unresolved patch conflicts in the previous run found."
+    exit 1
+fi
+# This will say "patching ..." so we do not say anything outselves.
+
+diff -u -L "a/$name" -L "b/$name" "$tmp1" "$tmp2" | patch -p1
+test -f "$name.rej" || {
+    case "$mode1,$mode2" in
+    .,?x)
+	# newly created
+	case "$mode2" in
+	+x)
+	    echo >&2 "created $name with mode +x."
+	    chmod "$mode2" "$name"
+	    ;;
+	-)
+	    echo >&2 "created $name."
+	    ;;
+	esac
+	git-update-cache --add -- "$name"
+	;;
+    ?x,.)
+	# deleted
+	echo >&2 "deleted $name."
+	rm -f "$name"
+	git-update-cache --remove -- "$name"
+	;;
+    *)
+	# changed
+	case "$mode1,$mode2" in
+	"$mode2,$mode1") ;;
+	*)
+	    echo >&2 "changing mode from $mode1 to $mode2."
+	    chmod "$mode2" "$name"
+	    ;;
+	esac
+    esac
+    # This bit is debatable---the SCM may not want to keep
+    # cache in sync with the work tree (JIT does want to).
+    git-update-cache -- "$name"
+}
+exit 0

