Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687BC392837
	for <git@vger.kernel.org>; Mon, 18 May 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779135921; cv=none; b=DW3CPSqjddiJ0c1gw577o7/oGgQcNSvvi4SdG9YDtp3eghdzvUwin9lLPxcr/K+pMCfC4insc5MGLJAgSduNQECLGSfpOVjhf8hZMUQG81sRCDvr3b66qzWIQDgZ/RpEgbDWszSbRd8gQ1FUHzZ8/D6B9JbumBhcnSnlT24CGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779135921; c=relaxed/simple;
	bh=AvLL3bBOOXvo93HWHMBdBaLMiBVQ+EAqfU9bF4gifFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfOUWfUrlrUIVMZBrE4qALcj0Sb2zxCj1D38ZZYP0Vt4f6aljws96r8JNK17FHn2LKCiEPjSrZ9e+YnpX5+5cX8L3nLmRw4G77GHJWqi9EoDYls1vhtF3BcIEzYnhdcCYWrhQZZngmtRa7dsfUfNSAo1e4y4oiSwIQkpmArYH7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=sFXTeY98; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="sFXTeY98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779135908; x=1779740708; i=l.s.r@web.de;
	bh=2Q2JJv5f1iEolJ33vDzJDsSUJy+epCqZfyB0zdlpGAE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sFXTeY98xheVXB1Wzu63ARSRAV6Ud0K4Lne85W3o8LPSieVDedV3ooHXajlt32Rx
	 EW5P2S9UnGb7+UGjeZYDbUCvbpR33aGw/LK+MfP+CB1cBZjwFp4OMQO231njxMncF
	 ClvpQrd0uKXfYtnvRJXuT/BMuoZKhYwF2kBv4Q9Yb47kWk72QZ7AweBWl6If/mL1s
	 HpYcHg1geVvcYoPKZpfuD+FYFYM/FxGZek8WJtDvZF2zc5yu14ao355Z1dfJ8EWLn
	 0A53/D3chNuCFb9jHng1IMUv+J1LPXA/wDcaJVz/D6/XG/p6IIy+VC+xlylKdbJTl
	 HonnASY76Mwl+BxhfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLAVa-1wg3RR3bFa-00Vchd; Mon, 18
 May 2026 22:25:07 +0200
From: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] use __builtin_add_overflow() in st_add() with Clang
Date: Mon, 18 May 2026 22:25:00 +0200
Message-ID: <20260518202502.25682-1-l.s.r@web.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
References: <c6e9b337-c4fc-4cbd-ac32-e8d3814749b0@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kdN5KnpljGuaaoyXtrVirjOSOw9TWJrEINOLhrvct1E/yg+aRs+
 bFyZsduJLBoFzUwGIauS/h6hz9oq5kTjn66ZYgLwODjXJVxNaI37ECq5HMRKeSLrbz2ErQo
 ne3ShkBjE2q+aiRugNBwRVQN/UKht6E5KkmV5OSF7AikiGQ26QCPRLrg7zasSV4JAVeMGzD
 JqXTOnyfOxEU3vcZf7A+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sJGkMjk0l1U=;LgbxZTeKESd+9FPmqeGqmSF6qod
 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
 U88ntb8fZCjV5FlbrCqpJHnPhxU=

Changes since v2:
- Pass variable instead of st_add3() expression to ALLOC_GROW.
- Add the helper st_add_overflow() that mimics __builtin_add_overflow()
  for size_t to avoid duplicating most of the definition of st_add().

  strbuf: use st_add3() in strbuf_grow()
  use __builtin_add_overflow() in st_add() with Clang

 git-compat-util.h | 22 ++++++++++++++++++++--
 strbuf.c          |  6 ++----
 2 files changed, 22 insertions(+), 6 deletions(-)

Interdiff against v1:
diff --git a/git-compat-util.h b/git-compat-util.h
index aa088d04bb..5b1d15fe4f 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -614,25 +614,31 @@ static inline bool strip_suffix(const char *str, con=
st char *suffix,
 int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
=20
-/* Help Clang; GCC generates the same code for both variants. */
-#if defined(__clang__)
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
-	size_t sum;
-	if (__builtin_add_overflow(a, b, &sum))
-		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
-		    (uintmax_t)a, (uintmax_t)b);
-	return sum;
+	if (unsigned_add_overflows(a, b))
+		return true;
+	*out =3D a + b;
+	return false;
 }
-#else
+#endif
+
 static inline size_t st_add(size_t a, size_t b)
 {
-	if (unsigned_add_overflows(a, b))
+	size_t result;
+	if (st_add_overflow(a, b, &result))
 		die("size_t overflow: %"PRIuMAX" + %"PRIuMAX,
 		    (uintmax_t)a, (uintmax_t)b);
-	return a + b;
+	return result;
 }
-#endif
 #define st_add3(a,b,c)   st_add(st_add((a),(b)),(c))
 #define st_add4(a,b,c,d) st_add(st_add3((a),(b),(c)),(d))
=20
diff --git a/strbuf.c b/strbuf.c
index bb04d3910e..8610965d53 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -106,9 +106,10 @@ void strbuf_attach(struct strbuf *sb, void *buf, size=
_t len, size_t alloc)
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
 	int new_buf =3D !sb->alloc;
+	size_t new_len =3D st_add3(sb->len, extra, 1);
 	if (new_buf)
 		sb->buf =3D NULL;
-	ALLOC_GROW(sb->buf, st_add3(sb->len, extra, 1), sb->alloc);
+	ALLOC_GROW(sb->buf, new_len, sb->alloc);
 	if (new_buf)
 		sb->buf[0] =3D '\0';
 }
=2D-=20
2.54.0

