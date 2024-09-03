Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DB19006A
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725387797; cv=none; b=dzJJAhpoG+lk1Y4AoZctKFb1HXkDcmaYG2J3Kjug4qPuboKUKD6rK88hw6cGAUXWLwJIQ3IRhn6rZrhU8NogLpfiB/uqcJ0HeOHoIe84y0Vb2iPGerE2TTwIgC5snXZr3M91pMASIgMQFkTicbroUGMuxzcxwrINnq9S7nby+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725387797; c=relaxed/simple;
	bh=4Te6Xbmlxa5f3f280EOVbeR0nuROms8XD+lD+gapPFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsZSsIuQ5UviaAwm5JdypF8rZwwhViR87kFFV5Qh/skxyQFiFLzOTrr8Cv8Zn+1EmKZkfbJKQJU7o/2NYwxYAsBABB08nxIDY6dbmjE5FjanqbY1AnYlSE9Lp4NtY/tfEDJqrK402l2do0hMsCziSkv1NIHOd0GuCb0hwAjKE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pSQ82B9C; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pSQ82B9C"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BAD2E27E21;
	Tue,  3 Sep 2024 14:23:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4Te6Xbmlxa5f3f280EOVbeR0nuROms8XD+lD+g
	apPFk=; b=pSQ82B9CpXRioNCbBd1n3BhkMsZyikqtDJFRgVtLLLDsG9CxjNRkHW
	XtmB/uun3GBLkZWjOEwZNVOaymlKwIm/4mjs7uQNSxZ8yqjZeeMd8/S5GNnMtBa5
	riFBlZiHwGAnXk2kzMDDO1mrTseBJJT3jcTdC1vafuy24Q2HT8qBI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B13A727E20;
	Tue,  3 Sep 2024 14:23:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 207AD27E1F;
	Tue,  3 Sep 2024 14:23:14 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: karthik nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] refs/files: use heuristic to decide whether to
 repack with `--auto`
In-Reply-To: <ZtbVbn5rxrmLFuNa@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Sep 2024 11:23:00 +0200")
References: <cover.1725280479.git.ps@pks.im>
	<9a63abfe3b812a32d69c7393004bea4f88971559.1725280479.git.ps@pks.im>
	<CAOLa=ZRGvU4LvX9kjvF3dJCTvKR6CC1CwPTp515c3Wt5M8a5vA@mail.gmail.com>
	<ZtbVbn5rxrmLFuNa@pks.im>
Date: Tue, 03 Sep 2024 11:23:12 -0700
Message-ID: <xmqq4j6wlhpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 95349D26-6A21-11EF-AE87-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I also noticed `log2i()`, but honestly the only reason why I didn't
> reuse it is that I had no clue where to put it. There isn't any header
> that would be a good fit for it, and creating a new "math.h" header for
> a single function felt overblown to me. So I decided to just not bother.
> I'm happy to adjust though if somebody has a suggestion for where to put
> it.

Given the existing contents of wrapper.h (near the end of the file),
I think wrapper.c would be a good place to do so.

Shouldn't this essentially be a call to ffs() with the argument
tweaked, by the way?

