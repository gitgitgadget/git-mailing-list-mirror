Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459C27E1DC
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770619123; cv=none; b=vE34wjS2EiGOjSm2t/LndXNAVC24EybrWVNFPl9G6LRqdaKKSi8ChKocneD0FXfZ8jd9A38Ln6ClygHXAfBDje/zOLSkr7WFg82XDSInGnpJDSSdJv3A/HC1G3lIC1fLvUAFhdvAw06IbSSoxVkOgoHrUJp5Go914NiBhJ1DO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770619123; c=relaxed/simple;
	bh=PBsfivXaohVHikA6RAWSJL3KliE2H8VmL9+oyq2AD/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c1DLhWE7nv1qRc29vXWrL0WZKJyZW8AHob+1u+OjcEaTNZ6TmKu/haA1GPMlBXrTJfjFee8Y03DrMdusFC4SsACeOgNZV46TZxGamNp1cRavnXxPOTo7YDxpo0Rblkli4wlyqWNLDYN16ZJ4Q5NNzgEUkw/rExXAUVHvSqAYP0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=g1QFZUaS; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="g1QFZUaS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770619119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjoMHtcattxE8w8Cu5BPJe7HvLFzy/0Z76rAhmQ5Xws=;
	b=g1QFZUaS6O8aFX8B5W5rlpez9PeCHKBndquYgz22FAx0YpCUSZe9Y9cfjCRwwEb+9mW9uh
	AOIvJkmdeiDCIG22iCqk2tD2JEX7zo0uSRacjvf7mK9V+y1ZLoLQNEAyVKSXYSXNrhZuIV
	AEHbyeeQuRHStqCSRE9/uBghQ/c6m9o=
From: Toon Claes <toon@iotcl.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
In-Reply-To: <ad776ca0-1038-43f7-860d-2f3a78a5db6d@kdbg.org>
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
 <ad776ca0-1038-43f7-860d-2f3a78a5db6d@kdbg.org>
Date: Mon, 09 Feb 2026 07:38:21 +0100
Message-ID: <87h5rqqv4y.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Johannes Sixt <j6t@kdbg.org> writes:

> IMNSHO, we need a better way to show where links to parents were
> truncated. Otherwise, I must consider this chart an incorrect
> representation of the history above.

The only alternative I can come up is showing as if the branch was made
from the parent commit of the merge commit. Like so:

Real:

    *
    |\
    | *
    | *
    *  \
    |\  |
    * * |
    |/ /
    * /
    *

My current implementation:

    *
    |\
    | *
    | *
    *
    |\
    * *
    |/
    *
    *

The suggestion:

    *
    |\
    | *
    | *
    |/
    *
    |\
    * *
    |/
    *
    *

But either way, what it shown it wrong. And that's in my opinion a
tradeoff of this feature.

I've been thinking about something else. Display in some way part of the
history is missing, maybe by showing a '.' in the graph:

    *
    |\
    | *
    | *
    | .
    *
    |\
    * *
    |/
    *
    *

This indicates a piece of the history is truncated. I'm still on the
fence about this

>
>> As you can see, this untangles the arms of the octopus.
>
> This example is too small to show any real improvement. But I think I
> understood what the goal is.

I would like to invite anyone here to try the feature on some of your
repositories you have. I feel it's impossible to really demonstrate it's
power through some examples over email.

> So, the option's effect is to untangle visual representation of the
> history. It is achieved by truncating links between merge-bases and
> commits that appear in non-first parent links.

Yes, that's the idea.

> How does this work with criss-cross merges?
>
>   Z
>  / \
> o   o
> |\ /|
> | x |
> |/ \|
> o   o
>  \ /
>   A

I haven't tried it yet.

>
> (not sure how --graph would represent this...)
>
> How does this work with backward merges?
>
> * main
> |\
> * | C
> | * sync with main
> |/|
> * | B
> | * A
> |/
> * initial

I've been trying in this first version to address that, but I haven't
been fully able to make it work.

I assume you and other readers know, but your example is a
simplification of:

    * main
    |\
    * | C
    | * sync with main
    | |\
    | |/
    |/|
    * | B
    | * A
    |/
    * initial

So here there merge-base isn't the first parent, so things get a little
more complicated. Also when 'B' is ignored as merge-base, the merge-base
needs to be recalculated to be 'initial'.

Anyhow, the idea is to show it like this:

    * main
    |\
    * | C
    | * sync with main
    * | B
    | * A
    * initial

If you don't like my proposal of being fully disconnected from the
merge-base, we could consider using a different symbol for "truncated"
history:

    * main
    |\
    * | C
    | + sync with main
    * | B
    | + A
    * initial

The commits with a '+' have more parents but they are not shown.

> How does this interact with --boundary?

Haven't tried it yet.

> Speaking of which, boundary commits are listed last. Since they need to
> be linked to the commits for which they are the boundary, a whole lot of
> these "unnecessary" lines accumulate the longer the list of commits is.

That's good to know, when I continue work on this feature.

> If only there were a way to show boundary commits as soon as possible,
> then this accumulation would not happen.

I'll need to dive deeper into this to understand what you're saying
here.

-- 
Cheers,
Toon
