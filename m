Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3336D27FB37
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 19:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782328558; cv=none; b=l3fThsNSCWT09TG38JbFxIFiFMoOUZ58iAMEv2EzqhSUfsuSplaQ6j3BdFrcJCQGuWiRv1c3GwEITjp1JVYHWQw/vfN1f6y4sozv50Qy+ePoZmD5CXWcjetA5U0//MJjLKNU9oCK1THrI6v4+oihZ7EnNQSm4d4/5mfB17pwz8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782328558; c=relaxed/simple;
	bh=nr9Uv4JMGpiO8chzPpoxrWhhUqZTo1xALxC59u3ZSuA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PjlGjhTtxLBtC14oCH2xs4xT22tXvaUQhNUmaYX1yWyVN2Qxn+imoalww+ZgCKW6t5VK6XkY91svlmERH9MA2auyisysdeHOd6UBuTQHG0pP6qEcyMCGhfM3tVV7t9eUq6c+RJlumjvV5RsVr3dElRaJcTQmNYsVChTvYpqSQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VdHJI6Wz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VdHJI6Wz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1782328553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEBEl/VmJ4u9iYSHhUTq2hurrNvcXXIGWmG4kAUtUWk=;
	b=VdHJI6WzFEItgxUN2JwZHuXWEtWXZ2drKBClxTUitxRuRq9RA2tdd21ReTaLU2GwQ+iwgw
	UNOpiVGWfZOifsSRq0jUet8i8+p8XbjJrgedWBj/j+MN/SoAY5ZX31NNSuJ3fleO5mTha6
	1tOXYXcRvF2hq839y6si23PwLXdMSdQ=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/3] replay: refactor enum replay_mode into a bool
In-Reply-To: <xmqq7bnq37jm.fsf@gitster.g>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-1-ff257f534319@iotcl.com>
 <ajk-YQxLWfspNWIm@pks.im> <xmqq7bnq37jm.fsf@gitster.g>
Date: Wed, 24 Jun 2026 21:15:45 +0200
Message-ID: <87tsqrycke.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> That's fair, and the result is easier to write. But is it really easier
>> to read?

You're bringing up a very valid point there, and not directly in what
you're saying, but how it makes me reconsider.

So we're comparing:

    pick_regular_commit(revs->repo, commit, replayed_commits,
                        mode == REPLAY_MODE_REVERT ? last_commit : onto,
                        &merge_opt, &result, mode, opts->empty);

with:

    pick_regular_commit(revs->repo, commit, replayed_commits,
                        reverse ? last_commit : onto,
                        &merge_opt, &result, reverse, opts->empty);

You can argue which of both is easier to read, but the problem isn't
really whether it's a bool or an enum, but the ternary operator in this
lengthy function call is. That is the problem I was trying to solve, and
converting enum to bool isn't really the solution.

>> And what if we ever have to create a third mode going forward?

Personally I find this weak argument. As far as I know we most of the
time do not write code in a way so "it will be ready to add X in the
future". In my personal experience, I'm always wrong in predicting what
might be added in the future. Although I must say this case is
different, because we're not adding something new, no this commit was
dumbing down something existing. So I'll revisit this commit in the next
iteration.

>> I'm generally no fan of booleans as parameters as they basically give
>> you no information at all at the callsite, except if you're lucky and
>> you already have an aptly-named variable available that you can pass.
>> Which seems to be the case here, but I'm still not sure whether this
>> change really improves the code.

That's also a very valid argument, which I didn't take in mind.

> I tend to agree with you on both counts.  The "what happens when
> somebody else wants a third choice?" is a quesiton I would ask the
> first thing as the maintainer of a project.
>
> Even if the boolean parameter is so obviously named, the callsite
> can only say "true" or "false", unlike some other popular languages
> that lets you say
>
> 	my_function(use_revert_mode=true, verbose=false);
>
> and you cannot tell what effect the author wanted out of that "true"
> if all you can write were
>
> 	my_function(true, false);
>
> Of course, we could go ultra verbose, like
>
> 	my_function(true, /* use_revert_mode */
> 		    false, /* verbose */);
>
> but then we are often better off writing:
>
> 	my_function(REPLAY_MODE_REVERT, REPLAY_QUIET);

Thanks for bringing in this illustrative example. Point made, I'll
revisit.

-- 
Cheers,
Toon
