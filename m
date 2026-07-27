Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502793FCB0C
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157668; cv=none; b=M0KmMQXvVmBrXny7bMPD48hpfFVqs6TQb19xMRuUAFn9M4tQ1HoX0JAHtHfpGkpN1ZfEB4iqUq2v40L6C4iq6p9tTmfKz2ctmZxiifDi0hNosByYBLMYxqHpc+P0rDgjK4EMjDiNrZ4qwkjybJQO9hkekGyKMo7Kol4TxdfxyWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157668; c=relaxed/simple;
	bh=2lb6XMJeBKqz4XQREsqm3Ky2eA2eVpe0urW/nU1wblI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E7S2i4KNbo7w5J3fopPj2n5X+Vx94RWqOR0BbXu5Nwp/RnfWfnMVYOjziaNPxRwWaMVm0VL/sXSyN6ygRk007IIIH4STA00g+DbKHpSo9c26jTai6TrZ1X6QPJj5WLFCoMlgSBitA8x3a0ZBXytcGE7R/1bgQYivf3aCCxvbZi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=feSqeqAn; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="feSqeqAn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1785157662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E7CZcLlSw57n8O8kHKW5xKzpOk72myzzaELG0YHSjVs=;
	b=feSqeqAnTeBLBbiMBJTS2eDmwwUx97wWTvL9pKk5ogy+PlOeZxD5T7SdAhXKrVqbjw8gdR
	hPDrXVOi9RXCjIl9QHU+NR/dUs1954cmxD+tYT6ubxVfnMZ36JqSMMl/Zo4B1p6l01IB4c
	m2Zb7PZMBZkKZQyQKI5yCIN4B/M4BJo=
From: Toon Claes <toon@iotcl.com>
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <CABPp-BGdK8v8Qk5XB=QL_yJDPTNjSb2rN08GiPpK50V2gAj1QQ@mail.gmail.com>
References: <20260707-toon-git-replay-drop-merges-v7-0-808ab9b4afa6@iotcl.com>
 <20260707-toon-git-replay-drop-merges-v7-3-808ab9b4afa6@iotcl.com>
 <CABPp-BGzU9KHGF1nipi2HZaa1AiikMKGGaapQzHVH06wO4V1ww@mail.gmail.com>
 <xmqqbjcawnhp.fsf@gitster.g>
 <CABPp-BGxO0bd3UzDYNnhNUgDSKYwcFVCFsJ9rCzmNX7Q0xBrow@mail.gmail.com>
 <xmqqse5km6lc.fsf@gitster.g>
 <CABPp-BGdK8v8Qk5XB=QL_yJDPTNjSb2rN08GiPpK50V2gAj1QQ@mail.gmail.com>
Date: Mon, 27 Jul 2026 15:07:24 +0200
Message-ID: <87bjbs4m43.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Elijah Newren <newren@gmail.com> writes:

> As I proposed last time, I'd be fine with erroring on multiple
> positive refs as an interim step (plus associated documentation and
> commit message updates) so this series lands, with per-branch
> linearization as the real fix later.

I appreciate you're open to this interim step, but I would like to
understand the end goal better before we continue.

> TL;DR version; my problems with the current implementation of
> `--linearize` are that it:
>   * Makes the rare usecase easy, and ignores the common usecase

Cannot deny that, although I'm not sure git-replay(1) is a popular
end-user command.

>   * Makes it asymmetrically difficult to recover for those that wanted
> the common usecase instead of the easy

I don't think many users would use --linearize anyway. I'm guessing
properly replaying merges would be far more useful to most people.
I'm adding it mostly to scratch my own itch: do a server-side
non-interactive rebase that's identical git-rebase(1)'s
--no-rebase-merges.

>   * Makes `--linearize` mean something other than "remove non-linearity"

It's debatable what it means, because you can think of it linearizing
all reachable commits (see also below what you said context of
gitrevisions(7)).

>   * Turns multiple branches into one, but updates several branches anyway
>   * Ignores order specified by the user on the command line
>   * Introduces an inconsistency within git-replay between `--advance`
> and `--linearize --onto`
> (The last three items being minor compared to the first three.)

I'm surprised you consider these three more minor, because I have more
issues with them personally (the ordering in particular).

