From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 7/9] Ensure clean addresses are always used with Net::SMTP
Date: Wed, 25 Apr 2007 19:37:21 -0700
Message-ID: <1177555043174-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
 <11775550433288-git-send-email-robbat2@gentoo.org>
 <11775550432746-git-send-email-robbat2@gentoo.org>
 <11775550433329-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgtyU-0001PR-VI
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbXDZCoq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbXDZCoq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:46 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:51047 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754688AbXDZCop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:45 -0400
Received: (qmail 18909 invoked from network); 26 Apr 2007 02:44:45 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:45 +0000
Received: (qmail 18845 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32457 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550433329-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45606>

From: Robin H. Johnson <robbat2@gentoo.org>

Always pass in clean addresses to Net::SMTP for the MAIL FROM, and use them on
the SMTP non-quiet output as well.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0e1cc16..82468bd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -479,6 +479,7 @@ X-Mailer: git-send-email $gitversion
 	}
 
 	my @sendmail_parameters = ('-i', @recipients);
+	my $raw_from = extract_valid_address($from);
 
 	if ($dry_run) {
 		# We don't want to send the email.
@@ -493,7 +494,7 @@ X-Mailer: git-send-email $gitversion
 	} else {
 		require Net::SMTP;
 		$smtp ||= Net::SMTP->new( $smtp_server );
-		$smtp->mail( $from ) or die $smtp->message;
+		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
 		$smtp->datasend("$header\n$message") or die $smtp->message;
@@ -504,10 +505,10 @@ X-Mailer: git-send-email $gitversion
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
 	} else {
 		print (($dry_run ? "Dry-" : "")."OK. Log says:\nDate: $date\n");
-		if ($smtp) {
+		if ($smtp_server !~ m#^/#) {
 			print "Server: $smtp_server\n";
-			print "MAIL FROM: $from\n";
-			print "RCPT TO: ".join(',',@recipients)."\n";
+			print "MAIL FROM:<$raw_from>\n";
+			print "RCPT TO:".join(',',(map { "<$_>" } @recipients))."\n";
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
-- 
1.5.2.rc0.43.g2f4c7
