Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0677320DF4
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261907; cv=none; b=Sr8dCz0Tsv/CNwYStVyIOLdm81K9iiWxuiGymXWo+t1M/u4xoID+fjOXhp4C1uEMtyIQNIc4dmimw1/o46i65gi5OZdrBnB9hRcowdhjDyhxP4c8aJcAgXw+BCHAJzzWGkWANqHGTvMbGlVFPnB3hlRBqSECiP4mfN5Z+BfREFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261907; c=relaxed/simple;
	bh=rYpVbYe2Tnu9OnTZBEbYirPtZoi/bGGD0bZjsjo+uKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9uPT9aQBLI4eCWkeJ0vXRYTCPvOuxroKhlZgz3X+ZfiK/f9XH3Mq6C0c+V3B7xLcB0QZEdRkRhf9VWPrM+WUozndjaZzs2mGbYnq2/DAybI9r23K9KCSWxiXLKAvNxaMvCOuoIxFr9e13uRMYad7dyAzSdwj8saR4k2nhnqRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MmaPWFXB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MmaPWFXB"
Received: (qmail 26427 invoked by uid 109); 18 Mar 2025 01:38:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rYpVbYe2Tnu9OnTZBEbYirPtZoi/bGGD0bZjsjo+uKo=; b=MmaPWFXBcLXniyvAb3BzcDhghF7AaBVEvLhI6R5Hxn52GkHMVZAERm+yHhKepGcgoz179hPZwlhAcY9MW/MgQ59t5Q7xu5q1FEF/ht70oBGnvtav7G+qGhTCpKWE1j0BrT69oOFRabdKyZ4bwutRFlnIXAtDzaBFAGs8DXyKzedHWshBxadlWJTvkrw/8gfIjMEDsPk1Ft7925plnqm5lsn1BHKZ8wPfrtXSTrzND0NU8Azyj1z/B1B4Qzbrz1yzcytBx+jU2bP8z875DUTj4vadejjVAjHKZcMekFjq5CH0ZkyeDwvThd+dYA/btFYwyHa/DNElrT0XKyq0qryfmA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Mar 2025 01:38:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3451 invoked by uid 111); 18 Mar 2025 01:38:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 21:38:24 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 21:38:23 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/13] pack-bitmap.c: teach `bitmap_for_commit()`
 about incremental MIDXs
Message-ID: <20250318013823.GC1471939@coredump.intra.peff.net>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <832fd0e8dc3a37e36b3d59085e448f8de84ce4b4.1741983492.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <832fd0e8dc3a37e36b3d59085e448f8de84ce4b4.1741983492.git.me@ttaylorr.com>

On Fri, Mar 14, 2025 at 04:18:31PM -0400, Taylor Blau wrote:

> The pack-bitmap machinery uses `bitmap_for_commit()` to locate the
> EWAH-compressed bitmap corresponding to some given commit object.
> 
> Teach this function about incremental MIDX bitmaps by teaching it to
> recur on earlier bitmap layers when it fails to find a given commit in
> the current layer.
> 
> The changes to do so are as follows:
> 
>   - Avoid initializing hash_pos at its declaration, since
>     bitmap_for_commit() is now a recursive function and may receive a
>     NULL bitmap_index pointer as its first argument.
> 
>   - In cases where we would previously return NULL (to indicate that a
>     lookup failed and the given bitmap_index does not contain an entry
>     corresponding to the given commit), recursively call the function on
>     the previous bitmap layer.

This makes sense, though it does make me wonder if we could/should store
a (midx/pack,pos) pair. I.e., a master hash table stored once for the
whole midx stack. And then you wouldn't need to recurse; it would just
be a single lookup.

Or would that work badly with the lazy nature? You'd need to load all of
the layers to fill it (rather than doing each incrementally). OTOH, if
you ask for the bitmap for commit X you're eventually going to have to
figure out what's in all of the layers as soon as you have a miss and
have to check them all. And I think the lookup table extension is what's
supposed to make that cheap-ish.

I dunno. It has been a long time since I dug into this (and the whole
khash-of-commits thing is just a hack around the lack of the lookup
table in the first place, I think?).

-Peff
