From: Alexander Litvinov <lan@ac-sw.com>
Subject: [PATCH] git-mv is not able to handle big directories
Date: Wed, 23 Nov 2005 11:41:57 +0600
Organization: AcademSoft Ltd.
Message-ID: <200511231141.57683.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lEAhDsdaBvOllH2"
X-From: git-owner@vger.kernel.org Wed Nov 23 06:41:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EenLk-0008Mp-8x
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 06:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVKWFjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 00:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbVKWFjR
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 00:39:17 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:33181 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1030315AbVKWFjQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2005 00:39:16 -0500
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id 61B3BBD1B
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 11:39:12 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id E18111A12ED; Wed, 23 Nov 2005 11:42:02 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 08C6D19278A
	for <git@vger.kernel.org>; Wed, 23 Nov 2005 11:41:58 +0600 (NOVT)
To: git <git@vger.kernel.org>
User-Agent: KMail/1.8
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12604>

--Boundary-00=_lEAhDsdaBvOllH2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When moving directory with large number of files git-mv says:
> git-mv jsp* .
Can't exec "git-update-index": Argument list too long at /usr/local/bin/git-mv 
line 193.
git-update-index failed to add new names with code -1

This patch fixes this by building list of files with limited len (currently 
5000) and executing git-update-index few times until all files will be 
processed. I don't know how to determinate limit of command line but 5000 
seems safe enougth to me.

--Boundary-00=_lEAhDsdaBvOllH2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="git-mv.perl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-mv.perl.patch"

--- git-mv.perl.orig	2005-11-23 11:24:10.000000000 +0600
+++ git-mv.perl	2005-11-23 11:33:31.000000000 +0600
@@ -185,13 +185,36 @@
 }
 	
 my $rc;
-if (scalar @changedfiles >0) {
-	$rc = system("git-update-index","--",@changedfiles);
+while (scalar @changedfiles >0) {
+	my @toHandle = ();
+	my $len = 0;
+	while ($len < 5000 && scalar(@changedfiles) >0) {
+		my $f = pop(@changedfiles);
+		$len += length($f) + 1;
+		push(@toHandle, $f);
+	}
+	$rc = system("git-update-index","--",@toHandle);
 	die "git-update-index failed to update changed files with code $?\n" if $rc;
 }
-if (scalar @addedfiles >0) {
-	$rc = system("git-update-index","--add","--",@addedfiles);
+while (scalar @addedfiles >0) {
+	my @toHandle = ();
+	my $len = 0;
+	while ($len < 5000 && scalar(@addedfiles) >0) {
+		my $f = pop(@addedfiles);
+		$len += length($f) + 1;
+		push(@toHandle, $f);
+	}
+	$rc = system("git-update-index","--add","--",@toHandle);
 	die "git-update-index failed to add new names with code $?\n" if $rc;
 }
-$rc = system("git-update-index","--remove","--",@deletedfiles);
-die "git-update-index failed to remove old names with code $?\n" if $rc;
+while (scalar @deletedfiles > 0) {
+	my @toHandle = ();
+	my $len = 0;
+	while ($len < 5000 && scalar(@deletedfiles) >0) {
+		my $f = pop(@deletedfiles);
+		$len += length($f) + 1;
+		push(@toHandle, $f);
+	}
+	$rc = system("git-update-index","--remove","--",@toHandle);
+	die "git-update-index failed to remove old names with code $?\n" if $rc;
+}

--Boundary-00=_lEAhDsdaBvOllH2--
