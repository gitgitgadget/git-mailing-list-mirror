Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE075228
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 01:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079349; cv=none; b=cZUqCmlIRsB6DA1ph0ggUP6fsQDVJOo1eGOAbK7VaPKHWbkCuhRwHuLDQ2PEJz5tJ0YjBVDOL2bSaHBH4rbdieL4g5Q57ayF4cZilpher2p8QMq+w71TTqXdFadevw30HCDWImsDuUCxWoipZns+Vy+dOrJaHX0pQvGxYDzzTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079349; c=relaxed/simple;
	bh=kN1Nwnl7HCTvn4XVidwGiV21ZpZXybOudX67saN5Sks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bfTXNSsVrdosGlCHMSQYW9jmcdampBIQ1GtoJGc2NjYa9pKfIbQo1b26FSXMqQPkPoqWUw0VclZqWMfgy8vzsA+ceXM0inTBtbartb6r6lNUs9qB4bQNMj+d4qprUF4sP/j746HRW9KOT5oCD39pEO6xNvzypnEaafWceQY1QWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jjPn31mr; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jjPn31mr"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC0A328FEE;
	Wed,  7 Aug 2024 21:09:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kN1Nwnl7HCTvn4XVidwGiV21ZpZXybOudX67sa
	N5Sks=; b=jjPn31mrOdI3W51p2kX/NpJLUFyMEUpoQ+b29DDWAaOxOjJOgNFCiY
	vIonA3cVvp3ZO0PCpNYOO8p4glIEOcFtcZm90/Rf4T9SdHJwATehUGyt7fujp3GH
	8RUOFp6SMACZkubf6TJHIzuUMzDRkVBm/536MGsOvMIt0N2d4VMeI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BEBFE28FED;
	Wed,  7 Aug 2024 21:09:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EBC8828FEC;
	Wed,  7 Aug 2024 21:09:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Jeppe
 =?utf-8?Q?=C3=98land?= <joland@gmail.com>
Subject: Re: [PATCH 0/6] Improvements for ref storage formats with submodules
In-Reply-To: <cover.1723032100.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 7 Aug 2024 14:43:44 +0200")
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
	<cover.1723032100.git.ps@pks.im>
Date: Wed, 07 Aug 2024 18:09:04 -0700
Message-ID: <xmqqa5hnn7m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CEE08742-5522-11EF-BCF6-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> this small patch series contains some improvements for ref storage
> formats and their interaction with submodules. Notably:
>
>   - Use the correct format for submodules in situations where the parent
>     repository uses a different ref storage format than the submodule.
>
>   - Wire up `--ref-format=` for git-submodule(1), such that users can
>     explicitly use a different ref format for their submodules.
>
>   - Propagate the `--ref-format=` flag of git-clone(1) into submodules
>     when using `--recursive`.
>
> The first three patches implement improvements for the above three
> issues and introduce tests. The test did hit some memory leaks, which
> get fixed by patches 3 to 6 such that the new test can be marked as leak
> free.

Nicely done.  I've read through the series and did not find any
design decisions in the series questionable.

As to propagating the choice of ref backend down from the
superproject to the submodule, I am not sure if it matters all that
much, so I view it as a relative low priority.  If somebody wants to
use a specific ref backend for their repositories, then they want
all their "git init" (or init_db()) to use that ref backend, and
would arrange configuration to make it so.  When "git submodule
init" internally calls "git init" (or init_db()), as long as we make
sure such a choice would propagate to the new repository that
happens to the one used for that submodule, we do not necessarily
need to have a custom logic that says "ah, the user did not say
anything about the ref backend, so let me peek the one used in the
superproject and propagate it down".

Thanks.

