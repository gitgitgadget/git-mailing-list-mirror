From: Roberto Sassu <roberto.sassu@polito.it>
Subject: [RFC][PATCH] git-send-email: added support for S/MIME
Date: Tue,  4 Jan 2011 17:02:06 +0100
Message-ID: <1294156930-21367-1-git-send-email-roberto.sassu@polito.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha1"; boundary="----835CA9063457F7FAB643CBD6DD103557"
Cc: Roberto Sassu <roberto.sassu@polito.it>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 17:02:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa9LB-0001Ka-Am
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 17:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab1ADQCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 11:02:20 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49266 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751324Ab1ADQCS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 11:02:18 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5C70220B04;
	Tue,  4 Jan 2011 11:02:18 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 04 Jan 2011 11:02:18 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:mime-version:content-type; s=smtpout; bh=yi6gl2lqRqZOFv2PofIDep4Rj1Y=; b=EXLmFASnBCPETXkcgY33SsqlWA+D9JWJCnh6mgLcDtw6JsXqQEVFoNndDXhG0/UmW8oUuav4ChhPxocvEEbN5aZ62jWrLImLHv2mIG/R38QK8mQsPjG7/XS9TWcVNR4vPn7tQVXmRfFqfcuB6wIVoDsLSTbYmzIMnSEKrj1c5rc=
X-Sasl-enc: LQDrozHAVy7jPdP/1+0WYrkd5o4e5NCjZ45d7ZIjgxiQ 1294156937
Received: from localhost.localdomain (93-38-128-151.ip70.fastwebnet.it [93.38.128.151])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B96444016DD;
	Tue,  4 Jan 2011 11:02:17 -0500 (EST)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164499>

This is an S/MIME signed message

------835CA9063457F7FAB643CBD6DD103557

The script git-send-email.perl has been modified in order to add support
for messages with S/MIME format.  First, the message body is written in a
temporary file and signed by OpenSSL with the X.509 certificate provided by
the user.  Then the returned content is added to the previously parsed
header and the message is sent as the same for unsigned messages.

Usage:
    git send-email -sign -signing-cert </path/of/PEM> <other options>

Signed-off-by: Roberto Sassu <roberto.sassu@polito.it>
---
 git-send-email.perl |   97 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 87 insertions(+), 10 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 76565de..c040fe6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -57,6 +57,8 @@ git send-email [options] <file | directory | rev-list options >
     --annotate                     * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
+    --sign                         * Sign all emails with an X.509 certificate.
+    --signing-cert          <str>  * Path of the X.509 certificate.
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -141,7 +143,7 @@ my $auth;
 
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
-	$initial_reply_to,$initial_subject,@files,
+	@xb,$initial_reply_to,$initial_subject,@files,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 
 my $envelope_sender;
@@ -161,9 +163,10 @@ if ($@) {
 }
 
 # Behavior modification variables
-my ($quiet, $dry_run) = (0, 0);
+my ($quiet, $dry_run, $sign) = (0, 0, 0);
 my $format_patch;
 my $compose_filename;
+my $signing_cert;
 my $force = 0;
 
 # Handle interactive edition of files.
@@ -232,6 +235,7 @@ my %config_settings = (
     "confirm"   => \$confirm,
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
+    "signing_cert" => \$signing_cert
 );
 
 # Help users prepare for 1.7.0
@@ -311,6 +315,8 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "format-patch!" => \$format_patch,
 		    "8bit-encoding=s" => \$auto_8bit_encoding,
 		    "force" => \$force,
+		    "sign" => \$sign,
+		    "signing-cert:s" => \$signing_cert,
 	 );
 
 unless ($rc) {
@@ -356,6 +362,11 @@ sub read_config {
 	}
 }
 
+# verify if the signing certificate has been specified
+if ($sign && !$signing_cert) {
+	die "Signing certificate not specified";
+}
+
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
 $identity = Git::config(@repo, "sendemail.identity") unless (defined $identity);
 read_config("sendemail.$identity") if (defined $identity);
@@ -1161,6 +1172,7 @@ foreach my $t (@files) {
 	@to = ();
 	@cc = ();
 	@xh = ();
+	@xb = ();
 	my $input_format = undef;
 	my @header = ();
 	$message = "";
@@ -1223,7 +1235,20 @@ foreach my $t (@files) {
 				if (/charset="?([^ "]+)/) {
 					$body_encoding = $1;
 				}
