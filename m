From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] git add - recursive directories
Date: Sun, 24 Apr 2005 16:51:23 -0400
Message-ID: <200504241651.24276.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 24 22:48:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPo1E-0005wG-Fg
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVDXUwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 16:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVDXUwt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 16:52:49 -0400
Received: from node1.wunjo.org ([64.62.190.230]:47537 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S262413AbVDXUwh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 16:52:37 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id 6D1BC42EE5; Sun, 24 Apr 2005 16:52:36 -0400 (EDT)
Received: from thor.circle (24.229.157.212.cmts.dan.ptd.net [24.229.157.212])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id B496342AB7
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 16:52:33 -0400 (EDT)
To: git@vger.kernel.org
User-Agent: KMail/1.8
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on node1
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=FORGED_RCVD_HELO 
	autolearn=ham version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch does two things:
  1) git add will now by default recursively add any directories given to it.
  2) this can be disabled and the old behavior used instead with the new -n
     switch.

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

Index: git
===================================================================
--- 2aaf94eae20acc451553766f3c063bc46cfa75c6/git  (mode:100755 
sha1:f8f5e0e4e5c50102415cd479619dd7598d3c42e1)
+++ 58dd789846677d8d0848b608e365e9742d2db642/git  (mode:100755 
sha1:24d8c30383fa11d049aafcd659cefe700afe1cf1)
@@ -25,7 +25,7 @@
 Usage: git COMMAND [ARG]...
 
 Available commands:
-	add		FILE...
+	add		[-n] FILE...
 	addremote	RNAME RSYNC_URL
 	apply				< patch on stdin
 	cancel
Index: gitadd.sh
===================================================================
--- 2aaf94eae20acc451553766f3c063bc46cfa75c6/gitadd.sh  (mode:100755 
sha1:fa77d96198dd7d5ebf47bdedb296995ab7e77cf3)
+++ 58dd789846677d8d0848b608e365e9742d2db642/gitadd.sh  (mode:100755 
sha1:f0b030e1b4d770d96dabd5350e25f2e8fad5e59d)
@@ -5,10 +5,31 @@
 #
 # Takes a list of file names at the command line, and schedules them
 # for addition to the GIT repository at the next commit.
+# Optional "-n" parameter specifies that you don't want to add directories
+# recursively.
 
 if [ ! "$1" ]; then
-	echo "gitadd.sh: usage: git add FILE..." >&2
+	echo "gitadd.sh: usage: git add [-n] FILE..." >&2
 	exit 1;
 fi
 
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
+else
+  update-cache --add -- "$@"
+fi
