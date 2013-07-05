From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 1/2] send-email: squelch warning from Net::SMTP::SSL
Date: Fri,  5 Jul 2013 17:35:46 +0530
Message-ID: <1373025947-26495-2-git-send-email-artagnon@gmail.com>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 05 14:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv4pk-0002wx-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 14:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757283Ab3GEMJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 08:09:45 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:64618 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab3GEMJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 08:09:43 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1970609pdi.27
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vFjKUo9TBX7Vgz1MnUwfkRshlSB2hTfM8YUN+UUZYOU=;
        b=OSXj/UOnUuCLb1y1xqTrefctYBLavvXUdyruNUvvyPXAiEzjPW+L9fTf45Be7IPVZ7
         0onMErtEMqxnHlaZaofIZ/ECsragxA6fysDNMmrBtkDbBNwhIQMT5BQ7mOHgIaop3q0M
         dOfGwsozBVoy5+15++5aPn8Rd/4cb8Cxa1XmfIBP24vrGwCA6M8wpUjS5J2bB6xK96VL
         uw9hWP301gJR5b3gSsosyxmsTqfCX6xTQpBv6LBcfJ6F89+hlTQO1NpSQZHtU5FOM5gl
         YSasPJE9fh6sur120oOYgbdkvwld7COCPRDQZ6zrf05Net0Zy6+ueq9+sIlYSVD1LZJR
         Y9sg==
X-Received: by 10.68.218.100 with SMTP id pf4mr9578487pbc.72.1373026182860;
        Fri, 05 Jul 2013 05:09:42 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id b4sm7340980pbm.6.2013.07.05.05.09.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 05:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.723.gad7967b.dirty
In-Reply-To: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229658>

Due to a recent change in the Net::SMTP::SSL module, send-email emits
the following ugly warning everytime a email is sent via SSL:

*******************************************************************
 Using the default of SSL_verify_mode of SSL_VERIFY_NONE for client
 is deprecated! Please set SSL_verify_mode to SSL_VERIFY_PEER
 together with SSL_ca_file|SSL_ca_path for verification.
 If you really don't want to verify the certificate and keep the
 connection open to Man-In-The-Middle attacks please set
 SSL_verify_mode explicitly to SSL_VERIFY_NONE in your application.
*******************************************************************

Fix this by explicitly specifying SSL_verify_mode => SSL_VERIFY_NONE in
Net::SMTP::SSL->start_SSL().

Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ecbf56f..758100d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1193,10 +1193,12 @@ X-Mailer: git-send-email $gitversion
 						 Debug => $debug_net_smtp);
 			if ($smtp_encryption eq 'tls' && $smtp) {
 				require Net::SMTP::SSL;
+				use IO::Socket::SSL qw(SSL_VERIFY_NONE);
 				$smtp->command('STARTTLS');
 				$smtp->response();
 				if ($smtp->code == 220) {
-					$smtp = Net::SMTP::SSL->start_SSL($smtp)
+					$smtp = Net::SMTP::SSL->start_SSL($smtp,
+									  SSL_verify_mode => SSL_VERIFY_NONE)
 						or die "STARTTLS failed! ".$smtp->message;
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
-- 
1.8.3.2.723.gad7967b.dirty
