Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FC15E9B
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrCvQyO9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E421A1D1CAE;
	Thu, 11 Jan 2024 13:35:26 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3rXiVbbJwcyz8RSBlcCCBKnn0huXqcGulusaT8
	uZ6vg=; b=DrCvQyO9zvhCBkr51eLXBn5LBbN2hWiCd/1RNGPO3MeVIrzL2ppJ4z
	hV6i3kFaoqxUbd5v59FhwhWy9cYTtFFmgYys0pdZNXorUbaiQ1NpW8nnotUOX4UY
	IZTn6EAHCI9kLu3qOnjyBXh3eW/j26F4byrntcR3MkB0IrpGchrEU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DC3A01D1CAD;
	Thu, 11 Jan 2024 13:35:26 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0E1D31D1CAA;
	Thu, 11 Jan 2024 13:35:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Scott Leggett
 <scott@sl.id.au>
Subject: Re: [PATCH] commit-graph: retain commit slab when closing NULL
 commit_graph
In-Reply-To: <20240111075313.GF48154@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 11 Jan 2024 02:53:13 -0500")
References: <20240105054142.GA2035092@coredump.intra.peff.net>
	<ZZg3YIEDCjbbGyVX@nand.local>
	<20240110113914.GE16674@coredump.intra.peff.net>
	<xmqq34v5dtz9.fsf@gitster.g>
	<20240111075313.GF48154@coredump.intra.peff.net>
Date: Thu, 11 Jan 2024 10:35:24 -0800
Message-ID: <xmqqedenhg5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2FFAC8C0-B0B0-11EE-96AB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Jan 10, 2024 at 08:38:18AM -0800, Junio C Hamano wrote:
>
>> > It should be easy-ish to iterate through the slab and look at the
>> > commits that are mentioned in it. Though maybe not? Each commit knows
>> > its slab-id, but I'm not sure if we have a master list of commits to go
>> > the other way.
>> 
>> We have table of all in-core objects, don't we?
>
> Oh, duh. Yes, we could iterate over obj_hash. I do think the "on demand"
> version I showed later in the message is better, though, as the work
> both scales with the number of affected commits (rather than the total
> number of objects) and can be done lazily (so callers that are not buggy
> pay no price at all).

Yeah, it is far more desirable than scanning obj_hash if we can do
the right thing on lazily.

> So what if we just tried harder to look it up in the graph file (rather
> than the slab) when we see COMMIT_NOT_FROM_GRAPH? And indeed, we even
> have a function to do this already!

;-)

> but:
> ...
> I somehow sniped myself into thinking about it more, but that has only
> reinforced my feeling that I'm afraid to touch it. ;)

Thanks for a nice summary.
