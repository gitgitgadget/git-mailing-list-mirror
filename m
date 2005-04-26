From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] cogito recursive cg-add and cg-rm
Date: Tue, 26 Apr 2005 00:27:02 -0400
Message-ID: <200504260027.03451.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Apr 26 06:27:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQHf2-0003q0-IE
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 06:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVDZEbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 00:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVDZE3k
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 00:29:40 -0400
Received: from node1.wunjo.org ([64.62.190.230]:23220 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S261319AbVDZE2N (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 00:28:13 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id DDE7342EF9; Tue, 26 Apr 2005 00:28:08 -0400 (EDT)
Received: from [192.168.1.100] (24.238.44.109.res-cmts.tv13.ptd.net [24.238.44.109])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id E3E8D42B74
	for <git@vger.kernel.org>; Tue, 26 Apr 2005 00:28:05 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=5.0 tests=RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch adds recursive addition and removal to cg-add and cg-rm, recursion 
can be disabled with the -n switch.

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

Index: cg-add
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/cg-add  (mode:100755 
sha1:8ba5351a4c7e28a577ea1aa4afa1078c54e9bccc)
+++ ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-add  (mode:100755 
sha1:1b7a821fd0b3f9702508503a082869ed4ec3ab52)
@@ -5,9 +5,31 @@
 #
 # Takes a list of file names at the command line, and schedules them
 # for addition to the GIT repository at the next commit.
+# Optional "-n" parameter specifies that you don't want to add directories
+# recursively.
 
 . cg-Xlib
 
-[ "$1" ] || die "usage: cg-add FILE..."
+[ "$1" ] || die "usage: cg-add [-n] FILE..."
 
-update-cache --add -- "$@"
+recur=1
+if [ "$1" = "-n" ]; then
+  shift
+  recur=
+fi
+
+if [ $recur ]; then
+  ADDFILE=$(mktemp -t gitadd.XXXXXX)
+  while [ "$1" ]; do
+    if [ -d "$1" ]; then
+      find $1 -type f -and -not -name '.*'
+    else
+      echo "$1"
+    fi
+    shift
+  done > $ADDFILE
+  update-cache --add -- $(cat $ADDFILE)
+  rm -f $RMFILE
+else
+  update-cache --add -- "$@"
+fi
Index: cg-help
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/cg-help  (mode:100755 
sha1:86f29161aadf15411244db9514a1fdfb03e664bd)
+++ ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-help  (mode:100755 
sha1:36480174eba9cc54e9baba100cbd368fbced5c76)
@@ -11,7 +11,7 @@
 Usage: cg-COMMAND [ARG]...
 
 Available commands:
- cg-add  FILE...
+ cg-add  [-n] FILE...
  cg-branch-add BNAME SOURCE_LOC
  cg-branch-ls
  cg-cancel
@@ -27,7 +27,7 @@
  cg-mkpatch [COMMIT_ID | COMMIT_ID:COMMIT_ID]
  cg-patch   < patch on stdin
  cg-pull  [BNAME]
- cg-rm  FILE...
+ cg-rm  [-n] FILE...
  cg-seek  [COMMIT_ID]
  cg-status
  cg-tag  TNAME [COMMIT_ID]
Index: cg-rm
===================================================================
--- f262000f302b749e485f5eb971e6aabefbb85680/cg-rm  (mode:100755 
sha1:029a03128eb7a8dd807335fea2ff52cb2bcda4fa)
+++ ddd5e0ab084034b713bb2f7d9de6f365d5a2e5bf/cg-rm  (mode:100755 
sha1:1e0c64567767668454a0360785ac84883c7bbd58)
@@ -5,10 +5,36 @@
 #
 # Takes a list of file names at the command line, and schedules them
 # for removal from the GIT repository at the next commit.
+# Optional "-n" parameter specifies that you don't want to remove directories
+# recursively.
 
 . cg-Xlib
 
-[ "$1" ] || die "usage: cg-rm FILE..."
+[ "$1" ] || die "usage: cg-rm [-n] FILE..."
 
-rm -f "$@"
-update-cache --remove -- "$@"
+recur=1
+if [ "$1" = "-n" ]; then
+  shift
+  recur=
+fi
+
+if [ $recur ]; then
+  RMFILE=$(mktemp -t gitrm.XXXXXX)
+  RMDIRS=
+  while [ "$1" ]; do
+    if [ -d "$1" ]; then
+      RMDIRS="$DIRS $1"
+      find $1 -type f -and -not -name '.*'
+    else
+      echo "$1"
+    fi
+    shift
+  done > $RMFILE
+  rm -f $(cat $RMFILE)
+  rmdir $(find $RMDIRS -depth -type d)
+  update-cache --remove -- $(cat $RMFILE)
+  rm -f $RMFILE
+else
+  rm -f "$@"
+  update-cache --remove -- "$@"
+fi
