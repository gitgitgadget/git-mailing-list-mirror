From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: git-mv: keep git index consistent with file system on failed rename
Date: Sun, 27 Nov 2005 22:04:14 +0100
Message-ID: <200511272204.14835.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:04:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgThD-00084i-IJ
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVK0VES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVK0VER
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:04:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:49059 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751151AbVK0VER (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 16:04:17 -0500
Received: (qmail invoked by alias); 27 Nov 2005 21:04:15 -0000
Received: from p5496A06C.dip0.t-ipconnect.de (EHLO linux) [84.150.160.108]
  by mail.gmx.net (mp031) with SMTP; 27 Nov 2005 22:04:15 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12821>

When doing multiple renames, and a rename in the middle fails,
git-mv did not store the successful renames in the git index;
this is fixed by delaying the error message on a failed rename
to after the git updating.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
---
This is actually independent from the just sent patch, but
the context lines shows it applied...

 git-mv.perl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

applies-to: 8acd56ea24d565996dc4618f7d7e4fa152d8623c
81f4a3e528094e5e2b0221fd6e76edd205c8e56d
diff --git a/git-mv.perl b/git-mv.perl
index 990bec5..ac19876 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -142,14 +142,17 @@ while(scalar @srcArgs > 0) {
 
 # Final pass: rename/move
 my (@deletedfiles,@addedfiles,@changedfiles);
+$bad = "";
 while(scalar @srcs > 0) {
     $src = shift @srcs;
     $dst = shift @dsts;
 
     if ($opt_n || $opt_v) { print "Renaming $src to $dst\n"; }
     if (!$opt_n) {
-	rename($src,$dst)
-	    or die "rename failed: $!";
+	if (!rename($src,$dst)) {
+	    $bad = "renaming '$src' failed: $!";
+	    last;
+	}
     }
 
     $safesrc = quotemeta($src);
@@ -209,3 +212,8 @@ else {
 	close(H);
     }
 }
+
+if ($bad ne "") {
+    print "Error: $bad\n";
+    exit(1);
+}
---
0.99.9.GIT
