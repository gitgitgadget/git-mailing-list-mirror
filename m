From: Michal Nazarewicz <mpn@google.com>
Subject: [PATCHv3 5/5] git-send-email: use git credential to obtain password
Date: Mon, 11 Feb 2013 17:23:39 +0100
Message-ID: <fd7997960cad569d57f5330f2416f702db414169.1360599712.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
Cc: git@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wBK-0002EW-Dw
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757915Ab3BKQYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:24:12 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:51407 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757919Ab3BKQYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:24:06 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so3457829eek.9
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 08:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=Qe5TrP60MeIJzp0GN6mLevZeGmd1pXkyYR/xiBH1iDg=;
        b=cv2w6z9D1QgLRGS6a6t9lQ/sVgiehG+94r8nKSGy4VMJFna5E6jx5U+4PQ7aFZ47oj
         xQN++QV7q1Zzqjrm77fR6Te+LQ7oKUwmdCHNeWrMTjsKUS1Ba7U6qmsWPpKGCl8yluAg
         4e/WWhHO8DzP3iJXWH9ihZu+2hui38PsbBrQpmD5/j66OAgE8Ee/lO9VihBQ3iqBX0SY
         iSdEwH2BhDAujP1a7dhazXivWPU9cooWQNkkb9v31Lh0dqO6vTUzw+Y4OWtfXwIUFY7b
         C0IWdQ9/Qroynim+ZjaApIbOg6Pd9ihvCDqvxnN3Fi8FokQiDkKk9R0pJq1j/QTu7Qlc
         t6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references:x-gm-message-state;
        bh=Qe5TrP60MeIJzp0GN6mLevZeGmd1pXkyYR/xiBH1iDg=;
        b=kJaxEXmGWqqTdnZ+U7Ji2IsYOMT395q+GOBI+JKfkFdZQSqkZ3qrHd4IpeTVbfDUDZ
         TlRcdnLGa0QxtmGZqTUNgLM5/Ec4fr7eurzgsG+ZMTH6Y2BUdL1Zok8OhoJJgfzovInb
         wzvzPDzMyHnc/nRi5Ds8fvLIeI3T2cn/Vu5D/UN9EepPBSOeZuFg8QlkqItUaTleDgLM
         y/lzFUDQmveQRSUE5hrJSmFBFQf/1D3sQGUTD/VK7XVSkkVHr7qn7GcMXB+B5oVPIAyT
         Vsg595jp9uYoeH1CiXOlGD4jQd0yxkUqd9AxdaRrljhAiWK0XC4szReDRyQkRJRG8zOM
         hTjQ==
X-Received: by 10.14.194.8 with SMTP id l8mr51800718een.31.1360599844604;
        Mon, 11 Feb 2013 08:24:04 -0800 (PST)
Received: from mpn-glaptop.corp.google.com ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id 3sm63347527eej.6.2013.02.11.08.24.02
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 08:24:03 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.571.g3f8bed7.dirty
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
In-Reply-To: <cover.1360599057.git.mina86@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com>
X-Gm-Message-State: ALoCoQlF4UwWDuoEo/9RfQnSSiD8x1hdhjrKfkUVhWXqb9/KChptRCr9+B2dxee/iZh1knSv+KYl8yx3dkBo1r/ESYCHQ1Jmkr4JAA4GQkGLD7Y0+V7F7cOWF/9o/Tu5Bj9uKwT/19zECgQcwjwtZ5C14cZMS9ML04l1A0DWEtoXWXHnJRKUsQgnUd6FpeeUPdFzlb7EpCpU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216044>

From: Michal Nazarewicz <mina86@mina86.com>

If smtp_user is provided but smtp_pass is not, instead of
prompting for password, make git-send-email use git
credential command instead.

Signed-off-by: Michal Nazarewicz <mina86@mina86.com>
---
 Documentation/git-send-email.txt |  4 +--
 git-send-email.perl              | 59 +++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 44a1f7c..0cffef8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -164,8 +164,8 @@ Sending
 Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
 '--smtp-user' or a 'sendemail.smtpuser'), but no password has been
-specified (with '--smtp-pass' or 'sendemail.smtppass'), then the
-user is prompted for a password while the input is masked for privacy.
+specified (with '--smtp-pass' or 'sendemail.smtppass'), then
+a password is obtained using 'git-credential'.
 
 --smtp-server=<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..76bbfc3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1045,6 +1045,39 @@ sub maildomain {
 	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
 }
 
+# Returns 1 if authentication succeeded or was not necessary
+# (smtp_user was not specified), and 0 otherwise.
+
+sub smtp_auth_maybe {
+	if (!defined $smtp_authuser || $auth) {
+		return 1;
+	}
+
+	# Workaround AUTH PLAIN/LOGIN interaction defect
+	# with Authen::SASL::Cyrus
+	eval {
+		require Authen::SASL;
+		Authen::SASL->import(qw(Perl));
+	};
+
+	# TODO: Authentication may fail not because credentials were
+	# invalid but due to other reasons, in which we should not
+	# reject credentials.
+	$auth = Git::credential({
+		'protocol' => 'smtp',
+		'host' => join(':', $smtp_server, $smtp_server_port),
+		'username' => $smtp_authuser,
+		# if there's no password, "git credential fill" will
+		# give us one, otherwise it'll just pass this one.
+		'password' => $smtp_authpass
+	}, sub {
+		my $cred = shift;
+		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
+	});
+
+	return $auth;
+}
+
 # Returns 1 if the message was sent, and 0 otherwise.
 # In actuality, the whole program dies when there
 # is an error sending a message.
@@ -1185,31 +1218,7 @@ X-Mailer: git-send-email $gitversion
 			    defined $smtp_server_port ? " port=$smtp_server_port" : "";
 		}
 
-		if (defined $smtp_authuser) {
-			# Workaround AUTH PLAIN/LOGIN interaction defect
-			# with Authen::SASL::Cyrus
-			eval {
-				require Authen::SASL;
-				Authen::SASL->import(qw(Perl));
-			};
-
-			if (!defined $smtp_authpass) {
-
-				system "stty -echo";
-
-				do {
-					print "Password: ";
-					$_ = <STDIN>;
-					print "\n";
-				} while (!defined $_);
-
-				chomp($smtp_authpass = $_);
-
-				system "stty echo";
-			}
-
-			$auth ||= $smtp->auth( $smtp_authuser, $smtp_authpass ) or die $smtp->message;
-		}
+		smtp_auth_maybe or die $smtp->message;
 
 		$smtp->mail( $raw_from ) or die $smtp->message;
 		$smtp->to( @recipients ) or die $smtp->message;
-- 
1.8.1.3.571.g3f8bed7.dirty
