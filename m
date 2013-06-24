From: Vicent Marti <tanoku@gmail.com>
Subject: [PATCH 07/16] compat: add endinanness helpers
Date: Tue, 25 Jun 2013 01:23:04 +0200
Message-ID: <1372116193-32762-8-git-send-email-tanoku@gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Cc: Vicent Marti <tanoku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 25 01:24:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrG7F-0003Il-7S
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 01:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab3FXXXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 19:23:55 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:53913 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005Ab3FXXXw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 19:23:52 -0400
Received: by mail-wg0-f48.google.com with SMTP id f11so8638671wgh.3
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 16:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=qUS8Qm7NdMjsS5l6JrT+y8BNWnqwAoBEaPrrswOURoU=;
        b=Y4RsPHo7ElO0rWxIen0bU0cuKvkT65vrob4Aq1pqmJn7TZm+nrxCKleO4Y1Xj6sTNn
         fOXZLm3sRJOyq2uj6/CcPDk9AZOujPjN19dMqEjXJypGJPesuk58hQQXuL07W2WJK9uV
         DGwO/VUoYUPRpje3Mv8APZTGHmiE7h1rWalpR2hn7IEylVIYYfzU08N6xaHRRBj6dFqk
         HozaOQVnKz1SVnMoRHKrgS95JJXm1KytoLYyPWrWBTq0Gnlr6E43hvU2USK/Y+G4ozo4
         /UhU/Rd2730DhMtFBT162kSu5wvyqtif/DPKhE/yvN36/rLbWAQ911Y8p5rmYrM7LelP
         Kuog==
X-Received: by 10.180.89.231 with SMTP id br7mr7477565wib.19.1372116231472;
        Mon, 24 Jun 2013 16:23:51 -0700 (PDT)
Received: from localhost.localdomain (212.Red-81-32-36.dynamicIP.rima-tde.net. [81.32.36.212])
        by mx.google.com with ESMTPSA id x13sm593766wib.3.2013.06.24.16.23.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Jun 2013 16:23:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228926>

The POSIX standard doesn't currently define a `nothll`/`htonll`
function pair to perform network-to-host and host-to-network
swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
storage of EWAH bitmaps if they are not in native byte order.
---
 git-compat-util.h |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index ff193f4..bc9b591 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -710,4 +710,32 @@ void warn_on_inaccessible(const char *path);
 /* Get the passwd entry for the UID of the current process. */
 struct passwd *xgetpwuid_self(void);
 
+#include <endian.h>
+
+#ifndef __BYTE_ORDER
+# if defined(BYTE_ORDER) && defined(LITTLE_ENDIAN) && defined(BIG_ENDIAN)
+#  define __BYTE_ORDER BYTE_ORDER
+#  define __LITTLE_ENDIAN LITTLE_ENDIAN
+#  define __BIG_ENDIAN BIG_ENDIAN
+# else
+#  error "Cannot determine endianness"
+# endif
+#endif
+
+#if __BYTE_ORDER == __BIG_ENDIAN
+# define ntohll(n) (n)
+# define htonll(n) (n)
+#elif __BYTE_ORDER == __LITTLE_ENDIAN
+# if defined(__GNUC__) && defined(__GLIBC__)
+#  include <byteswap.h>
+#  define ntohll(n) bswap_64(n)
+#  define htonll(n) bswap_64(n)
+# else /* GNUC & GLIBC */
+#  define ntohll(n) ( (((unsigned long long)ntohl(n)) << 32) + ntohl(n >> 32) )
+#  define htonll(n) ( (((unsigned long long)htonl(n)) << 32) + htonl(n >> 32) )
+# endif /* GNUC & GLIBC */
+#else /* __BYTE_ORDER */
+# error "Can't define htonll or ntohll!"
+#endif
+
 #endif
-- 
1.7.9.5
