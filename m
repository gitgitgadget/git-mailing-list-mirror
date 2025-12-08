Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699D3B8D6F
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765194475; cv=none; b=P9/TBrNJ6GxS3AunsV0WM3m7TUq1BVoPXs2k8/2Ju7dKxuxdFiP8XkvUofBhNenq7CC+2Tpd3d+sA4wlsJQ+DW/3P8FhQSeuPhvkyPaUnSkaGKsvXxMHH1oX6o3u9Z71CHDrdXLWWfyBS4OMEh5EC6lMorW51NLh55/+mii3070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765194475; c=relaxed/simple;
	bh=0Lxp6QIH+WVwAn4hOvnplHIAlGxYsjt/XqQ2/6hURcY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SyMa7swtvZ64c6HknoqEzCebxOnApFizg1e8e+yVjlDqSV8X+Zwh4w01HItHA10XmF42OhcVaPkPn5MGBT3GSS+6iJmX1WYCwyOaHtMsiDUOTNlfzmLK/3PltCSeyr78eVPTfiqafsO2d93BFFGoS8ZqjapZsff0gsQXZ+5cono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=y+sw30on; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="y+sw30on"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1765194470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ko7LV9tjK2IkEJcBiUE9hKRwWZSEj8zDAv0evJu08pI=;
	b=y+sw30onvlFZqPRsA+l6tqiNJRBIOa8QOpPSqPZFYTQ8XMssb298d82XkHenRBxEthrHPF
	mDk6VHKHfJK/Xqhr56Ao8wjba3+Yjhpd1ONNodWC9RGIC8gpTBznQ3UtQtKrRSDWQ33Iy2
	U0CGAvlCLfla8sHkHIAz7LKVnR3On1E=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Anders
 Kaseorg <andersk@mit.edu>
Subject: Re: [PATCH] last-modified: fix bug caused by inproper initialized
 memory
In-Reply-To: <20251128205514.GA605489@coredump.intra.peff.net>
References: <20251128-toon-big-endian-ci-v1-1-80da0f629c1e@iotcl.com>
 <20251128205514.GA605489@coredump.intra.peff.net>
Date: Mon, 08 Dec 2025 12:47:20 +0100
Message-ID: <87bjk9w5yv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> I think this patch makes sense as the most obvious and immediate fix.
> But thinking on how we might have avoided this bug:
>
>   - We have macros like ALLOC_ARRAY() and COPY_ARRAY() that
>     automatically multiply the array length by the size of each element
>     (by looking at the type of the array). We could in theory have a
>     helper like:
>
>       MEMSET_ARRAY(lm->scratch->words, 0x0, lm->scratch->word_alloc);
>
>     that would have made this hard to get wrong. But that's actually a
>     bit of a funny interface, because memset is inherently byte-oriented
>     under the hood. So we are not setting each element to 0x0, but
>     rather each byte. For a value of 0x0, that is the same thing. But if
>     you chose, say "0x1", it is not.
>
>     So it would probably have to be limited to something like:
>
>       CLEAR_ARRAY(lm->scratch->words, lm->scratch->word_alloc);
>
>     which I'd guess would cover most memset cases. But this is getting
>     specific enough that maybe the macro is making things more confusing
>     rather than less.

I've submitted a v2 that introduces MEMZERO_ARRAY(). I'm curious what
the responses on this proposal are?

-- 
Cheers,
Toon
