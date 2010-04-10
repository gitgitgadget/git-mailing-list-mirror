From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH v3 4/4] send-email: Cleanup smtp-domain and add config
Date: Sat, 10 Apr 2010 10:53:56 -0400
Message-ID: <1270911236-32476-5-git-send-email-brian@gernhardtsoftware.com>
References: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 10 16:54:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0c4w-0006h6-Ge
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 16:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0DJOyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 10:54:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45717 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab0DJOyG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 10:54:06 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 676AA1FFC05B; Sat, 10 Apr 2010 14:54:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from Hermes.local.net (unknown [64.134.103.20])
	by silverinsanity.com (Postfix) with ESMTPA id E06C91FFC056;
	Sat, 10 Apr 2010 14:53:59 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.251.g42f41
In-Reply-To: <1270911236-32476-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144556>

The way the code stored --smtp-domain was unlike its handling of other
similar options.  Bring it in line with the others by:

- Renaming $mail_domain to $smtp_domain to match the command line
  option. Also move its declaration from near the top of the file to
  near other option variables.

- Removing $mail_domain_default.  The variable was used once and only
  served to move the default away from where it gets used.

- Adding a sendemail.smtpdomain config option.  smtp-domain was the
  only SMTP configuration option that couldn't be set in the user's
  .gitconfig.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    3 ++-
 git-send-email.perl              |   19 +++++++++----------
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 626b19a..b755beb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1651,6 +1651,7 @@ sendemail.smtppass::
 sendemail.suppresscc::
 sendemail.suppressfrom::
 sendemail.to::
+sendemail.smtpdomain::
 sendemail.smtpserver::
 sendemail.smtpserverport::
 sendemail.smtpuser::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f171471..288a4ec 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -123,7 +123,8 @@ Sending
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, git send-email attempts
-	to determine your FQDN automatically.
+	to determine your FQDN automatically.  Default is the value of
+	'sendemail.smtpdomain'.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 1e9bec1..111c981 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -132,8 +132,6 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
-my $mail_domain_default = "localhost.localdomain";
-my $mail_domain;
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -190,7 +188,7 @@ sub do_edit {
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
-my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
+my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 
@@ -212,6 +210,7 @@ my %config_settings = (
     "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+	"smtpdomain" => \$smtp_domain,
     "to" => \@to,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
@@ -283,7 +282,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
-		    "smtp-domain:s" => \$mail_domain,
+		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -898,7 +897,7 @@ sub maildomain_mta {
 }
 
 sub maildomain {
-	return maildomain_net() || maildomain_mta() || $mail_domain_default;
+	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
 # Returns 1 if the message was sent, and 0 otherwise.
@@ -1002,18 +1001,18 @@ X-Mailer: git-send-email $gitversion
 		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
-			$mail_domain ||= maildomain();
+			$smtp_domain ||= maildomain();
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
-						      Hello => $mail_domain,
+						      Hello => $smtp_domain,
 						      Port => $smtp_server_port);
 		}
 		else {
 			require Net::SMTP;
-			$mail_domain ||= maildomain();
+			$smtp_domain ||= maildomain();
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server,
-						 Hello => $mail_domain,
+						 Hello => $smtp_domain,
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
@@ -1036,7 +1035,7 @@ X-Mailer: git-send-email $gitversion
 			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
-			    "maildomain=$mail_domain",
+			    "hello=$smtp_domain",
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
-- 
1.7.1.rc0.251.g42f41
