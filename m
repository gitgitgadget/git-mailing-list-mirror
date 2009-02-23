From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] send-email: don't create temporary compose file until it is needed
Date: Mon, 23 Feb 2009 13:51:37 -0500
Message-ID: <1235415097-16403-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 19:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbfvS-0007am-Vy
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 19:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756218AbZBWSvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 13:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbZBWSvo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 13:51:44 -0500
Received: from el-out-1112.google.com ([209.85.162.176]:15462 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbZBWSvn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 13:51:43 -0500
Received: by el-out-1112.google.com with SMTP id b25so1060992elf.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=jXVlNmkwNa/35ksHp5+HynZT8erbrKqyABLH8MWUi4I=;
        b=L6WMs3I7FD+sUdG6pkiBHaE8PXbVCqVEQLf9EmWlky6hryKRxdapMV3v4HLckMQj29
         u+tEZqU5RPUE+DvA3dnMmVM1gbQlLNJr2igXIKLxI+cydIzC6MWoYeClvgYsIGxGGR9y
         CEi5g0Eo0hQL8Vf069QBAwWfldggubnkbWcCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=gG9pONFFkViLQKBX3HGzs0y29AQVdQUlI87aDI30swFHKfrOhBQSGJFZR7lZgyB+bm
         wQk8Sk+CIMxEg3Zw1gESWInvqBQvFdKOaSf0pFLLeRQUmXEaEPtlxTPs+VnB4l1wLD7C
         dd2CICW1kC+WU+LdV5wF7+6aU0shhKlZao+B4=
Received: by 10.231.16.74 with SMTP id n10mr6435055iba.44.1235415100150;
        Mon, 23 Feb 2009 10:51:40 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id k8sm13591389qba.33.2009.02.23.10.51.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Feb 2009 10:51:39 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.268.g83c06
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111165>

Commit eed6ca7 caused a minor regression when it switched to using
tempfile() to generate the temporary compose file. Since tempfile()
creates the file at the time it generates the filename, zero-length
temporary files are being left behind unless --compose is used (in which
case the file is cleaned up).

This patch fixes the regression by not calling tempfile() to generate
the compose filename unless --compose is in use.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-send-email.perl |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 54e7617..adf7ecb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -156,10 +156,7 @@ if ($@) {
 # Behavior modification variables
 my ($quiet, $dry_run) = (0, 0);
 my $format_patch;
-my $compose_filename = ($repo ?
-	tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
-	tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
-
+my $compose_filename;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -222,11 +219,13 @@ sub signal_handler {
 	system "stty echo";
 
 	# tmp files from --compose
-	if (-e $compose_filename) {
-		print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
-	}
-	if (-e ($compose_filename . ".final")) {
-		print "'$compose_filename.final' contains the composed email.\n"
+	if (defined $compose_filename) {
+		if (-e $compose_filename) {
+			print "'$compose_filename' contains an intermediate version of the email you were composing.\n";
+		}
+		if (-e ($compose_filename . ".final")) {
+			print "'$compose_filename.final' contains the composed email.\n"
+		}
 	}
 
 	exit;
@@ -505,6 +504,9 @@ sub get_patch_subject($) {
 if ($compose) {
 	# Note that this does not need to be secure, but we will make a small
 	# effort to have it be unique
+	$compose_filename = ($repo ?
+		tempfile(".gitsendemail.msg.XXXXXX", DIR => $repo->repo_path()) :
+		tempfile(".gitsendemail.msg.XXXXXX", DIR => "."))[1];
 	open(C,">",$compose_filename)
 		or die "Failed to open for writing $compose_filename: $!";
 
-- 
1.6.2.rc1.268.g83c06
