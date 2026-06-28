Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD3231827
	for <git@vger.kernel.org>; Sun, 28 Jun 2026 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782634033; cv=none; b=bGFAohkW8CDELtDaWSmqyBH+IshOGBBz42dWkCb6cJpUtWQOWoDucOyDv6G9SOw8nKV/ijpFDDpl7IZ/fPyjmplUIvSvh/n846bDT2PS6FVEkv/ystph9f5YenYjzlBsx19JGtVJjk8debvNwy/1T2QCqOHSHh6xHuag7nyuZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782634033; c=relaxed/simple;
	bh=XQnz78XkGa2bytwAciBn9K5geUeoINzuQgqUXmTRE8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reaSXHG5h5i4XoQ3KAfo5BrCrl8jArD9eeASobR7gTLEDz/4CAS3JWHgDnUypK72N8cRbKSmDkFWCJnQRqIXa1N/kNoq2hUfLySPAIGQGtVu3NTRfmhFGvt4H7J+CwOACbB4irrjRkUXti2V2BdBQ1favOZezdzFwVwWad14Oec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U0ADlHMu; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U0ADlHMu"
Received: (qmail 52271 invoked by uid 106); 28 Jun 2026 08:07:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=XQnz78XkGa2bytwAciBn9K5geUeoINzuQgqUXmTRE8Q=; b=U0ADlHMuxwdUsSU5A1b1hgjYc4I1FbN4PoOSLGXdMJ2IGhEP840pTExR+r6l3i+Qdu1lsZIGmdlbwvomsf2tBDo4syN/xU9f6p2YKSNz5MWFHkVl3oH/3NR0pTeGxGlP5hXYcJwc0kq9e2pR1VBkWXx3t0oNNKTUJajeX15y8BOiSUVprYl8G+mmT76nIpYyRF709fV72AJCAXACExC+D07dHaQhfpepU2osWy8+ai45W8jabBQQ9R362ur58ntztY45EusEjDwUVb52x8EAf8odx1lWNBDSWJoer6wv1+jBlqzLpqNyjHhA1FkvBQ/bTBF4eqlV9w4DUhoK4227zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 28 Jun 2026 08:07:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 111322 invoked by uid 111); 28 Jun 2026 08:07:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jun 2026 04:07:11 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jun 2026 04:07:10 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t5551: pack refs after creating many tags
Message-ID: <20260628080710.GC107826@coredump.intra.peff.net>
References: <20260628075716.GA3525066@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260628075716.GA3525066@coredump.intra.peff.net>

We have two tests that create 2,000 and 100,000 tags respectively.
After doing so, the resulting state can be a bit slow to work with when
using the "files" ref backend, as each of those refs is in its own file.

This isn't a very realistic scenario, as we'd expect most of those refs
to be packed. If they accrue over time along with objects, they'd get
packed by maintenance/gc runs. And if you have a process that creates a
ton of refs at once (like a big fast-import), the usual recommendation
is to run maintenance afterwards.

So let's follow that recommendation and pack the refs ourselves.
Unfortunately, this does not seem to produce an improvement to the
run-time of the test script! That's because after producing this state,
we perform only a few fetches of it. And packing the refs costs at least
as much as serving a ref advertisement (both have to iterate the refs,
but packing additionally must write .lock files as we pack).

My wall-clock time was slightly improved (but within the noise) with
this patch, but my user and system CPU time were slightly worse!
However, on a loaded system with I/O bottlenecks, it may be a net win.
That's somewhat of a guess, though.

It would be nice if we had a way to generate all of these refs without
writing so many individual files. But even if we taught the ref code to
write large cases directly to the packed-refs file, we'd still need to
take individual locks. The real solution is a backend like reftable,
which shaves ~30% off of the test runtime.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm iffy on whether this one is worth it.

If you apply just this patch without patch 2, then the run-time does
improve quite a bit. The cost of packing is amortized by the improved
performance for all of those subsequent tests (but after patch 2, they
never even see the unpacked state).

Likewise, I suspect this would make our timeout problems go away even
without patch 1.

So the whole series _could_ be reduced to just this one patch. But
hopefully the reasoning given in the earlier patches makes sense, at
which point this one is kind of superfluous.

 t/t5551-http-fetch-smart.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index cd851f24b8..e2e729216f 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -393,6 +393,7 @@ create_tags () {
 	tag=$(perl -e "print \"bla\" x 30") &&
 	sed -e "s|^:\([^ ]*\) \(.*\)$|create refs/tags/$tag-\1 \2|" <marks >input &&
 	git update-ref --stdin <input &&
+	git pack-refs --all &&
 	rm input
 }
 
-- 
2.55.0.rc2.353.gf769b6597e
