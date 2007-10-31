From: Simon Sasburg <simon.sasburg@gmail.com>
Subject: [PATCH] Implement sending mails over TLS in git-send-email.
Date: Wed, 31 Oct 2007 16:50:59 +0100
Message-ID: <1193845859-1788-1-git-send-email-Simon.Sasburg@gmail.com>
Cc: Simon Sasburg <Simon.Sasburg@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 16:51:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFqq-0005xI-Ub
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159AbXJaPvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbXJaPvH
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:51:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:23334 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754192AbXJaPvE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 11:51:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so324998ugc
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=+lTiYebIYEtb1p7uvrr7+UWGruySr76cMVs3DAB9vgQ=;
        b=dXxZkqq7rIm5FF/YVK14Lb7IOnUbbjl66goIZBTnv5AGLcdw96Frd1qNNZ+UA6qvSeaWJZTrSSlAbUgpQdOxzwGQbNz2Ph1vpUht7VuUrFtk9VjN04QsiexhcNNUDk9i9PDMd629ZGztxUDbnkhwmw4yt6TgnlHVk7UUQBIC3fw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=WRT7RlCjaYS3IXQtLABjiwmkuiRl5A5Uu1++UcZaEgmFn/K7TOX/kq1U6TfIA2rRNTDxMZ3T1+UGwItJhnuKaS58xxWMQAMPNMHK/04zIOnZTM11eJWJAHfcuCF8TZTyxcf4/AABNZwhB3kIHi1ZEDJyePKG76zP6pLfJJg8QWY=
Received: by 10.67.196.4 with SMTP id y4mr213546ugp.1193845862705;
        Wed, 31 Oct 2007 08:51:02 -0700 (PDT)
Received: from localhost ( [86.85.232.104])
        by mx.google.com with ESMTPS id 6sm1460427ugc.2007.10.31.08.51.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2007 08:51:01 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.498.g9c514
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62846>

Signed-off-by: Simon Sasburg <Simon.Sasburg@gmail.com>
---

With this patch I was able to use git-send-email to send mail through gmail's
smpt server, which uses TLS.

Net::SMTP::TLS apparently doesn't do proper error handling, so the TLS
codepath is essentially not checked for errors. I'm not really happy with this.

The Net::SMTP::TLS docs say this about error handling:
>ERROR HANDLING:
>This module will croak in the event of an SMTP error. Should you wish to handle this gracefully in your application, you may wrap your mail transmission in an eval {} block and check $@ afterward.

But my perl knowledge is way too limited for me to know if/how that helps.
(This patch was just made by copying existing code and fiddling with it untill it did what i wanted)

Maybe someone who knows more about perl than I do can finish this?
Or give an estimate how difficult it would be for me to fix after pointing me in the right direction?
(I'm willing to learn a little perl for this, but not too much :-p)
---
 git-send-email.perl |   64 +++++++++++++++++++++++++++++++++-----------------
 1 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 96051bc..5cf220f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -88,6 +88,9 @@ Options:
 
    --smtp-ssl     If set, connects to the SMTP server using SSL.
 
+   --smtp-tls     If set, connects to the SMTP server using TLS.
+                  Overrides --smtp-ssl.
+
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
@@ -175,7 +178,7 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
+my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl, $smtp_tls);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 
 my %config_bool_settings = (
@@ -184,6 +187,7 @@ my %config_bool_settings = (
     "suppressfrom" => [\$suppress_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
     "smtpssl" => [\$smtp_ssl, 0],
+    "smtptls" => [\$smtp_tls, 0],
 );
 
 my %config_settings = (
@@ -213,6 +217,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass=s" => \$smtp_authpass,
 		    "smtp-ssl!" => \$smtp_ssl,
+		    "smtp-tls!" => \$smtp_tls,
 		    "identity=s" => \$identity,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
@@ -613,31 +618,46 @@ X-Mailer: git-send-email $gitversion
 			die "The required SMTP server is not properly defined."
 		}
 
-		if ($smtp_ssl) {
-			$smtp_server_port ||= 465; # ssmtp
-			require Net::SMTP::SSL;
-			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
+		if ($smtp_tls) {
+			require Net::SMTP::TLS;
+			$smtp ||= Net::SMTP::TLS->new(
+				$smtp_server,
+				Port => $smtp_server_port,
+				User => $smtp_authuser,
+				Password=> $smtp_authpass);
+
+			$smtp->mail( $raw_from );
+			$smtp->to( @recipients );
+			$smtp->data;
+			$smtp->datasend("$header\n$message");
+			$smtp->dataend();
 		}
 		else {
-			require Net::SMTP;
-			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
-						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server);
-		}
+			if ($smtp_ssl) {
+				require Net::SMTP::SSL;
+				$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
+			}
+			else {
+				require Net::SMTP;
+				$smtp ||= Net::SMTP->new((defined $smtp_server_port)
+							 ? "$smtp_server:$smtp_server_port"
+							 : $smtp_server);
+			}
 
-		if (!$smtp) {
-			die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
-		}
+			if (!$smtp) {
+				die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
+			}
 
-		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
-			$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
+				$smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			}
+			$smtp->mail( $raw_from ) or die $smtp->message;
+			$smtp->to( @recipients ) or die $smtp->message;
+			$smtp->data or die $smtp->message;
+			$smtp->datasend("$header\n$message") or die $smtp->message;
+			$smtp->dataend() or die $smtp->message;
+			$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 		}
-		$smtp->mail( $raw_from ) or die $smtp->message;
-		$smtp->to( @recipients ) or die $smtp->message;
-		$smtp->data or die $smtp->message;
-		$smtp->datasend("$header\n$message") or die $smtp->message;
-		$smtp->dataend() or die $smtp->message;
-		$smtp->ok or die "Failed to send $subject\n".$smtp->message;
 	}
 	if ($quiet) {
 		printf (($dry_run ? "Dry-" : "")."Sent %s\n", $subject);
@@ -651,7 +671,7 @@ X-Mailer: git-send-email $gitversion
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n";
 		}
 		print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\n\n";
-		if ($smtp) {
+		if ($smtp && !$smtp_tls) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =~ /\n([^\n]+\n)$/s), "\n";
 		} else {
-- 
1.5.3.4.498.g9c514
