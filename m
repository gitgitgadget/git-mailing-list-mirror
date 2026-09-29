Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F597411F80
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664907; cv=none; b=FkBax/GEikAyd1TltkEwfrfmwmPQa6pe7VnZsL3T1bRDHY8N4t5/+ifayqi0EpdjCidsjgUtpVgQGFglgFUpmR0+zxn/yol5fGYXQi3tjY8QdXqLioxsokqZu3Qj2NVGgXfsVhdfWi96y4fks3clBQHPjfUXKeRQjv0O3iWy9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664907; c=relaxed/simple;
	bh=0QTY2+nqSPgGKSVMyghQsxcpI7u2eKKeYft18bKzzGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3ZNPtA+bwzmUJ1ZgPQch2EbFxfVtTgBl4Oy30HUrIzCavLrj0bSPX6m1Or+g+DlsjR7KaOHlyH2/G7JEMYB206+/SxK9Hv0zHR6lg+h/oyREKaRCLws6U4XT5IfU6Ih5Fmo2YA/9zpfo5THA4Eq9ZD8EoRBoGuRw8fhIqXsRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LuqAIFKJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LuqAIFKJ"
Received: (qmail 70168 invoked by uid 106); 29 Sep 2026 06:55:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0QTY2+nqSPgGKSVMyghQsxcpI7u2eKKeYft18bKzzGs=; b=LuqAIFKJr1MZ7R4K/EeOuL0vNQ/feRnTGu2A3JGapFc4rtyx0SQRt5LebwBw+l8Z65SfEEBXFqpIb7/AXePOr6WT0FmNPr0/uWoDs8a08hwDx5c/0tsOMBTSy3EDr9vclO0fBH+fwT+SMLbhR418JU/vOGCoEOwK6LxEnRMCnEaIRLtXDRm31xTTQ+qaZ6t8gOBmithXhKeTm01pw4PWRMnvtLYmInXi+ToliPIHF/MbcwmPrmcqeRb8d39Rf+qV9VxutTyI1azwDntVs+PAcR1OFwf9ydZLn+Cx/eFxd4pgGlNFM35aLkyNfYiPqHRljxppmH7P6O2m0vQodrXlUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 06:55:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 289561 invoked by uid 111); 29 Sep 2026 06:55:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 02:55:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 02:55:04 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/5] xdiff: NUL-terminate buffers read by read_mmfile()
Message-ID: <20260929065504.GE1697497@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929064935.GA1276867@coredump.intra.peff.net>

Since an mmfile_t is a ptr/len pair, our read_mmfile() allocates exactly
the number of bytes we claim to store. But in many other places in Git,
we add an extra NUL "just in case", which can help avoid read overruns
due to off-by-ones or the use of string functions.

I don't know of any path that would benefit from this, but I noticed it
while converting ll_ext_merge() to use read_mmfile(), since its original
code did add a NUL byte (even though I cannot find any case where it
would have mattered). Let's teach read_mmfile() to add this defensive
NUL; it probably doesn't help anything, but nor should it hurt.

Note that the matching read_mmblob() doesn't need the same treatment.
Its buffers already have a NUL from the object-reading code (which uses
the same defensive trick).

As a bonus, we can get rid of the hack in read_mmfile() to handle empty
files by allocating a single byte.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is obviously optional, which is why I put it last.

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
2.56.0.325.g545d7e68bc
