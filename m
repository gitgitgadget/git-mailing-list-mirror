From: Joe Perches <joe@perches.com>
Subject: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Fri,  5 Aug 2011 17:40:10 -0700
Message-ID: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 03:40:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpVsL-000822-6L
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 03:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064Ab1HFBkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Aug 2011 21:40:22 -0400
Received: from wondertoys-mx.wondertoys.net ([206.117.179.246]:52757 "EHLO
	labridge.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754433Ab1HFBkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 21:40:15 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Aug 2011 21:40:15 EDT
Received: from [173.60.85.8] (account joe@perches.com HELO joe-laptop.perches.com)
  by labridge.com (CommuniGate Pro SMTP 5.0.14)
  with ESMTPA id 17978924 for git@vger.kernel.org; Fri, 05 Aug 2011 17:40:12 -0700
X-Mailer: git-send-email 1.7.6.131.g99019
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178818>

The current perl Net::SMTP support will not use AUTH LOGIN
when other authentication options are available.

Add an option to force the use of AUTH LOGIN when necessary.
(Like when using my current hosted email server, grumble)

Signed-off-by: Joe Perches <joe@perches.com>
---
 Documentation/git-send-email.txt |    3 +++
 git-send-email.perl              |   19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 327233c..9595773 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -198,6 +198,9 @@ must be used for each option.
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtpuser'),
 	then authentication is not attempted.
 
+--smtp-auth=<authorization_type>::
+	Force the smtp authentication to use a particular type.
+	Currently supported forced style is "login"
 
 Automating
 ~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..37dfbe7 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -28,6 +28,7 @@ use File::Temp qw/ tempdir tempfile /;
 use File::Spec::Functions qw(catfile);
 use Error qw(:try);
 use Git;
+use MIME::Base64;
 
 Getopt::Long::Configure qw/ pass_through /;
 
@@ -193,7 +194,7 @@ sub do_edit {
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
-my ($smtp_authuser, $smtp_encryption);
+my ($smtp_authuser, $smtp_encryption, $smtp_auth);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -218,6 +219,7 @@ my %config_settings = (
     "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+    "smtpauth" => \$smtp_auth,
     "smtpdomain" => \$smtp_domain,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
@@ -293,6 +295,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-auth=s" => \$smtp_auth,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
@@ -1111,7 +1114,19 @@ X-Mailer: git-send-email $gitversion
 				system "stty echo";
 			}
 
-			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			if (defined $smtp_auth && $smtp_auth =~ /^login$/i) {
+
+			    $smtp->datasend("AUTH LOGIN\n");
+			    $smtp->response();
+			    $smtp->datasend(encode_base64("$smtp_authuser"));
+			    $smtp->response();
+			    $smtp->datasend(encode_base64("$smtp_authpass"));
+			    $smtp->response();
+
+			} else {
+
+			    $auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
+			}
 		}
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
-- 
1.7.6.131.g99019
