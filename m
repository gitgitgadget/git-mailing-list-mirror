Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6F33D813E
	for <git@vger.kernel.org>; Thu, 14 May 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771646; cv=none; b=fuiaS5c9AjrTTLFFGRpTpjL7sy7+KOb7fM0RXIoUlZpTL6ZGIImpI5Mn7sQydrv4GCdbk44MhU3l0ngpAb3OuO0tRnEdLPo4sRBN4Ayrc26ZUtAURXlzqUtoZGl5bbEiRFrNxMbOLFFZHj072M+MXWAB1vPZVefPLLbvGtm9EVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771646; c=relaxed/simple;
	bh=0nQgod+0jcqA8L9Dr7FLfwtkQ9ntLC8T3eWf6FglipM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=ZHsTtLJkHQKmK1zh04pKrEqyua1oPQDkGsI6CvMFZM0bNlw3yNduiZldOni0nHT8x75Mk4au286XpOa7hgmCWrZuVP8ocN1NbTNn1AwgV5Pz7t5czMdYCEMgwvEiBEexIFFbUazF7iwCdf+0wQOP1VVs1eJg2dFEmMazK34jT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=pxfzYDaI; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="pxfzYDaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1778771627; x=1779376427; i=l.s.r@web.de;
	bh=wcGIOYDv/d1+zB4jlfsmH70nEaKUN6N6yPh5emFpdYw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pxfzYDaIcYdOjGWqNCLEjnkIugZctlB9B9cL9UvB/rmd4zLUNm/6OfQcwGWaab3m
	 JmziNyWL3if+xtnoDVD1QcTmBtjwZFMMim0NAdrtGz3GjdA5JZ+0U7RzNXD7+uzkP
	 YT53dPj3hWo9KlVhwWDjbCHBgkUQ+4o4zecxA0q1J5+shRMPnn/BKMQFVho0xRKjE
	 t01vm3Oxl3p5Vm74x4qwG6icuHKkN67rZ8UC5bWmQXJOfFWL+5ykqvSaf6R7zBfdg
	 wIrumVQi48Hk53qAzdKIf30waSG8vMAQDISDVPItB5sGiI5yBN+3HPiEHoaO/ZkGJ
	 rq1Jl04TKCxRWWLfLQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1wSEae0KeJ-00BRF0; Thu, 14
 May 2026 17:13:47 +0200
Message-ID: <0ded6062-f66a-4713-af24-d1b5aa654823@web.de>
Date: Thu, 14 May 2026 17:13:46 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] use __builtin_add_overflow() in st_add() with Clang
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>
In-Reply-To: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/6Qq3EdCYhyzO6PN0ThkVV/F8lt+lUuOZLTSFzZbLQ0ohr1VfQm
 cUvIwPcbVk4vKpLriI+ze4i51upljiTaqNBRvsqrlW+fpMslrk5qXZCT3pRwkKkxEPrVNuM
 We2fzXTwWnRSKks35Qy8ruZfWR3evlM5YmueuxOSzCderew4Gw8P90x4SGuH+UWEeTgYglW
 RafaYJJXho3KImx4Npgrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i3o6S6yv6dA=;f4+ZWDlvSHzkuZz5v14k1Pr/t/j
 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

Clang and GCC optimize away comparisons of overflow checks by checking
the carry flag on x64.  GCC does the same on ARM64, but Clang currently
(version 22.1) doesn't.

Provide a variant of st_add() that wraps __builtin_add_overflow() to
help Clang optimize it.  Use it on all platforms for simplicity.

On an Apple M1 I get a nice speedup for a command that builds lots of
strings using a strbuf, which exercises the st_add3() in strbuf_grow()
for every line of output:

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)'
  Time (mean =C2=B1 =CF=83):     119.8 ms =C2=B1   0.2 ms    [User: 113.0 =
ms, System: 5.8 ms]
  Range (min =E2=80=A6 max):   119.6 ms =E2=80=A6 120.4 ms    24 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)'
  Time (mean =C2=B1 =CF=83):     114.6 ms =C2=B1   0.1 ms    [User: 107.6 =
ms, System: 6.0 ms]
  Range (min =E2=80=A6 max):   114.4 ms =E2=80=A6 114.9 ms    25 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)' ran
    1.05 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)'

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..aa088d04bb 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -614,6 +614,17 @@ static inline bool strip_suffix(const char *str, cons=
t char *suffix,
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
=20
+/* Help Clang; GCC generates the same code for both variants. */
+#if defined(__clang__)
+static inline size_t st_add(size_t a, size_t b)
+{
+	size_t sum;
+	if (__builtin_add_overflow(a, b, &sum))
+		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
+		    (uintmax_t)a, (uintmax_t)b);
+	return sum;
+}
+#else
 static inline size_t st_add(size_t a, size_t b)
 {
 	if (unsigned_add_overflows(a, b))
@@ -621,6 +632,7 @@ static inline size_t st_add(size_t a, size_t b)
 		    (uintmax_t)a, (uintmax_t)b);
 	return a + b;
 }
+#endif
 #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
 #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
=20
=2D-=20
2.54.0
