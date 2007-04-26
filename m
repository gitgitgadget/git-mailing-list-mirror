From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 5/9] Perform correct quoting of recipient names.
Date: Wed, 25 Apr 2007 19:37:19 -0700
Message-ID: <11775550432746-git-send-email-robbat2@gentoo.org>
References: <1177555043986-git-send-email-robbat2@gentoo.org>
 <11775550432104-git-send-email-robbat2@gentoo.org>
 <1177555043272-git-send-email-robbat2@gentoo.org>
 <11775550432268-git-send-email-robbat2@gentoo.org>
 <11775550433288-git-send-email-robbat2@gentoo.org>
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H\. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 04:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hgty1-0001Ck-Td
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 04:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbXDZCoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 22:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754686AbXDZCoL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 22:44:11 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:47644 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754687AbXDZCoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 22:44:07 -0400
Received: (qmail 18697 invoked from network); 26 Apr 2007 02:44:06 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 26 Apr 2007 02:44:06 +0000
Received: (qmail 18840 invoked from network); 25 Apr 2007 19:37:41 -0700
Received: from grubbs-int-e1000.local.orbis-terrarum.net (HELO grubbs-int.orbis-terrarum.net) (172.16.9.4)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 25 Apr 2007 19:37:41 -0700
Received: (nullmailer pid 32453 invoked by uid 0);
	Thu, 26 Apr 2007 02:37:23 -0000
X-Mailer: git-send-email 1.5.2.rc0.43.g2f4c7
In-Reply-To: <11775550433288-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45602>

From: Robin H. Johnson <robbat2@gentoo.org>

Always perform quoting of the recipient names if they contain periods,
previously only the author's address was treated this way. This stops sendmail
binaries from exploding the name into bad addresses.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 git-send-email.perl |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5210a40..c052760 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -431,9 +431,22 @@ sub unquote_rfc2047 {
 	return "$_";
 }
 
+# If an address contains a . in the name portion, the name must be quoted.
+sub sanitize_address_rfc822 
+{
+	my ($recipient) = @_;
+	my ($recipient_name) = ($recipient =~ /^(.*?)\s+</);
+	if($recipient_name && $recipient_name =~ /\./ && $recipient_name !~ /^".*"$/) {
+		my ($name, $addr) = ($recipient =~ /^(.*?)(\s+<.*)/);
+		$recipient = "\"$name\"$addr";
+	}
+	return $recipient;
+}
+
 sub send_message
 {
 	my @recipients = unique_email_list(@to);
+	@cc = (map { sanitize_address_rfc822($_) } @cc);
 	my $to = join (",\n\t", @recipients);
 	@recipients = unique_email_list(@recipients,@cc,@bcclist);
 	my $date = format_2822_time($time++);
@@ -442,11 +455,7 @@ sub send_message
 	    $gitversion = Git::version();
 	}
 
-	my ($author_name) = ($from =~ /^(.*?)\s+</);
-	if ($author_name && $author_name =~ /\./ && $author_name !~ /^".*"$/) {
-		my ($name, $addr) = ($from =~ /^(.*?)(\s+<.*)/);
-		$from = "\"$name\"$addr";
-	}
+	$from = sanitize_address_rfc822($from);
 	my $cc = join(", ", unique_email_list(@cc));
 	my $ccline = "";
 	if ($cc ne '') {
-- 
1.5.2.rc0.43.g2f4c7
