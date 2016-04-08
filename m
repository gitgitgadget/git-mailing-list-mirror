From: Kazuki Yamaguchi <k@rhe.jp>
Subject: [PATCH 1/4] imap-send: use HMAC() function provided by OpenSSL
Date: Sat,  9 Apr 2016 01:22:13 +0900
Message-ID: <80c694e8e35b81a082a7e800b5330fffb25e8ff9.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Cc: Kazuki Yamaguchi <k@rhe.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 18:22:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoZBC-0000dJ-6q
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758480AbcDHQWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 12:22:37 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:42464 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbcDHQWd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 12:22:33 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 640F761CA0;
	Fri,  8 Apr 2016 16:22:30 +0000 (UTC)
X-Mailer: git-send-email 2.8.1.104.g0d1aca6
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
In-Reply-To: <cover.1460130092.git.k@rhe.jp>
References: <cover.1460130092.git.k@rhe.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291039>

Fix compile errors with OpenSSL 1.1.0.

HMAC_CTX is made opaque and HMAC_CTX_cleanup is removed in OpenSSL
1.1.0. But since we just want to calculate one HMAC, we can use HMAC()
here, which exists since OpenSSL 0.9.6 at least.

Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
---
Since I don't have OS X machines, changes in
compat/apple-common-crypto.h is untested, just confirmed it compiles on
Travis CI.

 compat/apple-common-crypto.h | 16 +++++++++++-----
 imap-send.c                  |  7 ++-----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
index d3fb26418134..11727f3e1ed7 100644
--- a/compat/apple-common-crypto.h
+++ b/compat/apple-common-crypto.h
@@ -3,12 +3,18 @@
 #define HEADER_HMAC_H
 #define HEADER_SHA_H
 #include <CommonCrypto/CommonHMAC.h>
-#define HMAC_CTX CCHmacContext
-#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
-#define HMAC_Update CCHmacUpdate
-#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
-#define HMAC_CTX_cleanup(ignore)
 #define EVP_md5(...) kCCHmacAlgMD5
+/* CCHmac doesn't take md_len and the return type is void */
+#define HMAC git_CC_HMAC
+static inline unsigned char *git_CC_HMAC(CCHmacAlgorithm alg,
+		const void *key, int key_len,
+		const unsigned char *data, size_t data_len,
+		unsigned char *md, unsigned int *md_len)
+{
+	CCHmac(alg, key, key_len, data, data_len, md);
+	return md;
+}
+
 #if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
 #define APPLE_LION_OR_NEWER
 #include <Security/Security.h>
diff --git a/imap-send.c b/imap-send.c
index 2c52027c8445..0364b326e109 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -862,7 +862,6 @@ static char hexchar(unsigned int b)
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
-	HMAC_CTX hmac;
 	unsigned char hash[16];
 	char hex[33];
 	char *response, *response_64, *challenge;
@@ -877,10 +876,8 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
 		die("invalid challenge %s", challenge_64);
-	HMAC_Init(&hmac, (unsigned char *)pass, strlen(pass), EVP_md5());
-	HMAC_Update(&hmac, (unsigned char *)challenge, decoded_len);
-	HMAC_Final(&hmac, hash, NULL);
-	HMAC_CTX_cleanup(&hmac);
+	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, decoded_len, hash, NULL))
+		die("HMAC error");
 
 	hex[32] = 0;
 	for (i = 0; i < 16; i++) {
-- 
2.8.1.104.g0d1aca6
