Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FC1990A7
	for <git@vger.kernel.org>; Wed, 27 May 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876250; cv=none; b=PaxkmGN05Hwsfc10XSEeYuqzNPNg8mriUJQ+t0UC9LDdUAPOjum0urcwalgMW7thWSIq2BRh1rgFYgDm4tLrY3iMhnzz9bktybyr+CL7bNPnkKctRouw9h+XEgx4zW5vCMBliHV9BFHRMnA8BkYhw6Jl9ON8CkPzg8oI+qBLM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876250; c=relaxed/simple;
	bh=WwpHzt1aJk1gMlc9HcUSRpzC/uYpEIrdpFARaxC9oto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHupJqkx5vK+mTCumzu5AyAOPphFIjKpyRTKO1UpGOUxB/6YNyucmCBtnJm/J460BdG6zUxhHTsHLkI2kHWF+P1CyrNZvfBskTno4tiSFvcwFt1+/kDVSuUiFH/MPjP8L8R9xSq9Jt/tkfJNyA45XljUA5whRgb26SqYvb5YY/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DF5hxOrQ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DF5hxOrQ"
Received: (qmail 29160 invoked by uid 106); 27 May 2026 10:04:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WwpHzt1aJk1gMlc9HcUSRpzC/uYpEIrdpFARaxC9oto=; b=DF5hxOrQp4zwxYEQjMmalSWc4smELwjH49mbLUfR19GilRoRX6nFr7HD8PJKIYvuJLQXQ3EcoMfhahQVHdRdU/DYfZswEy0YiSy7Wm8G3qg5QBufan/zndLcv28Gzo5w0nHdP1Ua5W9LriRtuHiS96MDhBp9J28TRhdVDm2GAK7dAMhrMX6qZghAxDZxhIywkKLnxicxpeg++yTGSgDLtDh84fySpEV5rtzzicqoAmghjxz6JCHzGjBLnD2aM31YnT+WufBvHZS2WFBaPnFhN/4E30gq8WtkW7uii9klDJcjeMYqFx35i7Rl0gYOrInPIeBe92HPYJSkDrBRcOPcqQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 10:04:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72698 invoked by uid 111); 27 May 2026 10:04:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 06:04:11 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 06:04:06 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 6/8] pack-bitmap: sort bitmaps before XORing
Message-ID: <20260527100406.GG981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <b0a4f31353a7053ab37b6d8c8f22c69bcfadfe50.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0a4f31353a7053ab37b6d8c8f22c69bcfadfe50.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:50PM -0400, Taylor Blau wrote:

> Reachability bitmaps may be stored as XORs against nearby bitmaps, up to
> 10 away. However, when callers provide selected commits in an arbitrary
> order, the writer may miss good ancestor/descendant pairs and produce
> much larger bitmap files without changing query coverage.
> 
> Sort the selected bitmaps in date order (from oldest to newest) before
> computing XOR offsets, leaving pseudo-merge bitmaps alone (which we will
> deal with separately in following commits).

That order certainly makes the most sense. I'd have thought we ended up
there incidentally because of the order in which we consider the
commits, but perhaps not. I wonder if this got much worse when we
re-wrote the bitmap generation code a few years ago.

That was in v2.31.0, I think. Repacking linux.git with bitmaps, though,
I couldn't find any difference in size between v2.30 and v2.31. They're
both ~67M. But that also didn't shrink with this patch, either.

If you have some spare CPU cycles to burn, I would be interested in a
comparison of the bitmap size of your test repo using v2.30.0, v2.31.1,
and this patch.

> On our same testing repository from previous commits, this change shrunk
> our selection of 1,261 bitmaps from ~635.46 MiB to 176.4 MiB for a
> ~72.24% reduction in the on-disk size of our *.bitmap file. The time to
> generate the smaller bitmap file decreased by ~3.69 seconds, though this
> is likely mostly noise.

Certainly good numbers. The obvious follow-up question is: how does the
reading side fare? I'd expect it to be a little better, if only because
there are fewer bytes to consider when XOR-ing. But if there's some
hidden assumption we're missing, then it could get wildly worse. It
would be good to confirm that that didn't happen. ;)

>  static void compute_xor_offsets(struct bitmap_writer *writer)
>  {
>  	static const int MAX_XOR_OFFSET_SEARCH = 10;
>  
>  	int i, next = 0;
> +	int nr = bitmap_writer_nr_selected_commits(writer);
> +
> +	if (nr > 1) {
> +		QSORT(writer->selected, nr, bitmapped_commit_date_cmp);
> +
> +		for (i = 0; i < nr; i++) {
> +			struct bitmapped_commit *stored = &writer->selected[i];
> +			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
> +							   stored->commit->object.oid);
> +
> +			if (hash_pos == kh_end(writer->bitmaps))
> +				BUG("selected commit missing from bitmap map: %s",
> +				    oid_to_hex(&stored->commit->object.oid));
> +
> +			kh_value(writer->bitmaps, hash_pos) = stored;
> +		}
> +	}

OK. It took me a minute to wrap my head around this. The real work is
done by QSORT(). But because we maintain a hash pointing into that
array, we have to go through each hash entry and fix up its pointer.

Looks correct.

-Peff
