Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF2C4AF168
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811856; cv=none; b=EGrq3MQqxgxGSKQqaTYgBjKFroUbdLJy7Y9J0J8QTNxbQoLtBwaGazoif/kLTLCfngiya3SHBz6JCQeItg6QkyLbWMdNevGXHjc9EZnX+2PhJzkA0dYnfZtx4wIqBfEqZtZOpNtP5Vp7eLi2ffm5as8ymwMymrNzwzEFcELldKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811856; c=relaxed/simple;
	bh=jGryypwkhCBsaJd8soTciwZ/u/vnJZS9KrnMH1WIwW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4rebQOSAyFzt101H76p13ydtozwocyVBuvltR/83moQZbPjxsUUte+uhJ+5zhp3mDS8WnjsxcG6LMry5tFsqoOMIfa0UC9ZOE21LCOeIrfyiqGRxumqybkDH75XMKyw05W6IkP4+Y0iLu0zhgp3xzSnMW5cB4KTc2VCg+7t8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CzmRgNYM; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CzmRgNYM"
Received: (qmail 8191 invoked by uid 106); 30 Sep 2026 23:44:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jGryypwkhCBsaJd8soTciwZ/u/vnJZS9KrnMH1WIwW0=; b=CzmRgNYMQ7mKm1Chb4N1L+cEi4fnrNcL/oZJUvsEZlD57Typ9NM01tMypaBbItzSz6+1egpkUMuW/s66DaCSry1Q+PyqcheqBDsY3vpwDez/D3kbPmwmels17zak9FeebnBBe4Ix8HlsX+/hiFNekdPCNeK6OfcRQupAYQaqUEelak3ZDReNpLp/t/4zc4/D8AW2wBXT0AaVDWoedmlFdNC2FPkIedxgP+Tk971cDbYQCD9yVq5ZItxKrxx57kP5noEKkLQrqzMNUCnQkX6kJPMnkRHh0aOXGVqsOPhc3n4QN/eGpV4/kYZ53YlIz+NuYs35BPXqiQnQRLSzkWs6lQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:44:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20840 invoked by uid 111); 30 Sep 2026 23:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:44:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:44:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 4/7] xdiff: NUL-terminate buffers read by read_mmfile()
Message-ID: <20260930234413.GD1347555@coredump.intra.peff.net>
References: <20260930234348.GA1340390@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930234348.GA1340390@coredump.intra.peff.net>

Since an mmfile_t is a ptr/len pair, our read_mmfile() allocates exactly
the number of bytes we claim to store. But in many other places in Git,
we add an extra NUL "just in case", which can help avoid read overruns
due to off-by-ones or the use of string functions.

I don't know of any path that would benefit from this, but I noticed it
while converting ll_ext_merge() to use read_mmfile(), since its original
code did add a NUL byte (even though I cannot find any case where it
would have mattered). Let's add the same defensive NUL in read_mmfile()
by using xmallocz() instead of xmalloc().

Note that the matching read_mmblob() doesn't need the same treatment.
Its buffers already have a NUL from the object-reading code (which uses
the same defensive trick).

As a bonus, we can get rid of the hack in read_mmfile() to handle empty
files by allocating a single byte.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff-interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index bc340d5a8a..b3e9f1952b 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -166,7 +166,7 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	if (!(f = fopen(filename, "rb")))
 		return error_errno("Could not open %s", filename);
 	sz = xsize_t(st.st_size);
-	ptr->ptr = xmalloc(sz ? sz : 1);
+	ptr->ptr = xmallocz(sz);
 	if (sz && fread(ptr->ptr, sz, 1, f) != 1) {
 		FREE_AND_NULL(ptr->ptr);
 		fclose(f);
-- 
2.56.0.354.gb6b32d5be5