I don't have a feasible example, but as I understand from your
argumentation, v7 might make commits reachable from a branch where they
weren't before:

> M1  M2  M3  M4  M5
> *---*---*---*---* <- master
>                 |
>                 |  A1  A2  A3  A4
>                 |--*---*---*---* <- branchA
>                 |      \
>                 |       -*---* <- branchC
>                 |        C1  C2
>                 |
>                 \-*---*---* <- branchB
>                   B1  B2  B3
> 
> With the current implementation of --linearize, adding that flag, i.e.
>     git replay --linearize --onto master branchA branchB branchC
> would instead give something like:
> 
> M1  M2  M3  M4  M5  B1  B2  B3  A1  A2  C1  C2  A3  A4
> *---*---*---*---*---*---*---*---*---*---*---*---*---*
>                 ^           ^               ^       ^
>                 |           |               |       |
>               master     branchB         branchC  branchA

Before the replay, branchC didn't reach any commits in branchB, while it
does now. It kind of makes sense though, because branchC is specified
after branchB. But then again, why does now branchA contain branchB and
branchC? That's the problem I have with the ordering.

> I think I know what you mean, but this isn't quite right:
> git-replay(1) only ever accepts a single revision range.  From
> gitrevisions(7) (also in git-rev-parse(1)):
> 
>        Commands that are specifically designed to take two distinct ranges
>        (e.g. "git range-diff R1 R2" to compare two ranges) do exist, but they
>        are exceptions. Unless otherwise noted, all "git" commands that operate
>        on a set of commits work on a single revision range. In other words,
>        writing two "two-dot range notation" next to each other, e.g.
> 
>            $ git log A..B C..D
> 
>        does not specify two revision ranges for most commands. Instead it will
>        name a single connected set of commits, i.e. those that are reachable
>        from either B or D but are reachable from neither A or C.

You could think v7's implementation of --linearize converts the
"distinct ranges" into a "single connected set of commits", but then the
option name isn't very good.

> The reason I am comfortable with erroring out as a stopgap: turning an
> error into working behavior later never breaks anyone, whereas letting the
> current concatenation semantics reach 'master' risks users coming to
> depend on them, which would make switching to the better behavior a
> compatibility break.

I absolutely agree with that approach.

> Erroring now keeps our options open; merging as-is
> quietly closes them.  (git-replay is still EXPERIMENTAL, so this is not
> fatal either way, but it seems better not to paint ourselves into a
> corner.)

Being EXPERIMENTAL allows us to break things if we discover we didn't
think about before, that's not the case here.

But then again, what do we do about --contained?

M1  M2  M3  M4  M5
*---*---*---*---* <- master
     \
      \  A1  A2  A3  A4  A5  A6
       \-*---*---*---*---*---* <- branchA
          \   \     /   /
           \   *---*   /  <- branchB
            \  B1  B2 /
             \---*---/  <- branchC
                 C1

This would end up into something like:

M1  M2  M3  M4  M5
*---*---*---*---* <- master
                |
                |   A1  A2  A3  B1  B2  C1 A6
                \---*---*---*---*---*---*---* <- branchA
                           branchB -^   ^- branchC

Same issue, branchC suddenly contains the commits of branchB.

The only way we can linearize (as in flatten merges) these branches is
by replaying some commits twice:

M1  M2  M3  M4  M5
*---*---*---*---* <- master
                |
                |   A1  A2  A3  B1  B2  C1 A6
                \---*---*---*---*---*---*---* <- branchA
                     \   \
                      \   \---*---*           <- branchB
                       \     B1'  B2'
                        \---*                 <- branchC
                            C1'

But is that what the user wants? They could achieve that with running
git-replay(1) once for every single branch separately (let's assume they
set COMMITTER_DATE).
Is this the end goal we want for --linearize with multiple revision
ranges? I don't think that's doable with the last_commit per branch.

But for now, I would say --contained is not allowed with --linearize as
well.

And maybe, maybe we should make --ref required when --linearize is
given. Then the user would do something like:

    $ git replay --onto master branchA branchB branchC --ref branchA

This makes the end result unambiguous: take all commits reachable from
these 3 branches, replay them linearly onto 'master' and *only* update
ref 'branchA'.


-- 
Cheers,
Toon
