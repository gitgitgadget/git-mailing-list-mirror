From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] Provide another level of abstraction for the SHA1 utilities.
Date: Thu, 05 Nov 2015 10:29:24 -0800
Message-ID: <xmqq1tc47117.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cS7NktyhveQUiBFkRtJH1D-Aif861e9qshL2R=ZNg2+Lw@mail.gmail.com>
	<1446705523-30701-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 05 19:29:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuPHw-0007X2-Sf
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 19:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162183AbbKES32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 13:29:28 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162124AbbKES31 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 13:29:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 72C4828AA0;
	Thu,  5 Nov 2015 13:29:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=3qoG3CtUy8+z02fVr0hv5RfRwL4=; b=xtdYpuYtU3LztuxPveyi
	r/6Khshf1w5HGaxCG0yNfn9I415dZy/i1UqN3m/881twUVA0EBwnPOOiMouGfOzo
	3BLQgL28qdYyMtuDfaTGZ0CbtabMptloZcIIPTr/K3LUlhebJZIurU1iRBqfc/6r
	zFgyDVZn3a/hJxmcsWOUpxc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=iEPVONd97GGWBWy/fVxWX9vUa0yRCAh7aLuXdcxIpE1cW9
	Wusjqb/XcQasle0Ai4HmdlbIlDO6+/7bXzRn3Uv6vvxnQDa2gHjhjM83ORbUkF37
	E6ilzaLXNfrfqvoZFhHfk8I3kbJIUfMJwXaQt/CSLDbsU/nl69lT/Fn3RNR7c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6B93E28A9E;
	Thu,  5 Nov 2015 13:29:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D284228A9D;
	Thu,  5 Nov 2015 13:29:25 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2491C4E8-83EB-11E5-AE3D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280932>

atousa.p@gmail.com writes:

> From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
>
> The git source uses git_SHA1_Update() and friends to call
> into the code that computes the hashes.  This is can then be
> mapped directly to an implementation that computes the hash,
> such as platform_SHA1_Update(); or as we will do in a subsequent
> patch, it can be mapped to something more complex that will in turn call
> into the platform's SHA implementation.
>
> Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
> ---
>  cache.h | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index a9aaa03..a934a2e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -12,10 +12,21 @@
>  
>  #include SHA1_HEADER
>  #ifndef git_SHA_CTX
> -#define git_SHA_CTX	SHA_CTX
> -#define git_SHA1_Init	SHA1_Init
> -#define git_SHA1_Update	SHA1_Update
> -#define git_SHA1_Final	SHA1_Final
> +
> +/* platform's underlying implementation of SHA1, could be OpenSSL,
> +   blk_SHA, Apple CommonCrypto, etc...  */
> +#define platform_SHA_CTX	SHA_CTX
> +#define platform_SHA1_Init	SHA1_Init
> +#define platform_SHA1_Update	SHA1_Update
> +#define platform_SHA1_Final    	SHA1_Final
> +
> +/* git may call platform's underlying implementation of SHA1 directly,
> +   or may call it through a wrapper */
> +#define git_SHA_CTX		platform_SHA_CTX
> +#define git_SHA1_Init		platform_SHA1_Init
> +#define git_SHA1_Update		platform_SHA1_Update
> +#define git_SHA1_Final		platform_SHA1_Final
> +
>  #endif
>  
>  #include <zlib.h>

This is not quite correct, I am afraid.  Our own implementations
still define git_SHA* macros, but they should be considered the
"platform" ones in the new world order with another level of
indirection.

I think the attached is closer to what we want.  The implementations
may give us platform_SHA*() in which case cache.h does not have to
give the fallback mapping from them to the OpenSSL compatible
interface used by OpenSSL and CommonCrypto.  Regardless of the
platform SHA-1 implementations, by default they are the ones used by
the rest of the system via git_SHA*().

And in the second step, git_SHA1_Update() may map to the Chunked
one, whose implementation would use platform_SHA1_Update().

-- >8 ---
From: Atousa Pahlevan Duprat <apahlevan@ieee.org>
Subject: sha1: provide another level of indirection for the SHA-1 functions

The git source uses git_SHA1_Update() and friends to call into the
code that computes the hashes.  Traditionally, we used to map these
directly to underlying implementation of the SHA-1 hash (e.g.
SHA1_Update() from OpenSSL or blk_SHA1_Update() from block-sha1/).

