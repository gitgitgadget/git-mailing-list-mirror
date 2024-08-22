Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205411CB31B
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339468; cv=none; b=JTReq/kxqlY8Te0WAISG83x2jZGv1N0lh1g3pbjDPeWANoU+B8pdkljP6sgELnMvKm7PlzBG6ruwxcyU93M3TJ5GWR1QZqQcVbbSXgSlu5LX8NM/Y6JcQ3TlAwhsbCfIne/tdbAUwbsPmI8xPPuRe0eSDhUUUw7IE2b21G5U4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339468; c=relaxed/simple;
	bh=/ud+e2HG5UCSNNVhN58wGPypaFLXq2im0vSbcnmT0p4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7qSfQ8PSbSMUzcO/asEQPbJjWdVGhW9/pXR7obvEZWLm3vBmQjVxiIqyBDiOXIQ4Ke8fvKXrqOY82RkFjoVgWHqOiOcGKORuqXGjyuGPWluJHIiVAYVbOgmAKriFEk4c0N+AJ02ImY0C3rF2Ww0ichc3oWdcVeNJ6wAfZDFuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z22E8bEp; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z22E8bEp"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B0FD51915D;
	Thu, 22 Aug 2024 11:11:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/ud+e2HG5UCSNNVhN58wGPypaFLXq2im0vSbcn
	mT0p4=; b=Z22E8bEpBiGI1pM9Lino1r5XIkaKu4RGAy69MGUSSsM1zmjz1fX1hc
	9jHefKwLW0tkEGwJ3x0w5JiH4gdnLEO5KW5GOuZcYmk+j1xpnf1U29vnZupFz7c0
	2TIYDEM617BnQJo3kAZft5pdIgNAJT5NG31v7eSdv0LBHWCAeUeFQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A956B1915C;
	Thu, 22 Aug 2024 11:11:05 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E7801915A;
	Thu, 22 Aug 2024 11:11:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 00/10] reftable: fix reload with active iterators
In-Reply-To: <20240822124100.GA1070988@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 22 Aug 2024 08:41:00 -0400")
References: <cover.1724080006.git.ps@pks.im>
	<20240822124100.GA1070988@coredump.intra.peff.net>
Date: Thu, 22 Aug 2024 08:11:00 -0700
Message-ID: <xmqqr0agvbi3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BEA2B3CE-6098-11EF-9648-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> But I don't think that's sufficient here, as the race happens while we
> are actually iterating. You'd really need some for_each_ref() callback
> that blocks in some externally controllable way. Possibly you could do
> something clever with partial-clone lazy fetches (where you stall the
> fetch and then do ref updates in the middle), but that is getting pretty
> convoluted.

;-)

> So I think the tests you included seem like a good place to stop.

Yeah, I agree with this assessment.

> I did have a little trouble applying this for testing. I wanted to do it
> on 'next', which has the maintenance changes to cause the race. But
> merging it there ended up with a lot of conflicts with other reftable
> topics (especially the tests). I was able to resolve them all, but you
> might be able to make Junio's life easier by coordinating the topics a
> bit.

I haven't tried merging the topic to 'next', jumping over other
topics in flight in 'seen'.  Thanks for a heads up, but I am hoping
that my rerere database is fairly complete for this topic by now.

Thanks.
