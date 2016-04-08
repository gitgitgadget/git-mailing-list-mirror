From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 3/4] imap-send: avoid deprecated TLSv1_method()
Date: Sat,  9 Apr 2016 01:22:15 +0900
Message-ID: <ecc1d4f5988f6420639f4b7500a9d3782d7c1199.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 18:22:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZBB-0000dJ-KB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755802AbcDHQWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:22:34 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:42470 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbcDHQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id BF8ED61CA5;
	Fri,  8 Apr 2016 16:22:30 +0000 (UTC)
X-Mailer: git-send-email 2.8.1.104.g0d1aca6
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291041>

Use SSLv23_method always and disable SSL if needed.

TLSv1_method() function is deprecated in OpenSSL 1.1.0 and the compiler
emits a warning.

SSLv23_method() is also deprecated, but the alternative, TLS_method(),
is new in OpenSSL 1.1.0 so requires checking by configure. Stick to
SSLv23_method() for now (this is aliased to TLS_method()).

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
 imap-send.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index c5e24a35491d..f53380562c4d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -287,11 +287,7 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 	SSL_library_init();
 	SSL_load_error_strings();
 
-	if (use_tls_only)
-		meth = TLSv1_method();
-	else
-		meth = SSLv23_method();
-
+	meth = SSLv23_method();
 	if (!meth) {
 		ssl_socket_perror("SSLv23_method");
 		return -1;
@@ -303,6 +299,9 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 		return -1;
 	}
 
+	if (use_tls_only)
+		SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
+
 	if (verify)
 		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
 
-- 
2.8.1.104.g0d1aca6
