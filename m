Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871CE38F929
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135919; cv=none; b=IsOfZHj8mRcr+BFG4yLi3p6lt+TYqkQEjb7LV6pPuweYu82jtoehnIGu0v+J8CpIEa3pzVxgZvY6YisG3tw3Clq/vKZKKekPNYjNJHYYb9DpCcdP4FZftsIwWnr//Y9iipQjoZyXVWAUBHA1AdYLM1+tkYiOiJwHf9ETSoW2tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135919; c=relaxed/simple;
	bh=EmlsznWVRfZUPSU8P9/Nq29Df/TSKfTLbLmp3QZH0Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uj+M3dbnBTqVmCt2vRQmCGKKmGSdghl9W8ETYrIwHBLTzJ2CJADPPmRvAiksi/+Z87YLGYXELewzyyobIKwZZ5dRElJBr6FIKgPfmLdyfm9/Am+9ylx3UyMO2Jz8JD8WP0VrmNHPixM2tZwV/Pc9L7tmv/89cRXK526GacGnjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=HYLSDG9p; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="HYLSDG9p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779135908; x=1779740708; i=l.s.r@web.de;
	bh=yykR9iXMdlhIH1BvYu7hnVA34yOcfwqn3Od0PhFRYFE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HYLSDG9pPJE4Mt0e2RRV/xNSwBOZpNo5tv+hMLyh0Pq43VQ0WPogBaqK6veoVmb8
	 RT6bUz68tRu5qcCRuFepSbicaNbh7hTIRVN/nXZErZ1YWI02C9F5BJ2iwk51zPrlQ
	 I7YDqq+ixem8tnkKpKD0DLFlstPz3UfALZm0OMYBADcdXtCMT5Vtqwn1k6CH1P6WK
	 zwTCfGDKcTywlEjFB+426Iu+rzgBr8axiTf56UqLsxkITrbYHfeKqe5CPZC9NAqc8
	 E+N+sC9gCf9Px1e4JNo4xdRdkp78OqqOOk9OWbcTrTETym/On3sOuW5OSdGnaoHJt
	 2aRnfPnDfhdNU0sNZw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFlm-1x2F1y0gC2-00j2wr; Mon, 18
 May 2026 22:25:08 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] use __builtin_add_overflow() in st_add() with Clang
Date: Mon, 18 May 2026 22:25:02 +0200
Message-ID: <20260518202502.25682-3-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518202502.25682-1-l.s.r@web.de>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
 <20260518202502.25682-1-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CNJN9H0oc5ZyAXx62l9TWmMRMqKlniVLZy5eBYUIF97O85IHhSz
 PpAHePKt4yDaMUeA6Ygt3imvtBSKkB/2G9i0wJcS8swA29MMkt30M3pDc2Di7ILk5CLjqvl
 izCtSY6sOegRUiybX28dGGauCc3Zy8nMt3MwvTFuBd6FeIPqYUlyJWb+IWkkxV6HHJuPGzC
 8XKpihtMCptfkx0dFL0Lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ayJrfHQUXRg=;H4986/oiyo4GAHNbxS0edSj1I6E
 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

Clang and GCC optimize away comparisons of overflow checks by checking
the carry flag on x64.  GCC does the same on ARM64, but Clang currently
(version 22.1) doesn't.

It does this optimization for overflow checks that use its builtin
function __builtin_add_overflow(), though.  Provide a non-generic
lookalike for size_t that does the same checks as before as a fallback
and use the original with Clang.  Use it on all platforms for simplicity.

On an Apple M1 I get a nice speedup for a command that builds lots of
strings using a strbuf, which exercises the st_add3() in strbuf_grow()
for every line of output:

Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check=3D'%(ob=
jectname)'
  Time (mean =C2=B1 =CF=83):     120.4 ms =C2=B1   0.2 ms    [User: 113.8 =
ms, System: 6.0 ms]
  Range (min =E2=80=A6 max):   120.1 ms =E2=80=A6 121.1 ms    24 runs

Benchmark 2: ./git cat-file --batch-all-objects --batch-check=3D'%(objectn=
ame)'
  Time (mean =C2=B1 =CF=83):     115.5 ms =C2=B1   0.1 ms    [User: 108.6 =
ms, System: 5.8 ms]
  Range (min =E2=80=A6 max):   115.2 ms =E2=80=A6 115.8 ms    25 runs

Summary
  ./git cat-file --batch-all-objects --batch-check=3D'%(objectname)' ran
    1.04 =C2=B1 0.00 times faster than ./git_main cat-file --batch-all-obj=
ects --batch-check=3D'%(objectname)'

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 git-compat-util.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index ae1bdc90a4..5b1d15fe4f 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -614,12 +614,30 @@ static inline bool strip_suffix(const char *str, con=
st char *suffix,
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
=20
-static inline size_t st_add(size_t a, size_t b)
+
+/*
+ * Help Clang; GCC generates the same instructions for both variants on
+ * x64 and aarch64.
+ */
+#ifdef __clang__
+#define st_add_overflow __builtin_add_overflow
+#else
+static inline bool st_add_overflow(size_t a, size_t b, size_t *out)
 {
 	if (unsigned_add_overflows(a, b))
+		return true;
+	*out =3D a + b;
+	return false;
+}
+#endif
+
+static inline size_t st_add(size_t a, size_t b)
+{
+	size_t result;
+	if (st_add_overflow(a, b, &result))
 		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
 		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
+	return result;
 }
 #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
 #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
=2D-=20
2.54.0

