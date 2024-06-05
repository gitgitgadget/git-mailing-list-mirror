Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531637345F
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606448; cv=none; b=MnvqxwfhtT4cuJrTiP5DO5A1b7mu3pm4xnDjKKc8wfRru99EDit75qs8eDdx5/Rh2yuovPCazhfDh4HqxFo/jgRQOVzSnbVtwWPBO5DDXREyoAcFd6vrv4v2q8gZkUyqLs9CGbMJ0bh51An4x4DFFwwIpr7+zzmUEc/ezGsXj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606448; c=relaxed/simple;
	bh=+ECCZ4WT7FI0B9dr8g94zwZfejZn/2qwB2SoqgPPK04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fwcuFKIK+7rQdzKiPtfvNRTyc6aysPPhhJYmOAm23gnXGaieErYm5yAcxHgoJIgqnIOloxRz7O6IXMgLOnIBaT5nnnwliTBMxy+csHC4/LEnNUtXy5NFewiSa8iHTwTFWQ+LJXJkqvONGy4kgUdeZLs8sM8std3BpdOSSE9zH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wjMLfbiF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wjMLfbiF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 794662560F;
	Wed,  5 Jun 2024 12:54:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+ECCZ4WT7FI0B9dr8g94zwZfejZn/2qwB2Soqg
	PPK04=; b=wjMLfbiFGif453/AHvVDPjDPf22WsibbCuA46kHkyQ3RRzRfEHcWLi
	y4Ru8OA2myxO2ka8ghAugAB2QUkRNPvaP/fagwVYiMKsr8989jO8MfAFD6OZwBnM
	xVq9svtpUHMeA8qwg2sjDRjx4/zOlW7EdvOERAt7+IUPGlblpY14o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 640652560E;
	Wed,  5 Jun 2024 12:54:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74C832560D;
	Wed,  5 Jun 2024 12:54:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 10/12] refs: implement removal of ref storages
In-Reply-To: <20240605101200.GA3440499@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 5 Jun 2024 06:12:00 -0400")
References: <cover.1716451672.git.ps@pks.im> <cover.1717402363.git.ps@pks.im>
	<f9d9420cf93025595e00aa4287bc0cc1a1c067ab.1717402363.git.ps@pks.im>
	<20240605101200.GA3440499@coredump.intra.peff.net>
Date: Wed, 05 Jun 2024 09:54:02 -0700
Message-ID: <xmqq5xunuy8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 36C95BFC-235C-11EF-9447-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> If removing either of the directories fails, we set ret to "-1". Make
> sense. But...
>
>> +	ret = for_each_root_ref(refs, remove_one_root_ref, &data);
>> +	if (ret < 0)
>> +		ret = -1;
>
> ...then we unconditionally overwrite it, forgetting the earlier error.

Ouch.

> Is that a mistake, or are we normalizing other negative values? Maybe
> just:
>
>   if (for_each_root_ref(refs, remove_one_root_ref, &data) < 0)
> 	ret = -1;
>
> would work?

Sounds sensible.

Thanks for carefully reading.
