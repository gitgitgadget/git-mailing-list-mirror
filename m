Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D684CE1D
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 22:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QCdynSLC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0F811C951F;
	Wed, 10 Jan 2024 17:18:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+LbJJ+M/Rx/lbGxh4Z0X1EhdsP027kM1P8QY15
	jHwWg=; b=QCdynSLCxKXDvlagujRX3UO+35HD5zAz3SRyVzLkRGH7zP51TXiI2h
	Ie1IRdyCKvs4emQNywCjWHWA446HqVShGmVBEe9R/J54qCj6RFQYz01+Cwvm+DIp
	DKu1WOX7J90D/n23bIWfdYsdZhck1GDrCuTCEIGgBey5BkTXb5ano=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E83181C951E;
	Wed, 10 Jan 2024 17:18:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09C621C951D;
	Wed, 10 Jan 2024 17:18:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5309: run expected-to-fail `index-pack`s with
 `--threads=1`
In-Reply-To: <588de2e4f16ab090ff477088084e0b81d9615ec5.1704909216.git.me@ttaylorr.com>
	(Taylor Blau's message of "Wed, 10 Jan 2024 12:55:30 -0500")
References: <ZZ7VEVXSg1T8ZkIK@nand.local>
	<588de2e4f16ab090ff477088084e0b81d9615ec5.1704909216.git.me@ttaylorr.com>
Date: Wed, 10 Jan 2024 14:18:52 -0800
Message-ID: <xmqqfrz496ib.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D587CBA-B006-11EE-9555-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> But that requires us to tweak production code (albeit at a negligible
> cost) in order to appease LSan in this narrow circumstance. Another
> approach is to simply run these expected-to-fail `index-pack`
> invocations with `--threads=1` so that we bypass the above issue
> entirely.

But of course, multi-threaded operation that production folks use
will not be tested at all with the alternative.

> The downside of that approach is that the test doesn't match our
> production code as well as it did before (where we might have run those
> same `index-pack` invocations with >1 thread, depending on how many CPUs
> the testing machine has). The risk there is that we might miss a
> regression that would leave us in an inconsistent state. But that feels
> rather unlikely in practice, and there are many other tests related to
> `index-pack` in the suite.

As long as "make sure we spawn all of them atmically" has negligible
downside, I'd rather take that approach. Buying predictability with
minimum cost is quite attractive.

Thanks.
