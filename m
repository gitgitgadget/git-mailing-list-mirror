From: Pascal Obry <pascal@obry.net>
Subject: [PATCH 2/2] New send-email option smtpserveroptions.
Date: Sat,  4 Sep 2010 18:06:12 +0200
Message-ID: <1283616372-3340-3-git-send-email-pascal@obry.net>
References: <1283616372-3340-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 18:06:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvG4-0003Fx-Vb
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097Ab0IDQGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:06:19 -0400
Received: from smtp20.orange.fr ([80.12.242.26]:60405 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754031Ab0IDQGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:06:18 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id EA71E2000393;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id D75E120003BD;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
	by mwinf2003.orange.fr (SMTP Server) with ESMTP id A90172000393;
	Sat,  4 Sep 2010 18:06:07 +0200 (CEST)
X-ME-UUID: 20100904160607692.A90172000393@mwinf2003.orange.fr
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
In-Reply-To: <1283616372-3340-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155336>

The new command line parameter --smtp-server-options or default
configuration sendemail.smtpserveroptions can be used to pass
specific options to the SMTP server.
---
 Documentation/git-send-email.txt |    5 +++++
 git-send-email.perl              |    9 ++++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c283084..425b102 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -157,6 +157,11 @@ user is prompted for a password while the input is masked for privacy.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
+--smtp-server-options=<options>::
+	If set, specifies the outgoing SMTP server options to use.
+	Default value can be specified by the 'sendemail.smtpserveroptions'
+	configuration option.
+
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
diff --git a/git-send-email.perl b/git-send-email.perl
index 0063606..e5cdda7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -60,6 +60,7 @@ git send-email [options] <file | directory | rev-list options >
     --envelope-sender       <str>  * Email envelope sender.
     --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
                                      is optional. Default 'localhost'.
+    --smtp-server-options   <int>  * Outgoing SMTP server options to use.
     --smtp-server-port      <int>  * Outgoing SMTP server port.
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
@@ -188,7 +189,8 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
+my ($smtp_server, $smtp_server_port, $smtp_server_options);
+my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -210,6 +212,7 @@ my %config_bool_settings = (
 my %config_settings = (
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
+    "smtpserveroptions" => \$smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
     "smtpdomain" => \$smtp_domain,
@@ -279,6 +282,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "no-bcc" => \$no_bcc,
 		    "chain-reply-to!" => \$chain_reply_to,
 		    "smtp-server=s" => \$smtp_server,
+		    "smtp-server-options=s" => \$smtp_server_options,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
@@ -1015,6 +1019,9 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	unshift (@sendmail_parameters, $smtp_server_options)
+	    if (defined $smtp_server_options);
+
 	if ($dry_run) {
 		# We don't want to send the email.
 	} elsif ($smtp_server =~ m#^/#) {
-- 
1.7.2.2.277.gb49c4
