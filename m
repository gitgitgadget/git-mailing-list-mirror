From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] imap-send: eliminate HMAC warnings on OS X 10.8
Date: Fri, 10 May 2013 21:43:26 -0700
Message-ID: <1368247406-10334-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Mike McCormack <mike@codeweavers.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 06:43:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub1f0-00021r-C2
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 06:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab3EKEni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 00:43:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:60883 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3EKEnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 00:43:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa10so3357643pad.5
        for <git@vger.kernel.org>; Fri, 10 May 2013 21:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Vm60UDpGqOJ/KLg9NEIGsi6rYdn5OtZ87O91tZtjR64=;
        b=YfHP5kO+BFNLEE+xlboGE4Nm5HbgYNkABSNvDr+IETIbf7qeoagLGjtrde77ugVKI0
         UeTCV9KT4/nZPErBMdoX2woP3SfUTIEdx8WSD/SiqAMZw+4jc080I9khJTP/xcxvmGKV
         3CMEu+s13ANIPk+OvVHw0KlNjzGy5y4WOunFOa09JqUxf4BLEXB+oZeFkCjsFM6EbL6K
         3+0UMVGvYyCCuUBPHOjGMi/1I+wizW25+NdU6RsKq6oNUch8tEv3lIVxpKQpcDoXqXwx
         LCBMZpdO7fENKZPMvhu+ftLwlv52ENudWZ+9/st+tyfnbVWmT98IGzrjztZi1enzwic3
         /dtQ==
X-Received: by 10.68.213.231 with SMTP id nv7mr20401765pbc.70.1368247416728;
        Fri, 10 May 2013 21:43:36 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id aa8sm5422247pad.14.2013.05.10.21.43.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 May 2013 21:43:35 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.46.gb953cd9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223926>

Mac OS X Mountain Lion warns that HMAC_Init() and friends are
deprecated.  Use CommonCrypto's HMAC to eliminate the warnings.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This builds upon the patch I sent earlier, so technically it's 2/2

While researching these errors I found this:

http://opensource.apple.com/source/Git/Git-37/src/git/imap-send.c

The approach in this patch is similar in spirit, but simpler since
it avoids pushing #ifdefs into the function bodies.

 Makefile    |  5 +++++
 imap-send.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index d8a45b4..7e12999 100644
--- a/Makefile
+++ b/Makefile
@@ -1055,6 +1055,7 @@ ifeq ($(uname_S),Darwin)
 		endif
 	endif
 	COMMON_DIGEST_SHA1 = YesPlease
+	COMMON_DIGEST_HMAC = YesPlease
 	PTHREAD_LIBS =
 endif
 
@@ -1399,6 +1400,10 @@ else
 endif
 endif
 endif
+
+ifdef COMMON_DIGEST_HMAC
+	BASIC_CFLAGS += -DCOMMON_DIGEST_FOR_HMAC=1
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/imap-send.c b/imap-send.c
index d9bcfb4..1b2e69c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,8 +29,18 @@
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #else
+#ifdef COMMON_DIGEST_FOR_HMAC
+#include <CommonCrypto/CommonHMAC.h>
+#define HMAC_CTX CCHmacContext
+#define HMAC_Init(hmac, key, len, algo) CCHmacInit(hmac, algo, key, len)
+#define HMAC_Update CCHmacUpdate
+#define HMAC_Final(hmac, hash, ptr) CCHmacFinal(hmac, hash)
+#define HMAC_CTX_cleanup
+#define EVP_md5() kCCHmacAlgMD5
+#else
 #include <openssl/evp.h>
 #include <openssl/hmac.h>
+#endif
 #include <openssl/x509v3.h>
 #endif
 
-- 
1.8.3.rc1.46.g9f9589e
