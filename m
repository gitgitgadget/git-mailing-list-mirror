Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E646F13F451
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589506; cv=none; b=mSi6w1jOyDPV9fqL18B86CmDyd44H5DohvnaXmcBFs/y79zCFwQDGQDZnS3hoe+Qto3yezpoKAr9NlJOm6gN1GbzsLvUK5pT8foRhyGjzsDgWY4BIuoN/XpKD/I1M53aNX5VoPAasNTMIKSYxPNTcevdVnnr2KIT7yTae9zyyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589506; c=relaxed/simple;
	bh=5yZDpSWuWJ7XWXZkMDzFfTBTMYKx2TWl/ONYtKSbXZM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcbHsG9TsU5mHOXoH1UdAL0Nhoba/4hPf1QCmsq9S3AbBL2VtwG3giKGwv4UyFIi5L5RGn0HS1Gf+1FFjBqFYdcQgI97YjZOSG/bNgfovnN2PYwM9CtgyK+oQXMO82fw7Vi9lnPPaD5nDKee4Rl65Q0tGEqCsl0dH7u7lY8fd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TJvd7Boj; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TJvd7Boj"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 706451F27FA;
	Mon,  8 Apr 2024 11:18:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5yZDpSWuWJ7X
	WXZkMDzFfTBTMYKx2TWl/ONYtKSbXZM=; b=TJvd7BojBvIxYNX7oBxqUzC0Mfnk
	sVhYF5AJxSeksrishoumAtjmJgwCLF0ErrUc03vIM4GLLcVJek5o9928qkljIACx
	DxACg2n07Hnv0GWHCZvutfte8W9tWgb2zWkJetiOVBVBzZwDobOhIGPk3mVQaMEK
	vl/rLNy0sstIzgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 691661F27F9;
	Mon,  8 Apr 2024 11:18:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0E081F27F8;
	Mon,  8 Apr 2024 11:18:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel =?utf-8?Q?R=C3=B6thke?= <marcel@roethke.info>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rerere: fix crash during clear
In-Reply-To: <ZhL-Jt_Nb5egpKfx@roethke.info> ("Marcel =?utf-8?Q?R=C3=B6thk?=
 =?utf-8?Q?e=22's?= message of
	"Sun, 7 Apr 2024 22:12:22 +0200")
References: <xmqqplvjpacq.fsf@gitster.g> <ZhL-Jt_Nb5egpKfx@roethke.info>
Date: Mon, 08 Apr 2024 08:18:15 -0700
Message-ID: <xmqqle5ng9xk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3993BC84-F5BB-11EE-86BA-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Marcel R=C3=B6thke <marcel@roethke.info> writes:

> After reproducing this without manually corrupting the database, I
> noticed that the summary line is no longer accurate. Because it fixes
> two SEGFAULTs and one of them does not happen during clear. Can I chang=
e this
> in v3 or should I start a new thread?

Updating the title in the course of evolution of a topic/patch is
perfectly normal.  Please do so in v3 as continuation of the
previous round.

Thanks.
