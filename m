From: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Subject: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Wed, 15 Jan 2014 21:31:11 +0400
Message-ID: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com>
Cc: git@vger.kernel.org, Ruben Kerkhof <ruben@rubenkerkhof.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 15 18:31:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3UJR-0001sV-Ap
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 18:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbaAORb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 12:31:29 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:52679 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbaAORb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 12:31:28 -0500
Received: by mail-la0-f41.google.com with SMTP id mc6so1657823lab.14
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4NXFzUDxPc5E0UtBO07ZTB9irUjRTCt5qGoGVGfUUQg=;
        b=DXcjRoOvm/LaWDxyamYWE2CZrnMrEcAxXSePhKCzW2/QVLafR4gKKLwb+jspdrF3Lv
         qOEx3p//r7kclYA+tW1L7OQLHQ7IYm3uulx4EA2IET6puLoxLr4u37olkZ5dtbZmatcH
         sZ3jrNxe/qHD0Cico01mIbdTsb5AlKTsnHbCSOiO9TkwlTHBLFkbfvI2UD7C9+xPLrzi
         0aa3B98QWmmyVU9m5CSZiChaZpyGytHLibY97u7wqJrBeVL7E0rsExyBG0mhYczzGGyb
         xalj6aPeW8A6I19CqaKYgv1yIVodoqAi/51gM7gOKtSMKy6A5ufOsCbOUBhQx4s5P4hv
         wIxg==
X-Received: by 10.112.150.100 with SMTP id uh4mr2146294lbb.3.1389807086957;
        Wed, 15 Jan 2014 09:31:26 -0800 (PST)
Received: from localhost.localdomain ([176.192.189.198])
        by mx.google.com with ESMTPSA id bl6sm2822399lbb.5.2014.01.15.09.31.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2014 09:31:25 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240472>

From: Ruben Kerkhof <ruben@rubenkerkhof.com>

I use gmail for sending patches.
If I have the following defined in my ~/.gitconfig:
[sendemail]
	smtpencryption = tls
	smtpserver = smtp.gmail.com
	smtpuser = ruben@rubenkerkhof.com
	smtpserverport = 587

and try to send a patch, this fails with:
STARTTLS failed! SSL connect attempt failed with unknown error
error:14090086:SSL routines:SSL3_GET_SERVER_CERTIFICATE:certificate
verify failed at /usr/libexec/git-core/git-send-email line 1236.

Tested-by: Igor Gnatenko <i.gnatenko.brain@gmail.com>
Signed-off-by: Ruben Kerkhof <ruben@rubenkerkhof.com>
Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1043194
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3782c3b..689944f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1095,7 +1095,8 @@ sub ssl_verify_params {
 	}
 
 	if (!defined $smtp_ssl_cert_path) {
-		$smtp_ssl_cert_path = "/etc/ssl/certs";
+		# use the OpenSSL defaults
+		return (SSL_verify_mode => SSL_VERIFY_PEER());
 	}
 
 	if ($smtp_ssl_cert_path eq "") {
-- 
1.8.4.2
