From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 6/9] Validate @recipients before using it for sendmail and Net::SMTP.
Date: Wed, 25 Apr 2007 19:37:20 -0700
Message-ID: <11775550433329-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
 <11775550433288-git-send-email-robbat2@gentoo.org>
 <11775550432746-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgty0-0001Ck-O6
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbXDZCoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbXDZCoI
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:08 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:47617 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754685AbXDZCoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:07 -0400
Received: (qmail 18678 invoked from network); 26 Apr 2007 02:44:06 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:06 +0000
Received: (qmail 18827 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32455 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550432746-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45601>

From: Robin H. Johnson <robbat2@gentoo.org>

Ensure that @recipients is only raw addresses when it is handed to the sendmail
binary OR Net::SMTP, otherwise BCC cases might get an extra <, or wierd stuff
might be passed to the exec.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c052760..0e1cc16 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -449,6 +449,7 @@ sub send_message
 	@cc = (map { sanitize_address_rfc822($_) } @cc);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
+	@recipients = (map { extract_valid_address($_) } @recipients);
 	my $date = format_2822_time($time++);
 	my $gitversion = '@@GIT_VERSION@@';
 	if ($gitversion =~ m/..GIT_VERSION../) {
@@ -477,7 +478,7 @@ X-Mailer: git-send-email $gitversion
 		$header .= join("\n", @xh) . "\n";
 	}
 
-	my @sendmail_parameters = ('-i', map { extract_valid_address($_) } @recipients);
+	my @sendmail_parameters = ('-i', @recipients);
 
 	if ($dry_run) {
 		# We don't want to send the email.
-- 
1.5.2.rc0.43.g2f4c7
