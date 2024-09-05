Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7519E7D3
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549706; cv=none; b=VHBfZU+r9nuvzGCV/5k+ChIlTPpwkv+iPTtC82LIvnlukEPh9/VaN+Gja3wAoD3JGgw3gKGd6blXabLRQqvVeycoRdx/iTdqVMwM/ZEXe9KJWuHXO+0uImiNf9TY9Msb1aRR/UY7FY3HtURqn+cnDC4fDVkccSHzEF6a8gSrvE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549706; c=relaxed/simple;
	bh=mjCXN0D0gfRiZaDTNwtdnzmgz3i/DXOZhr0E7gXE3vU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hGpuX6AXrpy/gWfIdeuOa3wCSu4IhukhS3Nn21mWnRz3f5owDvHe+c+6zr1JFRQB50BdDla17iAP1G8mii9aRkl4wbvwYQDMS6wZS8gM9bkFd3l4rR6xqdjjjOVQLmNYnXFwPjOQ0K3d5sr3hXB/+zqRHTgPrapvthel1FndrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wpH4LTvG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wpH4LTvG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B030624C8A;
	Thu,  5 Sep 2024 11:21:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mjCXN0D0gfRiZaDTNwtdnzmgz3i/DXOZhr0E7g
	XE3vU=; b=wpH4LTvGbOZMgefV1LhFxpxIAsLO8x+gxOQBUjc47aa5gXit/+rFt8
	ql0xD0q+8KgTVG8u5Y/hYR+GuNzi6OL/E4qIAzsWobZvZf5qPPp3jz/MWz6BcV7z
	Fre2lht6xUa+ZOQ4r2RKgBP3M4AXsS14+of2fXi58x1EK/vrim8Zk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A888B24C89;
	Thu,  5 Sep 2024 11:21:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0DCFC24C88;
	Thu,  5 Sep 2024 11:21:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/5] pack-objects: brown-paper-bag fixes for multi-pack
 reuse
In-Reply-To: <20240905091043.GB2556395@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Sep 2024 05:10:43 -0400")
References: <cover.1724793201.git.me@ttaylorr.com>
	<xmqqv7zb8cys.fsf@gitster.g>
	<20240905091043.GB2556395@coredump.intra.peff.net>
Date: Thu, 05 Sep 2024 08:21:41 -0700
Message-ID: <xmqqbk125doa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8E71BE54-6B9A-11EF-8F60-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Sep 04, 2024 at 11:56:27AM -0700, Junio C Hamano wrote:
>
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>> > This series fixes a couple of issues (some cosmetic, others less so) in
>> > multi-pack reuse noticed when rolling this out over a few real-world,
>> > internal repositories on GitHub's servers.
>> 
>> I cannot claim I got all the detail that went into steps 2 & 3
>> right, but I was irritated enough that the topic was left in the
>> "Needs review" state, so I gave a look at the tail end of the
>> series, and they were pleasant read.
>
> Sorry, I'm probably the most qualified reviewer here. I read through
> the early patches, and I think the fix is correct, along with the
> preparation in patch 2.
>
> With the partial disclaimer that I helped with the early debugging, and
> my blind flailing at suggestions accidentally led Taylor to the right
> answer. I don't think that biases my perspective, but maybe. ;)

Thanks.
