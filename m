Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098D1862BB
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477839; cv=none; b=lgHrFffknXCsyZx9xshhx0yxZ6PK9/qOmxLL8uZbMytaE4e57S4hKHhY5ve0fqEino9A0SK1W6ELRLCkY6UYaIplpvRhiL6MBmb/RKNvpth+OW/lH9MSrZLcgQYqOIm6pxfnCT30NbAh1Reyx9A7P+G/w4f8sJyEQMOuqSSx5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477839; c=relaxed/simple;
	bh=JoY3Ilv6f/f8pbmT5Q/4oSIJUbLl7EmYeBDg0FnlFXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KsHvCBlfzFfg+1CTOxzP7+PdRAC9tbAu795I48sd/h3GOvHtEqnpArBHvh8+qwxM7hdKP369rc9L521o/fATV5OviQbXMa/eDf2+pSngQmajjrHMjA6W3OsFi6SdZ4BTpe/60KFMvy2BQwSEK90/f+pezB9l2v2f+IZRDJLQx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWcCTJOM; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWcCTJOM"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A103C3C77C;
	Mon, 12 Aug 2024 11:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JoY3Ilv6f/f8pbmT5Q/4oSIJUbLl7EmYeBDg0F
	nlFXA=; b=iWcCTJOMx+jC9KVHexK0q6e0xzmYwXVi9L9wN00QpigMBlgw7XCwqx
	xcW9U9u7t9JVgnoJibilzlwqKv+G7YUUwscEqYWoxhKVXvKLunIbkLtxqyfyzJTJ
	j51tOfydnoJIzd5OgXy71daeNdypK85/C6wN/idO8mdk9FRnVS/es=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A4F33C77B;
	Mon, 12 Aug 2024 11:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3090A3C77A;
	Mon, 12 Aug 2024 11:50:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  James Liu
 <james@jamesliu.io>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.4)
In-Reply-To: <4dbf731a-873b-4cab-b8ff-745bfa059060@gmail.com> (Phillip Wood's
	message of "Mon, 12 Aug 2024 15:01:43 +0100")
References: <cover.1722933642.git.ps@pks.im> <cover.1723121979.git.ps@pks.im>
	<4dbf731a-873b-4cab-b8ff-745bfa059060@gmail.com>
Date: Mon, 12 Aug 2024 08:50:32 -0700
Message-ID: <xmqq7ccl7nav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C5E9248-58C2-11EF-8C80-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/08/2024 14:04, Patrick Steinhardt wrote:
>> Hi,
>> this is the second version of my fourth batch of patches that fix
>> various memory leaks.
>> Changes compared to v1:
>>    - Adapt the memory leak fix for command characters to instead use
>> a
>>      `comment_line_str_allocated` variable.
>>    - Clarify some commit messages.
>>    - Drop the TODO comment about `rebase.gpgsign`. Turns out that
>> this is
>>      working as intended, as explained by Phillip.
>
> The changes to the rebase and sequencer patches look good to me
>
> Thanks
>
> Phillip

Thanks for a review.
