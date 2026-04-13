Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AAE36E47A
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117898; cv=none; b=k7i7fFmRq05271bCV5JlM1B6H2P2cOIQ6l+01VTc3uDc0C3ovwxtWsio7ytLfoQv/h/orGd5kTL7OATdI5DNu79pPhemVL7JFFuB65Wj//Va4ap94UznPbKKwp4/+0pLqlquwlOCqrsMnAJ5Gq/Aja+zuhFrxWWDOgRoVKUNqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117898; c=relaxed/simple;
	bh=aoDZPnSVyp77r29V1mkiYSYEn5+oM5mDGxH6fx6NnjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0D34cEYXEXkHlsxPq1/b4Y9qfu/YsaNL93MsCZWZH+DNmyFq71haeWUBoHrsqIfjq1pFM+68QGjHmGwtm1pxgWqHXpKkBNOtOb3Fkumfv6xx4DOBpVWIHW36H0mHDt7VNGgIZXMEV6VjIUX+eg3vbIPJbDSW9COB4sIk6c2Ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=SQHTLqSs; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="SQHTLqSs"
Date: Tue, 14 Apr 2026 00:04:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776117885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NjqnoOAicpS8Y6q6a/WdgGC08wNo/VgZ7CLf5ZHRy5M=;
	b=SQHTLqSskJ6VlLqGYilxfKrI+pipHgAsHKiRBlblV9TCZjqSLiN/IbXAitThPk1ZNbl65j
	2UEcICUiDMTVzLOgVM2SG4KClWNuWyzCr/FLiBjajRyTXyHXujkUugWBdwvd7G8Mwth5Ks
	k8t4CpWZIrYedwRbCJOsheiM/S1Xc+iQNBoCGYB9PdO2/6GiUJk811SY2nkMJOQYwmOAQZ
	pbjTbC+pXJb0Srj2Rvbwjp6Dq7hD0sizDdRBBZZyiPABbn/eeWX2GoD0CJDGEhQZrDufhn
	+ZeYPDwMKQDWJcmuGARuDnLyoOF2hRYRB8T1Sk+5qMFn0/UEnhVo4VvSvf8gVg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mirko Faina <mroik@delayed.space>
Subject: Re: [RFD] not grep but not log -S
Message-ID: <ad1oMLdO4ZMVo__O@exploit>
References: <xmqq4ileh822.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ileh822.fsf@gitster.g>
X-Spamd-Bar: --

On Mon, Apr 13, 2026 at 02:19:49PM -0700, Junio C Hamano wrote:
> may give something close to what I want, but it makes me feel dirty
> that I have to _guess_ how many is sufficient.

If you know when it is introduced and when it goes away you don't have
to guess at all. You should be able to log start..end (and filtering the
appropiate subject line).

    topic=jc/test-set-e-clean
    git log $(git log --oneline -S$topic --reverse whats-cooking.txt | \
        head -n1 | cut -d \  -f 1)~1..$(git log --oneline -S$topic \
        --max-count=1 whats-cooking.txt | cut -d \  -f 1)

I know it's a bit long but this way you won't have to guess (and I'm
assuming is going in a script anyway). The log command to get the first
and last occurrence would go on their own line as well.

    last=$(git log --oneline -Sjc/test-set-e-clean --max-count=1 \
        whats-cooking.txt | cut -d \  -f 1)
    first=$(git log --oneline -Sjc/test-set-e-clean --reverse \
        whats-cooking.txt | head -n1 | cut -d \  -f 1)
    git log $first~1..$last

I would've used --max-count=1 to get just the first occurrence instead
of using 'head', but '--reverse', '-S' and '--max-count' don't interact
in the way a user might obviously presume (and I'm assuming it's a bug).


P.S. sorry if I end up in your inbox twice, I forgot to cc the list.
