From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 3/3] send-email: set SSL options through IO::Socket::SSL::set_client_defaults
Date: Sun,  1 Dec 2013 23:48:43 +0100
Message-ID: <c5308d5ffb34b70cbfea5a39e08902904fac1400.1385938050.git.tr@thomasrast.ch>
References: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 01 23:49:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnFp8-0004Zr-CG
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 23:49:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab3LAWtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 17:49:04 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:39517 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986Ab3LAWs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 17:48:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 1D61E4D64C4;
	Sun,  1 Dec 2013 23:48:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hSv1mu0sECmn; Sun,  1 Dec 2013 23:48:46 +0100 (CET)
Received: from linux.local (unknown [89.204.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 3C8F04D65A0;
	Sun,  1 Dec 2013 23:48:46 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.5.g2a1fe2f
In-Reply-To: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238601>

When --smtp-encryption=ssl, we use a Net::SMTP::SSL connection,
passing its ->new all the options that would otherwise go to
Net::SMTP->new (most options) and IO::Socket::SSL->start_SSL (for the
SSL options).

However, while Net::SMTP::SSL replaces the underlying socket class
with an SSL socket, it does nothing to allow passing options to that
socket.  So the SSL-relevant options are lost.

Fortunately there is an escape hatch: we can directly set the options
with IO::Socket::SSL::set_client_defaults.  They will then persist
within the IO::Socket::SSL module.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 git-send-email.perl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9f31c68..2016d9c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1214,11 +1214,14 @@ sub send_message {
 			$smtp_server_port ||= 465; # ssmtp
 			require Net::SMTP::SSL;
 			$smtp_domain ||= maildomain();
+			require IO::Socket::SSL;
+			# Net::SMTP::SSL->new() does not forward any SSL options
+			IO::Socket::SSL::set_client_defaults(
+				ssl_verify_params());
 			$smtp ||= Net::SMTP::SSL->new($smtp_server,
 						      Hello => $smtp_domain,
 						      Port => $smtp_server_port,
-						      Debug => $debug_net_smtp,
-						      ssl_verify_params());
+						      Debug => $debug_net_smtp);
 		}
 		else {
 			require Net::SMTP;
-- 
1.8.5.rc3.5.g2a1fe2f
