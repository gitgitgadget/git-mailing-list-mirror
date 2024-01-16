Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBE20319
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444237; cv=none; b=Sn3htGt36knH/HgTGdG2tqn5CkIn9RGDjVZIGoZKJPoh8ZhmMgZfiaj+ArLnEzRhoZK7XD7KiSIWD5mrknKv0epVCIuOzK/7vhsdhEdDvzLtXA9ePi7TMw6fEDh7ztsuDSZs3sdyxvqg5zr/eTy0Q7h4Vwb+ncvRWqIVrdDtWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444237; c=relaxed/simple;
	bh=daVjCPeUfkk0F3bxwOj98/4JnRmObUhYnYBHla+hg5M=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=m/8rz+R1JL4WggFA5AdDuQl3b1CPnxB2PYp9pOMuwBTjY9nAuuKvCHHrWlQgKfDd7Z6Sh7XHMaKY3jZdS/NCVVPzDshGHj+WQzpEC672qbp0Rj1sbxR0yPAqHCYK2A9eh8sFe/q1TuGAGuYZIwX/hqV6sTtbYRnEN+S2Iesnrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAJIabzb; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAJIabzb"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E57DB1A331;
	Tue, 16 Jan 2024 17:30:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=daVjCPeUfkk0F3bxwOj98/4JnRmObUhYnYBHla
	+hg5M=; b=TAJIabzbgzQPidiCHtUfO36you2mbEnmeoPlHqQixg+UI57TZWl0Rk
	sMvu0weshaTRliJeF4LyD4Et4wlxN/Ilvf4qhBV3xQZLPNWO/217yiRo0HHWndRk
	Clpdf3Fr1MCrtk0wHM8tSdJlehuiPOKX4C/Wwho7aESCFFxpmqaTU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE92D1A330;
	Tue, 16 Jan 2024 17:30:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ABFDD1A32F;
	Tue, 16 Jan 2024 17:30:31 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kevin Wang via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kevin Wang <kevmo314@gmail.com>
Subject: Re: [PATCH] bisect: add --force flag to force checkout
In-Reply-To: <pull.1641.git.git.1705302307639.gitgitgadget@gmail.com> (Kevin
	Wang via GitGitGadget's message of "Mon, 15 Jan 2024 07:05:07 +0000")
References: <pull.1641.git.git.1705302307639.gitgitgadget@gmail.com>
Date: Tue, 16 Jan 2024 14:30:30 -0800
Message-ID: <xmqqmst4ykqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DBA9EA5E-B4BE-11EE-9475-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Kevin Wang via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kevin Wang <kevmo314@gmail.com>
>
> Adds a `--force`/`-f` flag to `git bisect good/bad` and `git bisect run` to
> force a checkout. Currently, if the repository state adds any local changes
> the user must manually reset the repository state before moving to the next
> bisection step. This can happen with package lock files or log output data,
> for example. With this change, a developer can run `git bisect run --force`
> to automatically reset the repository state after each evaluation. The flag
> is also supported as `git bisect (good|bad) --force` as well.

The usual way to compose a log message is to

 - Give an observation on how the current system work in the present
   tense (so no need to say "Currently X is Y", just "X is Y"), and
   discuss what you perceive as a problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to the make codebase "like so".

in this order.

To those who have been intimately following the discussion, it often
is understandable without both, but we are not writing for those who
review the patches.  We are writing for future readers who are not
aware of the review discussion we have on list, so we should give
something to prepare them by setting the stage and stating the
objective first, before going into how the patch solved it.

Having said all that.

I highly doubt that this patch is a good idea.  If your "bisect run"
script needs to update something in the working tree before it runs
some test, the script is in a much better place than Git, which is
unaware of what your run script is doing, to prepare the working
tree into pristine state.  The best Git would be able to do would be
to "reset --hard", but that will lose local modifications that are
deliberately there and has nothing to do with what your run script
did.

Adding some description to the documentation of "bisect run" and
teaching readers a common trick of structuring their run script
better might be a more productive approach, I would have to say.
For example, when I bisect some old code, I may have to apply a
temporary patch to some of the sources to get them compile with more
recent compilers (I usually do this with a cherry-picking of a local
fixup).  So my "bisect run" script might go like so:

    #!/bin/sh
    # bisect run

    git apply local-fixup || exit 125
    make test
    status=$?
    make distclean
    git apply -R local-fixup || exit 125
    exit $status

That is, I'd apply some local fix-up to the working tree files
before running tests, and once done, I revert the local fix-up
and exit from the run script with the exit status of the test
I wanted to perform.
    
This way, I can keep other local changes (things like changes to
documentation files that I am working on, which has nothing to do
with the problem I am bisecting but I know they do not interfere)
without wiping them away with a sledgehammer "reset --hard".  Your
"bisect good/bad -f" sounds like the sledgehammer approach to me.

Thanks.
