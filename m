From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] git-send-email: add support for TLS via Net::SMTP::SSL
Date: Wed, 25 Jun 2008 21:42:43 +0200
Message-ID: <1214422963-30628-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 21:43:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBatw-0002zZ-P7
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 21:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbYFYTmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 15:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754305AbYFYTmg
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 15:42:36 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:41529 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753185AbYFYTmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 15:42:35 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Jun 2008 21:42:33 +0200
Received: from localhost.localdomain ([84.75.156.10]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 25 Jun 2008 21:42:33 +0200
X-Mailer: git-send-email 1.5.6.133.gc2e2
X-OriginalArrivalTime: 25 Jun 2008 19:42:33.0579 (UTC) FILETIME=[9CCBB3B0:01C8D6FB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86330>

We do this by handing over the Net::SMTP instance to Net::SMTP::SSL,
which avoids Net::SMTP::TLS and its weird error checking.  This trick
is due to Brian Evins.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

The SMTP at my university only works with TLS, so I needed this.  The
trick referred to above was posted here:
  http://kerneltrap.org/mailarchive/git/2007/10/31/374810

- Thomas


 Documentation/git-send-email.txt |   16 ++++++++++++----
 git-send-email.perl              |   33 ++++++++++++++++++++++++++++-----
 2 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 251d661..dc7eb7b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -133,10 +133,13 @@ or on the command line. If a username has been specified (with
 specified (with --smtp-pass or a configuration variable), then the
 user is prompted for a password while the input is masked for privacy.
 
+--smtp-encryption::
+	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
+	value reverts to plain SMTP.  Default is the value of
+	'sendemail.smtpencryption'.
+
 --smtp-ssl::
-	If set, connects to the SMTP server using SSL.
-	Default is the value of the 'sendemail.smtpssl' configuration value;
-	if that is unspecified, does not use SSL.
+	Legacy alias for '--smtp-encryption=ssl'.
 
 --subject::
 	Specify the initial subject of the email thread.
@@ -229,8 +232,13 @@ sendemail.smtpuser::
 sendemail.smtppass::
 	Default SMTP-AUTH password.
 
+sendemail.smtpencryption::
+	Default encryption method.  Use 'ssl' for SSL (and specify an
+	appropriate port), or 'tls' for TLS.  Takes precedence over
+	'smtpssl' if both are specified.
+
 sendemail.smtpssl::
-	Boolean value specifying the default to the '--smtp-ssl' parameter.
+	Legacy boolean that sets 'smtpencryption=ssl' if enabled.
 
 Author
 ------
diff --git a/git-send-email.perl b/git-send-email.perl
index 0b04ba3..7630720 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,7 +84,10 @@ Options:
 
    --smtp-pass    The password for SMTP-AUTH.
 
-   --smtp-ssl     If set, connects to the SMTP server using SSL.
+   --smtp-encryption Specify 'tls' for STARTTLS encryption, or 'ssl' for SSL.
+                  Any other value disables the feature.
+
+   --smtp-ssl     Synonym for '--smtp-encryption=ssl'.  Deprecated.
 
    --suppress-cc  Suppress the specified category of auto-CC.  The category
 		  can be one of 'author' for the patch author, 'self' to
@@ -184,7 +187,7 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_ssl);
+my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($no_validate);
 my (@suppress_cc);
@@ -194,7 +197,6 @@ my %config_bool_settings = (
     "chainreplyto" => [\$chain_reply_to, 1],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffcc" => [\$signed_off_cc, undef],
-    "smtpssl" => [\$smtp_ssl, 0],
 );
 
 my %config_settings = (
@@ -249,7 +251,8 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
-		    "smtp-ssl!" => \$smtp_ssl,
+		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
+		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
@@ -289,6 +292,15 @@ sub read_config {
 			$$target = Git::config(@repo, "$prefix.$setting") unless (defined $$target);
 		}
 	}
+
+	if (!defined $smtp_encryption) {
+		my $enc = Git::config(@repo, "$prefix.smtpencryption");
+		if (defined $enc) {
+			$smtp_encryption = $enc;
+		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
+			$smtp_encryption = 'ssl';
+		}
+	}
 }
 
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
@@ -738,7 +750,7 @@ X-Mailer: git-send-email $gitversion
 			die "The required SMTP server is not properly defined."
 		}
 
-		if ($smtp_ssl) {
+		if ($smtp_encryption eq 'ssl') {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
 			$smtp ||= Net::SMTP::SSL->new($smtp_server, Port => $smtp_server_port);
@@ -748,6 +760,17 @@ X-Mailer: git-send-email $gitversion
 			$smtp ||= Net::SMTP->new((defined $smtp_server_port)
 						 ? "$smtp_server:$smtp_server_port"
 						 : $smtp_server);
+			if ($smtp_encryption eq 'tls') {
+				require Net::SMTP::SSL;
+				$smtp->command('STARTTLS');
+				$smtp->response();
+				if ($smtp->code == 220) {
+					$smtp = Net::SMTP::SSL->start_SSL($smtp)
+						or die "STARTTLS failed! ".$smtp->message;
+				} else {
+					die "Server does not support STARTTLS! ".$smtp->message;
+				}
+			}
 		}
 
 		if (!$smtp) {
-- 
1.5.6.84.ge5c1
