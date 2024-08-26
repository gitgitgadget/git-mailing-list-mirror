Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60979197A9B
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713524; cv=none; b=gMvxgAFzlI+OOKIZ+GGIHcoT6VYzlMqs7mPQ9oKRKmn5u7viL5lRe1vNRK9fM/1xv3dDcWwn/8EzMqpH0DBImyKRElqXkZT/IIiKod2Zv0QR1g96nHqmgAJPd4+eCsvgkd0Dk8teMrJ4YDDXRQSwp6FykHcSYCUu4UzpoGTgcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713524; c=relaxed/simple;
	bh=GHlonEQIyuM++zoFyPMYIaNmN8F/2MqXwstfs3e3KJA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i9qWT4iGccO68Arw+yzbS+gDwI2kHM2xjCigxs13nlQG5dLiPnsvqUV8rRn8CDhC5xmH/+BxFldXF2Gbs5+yxpHAG+h4IlZ/shHVJrSsQLugS3s07nmObOYljaA1ivxF5kP9BNSvF0yxvcNpu+/seU6vrLM5cexeo0A0FR1xY7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NQjk4UQa; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NQjk4UQa"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA5B82A1F2;
	Mon, 26 Aug 2024 19:05:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=GHlonEQIyuM++zoFyPMYIaNmN8F/2MqXwstfs3
	e3KJA=; b=NQjk4UQaa+JchyWZ3axUUmItfdlHuhX8B5NTRzI5RCYXvR2uZsdbGF
	ggFcAcxSncJgprQ9rwZPvH8TgdYmvwJsqtogMMux0vsFnZWL98QkDnf/cuuXd1rX
	2gyMTl/+9AVbOaU3zMGgEizGHTNpNnXzLeXyTHzm/AjYkvPt6SA/s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2C572A1F1;
	Mon, 26 Aug 2024 19:05:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 23ADD2A1F0;
	Mon, 26 Aug 2024 19:05:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 05/10] cat-file: use delta_base_cache entries directly
In-Reply-To: <xmqqjzg3geea.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	26 Aug 2024 14:31:09 -0700")
References: <20240823224630.1180772-1-e@80x24.org>
	<20240823224630.1180772-6-e@80x24.org> <xmqqjzg3geea.fsf@gitster.g>
Date: Mon, 26 Aug 2024 16:05:17 -0700
Message-ID: <xmqqcyluga1e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9FE6598-63FF-11EF-8F35-BF444491E1BC-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> +	/*
>> +	 * Set if caller is able to use OI_DBCACHED entries without copying.
>> +	 * This only applies to OI_DBCACHED entries at the moment,
>> +	 * not OI_CACHED or any other type of entry.
>> +	 */
>> +	unsigned direct_cache:1;
> ...
> You seem to set this bit in batch_objects(), so it does sound like
> that the bit is expected to be set by the caller to tell the API
> something.  If that is the case, then (1) move it to "request" part
> of the object_info structure, and (2) define what it means to be
> "able to use ... without copying".  Mechanically, it may mean
> "contentp directly points into the delta base cache", but what
> implication does it have to callers?  If the caller obtains such a
> pointer in .contentp, what is required for its access pattern to
> make accessing the pointer safe?  The caller cannot use the pointed
> memory after it accesses another object?  What is the definition of
> "access" in the context of this discussion?  Does "checking for
> existence of an object" count as an access?

Another thing that makes me worry about this approach (as opposed to
a much simpler to reason about alternative like "transfer ownership
to the caller") is that it is very hard to guarantee that other
object access that is not under caller's control will never happen,
and it is even harder to make sure that the code will keep giving
such a guarantee.

In other words, the arrangement smells a bit too brittle.

For example, would it be possible for a lazy fetching of (unrelated)
objects triggers after the caller asks about an object and borrows a
pointer into delta base cache, and would it scramble the entries of
delta base cache, silently invalidating the borrowed piece of
memory?  Would it be possible for the textconv and other filtering
mechanism driven by the attribute system trigger access to
configured attribute blob, which has to be lazily fetched from other
place?

Thanks.
