Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8213A6B8F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774432996; cv=none; b=pexPCm8nx0yAheh5xrsiRnwBPwtP97rm3fdrjX9FWU7+1UkCmKGZvGBkmjDpsNy+a0l+ErHqPC71zVo6rdVRyAgn2MUTflRvgnEhE8wY+OyzKpWRPoLOax7tJ1ameY+tgvvFUmsC+Po/NZ4S8iQncY0vNPIdIwRPL1uaug82Cq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774432996; c=relaxed/simple;
	bh=CGBO1atrbNWXhIhjeyApXRDN1oXOckicrhqdD/x/HLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyHztcBKhoqdaFY5sXbqYjgqcHPO9CcTdrsAbXajIKUor/NDVwRQhjt8H+r3qB1tlVQa5diflZ4rBPn+RF31joikxy0yUxTvCOXRr3rDvo+zOcxknt10U4MTFccn1OI8c093NH08f8hQ5GP2MVvuVEk2mbHhgFtxzHeGeqmvudg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4fgjCF5K0qz7RN14
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 11:03:05 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4fgjC44JVCzRnlX;
	Wed, 25 Mar 2026 11:02:56 +0100 (CET)
Message-ID: <fae2f8e3-029a-43c7-aa6e-45a452026853@kdbg.org>
Date: Wed, 25 Mar 2026 11:02:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v4 0/3] graph: add --graph-lane-limit option
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com,
 ayu.chandekar@gmail.com, siddharthasthana31@gmail.com,
 chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260323215935.74486-1-pabloosabaterr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> Repositories that have many active branches at the same time produce
> wide graphs. A lane consists of two columns, the edge and the space
> padding, each branch takes a lane in the graph and there is no way
> to limit how many can be shown.

Generally, I like the goal of this patch series. However, the way in
which it is presented and justified can be improved substantially, IMO.

It begins with the statement of what this patch series wants to achieve.
It is "limit the width of the graph", isn't it? It is not "add
--graph-lane-limit"; that is just a tool to achieve the goal.

To help reviewers, you should present an example chart in the cover
letter that shows the before- and after-state (with and without the user
of the new option).

As far as the separation into patches is concerned, I see a few
problems. With the current separation is difficult to justify the
patches. For example, the first patch adds prerequisites for a later
patch, but it is unclear how these are used. The answer to the question
"Why do we need this?" is simply "because the next patch uses them", but
this is a very weak justification, because the next questions are "how
are they used and why didn't you squash this into the next patch?"

Let me suggest a different separation.

1. The first patch limits the graph width with a hard-coded limit, say
15 lanes. It limits the graph *always*. Choose a limit that is large
enough to pass all tests.

2. The next patch adds --graph-lane-limit and its documentation. Let it
do its thing. Revert to the default limit value 0, i.e., unlimited.

3. Next, add additional eye-candy. I am alluding to the line that marks
where a graph lane was truncated.

(4. If more detailed document is warranted, e.g., an example chart, do
this as a separate patch that can now show all bells and whistles that
the earlier commits have implemented. Whether this makes sense as a
separate step, or whether documentation grows with the earlier patches,
is a judgement call.)

As far as commit messages are concerned, always, always provide an
answer to "Why?" for every detail.

- Why do we want to limit the graph width?
- Why is the hard-coded limit 15? (because it lets tests pass and is
still a useful limit; we'll make it dynamic later.)
- Why do we always limit the graph width? (Because it makes this patch
simpler; we'll fix this later.)
- Why does 0 mean unlimited? (Consistency with --max-parents.)
- Why is the truncation marked with a fullstop "."? (...)

I'll also look over the patches, but I don't do C code, so I can provide
only superficial comments, if any.

-- Hannes

