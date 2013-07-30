From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] imap-send: use Apple's Security framework for base64 encoding
Date: Tue, 30 Jul 2013 08:54:39 -0700
Message-ID: <7vtxjcvy9s.fsf@alter.siamese.dyndns.org>
References: <1375147710-71226-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:55:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4CG8-000179-9G
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab3G3Pyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 11:54:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751633Ab3G3Pyn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 11:54:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7039834D1F;
	Tue, 30 Jul 2013 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=iNc9iFhY8+RqM1gs+uVfdYfJegE=; b=sA1HYrdRAey67hW/NzMy
	E1zL6B4ZV0mIThi7mpd3+KB8DnJ9n2hsrkMR4hdlaB1tvhw5LRF6WR3+nelcQMcD
	uRXS34X3HpI02crLAwCq5j2q6K33JFppbCHjQkh4704BbAMkpDAHu42vVNJ/eXS+
	FXzB/+38HCXGX7zUqohRD/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=GPdUGq43jKeoWjMGiHrP81r9BzN0vBpAkFIOen/fRyg2WF
	YNAi8vBYLFkpgTaZmrhZ5DUIx8Lvh/Vbhdy0TEhayapr7z7gd1Hj7I7yMxN9BN3n
	6Rdr9pLja8914COan6qu21BF06NSsmO9d4fNtOl9igeODFv4T3iqQIBf3ZjXM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6520B34D1D;
	Tue, 30 Jul 2013 15:54:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6928F34D1A;
	Tue, 30 Jul 2013 15:54:41 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5895E4F6-F930-11E2-8502-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231371>

David Aguilar <davvid@gmail.com> writes:

> From: Jeremy Huddleston <jeremyhu@apple.com>
>
> Use Apple's supported functions for base64 encoding instead
> of the deprecated OpenSSL functions.
>
> Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This version moves the tricky #ifdefs into git-compat-util.h

Nice.  I however wonder if we can kick the inlines that are
irrelevant to most people out further.  For example, would the
following be an improvement?

-- >8 --
From: Jeremy Huddleston <jeremyhu@apple.com>
Date: Mon, 29 Jul 2013 18:28:30 -0700
Subject: [PATCH] imap-send: use Apple's Security framework for base64 encoding

Use Apple's supported functions for base64 encoding instead
of the deprecated OpenSSL functions.

Signed-off-by: Jeremy Huddleston <jeremyhu@apple.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                     |  1 +
 compat/apple-common-crypto.h | 86 ++++++++++++++++++++++++++++++++++++++++++++
 git-compat-util.h            | 11 ++++++
 imap-send.c                  | 14 --------
 4 files changed, 98 insertions(+), 14 deletions(-)
 create mode 100644 compat/apple-common-crypto.h

diff --git a/Makefile b/Makefile
index 5e7cadf..dddf49b 100644
--- a/Makefile
+++ b/Makefile
@@ -1398,6 +1398,7 @@ ifdef PPC_SHA1
 	LIB_H += ppc/sha1.h
 else
 ifdef APPLE_COMMON_CRYPTO
+	LIB_4_CRYPTO += -framework Security -framework CoreFoundation
 	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
 	SHA1_HEADER = <CommonCrypto/CommonDigest.h>
 else
diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
new file mode 100644
index 0000000..c8b9b0e
--- /dev/null
+++ b/compat/apple-common-crypto.h
@@ -0,0 +1,86 @@
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
+
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
diff --git a/git-compat-util.h b/git-compat-util.h
index e955bb5..6ebb029 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,17 @@
 #else
 #include <poll.h>
 #endif
+
+#ifndef NO_OPENSSL
+#ifdef APPLE_COMMON_CRYPTO
+#include "compat/apple-common-crypto.h"
+#else
+#include <openssl/evp.h>
+#include <openssl/hmac.h>
+#endif /* APPLE_COMMON_CRYPTO */
+#include <openssl/x509v3.h>
+#endif /* NO_OPENSSL */
+
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
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
1.8.4-rc0-137-g17832d4
