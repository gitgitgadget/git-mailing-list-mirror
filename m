Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC01DFF0
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553456; cv=none; b=b3GtisAVDKzztOPtfLF0Oqa/H5S23byUMhex9MRQB+eAkE3O2D8rnTFedRXs3T1sGiJkzuolBWqp5ntmaMBuECZ4GxghO0lbiZFgCNfSmslPigjgfSXKwXKU3rIAwR4DPhMsDZV7Fy24a3n53XevWXttMJ2LcV2zU4jMsCEDDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553456; c=relaxed/simple;
	bh=AVbsumE61ubTjDi5BbgZ7jmORKBWUwFKQh6D6odx+EM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sH53x70qWryR2i6BeLWIn2tJpyVPrl9afqJfd1uMSZiCfS+W9RITo9cd/rESRfgtXPwWLSx0yoJHtUlStX3NcqWfb6PIeg0xVUG9dk0EebqZh39SUoYbJ1yRKlrOpqfcIA3BUMjbijOauCMiviYdijTaNRVQTMjUKk6D8OG1A5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QnCsSE3n; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QnCsSE3n"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D0F82073B;
	Mon, 29 Jan 2024 13:37:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AVbsumE61ubTjDi5BbgZ7jmORKBWUwFKQh6D6o
	dx+EM=; b=QnCsSE3ncT5819ZVcrljCcettsk2F1xrstdZ4jeyd47pWKrAsAR7tC
	mjEHjBqrEeFi5Zdn3O6MeKQPl4W6BdtNB2PUHfaMpwBBATRaboOpW5R/gC71FGZN
	HtuKsD9IyCf8dU6JEQqd6+3PpQscmCldh/eT/iPWHJYqAgipCatO4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 067382073A;
	Mon, 29 Jan 2024 13:37:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 978BF20739;
	Mon, 29 Jan 2024 13:37:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Wilfred Hughes <me@wilfred.me.uk>,  git@vger.kernel.org
Subject: Re: [PATCH] diff: handle NULL meta-info when spawning external diff
In-Reply-To: <20240129015708.GA1762343@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 28 Jan 2024 20:57:08 -0500")
References: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>
	<20240129015708.GA1762343@coredump.intra.peff.net>
Date: Mon, 29 Jan 2024 10:37:29 -0800
Message-ID: <xmqqede0htp2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75A8B3C2-BED5-11EE-A082-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

>> $ git diff --no-index foo bar
>> zsh: segmentation fault (core dumped)  git diff --no-index foo bar
>
> Thanks for providing a simple reproduction recipe. There's a pretty
> straight-forward fix below, though it leaves open some question of
> whether there's another bug lurking with --no-index (but either way, I
> think we'd want this simple fix as a first step).

Yup, I agree with you that the "--no-index" mode violates the basic
design that "the other path" and "xfrm_msg" go hand-in-hand.  In its
two tree comparison mode "git diff --no-index A/ B/", it should be
able to behave sensibly, but in its two files comparison mode to
compare plain regular files 'foo' and 'bar', there is nothing it can
do reasonably, I am afraid.  You could say that the change is
renaming 'foo' to create 'bar', and feed consistent data that is
aligned with that rename to external diff, which might be slightly
more logical than showing a change to 'foo' that has no rename
involved (i.e. omitting "other name"), but neither is satisfying.

> But I'm not sure what fallout we might have from changing that behavior
> now. So this patch takes the less-risky option, and simply teaches
> run_external_diff() to avoid passing xfrm_msg when it's NULL. That makes
> it agnostic to whether "other" and "xfrm_msg" always come as a pair. It
> fixes the segfault now, and if we want to change the --no-index "other"
> behavior on top, it will handle that, too.

Sounds sensible.

Thanks.  Will queue.
