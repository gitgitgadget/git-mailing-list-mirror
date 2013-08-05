From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH 2/3] OS X: Fix redeclaration of die warning
Date: Mon,  5 Aug 2013 11:59:23 -0400
Message-ID: <1375718364-13824-3-git-send-email-brian@gernhardtsoftware.com>
References: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6NCJ-0000u2-TD
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115Ab3HEP7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:59:47 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:48900 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686Ab3HEP7n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:59:43 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6D4242736303; Mon,  5 Aug 2013 15:59:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-142-105-190-134.rochester.res.rr.com [142.105.190.134])
	by silverinsanity.com (Postfix) with ESMTPA id 425BA27362F5;
	Mon,  5 Aug 2013 15:59:37 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.rc1.384.g0976a17.dirty
In-Reply-To: <1375718364-13824-1-git-send-email-brian@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231664>

compat/apple-common-crypto.h uses die() in one of its macros, but was
included in git-compat-util.h before the definition of die.

Fix by simply moving the relevant block after the die/error/warning
declarations.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---

 Not sure if this is the best place to move it to, but it's the earliest it can
 be in the file without causing errors.  (Namely that clang has to guess what
 die() means in apple-common-crypto.h and guesses differently than the actual
 definition.)

 git-compat-util.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index af5f6bb..d60e28d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -129,16 +129,6 @@
 #include <poll.h>
 #endif
 
-#ifndef NO_OPENSSL
-#ifdef APPLE_COMMON_CRYPTO
-#include "compat/apple-common-crypto.h"
-#else
-#include <openssl/evp.h>
-#include <openssl/hmac.h>
-#endif /* APPLE_COMMON_CRYPTO */
-#include <openssl/x509v3.h>
-#endif /* NO_OPENSSL */
-
 #if defined(__MINGW32__)
 /* pull in Windows compatibility stuff */
 #include "compat/mingw.h"
@@ -340,6 +330,16 @@ extern NORETURN void die_errno(const char *err, ...) __attribute__((format (prin
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
 extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
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
 /*
  * Let callers be aware of the constant return value; this can help
  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,
-- 
1.8.4.rc1.384.g0976a17.dirty
