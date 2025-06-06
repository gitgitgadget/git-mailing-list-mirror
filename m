Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941442882B6
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229044; cv=none; b=kTH9wVBWK61gb7oi2dqVyGvu4N0ORXXiFf3MAQvpjRbJ4qzR/RhkkRcHN+EYAQn7b2zt938QOijnqFuBCizY0+pWm0styJb4Wy+1wNM9MbFuor/GriqL9qyTbdXY7AcIJiN26iY+Upnyw7WEXSKgf03nm8czWlHDC1L1yjRRqQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229044; c=relaxed/simple;
	bh=TI/FY5nuETHel/se1Z9Vo/0yioUBv0XmWhlLYyY2xSU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hs3PTKNADgYi9t6sGyzHfodOCPlwlGw6j0QgyHem4BLNreZ3xd9egPzbeIW+9wpdZcKMzhjOUHLeBm4Ed89fEs6fl3bIvEeNht7uIbloltIpSLWKcEeQ5C82dIx2LnyDKdYpAc9J3kAKXF72FpVUNp7MKlWS/tCg2KpICiLoa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=KyxPHdgL; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=OYgDhRFF; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="KyxPHdgL";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="OYgDhRFF"
Date: Fri, 6 Jun 2025 18:57:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749229040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=SAzGyC6FwVbje8ybVJgt5/r0z/tuAH8qv+dQFjT7LCY=;
	b=KyxPHdgLZCV3ZSY0wMXUpTSydMLWnrc7Uw/YOdzI2hGq4OODQdHjf1pHf9md5sWgMKTFm5
	blmvWwdYSfkjzZcsFFCPijftZN7/enqg8inrGnDv3mt6DTXspxE9T44Vb/9KzRgXvO0qv1
	UHMwrDWtP2Cc2bi1gVOlfzoPDYO+xAxcSDIWA/dlcj8AoB2l9JJ/3oZP9uHWrcyCuRsKTj
	AfhgW7od6GCcA39Ld9d5F3g1U7F9wis83NhpJKTS/xsq2fceNlrTaGYFNuQu6jQhUqKLAu
	hSDtb7ReaE5PjGdXhJwmup3SNGVCVkNWmUCdlsRtC1hunJ4fJJjtCI1SFn/NdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749229040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=SAzGyC6FwVbje8ybVJgt5/r0z/tuAH8qv+dQFjT7LCY=;
	b=OYgDhRFFJCIvYppJ0MD7aIoAA/vYsp4xJYD60CUM+ifVQ2gqaZQJgYTHdnGsHsPy4crUin
	SlUPT0XLGR9T5JBA==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Subject: [PATCH] bswap.h: Move the overwriting of the ntohl*/ htonl* macros.
Message-ID: <20250606165718.HOiC2U4X@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The top of that file contains optimized bswap32/64 only for a few little
endian machines. Since the commit cited below there is one for every
architecture supporting the __builtin_bswap* directives.

Later in the file, the ntohl* macros are replaced with the bswap* macros
should they be provided. Since they are now provided even on big endian
machines they replace the nop with a swap.

Move the ntohl*/ htonl* replacement once it is determined that it is a
little architecture where the swap is performed.

Fixes: 6547d1c9cbafa ("bswap.h: add support for built-in bswap functions")
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---

This builds on top of v2.50.0-rc1 on s390x and -rc0 and x86-64. The
testsuite passes.

 compat/bswap.h | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index 9e0f98e00b93a..5789d12c2c356 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -95,24 +95,6 @@ static inline uint64_t git_bswap64(uint64_t x)
 
 #endif
 
-#if defined(bswap32)
-
-#undef ntohl
-#undef htonl
-#define ntohl(x) bswap32(x)
-#define htonl(x) bswap32(x)
-
-#endif
-
-#if defined(bswap64)
-
-#undef ntohll
-#undef htonll
-#define ntohll(x) bswap64(x)
-#define htonll(x) bswap64(x)
-
-#else
-
 #undef ntohll
 #undef htonll
 
@@ -151,10 +133,23 @@ static inline uint64_t git_bswap64(uint64_t x)
 # define ntohll(n) (n)
 # define htonll(n) (n)
 #else
-# define ntohll(n) default_bswap64(n)
-# define htonll(n) default_bswap64(n)
-#endif
 
+# if defined(bswap32)
+#  undef ntohl
+#  undef htonl
+#  define ntohl(x) bswap32(x)
+#  define htonl(x) bswap32(x)
+# endif
+
+# if defined(bswap64)
+#  undef ntohll
+#  undef htonll
+#  define ntohll(x) bswap64(x)
+#  define htonll(x) bswap64(x)
+# else
+#  define ntohll(n) default_bswap64(n)
+#  define htonll(n) default_bswap64(n)
+# endif
 #endif
 
 static inline uint16_t get_be16(const void *ptr)
-- 
2.49.0

