From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 8/9] Allow users to optionally specify their envelope sender.
Date: Wed, 25 Apr 2007 19:37:22 -0700
Message-ID: <11775550433762-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
 <11775550433288-git-send-email-robbat2@gentoo.org>
 <11775550432746-git-send-email-robbat2@gentoo.org>
 <11775550433329-git-send-email-robbat2@gentoo.org>
 <1177555043174-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgty2-0001Ck-Gm
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbXDZCoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbXDZCoU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:20 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:48031 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754689AbXDZCoM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:12 -0400
Received: (qmail 18723 invoked from network); 26 Apr 2007 02:44:11 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:11 +0000
Received: (qmail 18853 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32459 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <1177555043174-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45604>

From: Robin H. Johnson <robbat2@gentoo.org>

If your normal user is not the same user you are subscribed to a list with,
then the default envelope sender used will cause your messages to bounce or
silently vanish into the ether.

This patch provides an optional parameter to set the envelope sender.
To use it with the sendmail binary, you must have privileges to use the -f
parameter!

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 82468bd..e1562b3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -79,6 +79,8 @@ Options:
 
    --dry-run	  Do everything except actually send the emails.
 
+   --envelope-sender	Specify the envelope sender used to send the emails.
+
 EOT
 	exit(1);
 }
@@ -139,6 +141,7 @@ my (@to,@cc,@initial_cc,@bcclist,@xh,
 my ($chain_reply_to, $quiet, $suppress_from, $no_signed_off_cc,
 	$dry_run) = (1, 0, 0, 0, 0);
 my $smtp_server;
+my $envelope_sender;
 
 # Example reply to:
 #$initial_reply_to = ''; #<20050203173208.GA23964@foobar.com>';
@@ -177,6 +180,7 @@ my $rc = GetOptions("from=s" => \$from,
 		    "suppress-from" => \$suppress_from,
 		    "no-signed-off-cc|no-signed-off-by-cc" => \$no_signed_off_cc,
 		    "dry-run" => \$dry_run,
+		    "envelope-sender=s" => \$envelope_sender,
 	 );
 
 unless ($rc) {
@@ -479,7 +483,11 @@ X-Mailer: git-send-email $gitversion
 	}
 
 	my @sendmail_parameters = ('-i', @recipients);
-	my $raw_from = extract_valid_address($from);
+	my $raw_from = $from;
+	$raw_from = $envelope_sender if (defined $envelope_sender);
+	$raw_from = extract_valid_address($raw_from);
+	unshift (@sendmail_parameters,
+			'-f', $raw_from) if(defined $envelope_sender);
 
 	if ($dry_run) {
 		# We don't want to send the email.
-- 
1.5.2.rc0.43.g2f4c7
