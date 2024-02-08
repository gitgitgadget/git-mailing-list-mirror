Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670285C6E
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415603; cv=none; b=KIsmDJQAtDAz63ZLSLpNqS+NtnXIE9Sao2UjdVfxp3PfDajpC1em8/lTQZxZ1YdMRZMWndlVWqIAIB92piHSlgRevsGjFpLL7yPi810TLb4cA19ulfsxgLhpZ+7GD3+gC4ZKHxllJGyy8bI3moQPZKQlixE0pyxblXJlorB7rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415603; c=relaxed/simple;
	bh=Acfr9fQWTEl2g/99JlN4W6AVokbroFLrSJW3OWu0v9E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i6/PpW1aVV/Qw+zT8/6mKG2IKPAXQ9qVFlgIZBwPp5kF8MWtU2MSTzcEezkN/li4EGqJTteMrzZiKovWUEJ70QK4NdkcOscen6dTzXQb3vtkc842A/q612Mp61v5TBlIfIInWvSjcH198UZKV6rLsNpg9DLP6Vm8zQLk23X6cfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TLW2WjVI; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLW2WjVI"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 176001E7CD7;
	Thu,  8 Feb 2024 13:06:40 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Acfr9fQWTEl2g/99JlN4W6AVokbroFLrSJW3OW
	u0v9E=; b=TLW2WjVICbtydxBWjJ5KbJJfpX3qfvwRRZ3mMUh5WeTBMu8l+R/wf2
	KwQlaTQgQNwntMHk4MrwzI+KC2Er3cjP/x2BAzY3w4MyxXkIMQh+9ICbVap5m5nM
	hHLBtSFENdKY5ch2SjjEnozoKqy/8phLaxV83q+4q3uPE4UCtNqJI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F28C1E7CD6;
	Thu,  8 Feb 2024 13:06:40 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 739B91E7CD4;
	Thu,  8 Feb 2024 13:06:39 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Orgad Shaneh <orgads@gmail.com>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] prune: mark rebase autostash and orig-head as reachable
In-Reply-To: <pull.1656.git.1707411636382.gitgitgadget@gmail.com> (Phillip
	Wood via GitGitGadget's message of "Thu, 08 Feb 2024 17:00:36 +0000")
References: <pull.1656.git.1707411636382.gitgitgadget@gmail.com>
Date: Thu, 08 Feb 2024 10:06:38 -0800
Message-ID: <xmqqmssan841.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CE6B81FE-C6AC-11EE-8963-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Rebase records the oid of HEAD before rebasing and the commit created by
> "--autostash" in files in the rebase state directory. This means that
> the autostash commit is never reachable from any ref or reflog and when
> rebasing a detached HEAD the original HEAD can become unreachable if the
> user expires HEAD's the reflog while the rebase is running. Fix this by
> reading the relevant files when marking reachable commits.

I do not like this kind of special casing in general, but because
these are our tools' droppings, I am OK to grandfather them in, as
long as we promise ourselves that we will not add more of these
ad-hoc "text files" that record object names, loss of which affects
correctness.  They should, like "git bisect", be using proper
references to protect these objects instead, of course.

I agree with you that we might want to add pseudorefs as a starting
points of reachability traversal, but I suspect it would add
unnecessary complexity we would rather not want to deal with.

For example, not GC'ing what is pointed at by lines in FETCH_HEAD is
OK.  Excluding those objects that are only reachable from an object
mentioned by a pseudoref, when a new "git fetch" is negotiating with
a remote what objects need to be sent here, might be disastrous, as
the pseudoref that said "this object is here and you can safely
consider everything reachable from it is" will be short-lived and
can go away anytime, and an auto-gc kicking in at a wrong time ...

Thanks.
