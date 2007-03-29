From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Don't error out in the merge case where the local file is deleted
Date: Thu, 29 Mar 2007 11:44:17 -0400
Message-ID: <11751830653157-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoJ-0004BP-7t
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbXC2Poh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbXC2Pog
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:36 -0400
Received: from thunk.org ([69.25.196.29]:36593 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030250AbXC2Poa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:30 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtd-0007J0-UQ; Thu, 29 Mar 2007 11:50:42 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xU-EP; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830651770-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43448>

If the file we are trying to merge resolve is in git-ls-files -u, then
skip the file existence test.  If the file isn't reported in
git-ls-files, then check to see if the file exists or not to give an
appropriate error message.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 3cc428c..9d959a9 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -111,14 +111,13 @@ resolve_deleted_merge () {
 merge_file () {
     path="$1"
 
-    if test ! -f "$path" ; then
-	echo "$path: file not found"
-	exit 1
-    fi
-
     f=`git-ls-files -u -- "$path"`
     if test -z "$f" ; then
-	echo "$path: file does not need merging"
+        if test ! -f "$path" ; then
+	    echo "$path: file not found"
+	else
+	    echo "$path: file does not need merging"
+	fi
 	exit 1
     fi
 
-- 
1.5.1.rc2.1.g8afe-dirty
