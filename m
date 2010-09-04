From: Pascal Obry <pascal@obry.net>
Subject: [PATCH v2 3/3] New send-email option smtpserveroption.
Date: Sat,  4 Sep 2010 21:55:28 +0200
Message-ID: <1283630128-3472-4-git-send-email-pascal@obry.net>
References: <1283630128-3472-1-git-send-email-pascal@obry.net>
Cc: Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 21:55:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oryq6-0005oe-Kc
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 21:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab0IDTzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 15:55:37 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53072 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0IDTzf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 15:55:35 -0400
Received: by wwj40 with SMTP id 40so4453808wwj.1
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 12:55:34 -0700 (PDT)
Received: by 10.227.12.223 with SMTP id y31mr234129wby.193.1283630133909;
        Sat, 04 Sep 2010 12:55:33 -0700 (PDT)
Received: from localhost (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id b23sm2909514wbb.22.2010.09.04.12.55.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 12:55:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.277.gb49c4
In-Reply-To: <1283630128-3472-1-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155352>

The new command line parameter --smtp-server-option or default
configuration sendemail.smtpserveroption can be used to pass
specific options to the SMTP server. Update the documentation
accordingly.
---
 Documentation/git-send-email.txt |    8 ++++++++
 git-send-email.perl              |    8 +++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index c283084..ed30be8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -157,6 +157,14 @@ user is prompted for a password while the input is masked for privacy.
 	`/usr/lib/sendmail` if such program is available, or
 	`localhost` otherwise.
 
+--smtp-server-option=<options>::
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
1.7.2.2.277.gb49c4
