From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] imap-send: use Apple's Security framework for base64 encoding
Date: Sat, 27 Jul 2013 13:31:32 -0700
Message-ID: <1374957092-41505-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 27 22:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3B95-00008F-SS
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 22:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218Ab3G0UbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 16:31:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35687 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3G0UbO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 16:31:14 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so4060982pdi.2
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=7vaSR7UgZ+b+/mCdf0dU0Qaqs0nIpf9SMegbfZTXYOU=;
        b=h3lzOqmobpTGFKkvoHQCNLMwpdCJVr33B5D6DxnyiQZcT6MYTxUQz5jXPGQlzwfoFM
         hM7TgUAEQCkf7zUg4MK1tqycdCGMTdfzVZSDdAaxw3LQlLze26V3cW/nZMwRHcc5mwKO
         yZbzH4IN4xNLYt8TeykrkZ0L+y/fmPx76ajrxcOXFgVEVu93u7rmLPAXUeKhINH9dbuP
         M+lbkEY3QY+Y9YweCxl/jItSdIX6DKHOK9LaQxqrjCUd9YWjL25N9wpkYPoMGhIgcaNm
         Ee0Bp38tr1zuBRP2LJo0FSu7/aZNmMhD5OACfR+yr52lOC/cgzaZstS5/RAkDV2rxQ0k
         BwpQ==
X-Received: by 10.66.138.15 with SMTP id qm15mr60310588pab.128.1374957074197;
        Sat, 27 Jul 2013 13:31:14 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ys4sm67626224pbb.9.2013.07.27.13.31.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 27 Jul 2013 13:31:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231252>

From: Jeremy Huddleston <jeremyhu@apple.com>

Use Apple's supported functions for base64 encoding instead
of the deprecated OpenSSL functions.

Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is Jeremy's original patch rebased onto the latest master.

Jeremy, the only way I could get this to work was to suppress inclusion of
openssl/sha.h by defining HEADER_SHA_H.  This can be removed when we have
replacements for openssl/x509v3.h.

 Makefile    |  1 +
 imap-send.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 0600eb4..4c40665 100644
--- a/Makefile
+++ b/Makefile
@@ -1413,6 +1413,7 @@ ifdef PPC_SHA1
 	LIB_H += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
+	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
 else
diff --git a/imap-send.c b/imap-send.c
index d6b65e2..3fd9c0e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -22,14 +22,11 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include "cache.h"
-#include "exec_cmd.h"
-#include "run-command.h"
-#include "prompt.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
 #ifdef APPLE_COMMON_CRYPTO
+/* git-compat-util.h overwrites ctype.h; this must be included first */
 #include <CommonCrypto/CommonHMAC.h>
 #define HMAC_CTX CCHmacContext
 #define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
@@ -37,12 +34,23 @@ typedef void *SSL;
 #define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
 #define HMAC_CTX_cleanup(ignore)
 #define EVP_md5() kCCHmacAlgMD5
+
+#if __MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
+#define APPLE_LION_OR_NEWER
+#include <Security/Security.h>
+#define HEADER_SHA_H /* suppress inclusion of openssl/sha.h */
+#endif
+
 #else
 #include <openssl/evp.h>
 #include <openssl/hmac.h>
 #endif
 #include <openssl/x509v3.h>
 #endif
+#include "cache.h"
+#include "exec_cmd.h"
+#include "run-command.h"
+#include "prompt.h"
 
 static const char imap_send_usage[] = "git imap-send < <mbox>";
 
@@ -877,6 +885,75 @@ static void imap_close_store(struct imap_store *ctx)
 	free(ctx);
 }
 
+#ifdef APPLE_LION_OR_NEWER
+#define EVP_DecodeBlock git_CC_EVP_DecodeBlock
+#define EVP_EncodeBlock git_CC_EVP_EncodeBlock
+#define error_check(pattern, err) \
+	do { \
+		if (err) { \
+			die(pattern, (long)CFErrorGetCode(err)); \
+		} \
+	} while(0)
+
+static int git_CC_EVP_EncodeBlock(unsigned char *out,
+		const unsigned char *in, int inlen)
+{
+	CFErrorRef err;
+	SecTransformRef encoder;
+	CFDataRef input, output;
+	CFIndex length;
+
+	encoder = SecEncodeTransformCreate(kSecBase64Encoding, &err);
+	error_check("SecEncodeTransformCreate failed: %ld", err);
+
+	input = CFDataCreate(kCFAllocatorDefault, in, inlen);
+	SecTransformSetAttribute(encoder, kSecTransformInputAttributeName,
+			input, &err);
+	error_check("SecTransformSetAttribute failed: %ld", err);
+
+	output = SecTransformExecute(encoder, &err);
+	error_check("SecTransformExecute failed: %ld", err);
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
+static int git_CC_EVP_DecodeBlock(unsigned char *out,
+		const unsigned char *in, int inlen)
+{
+	CFErrorRef err;
+	SecTransformRef decoder;
+	CFDataRef input, output;
+	CFIndex length;
+
+	decoder = SecDecodeTransformCreate(kSecBase64Encoding, &err);
+	error_check("SecEncodeTransformCreate failed: %ld", err);
+
+	input = CFDataCreate(kCFAllocatorDefault, in, inlen);
+	SecTransformSetAttribute(decoder, kSecTransformInputAttributeName,
+			input, &err);
+	error_check("SecTransformSetAttribute failed: %ld", err);
+
+	output = SecTransformExecute(decoder, &err);
+	error_check("SecTransformExecute failed: %ld", err);
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
 #ifndef NO_OPENSSL
 
 /*
-- 
1.8.3.2.804.g0da7a53.dirty
