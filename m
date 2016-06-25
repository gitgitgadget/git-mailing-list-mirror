Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7101FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 20:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693AbcFYUT6 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 16:19:58 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44207 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbcFYUT6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Jun 2016 16:19:58 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id 3766D403D5;
	Sat, 25 Jun 2016 14:19:56 -0600 (CST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
Date:	Sat, 25 Jun 2016 14:19:54 -0600
Cc:	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <15A0703E-92CD-4736-AF7D-5E809D7CEDF7@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org> <1FEF5F90-6534-4D91-B27C-16FE6D16EC3F@brennie.ca> <xmqq1t3ldpdl.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On Jun 25, 2016, at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Barret Rennie <barret@brennie.ca> writes:
> 
>>> What is "the name for the worktree"? Is it the directory where it lives in?
>>> Is it how it is listed with 'git worktree list'?
>> 
>> The name of the worktree is the name of the created directory in
>> `.git/worktrees`.
>> 
>>> How is --name different from the <path> argument?
>> 
>> Currently, if you run:
>> 	
>> 	git worktree add /my/worktree/checkout <branch>
>> 
>> you get a worktree "named" checkout, i.e., `.git/worktrees/checkout`. The
>> idea with this patch is to allow you use a more specific name when you would
>> otherwise have mulitiple worktrees of the form `checkout`, `checkout1`, etc.
>> 
>> That is, you could do
>> 
>> 	git worktree add --name branch1 /worktrees/branch1/src branch1
>> 	git worktree add --name branch2 /worktrees/branch2/src branch2
>> 	git worktree add --name branch3 /worktrees/branch3/src branch3
>> 
>> and have `.git/worktrees/branch1`, `.git/worktrees/branch2` and
>> `.git/worktrees/branch3` instead of `.git/worktrees/src`,
>> `.git/worktrees/src1`, `.git/worktrees/src2`. That way, it becomes more clear
>> when poking inside `.git/worktrees` which directory points to which checkout.
> 
> That is a way better justification of "why we need to use a custom
> name, not the default one" than the previous "with this we can use a
> custom name".
> 
> As long as you can justify why having anything underneath branch$n/
> is necessary, that is.  In your explanation above, it is still
> unclear why you need a checkout at /worktrees/branch$n/src/, and why
> it would not work if it is at /worktrees/branch$n/.

That was a less-than-concrete example, I'll grant you. I do follow the method
you suggest below for the projects I maintain with this workflow.

> 
> Note that I am not saying "there cannot be a good reason, do not add
> this feature" when I say "it is unclear why".  I am encouraging you
> and others in this discussion thread to find good use cases for the
> proposed new feature and come up with materials to help improving
> the documentation part of the patch.  That way, the users with
> similar needs can find how the feature is supposed to be used and
> understand the feature better.
> 
> I suspect that this new feature might be useful when two more more
> interdependent projects (they could be organized as submodules in a
> superproject, but they can be independent checkouts of different
> projects) are used together.  Imagine frotz and nitfol projects, and
> without fancier setup to have multiple checkouts, you may be
> expected (by these two projects) to check them out like so:
> 
>    $top/frotz/
>    $top/libs/nitfol/
> 
> where $top can be anywhere but to clarify the line of thought, lets
> pick a concrete place, say $HOME/xyzzy.  So without worktrees, you
> would have
> 
>    $HOME/xyzzy/frotz
>    $HOME/xyzzy/libs/nitfol
> 
> Now, if you do the worktree, you may still want the relative
> structure between these two, i.e. if you want to work on two
> different branch combinations of the whole thing, you would want to
> do this:
> 
>    $HOME/xyzzy-1/frotz       - borrow from $HOME/xyzzy/frotz
>    $HOME/xyzzy-1/libs/nitfol - likewise for nitfol
> 
>    $HOME/xyzzy-2/frotz       - borrow from $HOME/xyzzy/frotz
>    $HOME/xyzzy-2/libs/nitfol - likewise for nitfol
> 
> where xyzzy-$n may be for topic-$n branch both in frotz and nitfol.
> 
> And explained that way, it becomes clearer that you would want to
> name $HOME/xyzzy-1/frotz worktree after "topic-1", not the default
> name you would get "frotz" (because the default gives you the leaf
> level name of the newly created worktree).
> 
> After the discussion above (which may or may not match what you
> raised this topic for), I think a feature to let you override the
> default name makes sense.
> 
> It just needs to be explained better to help the users when the
> feature eventually becomes part of Git.  Also, others (especially
> Duy) may have even better ideas (e.g. instead of having to always
> use --name to give custom name for all worktrees, set a "hint" just
> once to help the logic that comes up with the default name give a
> better name), so while the feature may be desirable, your exact
> implementation may or may not be what we eventually want to adopt.

Would you like me to re-submit this with a more detailed
explanation in the commit message? Also, I agree that always having
to use `--name` to set a custom name could be possibly cumbersome.
An alternate way I can think of would be to a config option such as
`worktree.nameHint` which would let you set the kind of name you'd
like for your worktrees, say `default` (the current behaviour) or
`branch` (where it would be named <topic-branch><n>).

The only issue I have with that is I maintain two projects that
have a dependency on the same version of a library. My current
project directory looks like the following:

projects/reviewboard/branches/
	2.5.x/
		reviewboard/  # Version 2.0
		djblets/      # Version 0.8
	3.0.x/
		reviewboard/  # Version 3.0
		djblets/      # Version 0.10

projects/splat/src/
	splat/    # master checkout
	djblets/  # Version 0.10

If we used some sort of hint system, I'd end up with two worktrees
named something like `release-0.10.x` and `release-0.10.x1`, which
is better than the current situation, but still not ideal for my
use case.

If someone suggests a better scheme for naming the worktrees, I'd
be happy to rewrite this patch to use it.

> Thanks.
Thanks for reviewing.

