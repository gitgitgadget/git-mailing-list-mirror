Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761A73168EB
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419019; cv=none; b=tt3gIlv00ntoLjwbZqc/UcIWRQf5YH00r4qdSyF+Jhx0PQOfBB9LtlIvDrqF5xgbmIwFAMvE7AApZDV962YMkCNQUYW4fP676WuekFd0qYexKBJJ0zdRtYNxJiiqIZeg6UR52ve/VSz2irFqSpwJuE5i6XNLvIsSeUoDe5EwF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419019; c=relaxed/simple;
	bh=YXFvj/hjY75VkSjX6xK1pl7f94jQ/J3fB8zaxPtETu8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CkktX9ElBfWZW04uGAYOsoUkDKJ1dXksVPB+/18N1PbITb+WI1sODw6fPpjmS4bm63sFoZrvlGRx4KqnQl990cSySpvJXr98kJ1fkWdvR0DhFyItLZDVDXKeMJeB3j9gWfDmTR288IK6RXxW8UniKnSwHkDL+m9ISL9kWFSwOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lTCUYdM9; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lTCUYdM9"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773419012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xSX9IAcD8mO64nYAlOmUQ4ywTg1S24nZPc292k/ZvXk=;
	b=lTCUYdM9DNv0YwOUPMorZuLZQYc4LEnzS+LTIXB7N8eww+JlgBCgo2Mx9chFthc7CMoXxU
	GnPBxgENqRvjzSMwNiYOb8qihzTqwkf77cRR+K+ttEi24Ye/6ALv9WunAVkMR/XXtqI+kt
	0kTsX5eTyz4nL6Q6flaxVTQFOSBetqw=
From: Toon Claes <toon@iotcl.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Siddharth Asthana <siddharthasthana31@gmail.com>,
 Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] git-replay: implement subcommands
In-Reply-To: <abGutGnWo1gN0Dii@denethor>
References: <20260309-toon-replay-subcommands-v1-1-864ec82ef68a@iotcl.com>
 <abGutGnWo1gN0Dii@denethor>
Date: Fri, 13 Mar 2026 17:22:48 +0100
Message-ID: <87v7ezsnqf.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Justin Tobler <jltobler@gmail.com> writes:

> On 26/03/09 08:30PM, Toon Claes wrote:
>> git-replay(1) has various operation modes. The mode depends on which of
>> the options `--onto`, `--advance`, or `--revert` is given. These options
>> are mutually exclusive. This usage pattern is counterintuitive and
>> uncommon for Git commands to behave this way.
>> 
>> Implement subcommands into git-replay(1):
>> 
>> * `rebase`: This replaces what `--onto=` used to do.
>
> I'm a bit confused by this. It appears that the "rebase" subcommand
> still requires the `--onto` option so it doesn't seem to really be
> replacing anything. I assume we are tyring to break these operations
> into distinct categories which seems reasonable.

Okay, maybe I should be more verbose about the problem I'm trying to
solve.

Let's start with the existing option `--onto`. This implies a "rebase"
operation. The argument to this option is a revision which acts as the
base for the rebase. On this base the commits in the revision-range are
replayed.

In the end, git-replay(1) takes the ref from the upper boundary of this
revision-range, and updates that to the result of the rebase.

A usage example:

    $ git replay --onto=master master..my-branch

With option --ref-action=print, you'll get:

    update refs/heads/my-branch aaabbbccc 000111222

(using abbreviated OIDs for simplification in this email)

So 000111222 would be the commit my-branch is pointing to before the
git-replay(1), and aaabbbccc the new commit.

Now looking at `--advance`, this works differently:

    $ git replay --advance=other-branch master..my-branch

With option --ref-action=print, you'll get:

    update refs/heads/other-branch 888999000 444555666

As you can see, the argument of --advance is the ref that gets updated.

So this command would be identical to:

    $ git replay --advance=other-branch master..000111222

If we try to do use the commit OID in the revision-range when using
--onto: 

    $ git replay --onto=master master..000111222

Nothing (noticable) happens. git-replay(1) does the replay, but doesn't
know which ref to update.

This assymetry between --onto and --revert & --advance is the main issue
I'm trying to resolve with this proposal.


