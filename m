Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD918CBE1
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 02:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850304; cv=none; b=fmh9V4iq9OuEKkO7kg4qOHjMSs66/9YgS/PJppv0y+o3nHltlvAxR3kWS6ZQYPRySFyVuHzj3+rszkq1DvFuJYpZ8IEXidwvgOl3rDdNUmCOtLqTTbKWyjncogzAwSiHhsg9T3kv4aglDysCgsChFLrUfs7m2vz5mQCbZ3LMgH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850304; c=relaxed/simple;
	bh=ZprQjKnVJs/lu+9Mhm6GWcwy2R5m21P3b6NrwU/ebz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBvzIMq9pALVNd04uOd9svMXQRCOe7igtWANubPdkwFQZamEJpLvjKPLjXLHy/l6/oGdRStDg9o/diJ/gSLra2e4JiYjMo04IhR+0kj7GZNKIgjpkMX72IO5lxSzCiaf8OmUwxTbsWNjBn9LZfO5/dZ9yJRFichxqgCyepnoL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qd2M9dyP; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qd2M9dyP"
Received: (qmail 14345 invoked by uid 106); 7 Mar 2026 02:25:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZprQjKnVJs/lu+9Mhm6GWcwy2R5m21P3b6NrwU/ebz4=; b=Qd2M9dyPS5S+Jxu8l2NhSZK0nDcVfjZSML68QmkQIQm/5DiN3iMIgiNioJq/Im87R9VnEt8O3RZ5QOiiGgcCzMsFOhOBF81JGGuoMbEjE1p68vpNIemDix3uz12sP0GqyU+a7V7JkcBlU3YmmGf2A6UzQ4t+s0wNdN31HZzQEBf4Mddwx8F2pd3ywG7IUlY9CZ3yTbeDvtxvLR6K394peZYuFkP7bBFzlgz8RmzI5lBUDp1S4pkto0Zj34O0Ksh7rrVBWhNKU0pPH5E0AUgLijRzz2424AEaH6fs+Bwx/oYuDsf3pJCWLnzMO0E8uJ08PIMSNMeO0QkEbXVLmhPPhA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Mar 2026 02:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 413311 invoked by uid 111); 7 Mar 2026 02:25:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Mar 2026 21:25:03 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 6 Mar 2026 21:24:59 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 3.5/4] object-file: fix mmap() leak in
 odb_source_loose_read_object_stream()
Message-ID: <20260307022459.GA693632@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
 <20260305231305.GD2901305@coredump.intra.peff.net>
 <xmqqqzpwv3t7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqqzpwv3t7.fsf@gitster.g>

On Fri, Mar 06, 2026 at 05:14:28PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -1600,6 +1600,7 @@ BASIC_CFLAGS += -DSHA1DC_FORCE_ALIGNED_ACCESS
> >  endif
> >  ifneq ($(filter leak,$(SANITIZERS)),)
> >  BASIC_CFLAGS += -O0
> > +NO_MMAP = CatchMapLeaks
> >  SANITIZE_LEAK = YesCompiledWithIt
> >  endif
> >  ifneq ($(filter address,$(SANITIZERS)),)
> 
> And of course, this "breaks" the leaks job at CI without being the
> true culprit.
> 
>     https://github.com/git/git/actions/runs/22786105918/job/66103114142
> 
> My bisection between v2.52.0 and v2.53.0 with the following
> 
>     $ git bisect start v2.53.0 v2.52.0
>     $ git bisect run sh :doit
> 
> where :doit has the shell script attached at the end of this message
> blames this commit.  I didn't dig further than that.

Interesting. I ran my tests on "master", which would include v2.53.0,
and it came up clean. But I use gcc locally; switching to clang does
indeed report a leak for me.

Even more curiously, if I try testing the tip of jch, then gcc does find
the same leak! Bisecting, it starts to find the leak as of 1f3fd68e06
(odb/source: make `read_object_stream()` function pluggable,
2026-03-05).

There is a real leak here; the fix is below. But curiously, it is _not_
the fault of the commit you found by bisection.

In the test in question, we die() shortly after the leak happens. We've
definitely left the function that holds the pointer to the leaked
buffer, so it's a true leak. But my guess is that the leak detector
doesn't quite know which parts of stack memory are valid or not when we
die(), so it scans the whole thing looking for plausible pointers to
allocations. If it gets "lucky", then the stale out-of-scope pointer is
still in stack memory, and we consider it still reachable.

And whether that happens or not can depend on the compiler, or even
compile options. And as the code is refactored to use the more abstract
odb API (and call more functions), it is increasingly likely that
something else has re-used that bit of stack memory.

So that's why the leak "appears" in 4c89d31494 (streaming: rely on
object sources to create object stream, 2025-11-23) for clang, and
1f3fd68e06 (odb/source: make `read_object_stream()` function pluggable,
2026-03-05) for gcc. But it was really there all along.

Anyway, here's the fix. It should probably be slotted in before patch 4
(which turns on NO_MMAP for leak-check builds).

-- >8 --
Subject: object-file: fix mmap() leak in odb_source_loose_read_object_stream()

We mmap() a loose object file, storing the result in the local variable
"mapped", which is eventually assigned into our stream struct as
"st.mapped". If we hit an error, we jump to an error label which does:

  munmap(st.mapped, st.mapsize);

to clean up. But this is wrong; we don't assign st.mapped until the end
of the function, after all of the "goto error" jumps. So this munmap()
is never cleaning up anything (st.mapped is always NULL, because we
initialize the struct with calloc).

Instead, we should feed the local variable to munmap().

This leak is due to 595296e124 (streaming: allocate stream inside the
backend-specific logic, 2025-11-23), which introduced the local
variable. Before that, we assigned the mmap result directly into
st.mapped. It was probably switched there so that we do not have to
allocate/free the struct when the map operation fails (e.g., because we
don't have the loose object). Before that commit, the struct was passed
in from the caller, so there was no allocation at all.

You can see the leak in the test suite by building with:

  make SANITIZE=leak NO_MMAP=1 CC=clang

and running t1060. We need NO_MMAP so that the mmap() is backed by an
actual malloc(), which allows LSan to detect it. And the leak seems not
to be detected when compiling with gcc, probably due to some internal
compiler decisions about how the stack memory is written.

Signed-off-by: Jeff King <peff@peff.net>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 3094140055..ab2fb9c4eb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2197,7 +2197,7 @@ int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 	return 0;
 error:
 	git_inflate_end(&st->z);
-	munmap(st->mapped, st->mapsize);
+	munmap(mapped, mapsize);
 	free(st);
 	return -1;
 }
-- 
2.53.0.791.g8baeb4ea4d

