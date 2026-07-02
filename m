Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A8C2DC79F
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979454; cv=none; b=sBLwMYX1Nx2Mma+evfJLF3iwqMNwIp6jTp8DhGivdbO/yYB9RkGapP307e7zDEq3bJ+DdeJLRTy0bu5U/GaEHuOKa3fD5vs9uxm+v8Y4tATh2Tz4PXHOb3wvSiIxmHrnxvTNnk5V++soQmG3zzuD3vERejUmwArGznICRQ6Jc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979454; c=relaxed/simple;
	bh=BxygHjnMuBam1abAqFvNxHbUb79fidCdtQf5HkY+/Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa443JOPL3TFehTUaIn5/8WJE+ww3MU7FM8OVvr8Uhe/VevWqfxNT9z1yWa222bTkzYCagkbb63NXW/Qgg7K1wldKg2kfgDUuPzuw/SUIqwy651gHth8OAyo+1NkCmit/74rkFdCIISwngr13btXx4K/98qPb+RYP8rAvmqye/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KGsz7VPf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KGsz7VPf"
Received: (qmail 85637 invoked by uid 106); 2 Jul 2026 08:04:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BxygHjnMuBam1abAqFvNxHbUb79fidCdtQf5HkY+/Cw=; b=KGsz7VPf8meRnhtKol70gfSeNsNUyNzjCydmgj+Ztn1MYASGWZUd0ErRbfVbFG47M+Na3H9iG7X88B7cpbVuvfDdjgGyvAUllMYUEjd7Muj2WJSKEQy9bs8HrYB4W1MisL606c/i1+YVSnJRAD8CwqgmmljlI9dLLEfwuo3WOmfkKlKwX/yDV5qsXPZCp8QTWYHqIArwa7LefXK9y8iTq2giaAsSLKhpaygO+9d8AmgeWESldnsM+bA8iGlVkZR0Dg8DGSmsxyPGJ/R1iCZveNs0ymuag7tSZ2iZ+yQOZLKzErHEWVymt8BBbV9br1n18Ocd9kZCiUluGddL8rPKXQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jul 2026 08:04:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 178228 invoked by uid 111); 2 Jul 2026 08:04:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Jul 2026 04:04:11 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Jul 2026 04:04:11 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/9] patch-id: discard hash when done
Message-ID: <20260702080411.GE2029434@coredump.intra.peff.net>
References: <20260702075234.GA1548258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702075234.GA1548258@coredump.intra.peff.net>

When computing a patch-id, we have a flush_one_hunk() helper that calls
git_hash_final() on our running hunk git_hash_ctx, and then
reinitializes that context for the next hunk.

When we run out of hunks to look at, we return, discarding the
git_hash_ctx. This can cause a leak if the hash implementation we are
using allocates any memory during its initialization. This includes
OpenSSL >= 3.0, for both SHA-1 and SHA-256. Normally we would not use
SHA-1 here at all, as we only recommend using non-DC implementations for
the "unsafe" variant (and patch-id, though they probably _could_ use the
unsafe variant, were never taught to do so).

But it is certainly a problem for SHA-256, which you can see with:

  make SANITIZE=leak \
       OPENSSL_SHA256=1 \
       GIT_TEST_DEFAULT_HASH=sha256 \
       test

That results in leak failures of 60 scripts, 57 of which are fixed by
this patch (basically anything which runs rebase will hit this case).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/patch-id.c | 1 +
 diff.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 2781598ede..57d9bd4a65 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -173,6 +173,7 @@ static size_t get_one_patchid(struct object_id *next_oid, struct object_id *resu
 		oidclr(next_oid, the_repository->hash_algo);
 
 	flush_one_hunk(result, &ctx);
+	git_hash_discard(&ctx);
 
 	return patchlen;
 }
diff --git a/diff.c b/diff.c
index 2a9d0d8687..1568f0ed9c 100644
--- a/diff.c
+++ b/diff.c
@@ -6987,6 +6987,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		flush_one_hunk(oid, &ctx);
 	}
 
+	git_hash_discard(&ctx);
 	return 0;
 }
 
-- 
2.55.0.418.g37da59dd42

