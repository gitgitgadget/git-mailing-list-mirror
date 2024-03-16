Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D701BDE2
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612426; cv=none; b=n0etNYEVSsNgkNqLm8nmrA3ilwidjeBAusSe5pSIBjB5oSDJM4dhK4K+gg1bGzxM7HjVcMeVH+LevmTb363mhmxVlQ969clJ+w5a0Y+1s0em2VSePfVJLE5xY9hUMfu6VdzKzM0kLmh/LzNmRG3OOq2TeLQpIw7Mcs8G93EX+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612426; c=relaxed/simple;
	bh=g0faRcS7iyG38Lv4dfYl2m2A8VMtBWzDCXCo49Px5XA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VOPGqrgXZfHdDAOIp9HlrYLxWzY5ySAjT4d2Ftr1/XHzzDsOVjQQF4rDu4X5QDbvhtk/LHromK2KMixvS5SkCM/JtLU2YCkJP7uc+htyo4+nE4KqM283W1/0z3EnHKSsz5eZ8zl9gH5uya2/b4SISBQ2Gk/mnxyKOtChYwT6irg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hl7AsM2z; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hl7AsM2z"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 25BD61BDA1;
	Sat, 16 Mar 2024 14:06:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g0faRcS7iyG38Lv4dfYl2m2A8VMtBWzDCXCo49
	Px5XA=; b=hl7AsM2zcUOE0VMpYA9XNX8zyC8CbNFiPSSOnzqaHvHqXGntwTwsTC
	hA13vhOSktP85ScIm2O9tCUnOQEWW3DP/NHYlG4zPLkXOLvmrFei+4Iw+/+cye4y
	oMSqK0jLwc3wYXmc9cJ7l9nNsojDi7HS/vTUXtiSpcOnSgGj1qt4Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 103551BDA0;
	Sat, 16 Mar 2024 14:06:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9B7B11BD9C;
	Sat, 16 Mar 2024 14:06:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Beat Bolli <bb@drbeat.li>,  git@vger.kernel.org,  Beat Bolli
 <dev+git@drbeat.li>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Elijah
 Newren
 <newren@gmail.com>,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/22] avoid redundant pipelines
In-Reply-To: <ZfT7HHZ9Uchvp6Ao@nand.local> (Taylor Blau's message of "Fri, 15
	Mar 2024 21:51:24 -0400")
References: <20240305212533.12947-1-dev+git@drbeat.li>
	<20240315194620.10713-1-dev+git@drbeat.li>
	<ZfT7HHZ9Uchvp6Ao@nand.local>
Date: Sat, 16 Mar 2024 11:06:53 -0700
Message-ID: <xmqqfrwqm4oy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8BE5C9E-E3BF-11EE-B84A-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> On Fri, Mar 15, 2024 at 08:45:57PM +0100, Beat Bolli wrote:
>> As follow-up to [1], here's a series that eliminates redundant
>> pipelines, mostly under t/.
>>
>> --
>> 2.44.0
>
> I read through both rounds of this series thoroughly and everything
> looks all good to me. I left a couple of minor notes throughout that you
> might consider changing, but I think that neither merit a reroll.
>
> I'd be happy to see this series move forward as-is. Thanks for working
> on this!

Yeah, looks good.  Thanks, both.

