From: Michael Witten <mfwitten@MIT.EDU>
Subject: [PATCH] git-send-email: ssh/login style password requests
Date: Thu, 31 Jan 2008 23:59:14 -0500
Message-ID: <1201841954-17949-1-git-send-email-mfwitten@mit.edu>
Cc: gitster@pobox.com, Michael Witten <mfwitten@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 06:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKo1n-0002bG-6R
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 06:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYBAFAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 00:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbYBAFAh
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 00:00:37 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:48060 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751331AbYBAFAe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 00:00:34 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m114xKhM011132;
	Thu, 31 Jan 2008 23:59:20 -0500 (EST)
Received: from localhost.localdomain (MACGREGOR-TWO-FIFTY-EIGHT.MIT.EDU [18.239.6.3])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m114xEO1003603
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 31 Jan 2008 23:59:20 -0500 (EST)
X-Mailer: git-send-email 1.5.4.rc5.17.g536ee
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72148>

Whilst convenient, it is most unwise to record passwords
in any place but one's brain. Moreover, it is especially
foolish to store them in configuration files, even with
access permissions set accordingly.

git-send-email has been amended, so that if it detects
an smtp username without a password, it promptly prompts
for the password and masks the input for privacy.

Furthermore, the argument to --smtp-pass has been rendered
optional.

The documentation has been updated to reflect these changes.

Signed-off-by: Michael Witten <mfwitten@mit.edu>
---

	This was sent with the updated git-send-email ;-)

 Documentation/git-send-email.txt |   19 +++++++++++++++----
 git-send-email.perl              |   23 +++++++++++++++++++----
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 0554f2b..6d5abf4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -96,12 +96,23 @@ The --cc option must be repeated for each user you want on the cc list.
 	servers typically listen to smtp port 25 and ssmtp port
 	465).
 
---smtp-user, --smtp-pass::
-	Username and password for SMTP-AUTH. Defaults are the values of
-	the configuration values 'sendemail.smtpuser' and
-	'sendemail.smtppass', but see also 'sendemail.identity'.
+--smtp-user::
+	Username for SMTP-AUTH. The default value can be specified
+	with the configuration variable 'sendemail.smtpuser' or
+	sendemail.<identity>.smtpuser (see sendemail.identity).
 	If not set, authentication is not attempted.
 
+--smtp-pass::
+	Password for SMTP-AUTH. The default value can be specified
+	with the configuration variable 'sendemail.smtppass' or
+	sendemail.<identity>.smtppass (see sendemail.identity).
+	The argument is optional: If no argument is specified, then
+	the password is assumed to be the empty string.
+	If a username has been set, but no password has been set,
+	the user is prompted for a password with masked input for
+	privacy; passwords need not be recorded in configuration
+	files.
+
 --smtp-ssl::
 	If set, connects to the SMTP server using SSL.
 	Default is the value of the 'sendemail.smtpssl' configuration value;
diff --git a/git-send-email.perl b/git-send-email.perl
index a1a9d14..ed0a473 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -157,7 +157,7 @@ my $compose_filename = ".msg.$$";
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@initial_cc,@bcclist,@xh,
-	$initial_reply_to,$initial_subject,@files,$author,$sender,$compose,$time);
+	$initial_reply_to,$initial_subject,@files,$author,$sender,$smtp_authpass,$compose,$time);
 
 my $envelope_sender;
 
@@ -177,7 +177,7 @@ my ($quiet, $dry_run) = (0, 0);
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
-my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
+my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_ssl);
 my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
 my ($no_validate);
 
@@ -214,7 +214,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-server=s" => \$smtp_server,
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
-		    "smtp-pass=s" => \$smtp_authpass,
+		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl!" => \$smtp_ssl,
 		    "identity=s" => \$identity,
 		    "compose" => \$compose,
@@ -647,9 +647,24 @@ X-Mailer: git-send-email $gitversion
 			die "Unable to initialize SMTP properly.  Is there something wrong with your config?";
 		}
 
-		if ((defined $smtp_authuser) && (defined $smtp_authpass)) {
+		if (defined $smtp_authuser) {
+
+			if (!defined $smtp_authpass) {
+				
+				system "stty -echo";
+
+				do {
+					$_ = $term->readline("Password: ");
+				} while (!defined $_);
+
+				system "stty echo";
+
+				$smtp_authpass = $_ if ($_);
+			}
+
 			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
 		}
+
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
 		$smtp->data or die $smtp->message;
-- 
1.5.4.rc5.17.g536ee