This arrangement however makes it hard to tweak behaviour of the
underlying implementation without fully replacing.  If we want to
introduce a tweaked_SHA1_Update() wrapper to implement the "Update"
in a slightly different way, for example, the implementation of the
wrapper still would want to call into the underlying implementation,
but tweaked_SHA1_Update() cannot call git_SHA1_Update() to get to
the underlying implementation (often but not always SHA1_Update()).

Add another level of indirection that maps platform_SHA1_Update()
and friends to their underlying implementations, and by default make
git_SHA1_Update() and friends map to platform_SHA1_* functions.

Doing it this way will later allow us to map git_SHA1_Update() to
tweaked_SHA1_Update(), and the latter can use platform_SHA1_Update()
in its implementation.

Signed-off-by: Atousa Pahlevan Duprat <apahlevan@ieee.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 block-sha1/sha1.h |  8 ++++----
 cache.h           | 22 +++++++++++++++++-----
 ppc/sha1.h        |  8 ++++----
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
index b864df6..4df6747 100644
--- a/block-sha1/sha1.h
+++ b/block-sha1/sha1.h
@@ -16,7 +16,7 @@ void blk_SHA1_Init(blk_SHA_CTX *ctx);
 void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *dataIn, unsigned long len);
 void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx);
 
-#define git_SHA_CTX	blk_SHA_CTX
-#define git_SHA1_Init	blk_SHA1_Init
-#define git_SHA1_Update	blk_SHA1_Update
-#define git_SHA1_Final	blk_SHA1_Final
+#define platform_SHA_CTX	blk_SHA_CTX
+#define platform_SHA1_Init	blk_SHA1_Init
+#define platform_SHA1_Update	blk_SHA1_Update
+#define platform_SHA1_Final	blk_SHA1_Final
diff --git a/cache.h b/cache.h
index a9aaa03..2f697c4 100644
--- a/cache.h
+++ b/cache.h
@@ -11,13 +11,25 @@
 #include "string-list.h"
 
 #include SHA1_HEADER
-#ifndef git_SHA_CTX
-#define git_SHA_CTX	SHA_CTX
-#define git_SHA1_Init	SHA1_Init
-#define git_SHA1_Update	SHA1_Update
-#define git_SHA1_Final	SHA1_Final
+#ifndef platform_SHA_CTX
+/*
+ * platform's underlying implementation of SHA-1; could be OpenSSL,
+ * blk_SHA, Apple CommonCrypto, etc...  Note that including
+ * SHA1_HEADER may have already defined platform_SHA_CTX for our
+ * own implementations like block-sha1 and ppc-sha1, so we list
+ * the default for OpenSSL compatible SHA-1 implementations here.
+ */
+#define platform_SHA_CTX	SHA_CTX
+#define platform_SHA1_Init	SHA1_Init
+#define platform_SHA1_Update	SHA1_Update
+#define platform_SHA1_Final    	SHA1_Final
 #endif
 
+#define git_SHA_CTX		platform_SHA_CTX
+#define git_SHA1_Init		platform_SHA1_Init
+#define git_SHA1_Update		platform_SHA1_Update
+#define git_SHA1_Final		platform_SHA1_Final
+
 #include <zlib.h>
 typedef struct git_zstream {
 	z_stream z;
diff --git a/ppc/sha1.h b/ppc/sha1.h
index c405f73..9b24b32 100644
--- a/ppc/sha1.h
+++ b/ppc/sha1.h
@@ -19,7 +19,7 @@ int ppc_SHA1_Init(ppc_SHA_CTX *c);
 int ppc_SHA1_Update(ppc_SHA_CTX *c, const void *p, unsigned long n);
 int ppc_SHA1_Final(unsigned char *hash, ppc_SHA_CTX *c);
 
-#define git_SHA_CTX	ppc_SHA_CTX
-#define git_SHA1_Init	ppc_SHA1_Init
-#define git_SHA1_Update	ppc_SHA1_Update
-#define git_SHA1_Final	ppc_SHA1_Final
+#define platform_SHA_CTX	ppc_SHA_CTX
+#define platform_SHA1_Init	ppc_SHA1_Init
+#define platform_SHA1_Update	ppc_SHA1_Update
+#define platform_SHA1_Final	ppc_SHA1_Final
-- 
2.6.2-535-ga9e37b0
