Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731FB666
	for <git@vger.kernel.org>; Sat,  3 May 2025 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746244280; cv=none; b=djofdknJNTF/cGiE4GBZHkWTlAbvmnoPOL4otPDd+WyPc0GCX2nALkuXWD7ljrsac8ymzoubhNTD3ZrT/4U2EHpu5c7LHfg5ldBnKjbfvCEd/uo1OmwtaiU/BJidT79agU9Pp3pd466UOgI7YUxmX3A6cw1XL6IxC2XRLI99dlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746244280; c=relaxed/simple;
	bh=vhYATxX1hWfE5xGDaJn0FYij+fhrjikH4n63EOSkUao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1+8NLi1KlJV7QZuBVXgcuUbJBeja1cb3t0FPnFpX6ROMzmy6MMGqYjBD7fFKzIQKR+qU/MyxV1sSSSGC83azAzKpCE5gSl+nb6ksdcv1Lmm63s70D52UXLHwyz6Vp+TaU0KKCEG1kbjrWaJQiesvRFu4K8WxIz9oI9/UoJAYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev; spf=pass smtp.mailfrom=ameretat.dev; dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b=Waw2xOa6; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ameretat.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="Waw2xOa6"
Date: Fri, 2 May 2025 23:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
	s=default; t=1746244272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vhYATxX1hWfE5xGDaJn0FYij+fhrjikH4n63EOSkUao=;
	b=Waw2xOa62m0+z/Z3tgsZCixNYeSC3YhkKr6HQoQS2KBJEFrqkRbEEcGKYHwXr6gETYqBJa
	qIienmgkWfoG2KXG1tTKjFHTaZCgWg9/hzaklybhaEi814mCoTWyYwuio7l/5jihn2hip4
	rXvWjmz6ereqpZg3+sDLXqP2S5oZZ3Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Raymond E. Pasco" <ray@ameretat.dev>
To: Ryan Hodges <rphodges@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Jason Cho <jason11choca@proton.me>, 
	"git@vger.kernel.org" <git@vger.kernel.org>, "aclopte@gmail.com" <aclopte@gmail.com>, 
	Ryan Hodges <rhodges@cisco.com>
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
Message-ID: <4e2szrowd43w6lrzawqtddamdxvp6ke65jkzmdoru4gjin7xhn@kaqe7skrktgt>
References: <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
 <8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
 <xmqqmsbwxpfn.fsf@gitster.g>
 <ED60E13F-F9D4-4261-8C85-29AC771B5D54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED60E13F-F9D4-4261-8C85-29AC771B5D54@gmail.com>
X-Migadu-Flow: FLOW_OUT

Intents to add are a tricky part of the system; I fixed them up
some time ago for `add -p` which uses apply.c machinery, but not for
`apply -N`, which seems to have never worked since its introduction
in Git 2.19.

To recap how this all works, apply has three modes: with no flag, it
applies a diff to the physical files in the worktree; with --index it
applies a diff to both the physical files in the worktree and to the
index, and with --cached it applies to the index but *not* the physical
files in the worktree.

--intent-to-add / -N is intended to apply only to the first of these
modes; this makes sense, because an intent to add is meant to behave
like a diff not added to the index. However, the intent to add lives in
the index; Git just behaves as though it were a worktree change not in
the index.

The behavior `apply -N` actually exhibits is that it clobbers the index
with a new index containing *only* the contents of the diff, nothing
else; my guess is that it was only tested against repositories with
entirely empty trees. If the tree is not empty, then of course an index
with only the intent to add and nothing else shows up as every file in
the tree being deleted.

The patch discussed here (the headers for the thread seem broken,
but the message id is <20211106114202.3486969-1-aclopte@gmail.com>) does
seem like a mostly complete fix for the issue. However, the message is
entirely wrong and confused about how any of this works, which is likely
why the patch fell through the cracks. (Of course --intent-to-add can't
imply --index, they are mutually exclusive options.)

However, the code appears entirely correct. The combination of --cached
with -N doesn't work, despite the message claiming it does, but it can't
possibly work because it includes the file in the index, so it can't
include it as an intent to add in the index. So this just merits a note
that --intent-to-add is mutually exclusive with both --index and
--cached.

If the original author (Johannes Altmanninger) isn't around or doesn't
want to, I can clean this patch up for resubmission.
