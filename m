Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BF328B73
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952285; cv=none; b=N3OmFHYa0SmEi144Lk9wker51Rnt34GbLhJbe/IBsshASPxXN3vYSsWepVDiYe6dYBp2QQmtCpuzsswvwix8pYg/5e4LE/zYykGIn2Lb+IzwRtHOyCIrQnziCEXPGbtrCCyjMNTf96ZxES0k29aCs8myd/JZ8zVVd8SB6ZGfFs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952285; c=relaxed/simple;
	bh=Kmq3vbUHuA7TWsZSwVODeAF4ghAZIwlDHyoNi4xypmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Np1kW+fu4IMCUj2j8jjvvPvMv1cU9EGdkL4qePlcF/80Di5E95RR0CjLru5uy9qPec5Y6UrUxL5JhB9HnGVBImIIyDFAwyZdAMLlLeUeGsMRKJb5VFgZXPQqcr11yhJysvEWk2ZQVexSz16M+wqqRcjD4SEkUXPkNQx6MrvGI1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Oy+HLkGk; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Oy+HLkGk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1762952278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HfgSMA95HqWawb03JZhRwVOXrIIBwuXjG9ftUphDngo=;
	b=Oy+HLkGkgmDrnWDg8YMepF40lYcxtAxQmzqhXosxD26FYbkLULPNQn220P+DnooJHJDZrE
	TqzvOM7TlzLuCcjd9QLovIql3iWcz6Tx/bZaQt7nhwnoLMIbattoa8bTxmJTD6bila0PJr
	hpFBAFkh1uliPGVB7bTe75U+m2c55U0=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: Re: What's cooking in git.git (Nov 2025, #03; Fri, 7)
In-Reply-To: <xmqq8qghfz8x.fsf@gitster.g>
References: <xmqq8qghfz8x.fsf@gitster.g>
Date: Wed, 12 Nov 2025 13:56:47 +0100
Message-ID: <87jyzvwgs0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> * tc/last-modified-active-paths-optimization (2025-10-23) 1 commit
>   (merged to 'next' on 2025-11-03 at 9ab444edfb)
>  + last-modified: implement faster algorithm
>
>  "git last-modified" was optimized by narrowing the set of paths to
>  follow as it dug deeper in the history.
>
>  Will cook in 'next'.
>  source: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>

Do you plan to include these changes in the upcoming v2.52 release? I
would like to argue to include them.

Maybe it wasn't very clear how I phrased it in the v4 cover letter[1],
but without this patch, some results are wrong:

> As an added benefit, results are more consistent now. For example
> implementation in 'master' gives:
> 
>     $ git log --max-count=1 --format=%H -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de
> 
>     $ git last-modified -- pkt-line.h
>     15df15fe07ef66b51302bb77e393f3c5502629de	pkt-line.h
> 
>     $ git last-modified | grep pkt-line.h
>     5b49c1af03e600c286f63d9d9c9fb01403230b9f	pkt-line.h
> 
> With the changes in this patch the results of git-last-modified(1)
> always match those of `git log --max-count=1`.

So this patch speeds up git-last-modified(1), but it also fixes some
buggy results. That's why I consider this a bug fix and worthy to make
it into the upcoming release. (which is by the way also the first
release that includes this subcommand)

[1]: https://lore.kernel.org/git/20251103154726.26592-1-toon@iotcl.com/

-- 
Cheers,
Toon
