From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v3 3/3] New send-email option smtpserveroption.
Date: Sun,  5 Sep 2010 19:49:00 +0200
Message-ID: <1283708940-2172-4-git-send-email-pascal@obry.net>
References: <1283708940-2172-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 19:49:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsJKu-0005MD-0a
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 19:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab0IERso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 13:48:44 -0400
Received: from smtp19.orange.fr ([80.12.242.19]:28103 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab0IERsi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 13:48:38 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 3952F200047A;
	Sun,  5 Sep 2010 19:48:37 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id 2CCCF2000494;
	Sun,  5 Sep 2010 19:48:37 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf1928.orange.fr (SMTP Server) with ESMTP id EFC9E200047A;
	Sun,  5 Sep 2010 19:48:36 +0200 (CEST)
X-ME-UUID: 20100905174836982.EFC9E200047A@mwinf1928.orange.fr
X-Mailer: git-send-email 1.7.2.3.316.ga4c47
In-Reply-To: <1283708940-2172-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155470>

The new command line parameter --smtp-server-option or default
configuration sendemail.smtpserveroption can be used to pass
specific options to the SMTP server. Update the documentation
accordingly.
---
 Documentation/git-send-email.txt |    8 ++++++++
 git-send-email.perl              |    8 +++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c283084..5af05bc 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -157,6 +157,14 @@ user is prompted for a password while the input is masked for privacy.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
+--smtp-server-option=<option>::
+	If set, specifies the outgoing SMTP server option to use.
+	Default value can be specified by the 'sendemail.smtpserveroption'
+	configuration option.
++
+The --smtp-server-option option must be repeated for each option you want
+to pass to the server.
+
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
diff --git a/git-send-email.perl b/git-send-email.perl
index 39cb5af..47989fe 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -60,6 +60,7 @@ git send-email [options] <file | directory | rev-list options >
     --envelope-sender       <str>  * Email envelope sender.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
+    --smtp-server-option    <str>  * Outgoing SMTP server option to use.
     --smtp-server-port      <int>  * Outgoing SMTP server port.
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
@@ -188,7 +189,8 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
+my ($smtp_server, $smtp_server_port, @smtp_server_options);
+my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -210,6 +212,7 @@ my %config_bool_settings = (
 my %config_settings = (
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
+    "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
     "smtpdomain" => \$smtp_domain,
@@ -279,6 +282,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-server-option=s" => \@smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
@@ -1015,6 +1019,8 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	unshift (@sendmail_parameters, @smtp_server_options);
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
-- 
1.7.2.3.316.ga4c47
