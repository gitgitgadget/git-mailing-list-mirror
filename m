Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8861A196DAB
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688553; cv=none; b=kWCjmXDwnpf5n7ndM8dz9kNw+MZL3b5YpUab4/Dcxp/e23nJm2zc3tdLjeOA33Em1de+A/YapASwo2FYKrGQg+GBTGCVDMkmXqgAqv3iGrCEnq4Dz+Zo+TdabQn74jiRnB7VwnYf7pJTzvUR6Uj6DfAIw0Aux3tqSuDpVoc/fzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688553; c=relaxed/simple;
	bh=5kAwlfNYZpVMzHcEVasKuah3A5eQNJhwwUKWbRKyRsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R56ZjdLm7MDYSeHouS29rElexQvECkHrYxownAQXeEaJERKbbLV9P3wMGuJ+mevpohSv1enPkLX9cVb0bqF4EWIBqgDQH2TOZkmEkL/gFJVuCjM1n53TtmsfPVudHRJ4Jgec0WFIYji5RrQzkuZZINhq28HU0m4gL0XGiX27zQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JdodLskW; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JdodLskW"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E20002DCF0;
	Thu,  6 Jun 2024 11:42:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5kAwlfNYZpVMzHcEVasKuah3A5eQNJhwwUKWbR
	KyRsU=; b=JdodLskWDmG+rJ11PCWxhWQA5GPDumqDYshmuXFpaAp2uOfgidc46s
	L+lnu952nePJVFIJo3VDdG28/BIwLL5hju+2T5lesAPdwi619ekOhfsSxNCnzeKN
	I++WI6AkTJga3IsfX8VMZgUFobZzIDQREDwTz/a5zYUIl1o1CQMuA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DA2642DCEF;
	Thu,  6 Jun 2024 11:42:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECB682DCEC;
	Thu,  6 Jun 2024 11:42:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 11/12] refs: implement logic to migrate between ref
 storage formats
In-Reply-To: <20240606070109.GC646308@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2024 03:01:09 -0400")
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im>
	<1f26051eff8b7c18bb7114803454611272f84e19.1717402363.git.ps@pks.im>
	<20240605100318.GA3436391@coredump.intra.peff.net>
	<xmqq1q5buxzx.fsf@gitster.g> <ZmFAQ1UT6ePxHtzq@tanuki>
	<20240606070109.GC646308@coredump.intra.peff.net>
Date: Thu, 06 Jun 2024 08:41:10 -0700
Message-ID: <xmqqwmn2nko9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 60E10B00-241B-11EF-972B-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> In my fork I trigger Coverity runs based on my personal integration
> branch, which is based on next plus a list of non-garbage topics I'm
> working on. So I get to see (and fix) my own bugs before anybody else
> does. But I don't see other people's bugs until they're in next.

I am on a mostly same boat but doing a bit better ;-) in that my
daily driver is a point marked as 'jch', somewhere between 'next'
and 'seen', that appears on "git log --first-parent --oneline
master..seen", and this serves as a very small way [*] to see
breakages by others before they hit 'next'.

    Side note: This does not work as well as I should, because my
    use cases are too narrow to prevent all breakage from getting
    into 'next'.

> I could try running against "seen", but it's a minor hassle. I don't
> otherwise touch that branch at all, and I certainly don't want my daily
> driver built off of it. Plus it sometimes has test failures or other
> hiccups, and I already get enough false positive noise from Coverity (so
> even if I ran it, I'd be unlikely to spend much time digging into
> failures).

I'd recommend against anybody using "seen" as their daily driver.

Being in 'seen' merely is "I happened to have seen it floating on
the list", and the only guarantee I can give them is that I at least
have read sections of their code that happened to conflict with
other topics more carefully than just giving a casual reading over
them.

If CI is broken for more than a few days for 'seen', I may look at
them a bit more carefully, only to see which one is causing the
breakage.  But that is not necessarily to fix the breakage myself
but to just eject it out of 'seen' ;-).
