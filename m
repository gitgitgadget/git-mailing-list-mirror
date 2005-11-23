From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: [PATCH] Fix cg-mv for moving directories with 1 file
Date: Wed, 23 Nov 2005 12:04:23 +0100
Message-ID: <200511231204.24571.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Alexander Litvinov <lan@ac-sw.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:05:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EesQj-0001s0-FQ
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 12:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbVKWLE2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 06:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbVKWLE2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 06:04:28 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:62430 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1030399AbVKWLE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 06:04:27 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 17C682771;
	Wed, 23 Nov 2005 12:04:26 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12617>

This is fixed by putting the file into @changedfiles/@addedfiles,
and not the directory this file is in.

Additionally, this fixes the behavior for attempting to overwrite
a file with a directory, and gives a message for all cases where
overwriting is not possible (file->dir,dir->file,dir->dir).

Thanks for Alexander Litvinov for noting this problem.

Signed-off-by: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>

---

This should fix the wrong behavior.
Alexander, can you confirm this?


 git-mv.perl |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

applies-to: 5bc7f67c535dbbbb9340285c82226a8dd6e4afec
5237e9ac4adc6bed0074ce1eeee6846e40f45d84
diff --git a/git-mv.perl b/git-mv.perl
index a21d87e..bf54c38 100755
--- a/git-mv.perl
+++ b/git-mv.perl
@@ -103,13 +103,22 @@ while(scalar @srcArgs > 0) {
 	$bad = "bad source '$src'";
     }
 
+    $safesrc = quotemeta($src);
+    @srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
+
     $overwritten{$dst} = 0;
     if (($bad eq "") && -e $dst) {
 	$bad = "destination '$dst' already exists";
-	if (-f $dst && $opt_f) {
-	    print "Warning: $bad; will overwrite!\n";
-	    $bad = "";
-	    $overwritten{$dst} = 1;
+	if ($opt_f) {
+	    # only files can overwrite each other: check both source and destination
+	    if (-f $dst && (scalar @srcfiles == 1)) {
+		print "Warning: $bad; will overwrite!\n";
+		$bad = "";
+		$overwritten{$dst} = 1;
+	    }
+	    else {
+		$bad = "Can not overwrite '$src' with '$dst'";
+	    }
 	}
     }
     
@@ -118,8 +127,6 @@ while(scalar @srcArgs > 0) {
     }
 
     if ($bad eq "") {
-	$safesrc = quotemeta($src);
-	@srcfiles = grep /^$safesrc(\/|$)/, @allfiles;
         if (scalar @srcfiles == 0) {
 	    $bad = "'$src' not under version control";
 	}
@@ -166,10 +173,12 @@ while(scalar @srcs > 0) {
 
     push @deletedfiles, @srcfiles;
     if (scalar @srcfiles == 1) {
+	# $dst can be a directory with 1 file inside
 	if ($overwritten{$dst} ==1) {
-	    push @changedfiles, $dst;
+	    push @changedfiles, $dstfiles[0];
+
 	} else {
-	    push @addedfiles, $dst;
+	    push @addedfiles, $dstfiles[0];
 	}
     }
     else {
---
0.99.9.GIT
