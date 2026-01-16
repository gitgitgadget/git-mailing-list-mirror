Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F9F1E1E12
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581953; cv=none; b=ulSoLbwYm4/Ih0fbYglaczo6SI1KuxOvLk10+XM3rGkVlFpBMRsf1Zlvui+q1XmyWBlV5jSIVVFhA/Q0tq5XL4JgJ0c/mk+dIiOAi7omI0TF1cufxC+CJKqVi2k4bjnmUSaNKYhf48yQ1PZ+8EGpMt4JjZngAy/9G7P3jZUb9to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581953; c=relaxed/simple;
	bh=CNhhWAsmTye6aWWcaChxpU27N6FPGlEsBB3QG3e8t38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsrokPKo82xE2FGz/HQk8IgsmlZ3aZDVxMXDFwRz4MuFSga+W8xOhPiljKctOWNynhon0c7os+Ah113S6XwdLrFqA9tbJz6y4xjzNFqEWsggdNWhnx7jvtAkQY/15RtGaU1fir9z/UUVpUN4b2yLr+heYT8sEA/Ray0t+LLZAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SxcZzzbR; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SxcZzzbR"
Received: (qmail 59417 invoked by uid 109); 16 Jan 2026 16:45:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CNhhWAsmTye6aWWcaChxpU27N6FPGlEsBB3QG3e8t38=; b=SxcZzzbRb5pvKceS2+MvD/1OsNvbhoVKPLEPy8pRNFpVBvFKTIM3ClR1QOOYKmBhS4z+W7I0jFeOzevJ7UYe0+k8HMVJzwtfZEW0KwRGHowJTHpt5myrPxf1jSdjDTYOrr0u58RS7L1471R47sOYdY40NHsUPKbtUbN6uYTATjza0jDGzAeV59H9aHasNwfHISc8tMmQmThdb49zKPAGJhvw678kCUMCzq8qBa8kcLFS+xU9O8YyIw+WH+xglDA/2XMp66E631P2qkfeXjU+UqE0c/Z2FAy3MrZrHlHjofzZNLFy7eIAqfKQi3Qne+EeRcO8ybFP6LkvVmKe38fU7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Jan 2026 16:45:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 93702 invoked by uid 111); 16 Jan 2026 16:45:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 16 Jan 2026 11:45:51 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 16 Jan 2026 11:45:49 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] cat-file: only use bitmaps when filtering
Message-ID: <20260116164549.GA1636797@coredump.intra.peff.net>
References: <20260106102558.GA68914@coredump.intra.peff.net>
 <aV4Xa9ceY4ahYj2m@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aV4Xa9ceY4ahYj2m@pks.im>

On Wed, Jan 07, 2026 at 09:20:59AM +0100, Patrick Steinhardt wrote:

> > -	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> > -						 batch_one_object_bitmapped, &payload)) {
> > +	if (opt->objects_filter.choice != LOFC_DISABLED &&
> > +	    (bitmap = prepare_bitmap_git(the_repository)) &&
> > +	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
> > +				       batch_one_object_bitmapped, &payload)) {
> >  		struct packed_git *pack;
> >  
> >  		repo_for_each_pack(the_repository, pack) {
> 
> Yeah, this seems like a reasonable change to me. I would've preferred to
> avoid the assignment in the conditional, but other than that this looks
> good to me.

Yeah, I tried to rewrite this to avoid the assignment-in-conditional,
but the logic gets even more convoluted because we need to get to the
"else" clause from multiple places then.

I do think that the for_each_bitmapped_object() interface is making this
a bit harder. Before it was added, the main bitmap entry point was
always prepare_bitmap_walk(), which opened the bitmap file itself (and
only after doing the cheap can_filter_bitmap() check).

But here that doesn't quite work, because we need the bitmap_index to
persist after the for_each_bitmapped_object() call so that we can check
bitmap_index_contains_pack() on it.

I was tempted to suggest that for_each_bitmapped_object() should return
the bitmap_index itself, and then this code would become:

   if (filter.choice != LOFC_DISABLED)
	   bitmap = for_each_bitmapped_object(filter, cb, &payload);
   if (bitmap) {
	   /* we iterated those objects; check for other packs */
   } else {
	   /* we did nothing; look at all packs */
   }

   free_bitmap_index(bitmap);

which is not too bad. Mostly I wanted to make the fix as small as
possible, but I was also a little hesitant to tweak the API when we have
only one caller (and we don't know what a second caller might want).
But we could always revisit it on top.

-Peff
