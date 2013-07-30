From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] imap-send: use Apple's Security framework for base64 encoding
Date: Mon, 29 Jul 2013 18:28:30 -0700
Message-ID: <1375147710-71226-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 03:28:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3yju-00061C-UT
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 03:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab3G3B2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 21:28:34 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59800 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624Ab3G3B2d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 21:28:33 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so5365417pbb.14
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=VamoNAD71KSWyjHOUeZsWrE/h74tHlenRglKfSoWAWA=;
        b=DvHnKUfUD2pmqKbhbUsWjDdu/XRcR/y22lQUbIEGgrmq19l5Rgs0NE6aM1bSCu2Kcf
         +jtKpMn2/FCHORf72xS+g/mfPZppvuh7/V1d/e7QPG3vkf7+6go1HNejvxXAXprvA2/5
         tk3YJzANJs66za+Jy3GjPSaiocWz1XwuORzBBf1LVyzlx2ntjN+Sd1CKbw+Zn9T4E9PP
         i4WGtyd5CCqO9FNvRomOT1A7nAHGrNFcJTbJZB4GJdI0a41V/h3d3bM92oQA+uX8lqEW
         zQf53TGtUkSeG2g6/Q9ctAODRrKDLwF2/jJfAuOHR3dddMlgAhW9xvDsDg3h8qsXX2/D
         0fzA==
X-Received: by 10.66.154.162 with SMTP id vp2mr46620484pab.34.1375147713199;
        Mon, 29 Jul 2013 18:28:33 -0700 (PDT)
Received: from lustrous.local.fas.fa.disney.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id is3sm73448296pbc.25.2013.07.29.18.28.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 18:28:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.2.g416d4cd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231340>

From: Jeremy Huddleston <jeremyhu@apple.com>

Use Apple's supported functions for base64 encoding instead
of the deprecated OpenSSL functions.

Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This version moves the tricky #ifdefs into git-compat-util.h

 Makefile          |  1 +
 git-compat-util.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 imap-send.c       | 14 --------
 3 files changed, 96 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index ef442eb..2b1e936 100644
--- a/Makefile
+++ b/Makefile
@@ -1414,6 +1414,7 @@ ifdef PPC_SHA1
 	LIB_H += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
+	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
 else
diff --git a/git-compat-util.h b/git-compat-util.h
index cc4ba4d..1ba89f8 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -129,6 +129,32 @@
 #include <poll.h>
 #endif
 
+#ifndef NO_OPENSSL
+#ifdef APPLE_COMMON_CRYPTO
+/* suppress inclusion of conflicting openssl functions */
+#define OPENSSL_NO_MD5
+#define HEADER_HMAC_H
+#define HEADER_SHA_H
+#include <CommonCrypto/CommonHMAC.h>
+#define HMAC_CTX CCHmacContext
+#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
+#define HMAC_Update CCHmacUpdate
+#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
+#define HMAC_CTX_cleanup(ignore)
+#define EVP_md5(...) kCCHmacAlgMD5
+#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
+#define APPLE_LION_OR_NEWER
+#include <Security/Security.h>
+/* Apple's TYPE_BOOL conflicts with config.c */
+#undef TYPE_BOOL
+#endif
+#else
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
+#endif /* APPLE_COMMON_CRYPTO */
+#include <openssl/x509v3.h>
+#endif /* NO_OPENSSL */
+
 extern int get_st_mode_bits(const char *path, int *mode);
 
 #if defined(__MINGW32__)
@@ -717,4 +743,73 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
+#ifdef APPLE_LION_OR_NEWER
+#define git_CC_error_check(pattern, err) \
+	do { \
+		if (err) { \
+			die(pattern, (long)CFErrorGetCode(err)); \
+		} \
+	} while(0)
+
+#define EVP_EncodeBlock git_CC_EVP_EncodeBlock
+static inline int git_CC_EVP_EncodeBlock(unsigned char *out,
+		const unsigned char *in, int inlen)
+{
+	CFErrorRef err;
+	SecTransformRef encoder;
+	CFDataRef input, output;
+	CFIndex length;
+
+	encoder = SecEncodeTransformCreate(kSecBase64Encoding, &err);
+	git_CC_error_check("SecEncodeTransformCreate failed: %ld", err);
+
+	input = CFDataCreate(kCFAllocatorDefault, in, inlen);
+	SecTransformSetAttribute(encoder, kSecTransformInputAttributeName,
+			input, &err);
+	git_CC_error_check("SecTransformSetAttribute failed: %ld", err);
+
+	output = SecTransformExecute(encoder, &err);
+	git_CC_error_check("SecTransformExecute failed: %ld", err);
+
+	length = CFDataGetLength(output);
+	CFDataGetBytes(output, CFRangeMake(0, length), out);
+
+	CFRelease(output);
+	CFRelease(input);
+	CFRelease(encoder);
+
+	return (int)strlen((const char *)out);
+}
+
+#define EVP_DecodeBlock git_CC_EVP_DecodeBlock
+static int inline git_CC_EVP_DecodeBlock(unsigned char *out,
+		const unsigned char *in, int inlen)
+{
+	CFErrorRef err;
+	SecTransformRef decoder;
+	CFDataRef input, output;
+	CFIndex length;
+
+	decoder = SecDecodeTransformCreate(kSecBase64Encoding, &err);
+	git_CC_error_check("SecEncodeTransformCreate failed: %ld", err);
+
+	input = CFDataCreate(kCFAllocatorDefault, in, inlen);
+	SecTransformSetAttribute(decoder, kSecTransformInputAttributeName,
+			input, &err);
+	git_CC_error_check("SecTransformSetAttribute failed: %ld", err);
+
+	output = SecTransformExecute(decoder, &err);
+	git_CC_error_check("SecTransformExecute failed: %ld", err);
+
+	length = CFDataGetLength(output);
+	CFDataGetBytes(output, CFRangeMake(0, length), out);
+
+	CFRelease(output);
+	CFRelease(input);
+	CFRelease(decoder);
+
+	return (int)strlen((const char *)out);
+}
+#endif /* APPLE_LION_OR_NEWER */
+
 #endif
diff --git a/imap-send.c b/imap-send.c
index d6b65e2..6f5cc4f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -28,20 +28,6 @@
 #include "prompt.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
-#else
-#ifdef APPLE_COMMON_CRYPTO
-#include <CommonCrypto/CommonHMAC.h>
-#define HMAC_CTX CCHmacContext
-#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
-#define HMAC_Update CCHmacUpdate
-#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
-#define HMAC_CTX_cleanup(ignore)
-#define EVP_md5() kCCHmacAlgMD5
-#else
-#include <openssl/evp.h>
-#include <openssl/hmac.h>
-#endif
-#include <openssl/x509v3.h>
 #endif
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
-- 
1.8.4.rc0.2.g416d4cd
