From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Fri,  5 Jul 2013 17:35:47 +0530
Message-ID: <1373025947-26495-3-git-send-email-artagnon@gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:09:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4pl-0002wx-2M
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab3GEMJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:09:47 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:40933 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab3GEMJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:09:45 -0400
Received: by mail-pa0-f53.google.com with SMTP id tj12so2175962pac.40
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=yRglUw6Cn1gQRCp9wkKRtZToak+jYO0eqvfQmTegTgo=;
        b=dw5/7h55Q8KqUjcVKKGjlVTahyPnXcvu9PUQikCsDjhP1D0tbuZPshMqptOmet0Cl3
         Gt7UPHRMjU/Ijc4WJ5v3UkesbHh5yBzmd/p6pzkFfzb7wd8HSghYP9sUzyvAyncb5CW1
         MdYgaTAfR2fjJz/bmZaZGom7F64juHvtfqtlJzXvnGivOQ2h6ZnjLz6fQc1ezejh9Zri
         TFCSMAeNVZoRXtmVuJY7HsU8tXXfmKxRtkkhqYPLnKeaMB6V3f+knIR26VLfYJ8vndN5
         Xcjxnim8CMkXyY/eLzWZ0v6IuqPpt67qK0KB/3oHNXDFFDURGZGdpZ4ZqjsbDSq2DX2i
         G/Fg==
X-Received: by 10.66.141.4 with SMTP id rk4mr11001140pab.127.1373026185286;
        Fri, 05 Jul 2013 05:09:45 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id b4sm7340980pbm.6.2013.07.05.05.09.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:09:44 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.723.gad7967b.dirty
In-Reply-To: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229659>

Use the ca-certificates in /etc/ssl/certs by default (that's where most
distributions put it).  SSL_VERIFY_NONE is now the fallback mode.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt         |  3 +++
 Documentation/git-send-email.txt |  4 ++++
 git-send-email.perl              | 22 ++++++++++++++++++----
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b4d4887..b216a63 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2048,6 +2048,9 @@ sendemail.smtpencryption::
 sendemail.smtpssl::
 	Deprecated alias for 'sendemail.smtpencryption = ssl'.
 
+sendemail.smtpsslcertpath::
+	Path to ca-certificates.  Defaults to `/etc/ssl/certs`.
+
 sendemail.<identity>.*::
 	Identity-specific versions of the 'sendemail.*' parameters
 	found below, taking precedence over those when the this
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 40a9a9a..605f263 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -198,6 +198,10 @@ must be used for each option.
 --smtp-ssl::
 	Legacy alias for '--smtp-encryption ssl'.
 
+--smtp-ssl-cert-path::
+	Path to ca-certificates.  Defaults to `/etc/ssl/certs`, or
+	'sendemail.smtpsslcertpath'.
+
 --smtp-user=<user>::
 	Username for SMTP-AUTH. Default is the value of 'sendemail.smtpuser';
 	if a username is not specified (with '--smtp-user' or 'sendemail.smtpuser'),
diff --git a/git-send-email.perl b/git-send-email.perl
index 758100d..026bcbc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -69,6 +69,8 @@ git send-email [options] <file | directory | rev-list options >
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --smtp-ssl-cert-path    <str>  * Path to ca-certificates.  Defaults to
+                                     /etc/ssl/certs.
     --smtp-domain           <str>  * The domain name sent to HELO/EHLO handshake
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
@@ -195,6 +197,7 @@ my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
+my ($smtp_ssl_cert_path);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -220,6 +223,7 @@ my %config_settings = (
     "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
+    "smtpsslcertpath" => \$smtp_ssl_cert_path,
     "smtpdomain" => \$smtp_domain,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
@@ -1193,13 +1197,23 @@ X-Mailer: git-send-email $gitversion
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
-				use IO::Socket::SSL qw(SSL_VERIFY_NONE);
+				use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
 				$smtp->command('STARTTLS');
 				$smtp->response();
 				if ($smtp->code == 220) {
-					$smtp = Net::SMTP::SSL->start_SSL($smtp,
-									  SSL_verify_mode => SSL_VERIFY_NONE)
-						or die "STARTTLS failed! ".$smtp->message;
+					# Attempt to use a ca-certificate by default
+					$smtp_ssl_cert_path |= "/etc/ssl/certs";
+					if (-d $smtp_ssl_cert_path) {
+						$smtp = Net::SMTP::SSL->start_SSL($smtp,
+										  SSL_verify_mode => SSL_VERIFY_PEER,
+										  SSL_ca_path => $smtp_ssl_cert_path)
+							or die "STARTTLS failed! ".$smtp->message;
+					} else {
+						print STDERR "warning: Using SSL_VERIFY_NONE.  See sendemail.smtpsslcertpath.\n";
+						$smtp = Net::SMTP::SSL->start_SSL($smtp,
+										  SSL_verify_mode => SSL_VERIFY_NONE)
+							or die "STARTTLS failed! ".$smtp->message;
+					}
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
 					# supported commands
-- 
1.8.3.2.723.gad7967b.dirty
