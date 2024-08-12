Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3C18562A
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723478116; cv=none; b=ZguZ+Ap9imbtwqeFCWzQcSFSy2LqUI4w1igFUgzUQkn7gmI1ut2M43iTJd9WuQqnq2TKDLH/l76ZvcvV07riSxZnDfqf+FvBxmawubWHW4Sf6WROCOBItWv38oPZTdBbtIjkNQJRVnb6RwSBOj1yQ+Y4fN5s4GCmC33bcplLIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723478116; c=relaxed/simple;
	bh=ST9/UTUbaWGEEZp0HFz2peAbHfdsIXuD4sTGMXR75bE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S/xEVagQ8otrbYrKt4RFmdbaL/KzfVQrgSTszLoWIfEY8i4/4jWFo91tFZhKsV3zRPUP/MysfU9HtZACvQvd0S6HG1kOf30EkiKWd+N61qjxpLH6ueWvn9lnnviGAh4Tys8lx04kUuDaf+cXCutV2kk3PPK+uocExDZqmvoRGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZH7lArDh; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZH7lArDh"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FDA01C06A;
	Mon, 12 Aug 2024 11:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ST9/UTUbaWGEEZp0HFz2peAbHfdsIXuD4sTGMX
	R75bE=; b=ZH7lArDhnSMe9uVTTHPjrDOcmwYcp5XuaGnHONiSMXsq0BcnJHiqk5
	JvurBA1ejLdcFeiBP89+lKigJNt1u4F3ICtdQLwuGdLtGjfKw4kjruL44dKt/N1r
	TyLksAJfy9onqdoxkp+5NP6rDTHCFgGptHhzPnP+503AiQ97wyFZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17A2A1C069;
	Mon, 12 Aug 2024 11:55:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8528A1C068;
	Mon, 12 Aug 2024 11:55:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: ArcticLampyrid <ArcticLampyrid@outlook.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: SIGSEGV Error Occurs When Attempting to Unbundle Without
 Initializing Git Repository.
In-Reply-To: <20240812114733.GA3732689@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 12 Aug 2024 07:47:33 -0400")
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
	<20240812114733.GA3732689@coredump.intra.peff.net>
Date: Mon, 12 Aug 2024 08:55:12 -0700
Message-ID: <xmqq1q2t7n33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42DFA512-58C3-11EF-9EDC-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>   - "verify" requires a repo, which I wouldn't have expected, but I
>     guess it's because we probably unbundle under the hood to walk.
>     Anyway, it gets the ordering right here and checks the repo before
>     opening the bundle.

In hindsight "verify" is misnamed and overrated.  Its purpose is to
check if the bundle can be unbundled into your _current_ repository
by checking if you have all the commits _required_ to unbundle the
bundle.

In fact, I doubt that "verify" looks at the pack stream part of the
file at all.

>   - list-heads doesn't require a repo, and segfaults. So it really does
>     need some kind of detection or default to know which hash to use.

Yes.
