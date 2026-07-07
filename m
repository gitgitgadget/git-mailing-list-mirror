Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34137B02B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436974; cv=none; b=ZwXF2F5bsdhPt0CGhmowhqjAU8me2wZb1mzGytErtwLA9JJbz+eLtoCeREjATkPrAVYh9lT/HkNOci7PGWO+KJF/D9BCjVkPVDqQKtCA1pL7fuldQUbyUO7bVsDOT/V0eD9WVjO3Heh0olSRbwLXj1x81KdrZDk39V1zqddLk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436974; c=relaxed/simple;
	bh=i3tpCBqz91PwlWDskV9BwK1w0Zd8M1e6QJ5U2d6jL9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fG46PxZNNNqOlRjpZ4jJOgUg+c2CjuMEvLrKnmTjmRqOm9dGoE57d5rNRnduOpXS+gWO1yzLo68bxjSrJL6kqBQJ0EJvZUx4YSjhVwFUlOUAvYYYzYKJusYkamtTpIm3205TPFgCKD1UA/Xi3B1OYknrJ96cD5dzzPg0K4ZwgZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=1/yd6cg+; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="1/yd6cg+"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783436965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGHTRe/uM9zMhMt8tBXykhwqWFQvq/RjZSbbJMMCc8M=;
	b=1/yd6cg+kreLUdK/bBaX3iq+LoTf/qNQ0lAaFAC1kIsELJ4Z8LoF1kongPJascxMcElijV
	yrKhiIy8RkeQrNhoT6VWTJ/Sxq6KACe7v5BCx3kAuNle2JYb1jOKA7K3WrjIXALHK00baS
	UmjGFBijJSYJDyuBw7nCDaYBwaBslFg=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>, Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <xmqqbjcnhjvk.fsf@gitster.g>
References: <20260702-toon-git-replay-drop-merges-v6-0-78a07cdd0382@iotcl.com>
 <20260702-toon-git-replay-drop-merges-v6-3-78a07cdd0382@iotcl.com>
 <xmqqbjcnhjvk.fsf@gitster.g>
Date: Tue, 07 Jul 2026 17:09:09 +0200
Message-ID: <87ldbm3kh6.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> ...
>> Linearizing is a distinct operation, and flattening merge commits is
>> just one aspect of that. Recreating merges would be a separate mode, so
>> rather than mirror git-rebase(1)'s `--rebase-merges[=3D<mode>]` interfac=
e,
>> git-replay(1) uses its own `--linearize` option.
>>
>> Co-authored-by: Toon Claes <toon@iotcl.com>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>>  Documentation/git-replay.adoc |  21 ++++++-
>>  builtin/replay.c              |   6 +-
>>  replay.c                      |  54 ++++++++++------
>>  replay.h                      |   5 ++
>>  t/t3650-replay-basics.sh      | 140 +++++++++++++++++++++++++++++++++++=
++++++-
>>  5 files changed, 203 insertions(+), 23 deletions(-)
>
> With such an extensive change in behaviour, I wonder if Dscho is
> still responsible for latent bugs in this round of implementation
> and documentation, or should you take the responsibility over?

I don't mind. But I don't want to steal credit.

Initially, when Dscho shared the patch with me, he already informed me
he doesn't really care about authorship. So in the next version I'll be
taking over authorship and add a Based-on-patches-by trailer.

@Dscho, let me know if you disagree?

>> +--linearize::
>> +	In this mode, each replayed commit is stacked on top of the
>> +	previously replayed one, so all replayed commits are flattened into
>> +	a single linear history.
>> ++
>> +When a merge commit is encountered, the behavior of git-rebase(1)'s
>> +option `--no-rebase-merges` is imitated. All commits in the range
>> +reachable from the merge commit are replayed into a linear history, and
>> +the merge commit itself is dropped. A ref that pointed to a merge commit
>> +is updated to the merge's last replayed ancestor.
>> ++
>> +This flattens the `<revision-range>` as a whole. When multiple revision
>> +ranges are given they are stacked on top of each other into one linear
>> +history. Each of their refs is updated to point to its position in that
>> +history. To linearize ranges separately, replay them in separate `git
>> +replay` invocations.
>
> OK, very much understandable.
>
>> +This option is incompatible with `--revert`.
>
> Definitely it is OK to leave it outside the scope, but I am not sure
> if reverting a group of commits that happens to be "closed" and
> happens to contain merges, is inherently incompatible with
> flattening.  If you have
>
>     ----O--A
>          \  \
>           B--M--C
>
> and you want to revert what happened while the history advanced from
> O to M, I would na=C3=AFvely expect that I can arrive at
>
>     ----O--A
>          \  \
>           B--M--C-B'-A'
>
> by linearly applying the inverse of A and B (in either order).

You're absolutely right. Personally I'm not sure why the limitation was
introduced. I've done some testing and I cannot see why we wouldn't
allow --revert and --linearize to be combined. So I'll be submitting v7
without this restriction.

--=20
Cheers,
Toon
