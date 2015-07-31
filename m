From: Jan Viktorin <viktorin@rehivetech.com>
Subject: [PATCH v1] send-email: provide whitelist of SMTP AUTH mechanisms
Date: Sat,  1 Aug 2015 01:33:37 +0200
Message-ID: <1438385617-29159-1-git-send-email-viktorin@rehivetech.com>
Cc: Jan Viktorin <viktorin@rehivetech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 01 01:48:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLK2C-0000WN-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 01:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbbGaXsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 19:48:12 -0400
Received: from w-smtp-out-7.wedos.net ([46.28.106.5]:45522 "EHLO
	we2-f167.wedos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752596AbbGaXsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 19:48:11 -0400
X-Greylist: delayed 723 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jul 2015 19:48:11 EDT
Received: from ([147.229.13.147])
        by we2-f167.wedos.net (WEDOS Mail Server mail2) with ASMTP (SSL) id OLL00003;
        Sat, 01 Aug 2015 01:36:03 +0200
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275096>

When sending an e-mail, the client and server must
agree on an authentication mechanism. Some servers
(due to misconfiguration or a bug) denies valid
credentials for certain mechanisms. In this patch,
a new option --smtp-auth and configuration entry
smtpauth are introduced.

If smtp_auth is defined, it works as a whitelist
of allowed mechanisms for authentication. There
are four mechanisms supported: PLAIN, LOGIN,
CRAM-MD5, DIGEST-MD5. However, their availability
depends on the installed SASL library.

Signed-off-by: Jan Viktorin <viktorin@rehivetech.com>
---
 git-send-email.perl | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ae9f869..b00ed9d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -75,6 +75,9 @@ git send-email [options] <file | directory | rev-list options >
                                      Pass an empty string to disable certificate
                                      verification.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
+    --smtp-auth             <str>  * Space separated list of allowed AUTH methods.
+                                     This setting forces to use one of the listed methods.
+                                     Supported: PLAIN LOGIN CRAM-MD5 DIGEST-MD5.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
   Automating:
@@ -208,7 +211,7 @@ my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
-my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
+my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
@@ -239,6 +242,7 @@ my %config_settings = (
     "smtppass" => \$smtp_authpass,
     "smtpsslcertpath" => \$smtp_ssl_cert_path,
     "smtpdomain" => \$smtp_domain,
+    "smtpauth" => \$smtp_auth,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
@@ -310,6 +314,7 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
+		    "smtp-auth=s" => \$smtp_auth,
 		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
 		    "no-annotate" => sub {$annotate = 0},
@@ -1129,6 +1134,16 @@ sub smtp_auth_maybe {
 		return 1;
 	}
 
+	# Do not allow arbitrary strings.
+	my ($filtered_auth) = "";
+	foreach ("PLAIN", "LOGIN", "CRAM-MD5", "DIGEST-MD5") {
+		if($smtp_auth && $smtp_auth =~ /\b\Q$_\E\b/i) {
+			$filtered_auth .= $_ . " ";
+		}
+	}
+
+	die "Invalid SMTP AUTH." if length $smtp_auth && !length $filtered_auth;
+
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
 	eval {
@@ -1148,6 +1163,20 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
+
+		if($filtered_auth) {
+			my $sasl = Authen::SASL->new(
+				mechanism => $filtered_auth,
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
