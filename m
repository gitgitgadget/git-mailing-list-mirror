From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] send-email: squelch warning from Net::SMTP::SSL
Date: Fri,  5 Jul 2013 15:48:31 +0530
Message-ID: <1373019511-13232-1-git-send-email-artagnon@gmail.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 05 12:22:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uv39n-0001kQ-Nq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 12:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095Ab3GEKWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jul 2013 06:22:24 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:54054 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989Ab3GEKWX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jul 2013 06:22:23 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so2008669pbc.23
        for <git@vger.kernel.org>; Fri, 05 Jul 2013 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+j8vrI652cL+pgjHVBNLTdmSA/jaKuWRil1qY1eOPyc=;
        b=VDLxux5zjvGHo+CCtTqQKxnHWngyq0S31Vn1sxwXbvJUWpG0uWUL8dOywwxCwqnHGu
         lovrOQ3XMP9zTMG0Dm2XV9KEz/UhYyM2X8g9kR+0hr5R8gFe111aNnNPK+ThHLg1S4GV
         XvRf/p9z4e7nE+hVAmrunVTQ72PTa2rv/jpV3W1T8YyeSEWjkH4YiKCcxpdlYScS3dsh
         BvHdB1ywfykCWGKqj1pm10o7xr4ZGhFYxT2PuinqcFCzgt28qxY8vCaK4WLpfjj5YHGt
         UAKB5Dp2iDq/4wB7uNNdl1/SlmJOc99YTyafzxqZJii6ILRCkg8JA8ZqU0cu4eflcfUp
         vpVA==
X-Received: by 10.68.41.106 with SMTP id e10mr9274429pbl.136.1373019742677;
        Fri, 05 Jul 2013 03:22:22 -0700 (PDT)
Received: from localhost.localdomain ([122.174.59.189])
        by mx.google.com with ESMTPSA id xe9sm6900234pbc.21.2013.07.05.03.22.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 05 Jul 2013 03:22:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.722.g3244e19.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229647>

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
1.8.3.2.722.g3244e19.dirty
