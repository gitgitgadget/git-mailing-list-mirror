Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA91C2BF
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249607; cv=none; b=b+Yu5WSyrD+s30Ib/xFIJ11K7PF9k/tZUgPaFxBydA/YOLNnp7omUsguxeM1dFIXJfOXjIGhaVUxIzEjnQn5ILm2DmpSx7BOl3n2lpM90q6rEnc/za+zJHglYKvtSgFgTya+erONb01s6uWT1CfyuH07h3T3wtqg5SP2GIBvFUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249607; c=relaxed/simple;
	bh=3hsVoNZAEsQry231bjcVHgyMxX/WIuY3BazPtrsAQDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dr2OFkdyi0QhGgktPzocgH05zaBpfy55d6TkI7yvHsA+kd5nRa2QcPD9FMDehzVux88sMiYeIfak39qvQ+c4ORx/C1PJNWkOWlKlaZyXsYWHczwMoR9IJN6QxXB6sPBgDt6u515vp3QSulxBiuhXntLmNLAedRvJimTdvFFHc98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VaPtC/Iv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VaPtC/Iv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E9C1A274B6;
	Fri, 13 Sep 2024 13:46:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3hsVoNZAEsQry231bjcVHgyMxX/WIuY3BazPtr
	sAQDw=; b=VaPtC/IvNzsa2Lll2ye4OyJukTtGrWPGGjT1oQRANLDi2YGA5wh3ur
	uFe2UwU9+hNARnWCnURqqXMbQpiMXtK7KV6touP5lj2N7xcc1wCOHTZ0r2VU40bw
	tQ2QyyO07cGlARpYxxwCVcaUADWiONbATTD+bDw4srdA74hN447cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D3A1C274B5;
	Fri, 13 Sep 2024 13:46:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DBD4274B4;
	Fri, 13 Sep 2024 13:46:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Rodrigo <rodrigolive@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 0/2] fix bare repositories with Git.pm
In-Reply-To: <20240912223413.GA649897@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2024 18:34:13 -0400")
References: <CAGUZU_JZd_+8y19=kGif6u1+4n_+iOcVWV4p-kC0Uo=8Ev=aBA@mail.gmail.com>
	<20240912223413.GA649897@coredump.intra.peff.net>
Date: Fri, 13 Sep 2024 10:46:43 -0700
Message-ID: <xmqq4j6jzbss.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 241BAE84-71F8-11EF-9DBB-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Yikes, good catch. That's a pretty bad bug. I'm surprised we didn't
> cover this in the tests, but it's specific to bare repositories.
>
>> Bug hunting through the Git.pm code and skimming through the Git SCM
>> repo, there's a significant change (commit 20da61f25) that makes the
>> recent Git.pm rely on:
>> 
>>      git rev-parse --is-bare-repository --git-dir
>
> Yep, I confirmed via bisection that that commit is the culprit.

Yeah, it is surprising that nobody noticed it since Dec 2022.

> It does fix all cases, but it leaves some redundant code in place.
> Here are two patches. The first does the minimal fix within the code
> (what 20da61f25 should have done!) and corrects the problem. The second
> switches to --absolute-git-dir and drops the now-redundant code.
>
> Thank you for a very thorough bug report!

Yup, thanks, both.

Queued.
