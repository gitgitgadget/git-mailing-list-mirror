Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD21624A064
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680106; cv=none; b=fURopCaZ/TfrB+nB+DwcL8SSYektTktjPxztm+rfE20Q3eT2zWpHQILDp8BkI/96ZPENL1G6F6115fNkx9s65a1w/ZcAJ3Au4lbI6CUSNWXqzkfjG5z9WXu6Jo30URXpW10mHGgXyLZEkSheC2fzWFw3iLUM02+23gcue+bmDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680106; c=relaxed/simple;
	bh=pFVopkNp/f77ni8gazkeihtIZV+FSNp/nZ0pkucKeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl8JikOmjJqTC4nonssMe3gejUfP1/p2WUPJbA23HwLqMpxlPFzLK88Bj1Q9NwCFGWl3sC+EBaV8KqGEv6eU84vt5VvfWTmH6HSijo2U94+tsrkBIAfP/VkScRV8qdjzu63aIu7HfDeMJ37JjeFJCXDfKMDdT1rdH81+tdE79JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=koefYLak; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=VBgfxoFK; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="koefYLak";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="VBgfxoFK"
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1000)
	id A50636136F; Thu, 12 Jun 2025 00:14:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsiFEuw75K7084V6Me7t4DgiTNBxSESUw+uXFnMy4lc=;
	b=koefYLakHmu3cMSrCZFYmNLRznMB4ipDB1BDXd+tM7dDk3YMF7A23BOfNLH875xFKKIcQc
	9Q0SKLRAtw5y1a094eYJczXbesC1vKDz5csc6f4JnCdyZ1HHMK9Aili3FtH0sWGuftC2NX
	97MC2+1fWynjPDTLoQWHluCeikv86+tbXndv2j+kbBrKAkZMpUFz+oxRySRsCzW2qixlIK
	rrwCP553bbvMGW5PLckMmQW1NR2igz6bOtFjuiyMXO91s/3FMg82yq/sdZMScXyL/cUf/Z
	ijfttnbp8CTjd/yG/Ez859zS0YS7FA2KusMEcMKYc0GnhF1I8RcEtX+B8Ar2Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1749680093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SsiFEuw75K7084V6Me7t4DgiTNBxSESUw+uXFnMy4lc=;
	b=VBgfxoFK51wr6sB7QzyXWHqXa13otEJAkxXuY5bn0Mg27sLlemtUF9kHbMTvLWEn5kRQ3h
	K5R1azeTySG5koDw==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: git@vger.kernel.org
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: [PATCH v2 5/6] bswap: Remove optimized x86 version of bswap32/64
Date: Thu, 12 Jun 2025 00:14:42 +0200
Message-ID: <20250611221444.1567638-7-sebastian@breakpoint.cc>
In-Reply-To: <20250611221444.1567638-1-sebastian@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On x86 the bswap32/64 macro is implemenated based on the x86 opcode wich
performs the required shifting in just one opcode.
The other CPUs fallback to the generic shifting as implemented by
default_swab32() and default_bswap64() if needed.

I've been looking at how good a compiler is at recognizing the default
shift and emitting an optimized operation:
- x86, arm64 msvc v19.20
  default_swab32() optimized
  default_bswap64() shifts
  _byteswap_uint64() otimized

- x86, arm64 msvc v19.37
  default_swab32() optimized
  default_bswap64() optimized
  _byteswap_uint64() otimized

- arm64, gcc-4.9.4: optimized
- x86-64, gcc-4.4.7: shifts
- x86-64, gcc-4.5.3: optimized
- x86-64, clang-3.0: optimized

Given that gcc-4.5 and clang-3.0 are fairly old, any recent compiler
should recognize the shift.

Remove the optimized x86 version and rely on the compiler.

Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 compat/bswap.h | 41 +----------------------------------------
 1 file changed, 1 insertion(+), 40 deletions(-)

diff --git a/compat/bswap.h b/compat/bswap.h
index aeef304f671f5..ed00f6d1d53f3 100644
--- a/compat/bswap.h
+++ b/compat/bswap.h
@@ -35,46 +35,7 @@ static inline uint64_t default_bswap64(uint64_t val)
 #undef bswap32
 #undef bswap64
=20
-#if defined(__GNUC__) && (defined(__i386__) || defined(__x86_64__))
-
-#define bswap32 git_bswap32
-static inline uint32_t git_bswap32(uint32_t x)
-{
-	uint32_t result;
-	if (__builtin_constant_p(x))
-		result =3D default_swab32(x);
-	else
-		__asm__("bswap %0" : "=3Dr" (result) : "0" (x));
-	return result;
-}
-
-#define bswap64 git_bswap64
-#if defined(__x86_64__)
-static inline uint64_t git_bswap64(uint64_t x)
-{
-	uint64_t result;
-	if (__builtin_constant_p(x))
-		result =3D default_bswap64(x);
-	else
-		__asm__("bswap %q0" : "=3Dr" (result) : "0" (x));
-	return result;
-}
-#else
-static inline uint64_t git_bswap64(uint64_t x)
-{
-	union { uint64_t i64; uint32_t i32[2]; } tmp, result;
-	if (__builtin_constant_p(x))
-		result.i64 =3D default_bswap64(x);
-	else {
-		tmp.i64 =3D x;
-		result.i32[0] =3D git_bswap32(tmp.i32[1]);
-		result.i32[1] =3D git_bswap32(tmp.i32[0]);
-	}
-	return result.i64;
-}
-#endif
-
-#elif defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined=
(_M_ARM64))
+#if defined(_MSC_VER) && (defined(_M_IX86) || defined(_M_X64) || defined(_=
M_ARM64))
=20
 #include <stdlib.h>
=20
--=20
2.49.0

