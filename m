Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28605279DC3
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770459240; cv=none; b=pFQRIIhENCnCjd3jdEh2vLcucKbcwjq4ZCLEBcBmMvmEFxsbY2s3/gr9T5T4/LTilByBEf6QriATEjse3zCB5E/blEKEHAG17dP2Od2G/5jvWY20ndIADAYF2shKqQDhCVqQLMQQqlwfYd+suwroZrTrarQ2s0NEFaqY0B9aFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770459240; c=relaxed/simple;
	bh=MDzG04AoFqkK+ENRYg3doX1GR31+Wy8jGnmSuqEswXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=FobjvBdnUEe6hUjXpOdsZBetYLieJMA1kSdhRlPd5j8HYcM1bpPPnMf//8GvVQJP+/WFbYQl3vwym5XsehcTSC2L3qq1X0XOcdqv8gjJu2OuVPwA/ynBLM5PqvegQXb0F1bScI1wJJutbQb3ShvGVyuB+nnaHI/yPUuqt3tOntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4f7QjJ6gKbz7QTlV
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 10:32:36 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4f7Qj71kw6zRnlX;
	Sat,  7 Feb 2026 10:32:25 +0100 (CET)
Message-ID: <ad776ca0-1038-43f7-860d-2f3a78a5db6d@kdbg.org>
Date: Sat, 7 Feb 2026 10:32:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] graph: implement git-log(1) --untangle
To: Toon Claes <toon@iotcl.com>
References: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20260206-toon-log-graph-no-merge-base-v1-1-a6f983991a1d@iotcl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.02.26 um 19:49 schrieb Toon Claes:
> The output of `git log --graph` can be cluttered when dealing with
> long-living branches or octopus merges.
> 
> For example consider this graph:
> 
>     * left
>     | *-.   octopus-merge
>     |/|\ \
>     | | | * 4
>     | | * | 3
>     | | |/
>     | * / 2
>     | |/
>     * / 1
>     |/
>     * initial
> 
> The reason this looks messy, is because for each merged branch there is
> a line back to the source branch. But in most cases, the user doesn't
> care when merged branches are branched of.
> 
> To simplify the graph, implement option `--untangle`.
> 
>     * left
>     | *-.   octopus-merge
>     |/|\ \
>     | | | * 4
>     | | * 3
>     | * 2
>     * 1
>     * initial

IMNSHO, we need a better way to show where links to parents were
truncated. Otherwise, I must consider this chart an incorrect
representation of the history above.

> As you can see, this untangles the arms of the octopus.

This example is too small to show any real improvement. But I think I
understood what the goal is.

> To implement this feature, merge commits are treated a differently. For
> each parent commit (except the first one) of a merge, the merge-base
> with the first parent is found. That merge-base is saved in the column
> for that branch and when the next commit for the column would be that
> merge-base, no lines are drawn no more.

So, the option's effect is to untangle visual representation of the
history. It is achieved by truncating links between merge-bases and
commits that appear in non-first parent links.

How does this work with criss-cross merges?

  Z
 / \
o   o
|\ /|
| x |
|/ \|
o   o
 \ /
  A

(not sure how --graph would represent this...)

How does this work with backward merges?

* main
|\
* | C
| * sync with main
|/|
* | B
| * A
|/
* initial

How does this interact with --boundary?

Speaking of which, boundary commits are listed last. Since they need to
be linked to the commits for which they are the boundary, a whole lot of
these "unnecessary" lines accumulate the longer the list of commits is.
If only there were a way to show boundary commits as soon as possible,
then this accumulation would not happen.

-- Hannes

