Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2309E13D278
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173885; cv=none; b=d/KrwSxSk1WZ+IjrXzi+nAv3jFL1nig2GHm+IeOFGi7+iYUvzAMK1FRyZCyMAxHs/yc/sVejATKsWkRtfl1ZeHZdT2tjjCN+4VWb1Z2Tj3kyecN7cOeY8BEfQ7wlSPjEhdM3jhbEyM9IZ3por5BvRHdugxPUtz9LHBR+vwU3xjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173885; c=relaxed/simple;
	bh=yXBRLPy64l/jlwXwQmNY9+ilwbrUkjAHLRg7x3zGqiY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9aCXGHDpAlIcnqLcTULVMsW6DP5GPvC3S1fkyVTuS91DxomCYUkIF6mykLDkGQ6IigeNJhkZ2tZAuY3/SHFfaz6CBkHrbXB+x5grvjEwnxpYEzAuhC74zFzfN2A51PZOYc5RREkVwyZFtMn1U/VKrx0kJH5Lhuya4Ihi/Wjf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nqhr69IV; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nqhr69IV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0091F37601;
	Thu, 12 Sep 2024 16:44:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yXBRLPy64l/jlwXwQmNY9+ilwbrUkjAHLRg7x3
	zGqiY=; b=Nqhr69IV635VUK8rtvzGZXM3Tawth2Uqc8Y7Fu/XOgloptLmsjPiEq
	A+HCKEa8AhNdgh7iaM44EaS66YofzUWjMSVhhMwQaJ0UzNTj0ObzRDwTtcRUzjPx
	deJoNnwXFtw8RWfgSkYSM/3Tl6vfd/sohngaLq3fi0euwVZYiNLa8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EBC4537600;
	Thu, 12 Sep 2024 16:44:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D8B2375FF;
	Thu, 12 Sep 2024 16:44:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Brian Lyles <brianmlyles@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phillip Wood <phillip.wood123@gmail.com>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] rebase: apply and cleanup autostash when rebase
 fails to start
In-Reply-To: <xmqqr09tvmi5.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Sep 2024 14:55:30 -0700")
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
	<pull.1772.v2.git.1725289979450.gitgitgadget@gmail.com>
	<xmqqr09tvmi5.fsf@gitster.g>
Date: Thu, 12 Sep 2024 13:44:41 -0700
Message-ID: <xmqqldzw38li.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D650F3CC-7147-11EF-BDD3-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>     Thanks to Junio and Patrick for their comments on V1. I've updated the
>>     commit message to correct the typos found by Patrick and added an
>>     explanation of why it is safe to remove the state directory.
>
> Any other comments, or are we all happy with this iteration?

Let me mark the topic for 'next'.  Thanks for reporting, fixing and
reviewing.
