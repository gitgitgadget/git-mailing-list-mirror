From: silvio@port1024.net
Subject: [PATCH] git-send-email: Added the ability to query the number of smtp password questions
Date: Sat,  9 Nov 2013 11:21:48 +0100
Message-ID: <1383992508-2097-1-git-send-email-silvio@port1024.net>
Cc: Silvio F <silvio.fricke@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 09 11:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf5gX-0006hg-9P
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 11:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438Ab3KIKW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 05:22:29 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46019 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab3KIKWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 05:22:11 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3dGvXv3nmjz4KK6t;
	Sat,  9 Nov 2013 11:22:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3dGvXv3fPPzbbgH;
	Sat,  9 Nov 2013 11:22:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id HzfGXiNL7L5S; Sat,  9 Nov 2013 11:22:06 +0100 (CET)
Received: from port1024.net (ppp-188-174-65-208.dynamic.mnet-online.de [188.174.65.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPS;
	Sat,  9 Nov 2013 11:22:06 +0100 (CET)
Received: from [10.1.0.181] (helo=zwielicht.lan)
	by port1024.net with esmtp (Exim 4.82)
	(envelope-from <silvio@port1024.net>)
	id 1Vf5g5-0007wn-UF; Sat, 09 Nov 2013 11:22:05 +0100
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237572>

From: Silvio F <silvio.fricke@gmail.com>

Signed-off-by: Silvio F <silvio.fricke@gmail.com>
---
 Documentation/git-send-email.txt |  4 ++++
 git-send-email.perl              | 32 +++++++++++++++++++++-----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0e57a5..ac993d6 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -364,6 +364,10 @@ sendemail.confirm::
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
 	in the previous section for the meaning of these values.
 
+sendmail.askpasswordcount::
+	Number of times the smtp password can be entered before sending mail is
+	aborted. Default is 1.
+
 EXAMPLE
 -------
 Use gmail as the smtp server
diff --git a/git-send-email.perl b/git-send-email.perl
index 3782c3b..9b2eda3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -203,6 +203,7 @@ my ($validate, $confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
+my ($askpasswordcount) = 1;
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -237,6 +238,7 @@ my %config_settings = (
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
     "composeencoding" => \$compose_encoding,
+    "askpasswordcount" => \$askpasswordcount,
 );
 
 my %config_path_settings = (
@@ -360,6 +362,10 @@ sub read_config {
 		}
 	}
 
+	if ($askpasswordcount < 1) {
+		$askpasswordcount = 1
+	}
+
 	if (!defined $smtp_encryption) {
 		my $enc = Git::config(@repo, "$prefix.smtpencryption");
 		if (defined $enc) {
@@ -1069,17 +1075,21 @@ sub smtp_auth_maybe {
 	# TODO: Authentication may fail not because credentials were
 	# invalid but due to other reasons, in which we should not
 	# reject credentials.
-	$auth = Git::credential({
-		'protocol' => 'smtp',
-		'host' => smtp_host_string(),
-		'username' => $smtp_authuser,
-		# if there's no password, "git credential fill" will
-		# give us one, otherwise it'll just pass this one.
-		'password' => $smtp_authpass
-	}, sub {
-		my $cred = shift;
-		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
-	});
+	for my $i (1 .. $askpasswordcount) {
+		$auth = Git::credential({
+			'protocol' => 'smtp',
+			'host' => smtp_host_string(),
+			'username' => $smtp_authuser,
+			# if there's no password, "git credential fill" will
+			# give us one, otherwise it'll just pass this one.
+			'password' => $smtp_authpass
+		}, sub {
+			my $cred = shift;
+			return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+		});
+
+		last if ($auth);
+	}
 
 	return $auth;
 }
-- 
1.8.4.2
