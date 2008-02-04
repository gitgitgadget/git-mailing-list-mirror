From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH 3/3][V.2] git-send-email: Better handling of EOF [^D]
Date: Sun,  3 Feb 2008 19:53:58 -0500
Message-ID: <1202086438-16251-3-git-send-email-mfwitten@mit.edu>
References: <5C100A3B-0B4A-4D4E-B68B-1A54674A795A@mit.edu>
 <1202086438-16251-1-git-send-email-mfwitten@mit.edu>
 <1202086438-16251-2-git-send-email-mfwitten@mit.edu>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@mit.edu>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 04 01:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLpfg-0003OY-7h
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbYBDA6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbYBDA6U
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:58:20 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35375 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754494AbYBDA6T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 19:58:19 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m140w21Z012248;
	Sun, 3 Feb 2008 19:58:17 -0500 (EST)
Received: from localhost.localdomain (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m140rw7W001110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 3 Feb 2008 19:54:02 -0500 (EST)
X-Mailer: git-send-email 1.5.4.9.gcc769-dirty
In-Reply-To: <1202086438-16251-2-git-send-email-mfwitten@mit.edu>
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72440>

Before, when the user sent the EOF control character,
the prompts would be repeated on the same line as the
previous prompt.

Now, repeat prompts display on separate lines.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---
 git-send-email.perl |   46 +++++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 14268fc..6724810 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -376,9 +376,12 @@ if (@files) {
 my $prompting = 0;
 if (!defined $sender) {
 	$sender = $repoauthor || $repocommitter;
-	do {
+
+	while (1) {
 		$_ = $term->readline("Who should the emails appear to be from? [$sender] ");
-	} while (!defined $_);
+		last if defined $_;
+		print "\n";
+	}
 
 	$sender = $_ if ($_);
 	print "Emails will be sent from: ", $sender, "\n";
@@ -386,10 +389,14 @@ if (!defined $sender) {
 }
 
 if (!@to) {
-	do {
-		$_ = $term->readline("Who should the emails be sent to? ",
-				"");
-	} while (!defined $_);
+
+
+	while (1) {
+		$_ = $term->readline("Who should the emails be sent to? ", "");
+		last if defined $_;
+		print "\n";
+	}
+
 	my $to = $_;
 	push @to, split /,/, $to;
 	$prompting++;
@@ -411,20 +418,23 @@ sub expand_aliases {
 @bcclist = expand_aliases(@bcclist);
 
 if (!defined $initial_subject && $compose) {
-	do {
-		$_ = $term->readline("What subject should the initial email start with? ",
-			$initial_subject);
-	} while (!defined $_);
+	while (1) {
+		$_ = $term->readline("What subject should the initial email start with? ", $initial_subject);
+		last if defined $_;
+		print "\n";
+	}
+
 	$initial_subject = $_;
 	$prompting++;
 }
 
 if ($thread && !defined $initial_reply_to && $prompting) {
-	do {
-		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ",
-			$initial_reply_to);
-	} while (!defined $_);
-
+	while (1) {
+		$_= $term->readline("Message-ID to be used as In-Reply-To for the first email? ", $initial_reply_to);
+		last if defined $_;
+		print "\n";
+	}
+	
 	$initial_reply_to = $_;
 }
 if (defined $initial_reply_to && $_ ne "") {
@@ -474,9 +484,11 @@ EOT
 	close(C);
 	close(C2);
 
-	do {
+	while (1) {
 		$_ = $term->readline("Send this email? (y|n) ");
-	} while (!defined $_);
+		last if defined $_;
+		print "\n";
+	}
 
 	if (uc substr($_,0,1) ne 'Y') {
 		cleanup_compose_files();
-- 
1.5.4.9.gcc769-dirty