-				push @xh, $_;
+				if ($sign) {
+					push @xb, $_;
+				} else {
+					push @xh, $_;
+				}
+			}
+			elsif (/^MIME-Version:/i && $sign) {
+				# Do nothing: this will be added by OpenSSL
+			}
+			elsif (/Content-Transfer-Encoding:/i && $sign) {
+				# move the Content-Transfer-Encoding in the
+				# first part of the message if the latter is
+				# about to be signed
+				push @xb, $_;
 			}
 			elsif (/^Message-Id: (.*)/i) {
 				$message_id = $1;
@@ -1275,9 +1300,14 @@ foreach my $t (@files) {
 
 	if ($broken_encoding{$t} && !$has_content_type) {
 		$has_content_type = 1;
-		push @xh, "MIME-Version: 1.0",
-			"Content-Type: text/plain; charset=$auto_8bit_encoding",
-			"Content-Transfer-Encoding: 8bit";
+		if ($sign) {
+			push @xb, "Content-Type: text/plain; charset=$auto_8bit_encoding",
+				  "Content-Transfer-Encoding: 8bit";
+		} else {
+			push @xh, "MIME-Version: 1.0",
+				"Content-Type: text/plain; charset=$auto_8bit_encoding",
+				"Content-Transfer-Encoding: 8bit";
+		}
 		$body_encoding = $auto_8bit_encoding;
 	}
 
@@ -1298,12 +1328,59 @@ foreach my $t (@files) {
 			}
 			else {
 				$has_content_type = 1;
-				push @xh,
-				  'MIME-Version: 1.0',
-				  "Content-Type: text/plain; charset=$author_encoding",
-				  'Content-Transfer-Encoding: 8bit';
+				if ($sign) {
+					push @xb,
+					  "Content-Type: text/plain; charset=$author_encoding",
+					  'Content-Transfer-Encoding: 8bit';
+				} else {
+					push @xh,
+					  'MIME-Version: 1.0',
+					  "Content-Type: text/plain; charset=$author_encoding",
+					  'Content-Transfer-Encoding: 8bit';
+				}
+			}
+		}
+	}
+
+	if ($sign) {
+ 		my $linecount = 0;
+		my $message_body_tmp_file;
+
+		# put the original Content-Type, charset and Content-Transfer-Encoding
+		# information, if specified, in the first part of the message
+		if (@xb) {
+			$message = join("\n", @xb) . "\n\n" . $message;
+		} else {
+			$message = "\n" . $message;
+		}
+
+		# write the message body in a temporary file
+		$message_body_tmp_file = ($repo ?
+			tempfile(".gitsendemail.body.XXXXXX", DIR => $repo->repo_path()) :
+			tempfile(".gitsendemail.body.XXXXXX", DIR => "."))[1];
+
+		open(MESSAGE_BODY_FILE,">",$message_body_tmp_file) or
+			die "Failed to open for writing $message_body_tmp_file: $!";
+		print MESSAGE_BODY_FILE $message;
+		close MESSAGE_BODY_FILE;
+
+		# sign the message body and put the result in the $message variable
+		$message = "";
+		open(OPENSSL_SIGNED_MESSAGE, "openssl smime -sign -in $message_body_tmp_file -signer $signing_cert |")
+			or die "Could not execute OpenSSL";
+
+		while(<OPENSSL_SIGNED_MESSAGE>) {
+			chomp;
+			if($linecount < 2) {
+				# push first two lines into the header
+				push @xh, $_;
+			} else {
+				# put the remaining content in the $message variable
+				$message .= $_;
 			}
 		}
+		close OPENSSL_SIGNED_MESSAGE;
+ 		unlink($message_body_tmp_file);
 	}
 
 	$needs_confirm = (
-- 
1.7.3.4


------835CA9063457F7FAB643CBD6DD103557
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIICQYJKoZIhvcNAQcCoIIH+jCCB/YCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3
DQEHAaCCBWQwggVgMIIESKADAgECAgICuzANBgkqhkiG9w0BAQUFADBlMQswCQYD
VQQGEwJJVDEeMBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMTYwNAYDVQQD
Ey1Qb2xpdGVjbmljbyBkaSBUb3Jpbm8gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkw
HhcNMTAxMjIwMTExOTU0WhcNMTUxMjMxMjM1OTU5WjBfMQswCQYDVQQGEwJJVDEe
MBwGA1UEChMVUG9saXRlY25pY28gZGkgVG9yaW5vMRcwFQYDVQQDEw5Sb2JlcnRv
ICBTYXNzdTEXMBUGCgmSJomT8ixkAQETB2QwMjEzMDUwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDS6p4SaJdmmJHJu9On9ZohhBFE2GgYiY7YtRnhhQJA
NfOtHEhSbpUMaSOfq/Pna6ipR5nAFrlM8cOGcSHZdxrPcgzeJU7F2v1fl2ThvFOc
TIkcC1aAJGQUuCaCXDlQt+KFecJWTrRZnalMHZueO+J6cgHcvR1CQz5e88dSzo3Q
XZy0w/hxGL9Ht9velqsl48ohBk2rs/svAOCp6GfqT1Yxwx1p87d3ViTrmuZB4/X+
da39nJqmo6AZ/y3Zg+r91BgNcfsHVqFT0JTcG6qRIaeqTtqVYpYl+rH1rZzYCakD
yQyys66sBvaXyaiMr0M+SpyH+LaGz5bDn5Odq16FYEq7AgMBAAGjggIeMIICGjAO
BgNVHQ8BAf8EBAMCA/gwJwYDVR0lBCAwHgYIKwYBBQUHAwIGCCsGAQUFBwMDBggr
BgEFBQcDBDAiBgNVHREEGzAZgRdyb2JlcnRvLnNhc3N1QHBvbGl0by5pdDAMBgNV
HRMBAf8EAjAAMB0GA1UdDgQWBBQgKbXSXn+j769x0tsZQ9pSOzIIdDAfBgNVHSME
GDAWgBTNm1tbnup2IcQQaOjSLTfbHy/I5DCBywYDVR0gBIHDMIHAMD4GCisGAQQB
qQcBAQIwMDAuBggrBgEFBQcCARYiaHR0cDovL3d3dy5ldXJvcGtpLm9yZy9jYS9j
cHMvMS4yLzBEBgorBgEEAakHAgECMDYwNAYIKwYBBQUHAgEWKGh0dHA6Ly93d3cu
aXRhbHkuZXVyb3BraS5vcmcvY2EvY3BzLzEuMi8wOAYKKwYBBAGVYgECAjAqMCgG
CCsGAQUFBwIBFhxodHRwOi8vY2EucG9saXRvLml0L2Nwcy8yLjIvMGYGCCsGAQUF
BwEBBFowWDAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AucG9saXRvLml0MDMGCCsG
AQUFBzAChidodHRwOi8vY2EucG9saXRvLml0L2NlcnRzL3BvbGl0b19jYS5jZXIw
NwYDVR0fBDAwLjAsoCqgKIYmaHR0cDovL2NhLnBvbGl0by5pdC9jcmwvcG9saXRv
X2NybC5jcmwwDQYJKoZIhvcNAQEFBQADggEBADMe0aHcBJXV6pMJPVVSt1Vazd8Y
LuTLO45Igs9Sb2LuaO6pvcDGvq9dEJnBhP1B+zBAK6WEA1PWb66xC4QXaJnlGZTX
S3XeBivHWm6BNOH2kNeU0HBeGZCV/n5r70TPxkEAcc7u8YY2i6CiMM428YhZK8Zj
oN9D3QNIRf4HZgh0FTbf8eL/XvBbK/oPC+Rew+Qql6M3DHnaS1q2SKUwwO/4VXA4
JsOdatFI68AMXH0Xx9UIcjRi+kvsyvwHlc0Z8AoAtfRMoIl4zFF4Qaowec2UunBK
YlqPpFTtU9czuoEP12A86nqSVsoNok2mZOeYa9IdIjeE2rfdKx6k3YNRg08xggJt
MIICaQIBATBrMGUxCzAJBgNVBAYTAklUMR4wHAYDVQQKExVQb2xpdGVjbmljbyBk
aSBUb3Jpbm8xNjA0BgNVBAMTLVBvbGl0ZWNuaWNvIGRpIFRvcmlubyBDZXJ0aWZp
Y2F0aW9uIEF1dGhvcml0eQICArswCQYFKw4DAhoFAKCB2DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMTAxMDQxNjAyMTBaMCMGCSqG
SIb3DQEJBDEWBBTAENQmNJBbyyv/Nvlh0k50CxKC9zB5BgkqhkiG9w0BCQ8xbDBq
MAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3
DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggq
hkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAQChry527zLkEvM9Pc9TXH2R7sDc
OF4iamWxY1SoNu4l7We2gTUbXviAgdKJ8Qov+8NHHqTj8B52h4FyWmgHkUKeHVXu
7qGKbGXgtchx4H4Enxemrq5Yga+L2MDEuQBy2t3htIQBVyOlZvdAVYGrovOdbnmZ
BOiTQL/fRv8peSnN5Bt8142F3Dc2U8sr1hN+e7+WCkG6vLeKlr9TK0Hm8ziv8RRY
vBSE22echhAeioIzADmBZGXzpwfFfLH/1bQONhOaaMERlT8+xcI5ByWeBJPk/1CO
zdlOQZ9d37ZsoDxUUqNJAAlWRqVL/OakjELhdRWpBP+z/lV9iqmw6iyMcatH

------835CA9063457F7FAB643CBD6DD103557--
