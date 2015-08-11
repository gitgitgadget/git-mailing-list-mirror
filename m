From: Jan Viktorin <viktorin@rehivetech.com>
Subject: [PATCH v3] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Wed, 12 Aug 2015 01:39:44 +0200
Message-ID: <1439336384-1445-1-git-send-email-viktorin@rehivetech.com>
References: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
Cc: sandals@crustytoothpaste.net, sunshine@sunshineco.com,
	gitster@pobox.com, Jan Viktorin <viktorin@rehivetech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 01:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPJ9b-0001uy-DQ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 01:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932930AbbHKXkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 19:40:17 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:52067 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932738AbbHKXkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 19:40:15 -0400
Received: from ([109.81.211.201])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP (SSL) id ZLA00011;
        Wed, 12 Aug 2015 01:40:11 +0200
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438533769-17460-1-git-send-email-viktorin@rehivetech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275745>

When sending an e-mail, the client and server must agree on an
authentication mechanism. Some servers (due to misconfiguration
or a bug) deny valid credentials for certain mechanisms. In this
patch, a new option --smtp-auth and configuration entry smtpAuth
are introduced. If smtp_auth is defined, it works as a whitelist
of allowed mechanisms for authentication selected from the ones
supported by the installed SASL perl library.

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
---
 Documentation/git-send-email.txt | 11 +++++++++++
 git-send-email.perl              | 26 +++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f14705e..82c6ae8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -171,6 +171,17 @@ Sending
 	to determine your FQDN automatically.  Default is the value of
 	'sendemail.smtpDomain'.
 
+--smtp-auth=<mechs>::
+	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
+	forces using only the listed mechanisms. Example:
+
+	$ git send-email --smtp-auth="PLAIN LOGIN GSSAPI" ...
+
+	If at least one of the specified mechanisms matches the ones advertised by the
+	SMTP server and if it is supported by the utilized SASL library, the mechanism
+	is used for authentication. If neither 'sendemail.smtpAuth' nor '--smtp-auth'
+	is specified, all mechanisms supported by the SASL library can be used.
+
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
diff --git a/git-send-email.perl b/git-send-email.perl
index b660cc2..a7192c4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -75,6 +75,8 @@ git send-email [options] <file | directory | rev-list options >
                                      Pass an empty string to disable certificate
                                      verification.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
+    --smtp-auth             <str>  * Space-separated list of allowed AUTH methods.
+                                     This setting forces to use one of the listed methods.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
   Automating:
@@ -208,7 +210,7 @@ my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
-my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
+my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
@@ -239,6 +241,7 @@ my %config_settings = (
     "smtppass" => \$smtp_authpass,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
     "smtpdomain" => \$smtp_domain,
+    "smtpauth" => \$smtp_auth,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
@@ -310,6 +313,7 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
+		    "smtp-auth=s" => \$smtp_auth,
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
 		    "no-annotate" => sub {$annotate = 0},
@@ -1130,6 +1134,12 @@ sub smtp_auth_maybe {
 		Authen::SASL->import(qw(Perl));
 	};
 
+	# Check mechanism naming as defined in:
+	# https://tools.ietf.org/html/rfc4422#page-8
+	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
+		die "invalid smtp auth: '${smtp_auth}'";
+	}
+
 	# TODO: Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
@@ -1142,6 +1152,20 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
+
+		if ($smtp_auth) {
+			my $sasl = Authen::SASL->new(
+				mechanism => $smtp_auth,
+				callback => {
+					user => $cred->{'username'},
+					pass => $cred->{'password'},
+					authname => $cred->{'username'},
+				}
+			);
+
+			return !!$smtp->auth($sasl);
+		}
+
 		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
 	});
 
-- 
2.5.0
