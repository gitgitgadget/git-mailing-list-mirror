From: Douglas Stockwell <douglas.stockwell@gmail.com>
Subject: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Sun,  2 Sep 2007 12:14:45 +0900
Message-ID: <11887028854022-git-send-email-doug@11011.net>
Cc: Douglas Stockwell <doug@11011.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 05:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRfvf-00052d-LB
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 05:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXIBDOp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 23:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbXIBDOo
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 23:14:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:18360 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbXIBDOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 23:14:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1458539wah
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 20:14:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:date:message-id:x-mailer:from;
        b=S4UdqBYwtA+dMF2Ux1sMBSnc8jHkbwqLmaAAqHdNmOKycetoSOh5tHKa0+7iLCcWn1vgbZkdUeYBGyvXSfZqXVesD+O+OlRaDH0e14RlBLbXYsP8x0PRUMYwCiiTu26KlwQv5EVkSuQQ8hv6KoklBpxYZQRzSqJnC0kNPYh+gYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:date:message-id:x-mailer:from;
        b=UUnTve+B5HuOhQo/pqN2xNBOztkvUsXvzJk8gRd4RHrK3+BU9/E/0v2N/Zi3fjWyNxquu4N+amf4689/8tkmQsiskLvtkd2XFU3wWrqmxU0cZtqnOLGO48OawoXmSHcOhJYA87IapfCYKTTDe9RMmTgsQ7OQruQ9eT40l4t4KfQ=
Received: by 10.114.175.16 with SMTP id x16mr464065wae.1188702883227;
        Sat, 01 Sep 2007 20:14:43 -0700 (PDT)
Received: from localhost.localdomain ( [210.235.203.21])
        by mx.google.com with ESMTPS id m5sm1937492wag.2007.09.01.20.14.41
        (version=SSLv3 cipher=OTHER);
        Sat, 01 Sep 2007 20:14:42 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc7.17.gd77cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57294>

Allows username and password to be given using --smtp-authuser
and --smtp-authpass. SSL use is flagged by --smtp-ssl. These are
backed by corresponding defaults in the git configuration file.

Signed-off-by: Douglas Stockwell <doug@11011.net>
---
 Documentation/git-send-email.txt |   21 +++++++++++++++-
 git-send-email.perl              |   50 ++++++++++++++++++++++++++++++-------
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8231286..471c268 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -79,6 +79,16 @@ The --cc option must be repeated for each user you want on the cc list.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
+--smtp-authuser, --smtp-authpass::
+	Username and password for SMTP-AUTH. Defaults are the values of
+	the configuration values 'sendemail.smtpauthuser' and
+	'sendemail.smtpauthpass'. If not set, authentication is not attempted.
+
+--smtp-ssl::
+	If set, connects to the SMTP server using SSL.
+	Default is the value of the 'sendemail.smtpssl' configuration value;
+	if that is unspecified, does not use SSL.
+
 --subject::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
@@ -132,7 +142,16 @@ sendemail.chainreplyto::
 	parameter.
 
 sendemail.smtpserver::
-	Default smtp server to use.
+	Default SMTP server to use.
+
+sendemail.smtpauthuser::
+	Default SMTP-AUTH username.
+
+sendemail.smtpauthpass::
+	Default SMTP-AUTH password.
+
+sendemail.smtpssl::
+	Boolean value specifying the default to the '--smtp-ssl' parameter.
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index f1a8855..38e8395 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,6 +73,12 @@ Options:
    --smtp-server  If set, specifies the outgoing SMTP server to use.
                   Defaults to localhost.
 
+   --smtp-authuser The username for SMTP-AUTH.
+
+   --smtp-authpass The password for SMTP-AUTH.
+
+   --smtp-ssl     If set, connects to the SMTP server using SSL.
+
    --suppress-from Suppress sending emails to yourself if your address
                   appears in a From: line. Defaults to off.
 
@@ -142,7 +148,6 @@ my $compose_filename = ".msg.$$";
 my (@to,@cc,@initial_cc,@bcclist,@xh,
 	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$time);
 
-my $smtp_server;
 my $envelope_sender;
 
 # Example reply to:
@@ -161,17 +166,34 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc);
+my ($smtp_server, $smtp_authuser, $smtp_authpass, $smtp_ssl);
 
-my %config_settings = (
+my %config_bool_settings = (
     "thread" => [\$thread, 1],
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, 0],
     "signedoffcc" => [\$signed_off_cc, 1],
+    "smtpssl" => [\$smtp_ssl, 0]
+);
+
+my %config_string_settings = (
+    "smtpserver" => [\$smtp_server, undef],
+    "smtpauthuser" => [\$smtp_authuser, undef],
+    "smtpauthpass" => [\$smtp_authpass, undef],
 );
 
-foreach my $setting (keys %config_settings) {
+foreach my $setting (keys %config_bool_settings) {
     my $config = $repo->config_bool("sendemail.$setting");
-    ${$config_settings{$setting}->[0]} = (defined $config) ? $config : $config_settings{$setting}->[1];
+    ${$config_bool_settings{$setting}->[0]} = (defined $config)
+        ? $config
+        : $config_bool_settings{$setting}->[1];
+}
+
+foreach my $setting (keys %config_string_settings) {
+    my $config = $repo->config("sendemail.$setting");
+    ${$config_string_settings{$setting}->[0]} = (defined $config)
+        ? $config
+        : $config_string_settings{$setting}->[1];
 }
 
 @bcclist = $repo->config('sendemail.bcc');
@@ -190,6 +212,9 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "bcc=s" => \@bcclist,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-authuser=s" => \$smtp_authuser,
+		    "smtp-authpass=s" => \$smtp_authpass,
+		    "smtp-ssl!" => \$smtp_ssl,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "suppress-from!" => \$suppress_from,
@@ -315,10 +340,7 @@ if ($thread && !defined $initial_reply_to && $prompting) {
 	$initial_reply_to =~ s/(^\s+|\s+$)//g;
 }
 
-if (!$smtp_server) {
-	$smtp_server = $repo->config('sendemail.smtpserver');
-}
-if (!$smtp_server) {
+if (!defined $smtp_server) {
 	foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
 		if (-x $_) {
 			$smtp_server = $_;
@@ -548,8 +570,16 @@ X-Mailer: git-send-email $gitversion
 		print $sm "$header\n$message";
 		close $sm or die $?;
 	} else {
-		require Net::SMTP;
-		$smtp ||= Net::SMTP->new( $smtp_server );
+		if ($smtp_ssl) {
+			require Net::SMTP::SSL;
+			$smtp ||= Net::SMTP::SSL->new( $smtp_server, Port => 465 );
+		}
+		else {
+			require Net::SMTP;
+			$smtp ||= Net::SMTP->new( $smtp_server );
+		}
+		$smtp->auth( $smtp_authuser, $smtp_authpass )
+			or die $smtp->message if (defined $smtp_authuser);
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
-- 
1.5.3.rc7.17.gd77cc
