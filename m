Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786941B5824
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441907; cv=none; b=VzCM/JKcqf+3qRUpSkvRm3milN6xldnbPXSqMZoYMX+G8rUBOgWIyTNukM4lu6VPjtKOr6e/+IHN0wU0zrp43Quopim+dlPqHtW+BkQEI+Sa+urQXrS0eZ2d36eBkJjVseXzeK3Iaw8MM8BL1EWYilDkEws7BEhM2xlpUu07WbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441907; c=relaxed/simple;
	bh=JBHjFvMRAowN9wFaLs4yDskZS4RROk758GF3kjGeDL8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aBcFG65dabQLhQ/rn/+E11ZxGR9422AbVIWNpX7SxcbRhy1M4XLv+iAhrPmHhtWxCKur7cTmh8hEHbrUB5+zailnPx7bOkyDvYRBtRlVxHntrcPGVKRT1wjOh9Fm4XXRnaFzd3zVEmNUhlO+s0QqjIy7kYB/iIa0XVLiGSGkgXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhIqo2Sv; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhIqo2Sv"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2034D1C6EA;
	Wed, 31 Jul 2024 12:05:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JBHjFvMRAowN9wFaLs4yDskZS4RROk758GF3kj
	GeDL8=; b=WhIqo2SveBCF16u5Y5Qq0Rpouf7CVZD5+vkI0s1R4dZc7SILp99l4P
	VZc4Vb6GwSbM6np5Zk1zZH/aeiDHDBgnEOWTRC4puVW7jO7t7mCrbK08/B7a29Ir
	rltnjR58UdsscHy3s63C9KjV5FnXC+wG6h/VQannpyIQn1zhSyEJA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 179631C6E9;
	Wed, 31 Jul 2024 12:05:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87DB81C6E4;
	Wed, 31 Jul 2024 12:05:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/23] builtin/describe: fix memory leak with `--contains=`
In-Reply-To: <ZqoVDkOw5IEWv52m@tanuki> (Patrick Steinhardt's message of "Wed,
	31 Jul 2024 12:42:22 +0200")
References: <cover.1721995576.git.ps@pks.im>
	<08a12be13c2fed247d6086967e7a3f03fa6519e1.1721995576.git.ps@pks.im>
	<xmqqr0bagark.fsf@gitster.g> <ZqoVDkOw5IEWv52m@tanuki>
Date: Wed, 31 Jul 2024 09:04:59 -0700
Message-ID: <xmqqv80l7djo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A465DAF2-4F56-11EF-85CB-92D9AF168FA5-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jul 30, 2024 at 08:27:59AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> [Footnote]
>> 
>>  * The fact that cmd_foo() is called is not a hygiene thing to do in
>>    the first place, and in the longer term #leftoverbits we may need
>>    to refactor the thing further, into a proper library-ish reusable
>>    helper function that can be used to compute name_rev() any number
>>    of times, plus cmd_name_rev() and this caller that call it.
>
> Agreed. There have been several instances of this scattered across the
> codebase. The fix is quite ugly in my opinion, but it would be a bigger
> topic to refactor those cases properly, so I refrained from doing so as
> part of this series.

Oh, I agree that it would be a "after all the dust settles" kind of
clean-up.

Thanks.
