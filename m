From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] Limit the size of the data block passed to SHA1_Update()
Date: Thu, 05 Nov 2015 10:29:28 -0800
Message-ID: <xmqqtwp05mgn.fsf@gitster.mtv.corp.google.com>
References: <1446705523-30701-1-git-send-email-apahlevan@ieee.org>
	<1446705523-30701-2-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 05 19:29:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuPI2-0007Zy-99
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162241AbbKES3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:29:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162123AbbKES3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:29:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0281B28AA8;
	Thu,  5 Nov 2015 13:29:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=gcwwNbaQbfbpXV/yeSdf+NGevdk=; b=LWkClGeBP9TnREW3tapl
	e+5zXstNu4zAhgewo5B1xwPENltypTcEJtOoQszf3cj/QZcxPIolZ4f7s9Wbq6ck
	HG+yHEUDQuTHszmZChRBXmdAZfrzF00pOPAic1kFcWkhpXiWs8yrNx7IhND1nH8Y
	Mi62OyN7QaXaV3QTRVbleSI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=rpAa2BfjE3RmPObMCfIwDemdmv1QFbhcGs/7/4mhV6JHW7
	NcrW2KlM1CZKXhRrDSDdW4l5dFOQKrJDob8IWav5eqD4Naz3xKCOLBlrAlXa5ZZ8
	xcccpNYF31cD5AoGJoV70S1fvzA+6V37vY4LzphYpGFGgHyvcxuAwRYTVo42w=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECF9828AA7;
	Thu,  5 Nov 2015 13:29:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 61A6E28AA6;
	Thu,  5 Nov 2015 13:29:29 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 26ADC614-83EB-11E5-9015-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280933>

atousa.p@gmail.com writes:

> +#ifndef git_SHA_CTX
> +
> +#ifdef SHA1_MAX_BLOCK_SIZE
> +#include "compat/sha1-chunked.h"
> +#define git_SHA_CTX		platform_SHA_CTX
> +#define git_SHA1_Init		platform_SHA1_Init
> +#define git_SHA1_Update		git_SHA1_Update_Chunked
> +#define git_SHA1_Final		platform_SHA1_Final
> +#else
>  #define git_SHA_CTX		platform_SHA_CTX
>  #define git_SHA1_Init		platform_SHA1_Init
>  #define git_SHA1_Update		platform_SHA1_Update
>  #define git_SHA1_Final		platform_SHA1_Final
> -
>  #endif
>  
> +#endif 
> +

Adjusting to the proposed change to 1/3, this step would become the
attached patch.  Note that I thought the above would not scale well
so I did it a bit differently.

-- >8 --
From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
Subject: sha1: allow limiting the size of the data passed to SHA1_Update()

Using the previous commit's inredirection mechanism for SHA1,
support a chunked implementation of SHA1_Update() that limits the
amount of data in the chunk passed to SHA1_Update().

This is enabled by using the Makefile variable SHA1_MAX_BLOCK_SIZE
to specify chunk size.  When using Apple's CommonCrypto library this
is set to 1GiB (the implementation cannot handle more 4GiB).

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                     | 13 +++++++++++++
 cache.h                      |  6 ++++++
 compat/apple-common-crypto.h |  4 ++++
 compat/sha1-chunked.c        | 19 +++++++++++++++++++
 compat/sha1-chunked.h        |  2 ++
 5 files changed, 44 insertions(+)
 create mode 100644 compat/sha1-chunked.c
 create mode 100644 compat/sha1-chunked.h

diff --git a/Makefile b/Makefile
index 04c2231..6a4ca59 100644
--- a/Makefile
+++ b/Makefile
@@ -141,6 +141,10 @@ all::
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
+# Define SHA1_MAX_BLOCK_SIZE to limit the amount of data that will be hashed
+# in one call to the platform's SHA1_Update(). e.g. APPLE_COMMON_CRYPTO
+# wants 'SHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L' defined.
+#
 # Define NEEDS_CRYPTO_WITH_SSL if you need -lcrypto when using -lssl (Darwin).
 #
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lssl when using -lcrypto (Darwin).
@@ -1335,6 +1339,11 @@ ifdef NO_POSIX_GOODIES
 	BASIC_CFLAGS += -DNO_POSIX_GOODIES
 endif
 
+ifdef APPLE_COMMON_CRYPTO
+	# Apple CommonCrypto requires chunking
+	SHA1_MAX_BLOCK_SIZE = 1024L*1024L*1024L
+endif
+
 ifdef BLK_SHA1
 	SHA1_HEADER = "block-sha1/sha1.h"
 	LIB_OBJS += block-sha1/sha1.o
@@ -1353,6 +1362,10 @@ endif
 endif
 endif
 
+ifdef SHA1_MAX_BLOCK_SIZE
+	LIB_OBJS += compat/sha1-chunked.o
+	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
+endif
 ifdef NO_PERL_MAKEMAKER
 	export NO_PERL_MAKEMAKER
 endif
diff --git a/cache.h b/cache.h
index 2f697c4..19c966d 100644
--- a/cache.h
+++ b/cache.h
@@ -30,6 +30,12 @@
 #define git_SHA1_Update		platform_SHA1_Update
 #define git_SHA1_Final		platform_SHA1_Final
 
+#ifdef SHA1_MAX_BLOCK_SIZE
+#include "compat/sha1-chunked.h"
+#undef git_SHA1_Update
+#define git_SHA1_Update		git_SHA1_Update_Chunked
+#endif
+
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
diff --git a/compat/apple-common-crypto.h b/compat/apple-common-crypto.h
index c8b9b0e..d3fb264 100644
--- a/compat/apple-common-crypto.h
+++ b/compat/apple-common-crypto.h
@@ -16,6 +16,10 @@
 #undef TYPE_BOOL
 #endif
 
+#ifndef SHA1_MAX_BLOCK_SIZE
+#error Using Apple Common Crypto library requires setting SHA1_MAX_BLOCK_SIZE
+#endif
+
 #ifdef APPLE_LION_OR_NEWER
 #define git_CC_error_check(pattern, err) \
 	do { \
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
new file mode 100644
index 0000000..6adfcfd
--- /dev/null
+++ b/compat/sha1-chunked.c
@@ -0,0 +1,19 @@
+#include "cache.h"
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
+{
+	size_t nr;
+	size_t total = 0;
+	const char *cdata = (const char*)data;
+
+	while (len) {
+		nr = len;
+		if (nr > SHA1_MAX_BLOCK_SIZE)
+			nr = SHA1_MAX_BLOCK_SIZE;
+		platform_SHA1_Update(c, cdata, nr);
+		total += nr;
+		cdata += nr;
+		len -= nr;
+	}
+	return total;
+}
diff --git a/compat/sha1-chunked.h b/compat/sha1-chunked.h
new file mode 100644
index 0000000..7b2df28
--- /dev/null
+++ b/compat/sha1-chunked.h
@@ -0,0 +1,2 @@
+
+int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len);
-- 
2.6.2-535-ga9e37b0
