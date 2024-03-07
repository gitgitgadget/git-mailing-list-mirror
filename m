Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718DD446DE
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843588; cv=none; b=gm/6YfJhUZRtLt4L41WhVl0w2YojBE4HorU3qzrILiKrHCbGqv/u8IzqIKpI0G5CKSnGZg1PpiLyEd0hb3Eccs+gSea7ZVHG+NNi8Myey2IzrjyL27wYllZQK16oK+YByhetRe7WudrQORiROM9CfBemL0H778GIAyYeeTepts0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843588; c=relaxed/simple;
	bh=uueDQzWZD4rwKdFRSHqYWrQCD+9iyhyQIZu3BQpmMXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g2iBRO4FiiRziwy0WzHWEvN0U2Foj6wBgjVS3i1hfcLKsaPmE3kaAAzKcDkP0Hrg17UxLiqghWRN1DHTRxApO+myZbQT38VEhPievzyuGHqktNPCiatr3oFTaxD38NEs2H9MJKNAJrJUSFvsY0EVFnZZovZYFn0dXrlMm8vQ2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yDIjEd79; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yDIjEd79"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1746231AA7;
	Thu,  7 Mar 2024 15:33:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uueDQzWZD4rwKdFRSHqYWrQCD+9iyhyQIZu3BQ
	pmMXc=; b=yDIjEd79+hHLpK0Z3dajZM+oWn6mbOjKZrEvl7q/IQo2q+AuCBTc0H
	GcOCEv/ql4d/vs6itQRPycRRUlS8gdAogufCVhXp9REW5G4lybKpNQXTuPOxulUm
	Y13n4ac2hm6eMDbx3XDIsBcbK2sJJ3kl6hAWcMThvhkGQAuhhszVQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0ED8331AA6;
	Thu,  7 Mar 2024 15:33:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D19CC31AA3;
	Thu,  7 Mar 2024 15:33:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
In-Reply-To: <20240307095638.GC2650063@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 7 Mar 2024 04:56:38 -0500")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g>
	<xmqqr0hcglpk.fsf_-_@gitster.g>
	<20240217054048.GD539459@coredump.intra.peff.net>
	<xmqqfrxexx15.fsf@gitster.g>
	<20240227074903.GD3263678@coredump.intra.peff.net>
	<xmqq1q8xx38i.fsf@gitster.g>
	<20240307095638.GC2650063@coredump.intra.peff.net>
Date: Thu, 07 Mar 2024 12:33:00 -0800
Message-ID: <xmqqjzmdlr43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E4B20778-DCC1-11EE-8600-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>> So I do not have a strong opinion either way, if it is more
>> convenient to propagate the request out to other repositories when
>> we run processes in two or more repositories (e.g. "git clone
>> --local"), or if it is more convenient to make sure that the request
>> is limited to the target repository.  Here is a version without the
>> local_repo_env[] change.
>
> Yeah, GIT_CEILING_DIRECTORIES is maybe a bad example. But I do think
> LITERAL_PATHSPECS is a better one, and the submodule-fetch example I
> gave would be genuinely surprising if it behaved differently than the
> superproject, I'd think.
>
> I do agree this is probably going to mostly be a debugging aid, so it
> might not matter much. But once in the wild these things tend to take on
> a life of their own. ;)
>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
>> Subject: [PATCH v3 3/3] git: extend --no-lazy-fetch to work across subprocesses
>
> So anyway, this version seems good to me.

Thanks.
