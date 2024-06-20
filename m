Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7421AD4B9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900892; cv=none; b=pWd8n/j/ySY2gYmWdDAauXWS7Oht3hMRyc904TTJPdV6tCQdyfkJdiQw69pZo2LLFkfzqLDlsadQrdMQdMToeDIUr7jM+Iph20T1hBYZDoUeh0XaSTkmoDtPBe8uriPysSG1biXHQ7cVgguDBoHjeFq9pvj48aNN+ax0UUY7Nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900892; c=relaxed/simple;
	bh=ArRI/HyGb0PH0v5849ektBhbI21e3eAVVteU77HhHdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pLKJyZgWau/16x9y4Y0riV7MtwoDrJcZeCIMhED6nAiTjU4jrS4b6sbnrSSeHFdbHvvaUrJoTQYr5g2VZhowrmSQs26avw7HWRI4tJ26v7lPRFaLNudBDYYKZkkliIX665lHwfOBmivgutGDzTPwy14QbZWFUvBRdSlwQAuWzH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CrJkRu4U; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CrJkRu4U"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB8FA1CAD8;
	Thu, 20 Jun 2024 12:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ArRI/HyGb0PH0v5849ektBhbI21e3eAVVteU77
	HhHdI=; b=CrJkRu4U4SdlwvXuhjFt/G2S20wLTRVyoo6HJolQ/JVMHmAtHUeXDm
	eln28umnaUiL9w7jcXAvSsaMp2nLwZw8VxxL2jZ/XeS0BzkMobJ5VruOkMMEFeMe
	//46/PwHcID0e3/z15ipGbwx4lh/5L46MwOXSJdymhhdWEk0VJIF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DB011CACE;
	Thu, 20 Jun 2024 12:28:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E082F1CACB;
	Thu, 20 Jun 2024 12:28:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Advertise OS version
In-Reply-To: <20240619125708.3719150-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 19 Jun 2024 14:57:05 +0200")
References: <20240619125708.3719150-1-christian.couder@gmail.com>
Date: Thu, 20 Jun 2024 09:28:02 -0700
Message-ID: <xmqqfrt7y3xp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1223FEE8-2F22-11EF-B0ED-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> For debugging and statistical purposes, it can be useful for Git
> servers to know the OS the client are using.
>
> So let's add a new 'os-version' capability to the v2 protocol, in the
> same way as the existing 'agent' capability that lets clients and
> servers exchange the Git version they are running.
>
> This sends the same info as `git bugreport` is already sending, which
> uses uname(2). It should be the same as what `uname -srvm` returns,
> except that it is sanitized in the same way as the Git version sent by
> the 'agent' capability is sanitized (by replacing character having an
> ascii code less than 32 or more than 127 with '.').
>
> CI tests are currently failing on Windows as it looks like uname(1)
> and uname(2) don't report the same thing:
>
>   -os-version=MINGW64_NT-10.0-20348.3.4.10-87d57229.x86_64.2024-02-14.20:17.UTC.x86_64
>   +os-version=Windows.10.0.20348
>
> (See: https://github.com/chriscool/git/actions/runs/9581822699)

I think we already heard from enough people to cover the spectrum of
opinions.  I'd have to say that needs to be carefully kept to the
minimum what we send in the 'user-agent' like manner.  The "git
bugreport" is an opt-in "these should help you in helping me"
feature, designed to allow further redacting by the user before
sending it out, and should not be compared with "on by default for
everybody" telemetry data.

I personally like the idea to add to user-agent, instead of adding a
new capability.  What is the true motivation behind this?  Is this
thing meant to gather statistics from potentially non-paying general
public from hosting providers, or is this primarily for $CORP IT
folks to make sure that nobody is being too stale?
