Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BAE2FFDF0
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457151; cv=none; b=RnzuJVmvwwyn3kffT0QqFhE2n3hH5C0y9/wtNM2BPn4wbvbClQb/fSOeKKaBZdlYkufFJ7AzBRA81EZgb26/3xnq8KCifZVhnUWdTbG5NR+6wFKACR4ArO3IcUMzYsjw5nerLJ7mHbQL16yN+OpRG7TG0ZSWPqllXpuGUlPXTn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457151; c=relaxed/simple;
	bh=o8JpBBmlv4Qf5WhYNN2mJnIcA39Fq4jIu7HXhTR3tBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGnzsmN7nPDky2TBXoM0/utR8ovtCA63CCHBpwFyFr9MgKqkXX56pnLCqT2XIjbNzeWJf08knSBy9y3Lh4uOQmoTSqeE9RPjdokSmnJNJvVi0pzLUGwWismkf5NqlrL42B2JEy/TkmZnCu/vtW+gyUh6LFbjJtoraKkjgiz24K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JcKrZ1EA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JcKrZ1EA"
Received: (qmail 19814 invoked by uid 109); 18 Nov 2025 09:12:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=o8JpBBmlv4Qf5WhYNN2mJnIcA39Fq4jIu7HXhTR3tBo=; b=JcKrZ1EAiZ3jVUo7S7+GyhnS4dS4eAJdy5xxfinYbxLpiTjaPpqP0PjsySsZcgTXV4WeqjC0B7cfAEomq5NViSJXDKPCiEiPZEVTsan1U17KXHjBbqeG6PO4AKePTbKi5iW5/LjeJe88GDzDfahIemEip4G4f1DmBMBli68M8nracVDGKIXtlzvWkUTO3fcIunFlSUhyonMiTsxGhwRIaZeNmy+AD9bp35ZzAJh4K1BCBkqkofTT749uGv5IeSaZKKmO4B0TjwfU85AaHZ+O1kEKegqS5Dn5kciuX+YOAtUUd19xpFrJqaUpqhwCF/awxLJAmAhhlMwPD94ydMXbtg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27416 invoked by uid 111); 18 Nov 2025 09:12:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:30 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:25 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 7/9] fsck: remove redundant date timestamp check
Message-ID: <20251118091225.GG529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

After calling "parse_timestamp(p, &end, 10)", we complain if "p == end",
which would imply that we did not see any digits at all. But we know
this cannot be the case, since we would have bailed already if we did
not see any digits, courtesy of extra checks added by 8e4309038f (fsck:
do not assume NUL-termination of buffers, 2023-01-19). Since then,
checking "p == end" is redundant and we can drop it.

This will make our lives a little easier as we refactor further.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 2ee72d573d..266c965cec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -920,7 +920,7 @@ static int fsck_ident(const char **ident, const char *ident_end,
 		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
 		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
-	if ((end == p || *end != ' '))
+	if (*end != ' ')
 		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
 	if ((*p != '+' && *p != '-') ||
-- 
2.52.0.278.gadc6434dc3

