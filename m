Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2871422B9
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369214; cv=none; b=I9GSj+cTO/U0G6yaT91VO4G6qP+qdLfKcPoaPNCc1d4wlDHjou094VUtfXysCZMBerZvU071Yl8B72Fj8WOgUHNLOdVrrBy5zlKMqGxnCwBZhG/ymgJOUKZFaHTKNILR82N1j8A2pefHnbjs9c9i3+vH58v2F+TA5pOBbU97S+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369214; c=relaxed/simple;
	bh=V6ZWwr0+hTelm7oJR4xAnLbEMJ3b+R6PKEtUk78GCBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G3emPaUF38WpPPvjEZBBHleKc0lPejmVk4E2XJOwJE+l5+uPQBYMuyn1C/XuZPPFG+oyO3JWTxVL1462c1xhDuyjpT0vDOuVPYn+gqIsCcQ3cgs83uHkA9/05SxQzKS1kXqPTM7ArxX9MMZeCDOEIXDr13dBgIwuvl77GYdvIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nCTaCJSR; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nCTaCJSR"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C31ED19627;
	Wed, 17 Apr 2024 11:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V6ZWwr0+hTelm7oJR4xAnLbEMJ3b+R6PKEtUk7
	8GCBw=; b=nCTaCJSRVWs1IubXTcwYGB6a/2Kk9grAJd2CAL2EmHLVmR7bMIPHF3
	KrX5HtEC1xhVOEPybooCAHVgg/Ih91vy3cWhEXPEzYigVwhcbqLKG5XdqjZKyatZ
	Rcha+K92nTPi9TeEddUlu8fUrI3jTwBg/L1WujczeKiacGBIBv2vE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BAEBC19626;
	Wed, 17 Apr 2024 11:53:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1611219624;
	Wed, 17 Apr 2024 11:53:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] run-command: introduce function to prepare
 auto-maintenance process
In-Reply-To: <929b6bfa08132523ee97f5adc376c3600f779a99.1713334241.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 17 Apr 2024 08:16:31 +0200")
References: <cover.1713334241.git.ps@pks.im>
	<929b6bfa08132523ee97f5adc376c3600f779a99.1713334241.git.ps@pks.im>
Date: Wed, 17 Apr 2024 08:53:25 -0700
Message-ID: <xmqq8r1c9ea2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A117B0CC-FCD2-11EE-B5D2-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The `run_auto_maintenance()` function is responsible for spawning a new
> `git maintenance run --auto` process. To do so, it sets up the `sturct
> child_process` and then runs it by executing `run_command()` directly.
> This is rather inflexible in case callers want to modify the child
> process somewhat, e.g. to redirect stderr or stdout.
>
> Introduce a new `prepare_auto_maintenance()` function to plug this gap.

I guess the mention of "inflexible" and "redirection" above refers
to some incompatibile behaviour we would introduce if we just
replaced the manual spawning of "gc --auto" with a call to
run_auto_maintenance(), but I would have expected that will be
solved by making the interface to run_auto_maintenance() richer, not
forcing the callers that would want to deviate from the norm to
write the second half of the run_auto_maintenance() themselves.

> +int run_auto_maintenance(int quiet)
> +{
> +	struct child_process maint = CHILD_PROCESS_INIT;
> +	if (!prepare_auto_maintenance(quiet, &maint))
> +		return 0;
>  	return run_command(&maint);
>  }

But given that the "second half" is to just call run_command() on
the prepared child control structure, it is probably not a huge
deal.  It just felt somewhat an uneven API surface that 'quiet' can
be controlled with just a single bit and doing anything more than
that would require the caller to go into the structure to tweak.

Will queue.  Thanks.
