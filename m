Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C2433A3
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271734; cv=none; b=CDHMRaV+wQq1qqEW77tFDsDWA3Wts8iCTfQZ3yhIFyL88Lb5zaM+ohOv89nBWmqXgZI5VTxARHJinG3Ab32BgncdAIpAkgsVRlxXTLq/mCbj0pQpczTg5qEFYfje/VJ3X7h3B/99enYlpGkUZ9+EdJFgDt+a5yc89I0KF9qWt64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271734; c=relaxed/simple;
	bh=2HkxvGZx6dT+8taC7d0dhspMRbIFEqN1/n1KGsOsV5s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJcoycADK+cLaeJwevRADYCVSTSesfz/NwMkjJVXo86Q7+Lsv/bTa1iMafmpZR5oQYhND5oQNEATq+EeL9RwyLfcMnbgq7FqVAFo6ivXDhrS3etA87WsS3OQ1fUNiZnONgMU4CBwWcnEaU82Z5idwAAfbH6zmCDqyjR2/nYerJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h8IYvTz0; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h8IYvTz0"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 057173049F;
	Tue, 12 Mar 2024 15:28:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2HkxvGZx6dT+8taC7d0dhspMRbIFEqN1/n1KGs
	OsV5s=; b=h8IYvTz0NLzZGxkndW/G41Zu7cPfAFnPauhJsBNOOr4rNeFHeBpG5N
	vBMmkYrGjGUZZ+Oy1+W4CJNdsnpqSlN2Sk5udc/PIOMaX4uZfRkcYfmrgbxagMko
	osMUkjQtiAwmEoSt8aTWBaKeJfTHewLj2nt1mT2o/7skSysLKbZnU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EE1D63049E;
	Tue, 12 Mar 2024 15:28:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98EA130461;
	Tue, 12 Mar 2024 15:28:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] cat-file: add %(objectmode) avoid verifying
 submodules' OIDs
In-Reply-To: <20240312085901.GA69635@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 12 Mar 2024 04:59:01 -0400")
References: <pull.1689.git.1710183362.gitgitgadget@gmail.com>
	<xmqqwmq8o36j.fsf@gitster.g>
	<20240312085901.GA69635@coredump.intra.peff.net>
Date: Tue, 12 Mar 2024 12:28:48 -0700
Message-ID: <xmqq1q8fl05r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C0A70750-E0A6-11EE-BBCA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> That is an interesting direction. In practice I guess you might want to
> expand trees (to show their contents) or perhaps commits (to traverse
> history and/or look at their trees). And we already have tools to do
> that.
>
> So for example you can already do:
>
>   git ls-tree --format='%(objectname) %(objectmode)' HEAD
>
> Or if you wanted to mix-and-match with other cat-file placeholders, you
> can do:
>
>   git ls-tree --format='%(objectname) %(objectmode)' HEAD |
>   git cat-file --batch-check='%(objectname) %(deltabase) %(rest)'
>
> That is a little less efficient (we look up the object twice), but once
> you are working with hex object ids it is not too bad (cat-file is
> heavily optimized here). Of course in the long run I think we should
> move to a future where the formatting code is shared, and you can just
> ask ls-tree for deltabase if you want to.

I was imagining more about a use case "cat-file --batch" was
originally designed for---having a long-running single process
and ask any and all questions you have about various objects in the
object database by interacting with it.  So "yes, ls-tree can
already give us that information", while it is true, shoots at a
different direction from what I had in mind.

> The strategy so far has been making sure cat-file can efficiently take
> in the output of these other tools to further describe objects. But
> moving towards a unified output formatting model would be even better, I
> think. In the meantime, I think cat-file learning %(objectmode) makes
> sense for single names (rather than listing trees), and fortunately it
> uses the same (obvious) name that ls-tree does, so we won't have a
> problem unifying them later.

Yes, enriching the output format side is an orthogonal issue from
the input side, and the %(objectmode) thing that gives a piece of
information that is additionally available on top of the various
pieces of information about the object itself does make sense.

> The patch itself looked reasonable to me, modulo the comments you
> already made.
>
> -Peff
