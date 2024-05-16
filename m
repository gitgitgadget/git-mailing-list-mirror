Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C204A11
	for <git@vger.kernel.org>; Thu, 16 May 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715899398; cv=none; b=C4pvYXcO7XvMH0S+5oJ9iX1pit0WyYS8gDhJWovaBRW9+9QXx4/5ICRV5alE+u1cRLY0+UaMR+EL9mIRm5YqQ8ujC5hQ6bDE8EN/SzXJXp5ycxh27Uv+sPY9wzDWhv0ODerVY7B47tuDYmAMypRQjxPe6EBmlTkyuffFlKnVxqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715899398; c=relaxed/simple;
	bh=llOiJWZJ0N/U7cHlgpX5eUIYO4ab1KmIO8wdTOyXSZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NSRKzAqVFXyMhlbI3+eTZs3QN/qFOoY5OIgxXh+wWeLbeO8y5RhUKCn+ZmGUVRV0JihwEQRL6KmzM0xXbNAZX2MCaisv4Q8lZ01wIi0SFBFHOyx8pq6nH+jv5BoAr14CEOdYwr6UZPL1MjV+Hs0vWDmSszjQcbCIeXfSnpLureE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PgLSxrkm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PgLSxrkm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4887429516;
	Thu, 16 May 2024 18:43:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=llOiJWZJ0N/U7cHlgpX5eUIYO4ab1KmIO8wdTO
	yXSZ8=; b=PgLSxrkm9nzabF6Ji+ufWOi5uocUrY9b8ncRFFx6N14UWNBTYOBnYf
	wM7TJnAZG9bYUluGpTi8R84CeFLq3jGd2GTCxRIQblWkLDizf7uehM+f7Tda5ItW
	t/TjNvto7JyJKzzIwmLgdYOp0C4V8WBpxVKsDiXekvQqNrtMkfxL4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4051B29515;
	Thu, 16 May 2024 18:43:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CBD2A29514;
	Thu, 16 May 2024 18:43:12 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 09/23] pseudo-merge: implement support for selecting
 pseudo-merge commits
In-Reply-To: <20240516080704.GA85197@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 16 May 2024 04:07:04 -0400")
References: <cover.1710972293.git.me@ttaylorr.com>
	<cover.1714422410.git.me@ttaylorr.com>
	<86a1e4b8b9be99563836d1539fbf2ed4c4a6920d.1714422410.git.me@ttaylorr.com>
	<20240513190340.GC2675586@coredump.intra.peff.net>
	<ZkK3KYkA6+zUxu9A@nand.local>
	<20240516080704.GA85197@coredump.intra.peff.net>
Date: Thu, 16 May 2024 15:43:11 -0700
Message-ID: <xmqqzfspml8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD50E59C-13D5-11EF-81F0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>     motivation. Something like (assuming we're following a section on
>     bitmaps in the "advanced packing" page, something I recognize also
>     does not yet exist):
>
>       Reachability bitmaps are most efficient when we have on-disk
>       stored bitmaps for one or more of the starting points of a
>       traversal. For this reason, Git prefers storing bitmaps for
>       commits at the tips of refs, because traversals tend to start with
>       those points.
>
>       But if you have a large number of refs, it's not feasible to store
>       a bitmap for _every_ ref tip. It takes up space, and just OR-ing
>       all of those bitmaps together is expensive.
>
>       One way we can deal with that is to create bitmaps that represent
>       _groups_ of refs. When a traversal asks about the entire group,
>       then we can use this single bitmap instead of considering each ref
>       individually. Because these bitmaps represent the set of objects
>       which would be reachable in a hypothetical merge of all of the
>       commits, we call them pseudo-merge bitmaps.

Nicely put.  I wish there were something like the above in the
patches when I read these patches for the first time.  The concept
of "pseudo-merge" was the first hump in the road to understanding.
Eventually I figured it out, but a simple write-up like the above
would have helped readers a lot.

Thanks.
