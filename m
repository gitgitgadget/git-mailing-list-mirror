From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP code in send_message
Date: Sat, 18 Apr 2009 12:02:02 -0500
Message-ID: <1240074128-16132-7-git-send-email-mfwitten@gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 19:07:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvE0U-00072K-FJ
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 19:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756706AbZDRRFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 13:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbZDRRFe
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 13:05:34 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:41771 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbZDRRFe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 13:05:34 -0400
Received: by qyk32 with SMTP id 32so633766qyk.33
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IJFckFMONZr8qpHNIFlJXy2B3mkxl921niY1HoCCjAU=;
        b=fYE1PAQqWeTusbq01d/o9eeN1RGl7kLYS8F3RcVVVvVLfkCI0kN6T3fviOhJivk0Ad
         Vj6ubSs0D4pFW4AKRPnAtsRe2gFcSUr2CNNvNoRTtxrEWIHaaxJCo2eZOcN65HxLDdco
         EnArDH241DNCg+Qgibv/YroZLCqEEHZLlaCdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tfq/OTlF2cJT0aN3fg722jE7tsQLdemPAVX0YUySOZesvDuQ+F3onaf9xbPUvEw3Iv
         AcHqLLAIWTNeU2kKV0HaKVAIgQDTEmu3KwYE6hXQX84hgT7/nZDU/6wgyDVbn0sLtMsF
         yvB4YXzxGtHBLOYgRXEoVacErLQCT4mWHOsQk=
Received: by 10.220.95.75 with SMTP id c11mr4255022vcn.1.1240074332949;
        Sat, 18 Apr 2009 10:05:32 -0700 (PDT)
Received: from localhost.localdomain (97-116-125-103.mpls.qwest.net [97.116.125.103])
        by mx.google.com with ESMTPS id 6sm1776586ywn.52.2009.04.18.10.05.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 10:05:32 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.479.g2aec
In-Reply-To: <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116849>

Some of the code was never used or not necessary; it should
be easier to read now.

The code could even be simplified further, because Net::SMTP{,::SSL}
both take the PORT variable in their new methods (which, as of this
commit, are actually the same method). Moreover, both take a server
URI of the form 'host:port' that trumps any value passed to PORT.

Unfortunately, none of this is documented publicly, so it isn't
exploited out of purity.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 git-send-email.perl |   93 +++++++++++++++++++++++++++-----------------------
 1 files changed, 50 insertions(+), 43 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 2727c77..6e2ea2c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -985,67 +985,74 @@ X-Mailer: git-send-email $gitversion
 
 	} else {
 
-		if (!defined $smtp_server) {
-			die "The required SMTP server is not properly defined."
-		}
+		goto SEND_MAIL if $smtp;
+
+		if ($smtp_encryption =~ /ssl/i) {
+
+			use Net::SMTP::SSL;
+			$smtp = Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port // 465)
+				or die "Could not connect to SSL SMTP server '$smtp_server:$smtp_server_port'\n";
+
+		} else {
+
+			use Net::SMTP;
+
+			my $server_URI = (defined $smtp_server_port)
+						? "$smtp_server:$smtp_server_port"
+						:  $smtp_server;
+
+			$smtp = Net::SMTP->new($server_URI)
+				or die "Could not connect to SMTP server: '$server_URI'\n";
+
+			if ($smtp_encryption =~ /tls/i) {
 
-		if ($smtp_encryption eq 'ssl') {
-			$smtp_server_port ||= 465; # ssmtp
-			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
-		}
-		else {
-			require Net::SMTP;
-			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
-						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server);
-			if ($smtp_encryption eq 'tls') {
-				require Net::SMTP::SSL;
 				$smtp->command('STARTTLS');
-				$smtp->response();
-				if ($smtp->code == 220) {
-					$smtp = Net::SMTP::SSL->start_SSL($smtp)
-						or die "STARTTLS failed! ".$smtp->message;
-					$smtp_encryption = '';
-					# Send EHLO again to receive fresh
-					# supported commands
-					$smtp->hello();
-				} else {
-					die "Server does not support STARTTLS! ".$smtp->message;
-				}
-			}
-		}
+				$smtp->response(); # so $smtp->code works.
+
+				die "Server does not support STARTTLS: " . $smtp->message . "\n"
+					unless $smtp->code == 220;
+
+				use Net::SMTP::SSL;
+				Net::SMTP::SSL->start_SSL($smtp)
+					or die "STARTTLS failed! " . $smtp->message . "\n";
+
+				# Send EHLO again to receive fresh
+				# supported commands:
 
-		if (!$smtp) {
-			die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+				$smtp->hello();
+			}
 		}
 
 		if (defined $smtp_authuser) {
 
-			if (!defined $smtp_authpass) {
+			unless (defined $smtp_authpass) {
 
 				system "stty -echo";
 
-				do {
+				{
 					print "Password: ";
-					$_ = <STDIN>;
+					$smtp_authpass = <STDIN>;
 					print "\n";
-				} while (!defined $_);
-
-				chomp($smtp_authpass = $_);
+					redo unless defined $smtp_authpass;
+					chomp($smtp_authpass);
+				}
 
 				system "stty echo";
 			}
 
-			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			$smtp->auth($smtp_authuser, $smtp_authpass)
+				or die "Could not authenticate '$smtp_authuser': " . $smtp->message . "\n";
 		}
 
-		$smtp->mail( $raw_from ) or die $smtp->message;
-		$smtp->to( @recipients ) or die $smtp->message;
-		$smtp->data or die $smtp->message;
-		$smtp->datasend("$header\n$message") or die $smtp->message;
-		$smtp->dataend() or die $smtp->message;
-		$smtp->code =~ /250|200/ or die "Failed to send $subject\n".$smtp->message;
+		SEND_MAIL:
+
+		$smtp->mail($raw_from)               and
+		$smtp->to(@recipients)               and
+		$smtp->data                          and
+		$smtp->datasend("$header\n$message") and
+		$smtp->dataend                       or
+
+		die "Failed to send '$subject': " . $smtp->message . "\n";
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
-- 
1.6.2.2.479.g2aec
