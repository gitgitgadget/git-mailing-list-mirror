From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 3/3] send-email: Add sendemail.smtpdomain
Date: Fri,  9 Apr 2010 01:11:46 -0400
Message-ID: <1270789906-23735-4-git-send-email-brian@gernhardtsoftware.com>
References: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:12:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06Vx-0003vk-Ka
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754050Ab0DIFL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:11:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33164 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab0DIFLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:11:52 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 7C82A1FFC058; Fri,  9 Apr 2010 05:11:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	by silverinsanity.com (Postfix) with ESMTPA id 2F8831FFC05B;
	Fri,  9 Apr 2010 05:11:37 +0000 (UTC)
X-Mailer: git-send-email 1.7.1.rc0.243.g2ce66
In-Reply-To: <1270789906-23735-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144401>

--smtp-domain is an option that if you need once, you probably will
need again.  To help with that, allow the user to set it in their
.gitconfig

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Seemed like a natural thing to add.  Was surprised it wasn't there when I went
 poking around.

 Documentation/git-send-email.txt |    3 ++-
 git-send-email.perl              |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 11 deletions(-)

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
index 85fe374..14b996e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -132,8 +132,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
-my $mail_domain_default = "localhost.localdomain";
-my $mail_domain;
+my $smtp_domain_default = "localhost.localdomain";
 
 sub unique_email_list(@);
 sub cleanup_compose_files();
@@ -190,7 +189,7 @@ sub do_edit {
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
 my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
-my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
+my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
 
@@ -212,6 +211,7 @@ my %config_settings = (
     "smtpserverport" => \$smtp_server_port,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+	"smtpdomain" => \$smtp_domain,
     "to" => \@to,
     "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
@@ -283,7 +283,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-debug:i" => \$debug_net_smtp,
-		    "smtp-domain:s" => \$mail_domain,
+		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
 		    "compose" => \$compose,
@@ -902,7 +902,7 @@ sub maildomain_mta
 
 sub maildomain
 {
-	return maildomain_net() || maildomain_mta() || $mail_domain_default;
+	return maildomain_net() || maildomain_mta() || $smtp_domain_default;
 }
 
 # Returns 1 if the message was sent, and 0 otherwise.
@@ -1007,18 +1007,18 @@ X-Mailer: git-send-email $gitversion
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
@@ -1041,7 +1041,7 @@ X-Mailer: git-send-email $gitversion
 			die "Unable to initialize SMTP properly. Check config and use --smtp-debug. ",
 			    "VALUES: server=$smtp_server ",
 			    "encryption=$smtp_encryption ",
-			    "maildomain=$mail_domain",
+			    "maildomain=$smtp_domain",
 			    defined $smtp_server_port ? "port=$smtp_server_port" : "";
 		}
 
-- 
1.7.1.rc0.210.ge6da
