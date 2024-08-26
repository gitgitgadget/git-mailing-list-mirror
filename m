Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7BD188CA5
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685123; cv=none; b=KAkapjs6PnZyESmSo2PIJjhaqzDVbsZBRIuvQOTM4/aVX7QrNBIKBV85N387YDnspl/DqNdZIZztW7w/cKXm+gj0RCWtsXSR1PuaRDnaX4FFoRskhF82ERQP6MaO6HLxacfDdgFeIAoXGHSRw8McWfELzMrT7ok7viFeNyHBtl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685123; c=relaxed/simple;
	bh=TuCflN8hWLsqCxUNGW33ByqmvdHaVN+cuFik2pZgG5g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U57sdi447BtTYG2bjKHNG4OcWpoSCmlanYmhy/0V5kvOE7FSIQXsHMXLMnqb/rU9kqMUMHhkI5SNZBdEShOilwasT4jG4WvSyAQbCRdpwdcCmJvMQmDw4hr+xMIBW/ZZ9FPsdZktxXShOiSPxbvDWxwZKcGdXKqysHuJGZ9SoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nwJAIDqG; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nwJAIDqG"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2ECB26D02;
	Mon, 26 Aug 2024 11:11:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TuCflN8hWLsq
	CxUNGW33ByqmvdHaVN+cuFik2pZgG5g=; b=nwJAIDqGZuss9qqsSlT4/Lzy7F7J
	gSyWy0ZKxaJTqAfF8k452Wo39rKvL5LFnRKxJp03vJXGNxFtakP7aVZHv42NQ5w7
	QYlnHwZaRskVpQA3NcUndhkro27NwUInGsZYN/lqot4in8PEGcCVO4MqBXS70e2C
	BcmRh8kWL9++gXs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BA61E26D01;
	Mon, 26 Aug 2024 11:11:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 33BBD26D00;
	Mon, 26 Aug 2024 11:11:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH] remote: plug memory leaks at early returns
In-Reply-To: <ZswUWj_dg7-kM8b0@tanuki> (Patrick Steinhardt's message of "Mon,
	26 Aug 2024 07:36:26 +0200")
References: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>
	<xmqqseuvndsq.fsf@gitster.g> <ZswUWj_dg7-kM8b0@tanuki>
Date: Mon, 26 Aug 2024 08:11:50 -0700
Message-ID: <xmqqmskznwsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 8624104C-63BD-11EF-B6DB-BF444491E1BC-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 23, 2024 at 02:13:09PM -0700, Junio C Hamano wrote:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>=20
>> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> > ---
>> >  builtin/remote.c | 23 +++++++++++++++--------
>> >  1 file changed, 15 insertions(+), 8 deletions(-)
>>=20
>> Looks straight-forward.  Does this allow us to mark any test script
>> as leak-free?  I understand that Patrick has another round of
>> leakfixes topic that is not yet published, and I'd prefer to see us
>> not step each other's toes.
>
> No, this doesn't conflict with anything I have. And even if it did, I'd
> be happy to drop some patches from my local series :)
>
> The changes themselves also look good to me, thanks!

Thanks.  Will mark for "next".

