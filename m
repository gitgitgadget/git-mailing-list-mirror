From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: [PATCH] git rm -- recursive directories
Date: Sun, 24 Apr 2005 17:09:05 -0400
Message-ID: <200504241709.05689.jcorbin@wunjo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 24 23:06:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoIn-0007fM-5d
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVDXVKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVDXVKs
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:10:48 -0400
Received: from node1.wunjo.org ([64.62.190.230]:49585 "EHLO node1.wunjo.org")
	by vger.kernel.org with ESMTP id S262427AbVDXVKS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 17:10:18 -0400
Received: by node1.wunjo.org (Postfix, from userid 65534)
	id 6D57042EE6; Sun, 24 Apr 2005 17:10:17 -0400 (EDT)
Received: from thor.circle (24.229.157.212.cmts.dan.ptd.net [24.229.157.212])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by node1.wunjo.org (Postfix) with ESMTP id B35BB42AB7
	for <git@vger.kernel.org>; Sun, 24 Apr 2005 17:10:14 -0400 (EDT)
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

After posting the previous patch, I realized it made sense, to me at least ;), 
to have git rm work the same way. Same idea as my previous patch except this 
time the recursion is off by default, must pass -r.

Signed-off-by: Joshua T. Corbin <jcorbin@wunjo.org>

Index: git
===================================================================
--- be4029f0225729bd52a08ac39214264247e1d319/git  (mode:100755 
sha1:24d8c30383fa11d049aafcd659cefe700afe1cf1)
+++ e925e99aef139d50acc11d906be86809f3a08bcb/git  (mode:100755 
sha1:3928887f010454a41853b8a836e1b87eeb0aaf51)
@@ -42,7 +42,7 @@
 	merge		[-c] [-b BASE_ID] FROM_ID
 	patch		[COMMIT_ID | COMMIT_ID:COMMIT_ID]
 	pull		[RNAME]
-	rm		FILE...
+	rm		[-r] FILE...
 	seek		[COMMIT_ID]
 	status
 	tag		TNAME [COMMIT_ID]
Index: gitrm.sh
===================================================================
--- be4029f0225729bd52a08ac39214264247e1d319/gitrm.sh  (mode:100755 
sha1:3cc50fb9f12d2bf93a285ea18daadca7d3f5b549)
+++ e925e99aef139d50acc11d906be86809f3a08bcb/gitrm.sh  (mode:100755 
sha1:236261a53fdce287d32b40b8baf46c338515e555)
@@ -5,11 +5,36 @@
 #
 # Takes a list of file names at the command line, and schedules them
 # for removal from the GIT repository at the next commit.
+# Optional "-r" parameter specifies that you don't want to remove directories
+# recursively.
 
 if [ ! "$1" ]; then
 	echo "gitrm.sh: usage: git rm FILE..." >&2
 	exit 1;
 fi
 
-rm -f "$@"
-update-cache --remove -- "$@"
+recur=
+if [ "$1" = "-r" ]; then
+  shift
+  recur=1
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
+else
+  rm -f "$@"
+  update-cache --remove -- "$@"
+fi