>> * `pick`: This replaces what `--advance=` used to do.
>> * `revert`: This replaces what `--revert=` used to do.
>> 
>> Option `--onto` is still accepted. It's mandatory for the `rebase`
>> subcommand and needs to be used in the exact same way.
>> 
>> Option `--ref` is added and required for the `pick` and `revert`
>> subcommands. This replaces what `--advance` and `--revert` used to do,
>> but as a single uniform option for all subcommands.
>> 
>> The `rebase` subcommand also accepts option `--ref`, and when given this
>> is the ref that's updated with the outcome of the git-replay(1) command.
>> Thus following commands are identical:
>> 
>>     $ git replay rebase --onto=master master..branch-1
>> 
>>     $ git replay rebase --onto=master master..branch-1^{0} --ref=refs/heads/branch-1
>> 
>> In the second example the upper boundary of the revision range is peeled
>> down to a commit (using '^{0}'). Without option `--ref`, git-replay(1)
>> doesn't know which ref to update, that's why `--ref` is passed
>> explicitly.
>> 
>> For the subcommands `pick` and `revert` it's also possible to combine
>> `--ref` and `--onto`. Here are again two identical examples:
>> 
>>     $ git replay pick --onto=branch-1 master..aabbccdd
>> 
>>     $ git replay pick --onto=branch-1^{0} master..aabbccdd --ref=refs/heads/branch-1
>> 
>> In the latter the argument for `--onto` is peeled down to a commit, so
>> the command doesn't know which ref to update. To inform git-replay(1)
>> which refs should be updated, it's passed explicitly as option `--ref`.
>> 
>> Signed-off-by: Toon Claes <toon@iotcl.com>
>> ---
>> In the patch series by Siddharth Asthana[1] the option `--revert` is
>> added to git-replay(1). This is implemented as option `--revert`, next
>> to the existing options `--advance` and `--onto`.
>> 
>> The usage of these options is mutually exclusive, so the user can only
>> use one of them, and depending on which one, git-replay(1) selects a
>> "mode of operating".
>> 
>> Various people have raised this behavior is somewhat confusing. In this
>> series we attempt to make the usage of git-replay(1) more intuitive and
>> user-friendly by implementing the modes as subcommands.
>
> Ok, subcommands for git-replay(1) seem like they could be a good fit
> here.

<3

>
>> This patch is submitted as an RFC to gather feedback about the design.
>> All changes are implemented as a single patch right now, and thus
>> reviewing the changes might be challenging. When we got people aligned
>> on the direction, I'll work toward cleaner patches.
>> 
>> These changes are based on 'master' at 864f55e190 (The second batch,
>> 2026-02-09) with the patches of Siddharth[1] applied: 'sa/replay-revert'
>> at f79189a653 (replay: add --revert mode to reverse commit changes,
>> 2026-02-19)
>> 
>> [1]: 20260218234215.89326-3-siddharthasthana31@gmail.com
>> ---
>>  Documentation/git-replay.adoc | 124 ++++++++++++++++----------
>>  builtin/replay.c              | 150 ++++++++++++++++++++++++-------
>>  replay.c                      |  66 +++++++-------
>>  replay.h                      |  31 +++----
>>  t/t3650-replay-basics.sh      | 199 +++++++++++++++++++++++-------------------
>>  5 files changed, 349 insertions(+), 221 deletions(-)
>> 
>> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
>> index ffdf790278..a7e8dac23f 100644
>> --- a/Documentation/git-replay.adoc
>> +++ b/Documentation/git-replay.adoc
>> @@ -8,8 +8,13 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
>>  
>>  SYNOPSIS
>>  --------
>> -[verse]
>> -(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
>
> Do we intent to remove the experimental marker?

Yeah, I did. I don't like them in this synopsis. It seems git-replay(1)
is the only one doing this, so I'd like to get rid of it.

Doing this should end up in a separate commit.

>> +[synopsis]
>> +git replay rebase --onto <newbase> [--ref <branch>] [--contained]
>> +		[--ref-action[=<mode>]] <revision-range>
>> +git replay pick --ref <branch> [--onto <newbase>]
>> +		[--ref-action[=<mode>]] <revision-range>
>> +git replay revert --ref <branch> [--onto <newbase>]
>> +		[--ref-action[=<mode>]] <revision-range>
>
> Subcommands with required options like this feel quite bad IMO and I'm
> not sure it makes it much more intuitive.

Okay, I did some looking up, and maybe you're right, I couldn't find any
other command that has required options. It seems all commands have some
kind of "default behavior" when no options are given.

> I guess subcommands do make it easier to convey which options pertain
> to which operation. Maybe it would be better if required arguments
> remained positional though?

I'm not sure that's better:

    [synopsis]
    git replay rebase <newbase> [--ref <branch>] [--contained]
    		[--ref-action[=<mode>]] <revision-range>
    git replay pick <branch> [--onto <newbase>]
    		[--ref-action[=<mode>]] <revision-range>
    git replay revert <branch> [--onto <newbase>]
    		[--ref-action[=<mode>]] <revision-range>

I don't think is better because the required argument for 'rebase' is
used differently than 'pick' and 'revert', as explained above.

I guess my main gripe with the current options is the naming: `--onto`
to rebase, `--advance` to cherry-pick, and `--revert` to revert. And
while the last one does sound intuitive, the argument to that option is
the branch you want to replay the reverted commits onto. So the argument
isn't *what* you're reverting, it's *where* you're reverting to.

With my proposal I wanted to make that more clear.

This proposal is trying to be not too disruptive (for example, for
rebase you only need to a add `rebase`), but that's maybe not a good
idea. So an alternative could be: on top of this proposal, make both
`--onto` and `--ref` required. In various cases the user will provide
the exact same argument to both options, but since git-replay(1) is a
plumbing command, we can consider this is acceptable?

And now, while writing this, I was thinking about yet another proposal.
Because --advance and --revert are pretty similar. Why is --revert not
an additional option you can add when using --advance. So instead of:

    git replay --revert=my-branch master..other-branch
    git replay --advance=my-branch --revert master..other-branch

@Siddharth, have you considered that?

> Also, using these subcommands appears to be required now which is a
> breaking change compared to before. The command is experimental, so this
> may be fine, but should probably be more directly mentioned.

Sure, I can do that when I clean up the commits.

-- 
Cheers,
Toon
