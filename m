Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF6CC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 15:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbiDRPZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbiDRPZN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 11:25:13 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D153714
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 07:27:01 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ngSLB-0003VT-EN;
        Mon, 18 Apr 2022 15:26:58 +0100
Message-ID: <f87a549f-540e-d0f3-470c-178c2fa141a5@iee.email>
Date:   Mon, 18 Apr 2022 15:26:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Current state / standard advice for rebasing merges without
 information loss/re-entry?
Content-Language: en-GB
To:     Tao Klerks <tao@klerks.biz>, git <git@vger.kernel.org>
References: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAPMMpojjs4sjKdN6DAJFSwERdjq9XQgi35CcqkXu7HijadHa1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few personal ramblings/comments..
On 18/04/2022 12:56, Tao Klerks wrote:
> Hi folks,
>
> The discussion around Edmundo Carmona Antoranz's recent "git replay"
> proposal ([1]) led me down a rabbit-hole reminding me I really don't
> understand where we stand with rebasing merges, and I don't think I'm
> alone.
My understanding was the 'preserve' may not have retained the expected
history structure. `rebasing` merges is better with the history
expectations. Neither address the merge resolutions.
>
> I understand the standard advice at the moment to be something like:
> ---
> Use a recent git client, use the '--rebase-merges' option (avoid the
> --preserve-merges option if you find it), and re-resolve any textual
> and/or semantic conflicts manually (possibly using rerere if you know
> what you're doing).

The rerere man page is still magic for me. The UX here could be
improved. (also, could the rerere-train be focussed on each merge?)
> ---
> Is this correct?
>
> This current state/advice seems... suboptimal, at best, because it
> ignores any information encoded in the original merge commit, as
> clearly documented in the help. It will often result in you having to
> resolve conflicts that you already resolved, *where nothing relevant
> to that merge/commit has changed in your rebase*. If you have rerere,
> and you know what you are doing, and you were the one that performed
> the merge, in this repo, then maybe you're ok; similarly if it's a
> clean merge of course.
>
> Elijah Newren describes this problem/opportunity quite carefully in
> [2], and mentions a bunch of WIP that I have a hard time getting my
> head around.
>
> Similarly, Sergey Organov refers to a thread/discussion four years ago
> [3], largely involving a debate around two implementations (his and
> that of Phillip Wood?) that are largely theoretically-equivalent (in a
> majority of cases), with a lovely explanation of the theory behind the
> proposal by Igor Djordjevic / Buga [4], but that discussion appears to
> have dried up; I can't tell whether anything came of it, even if only
> a manually-usable "rebase a merge" script.
>
> Finally, Martin von Zweigbergk mentions his git-like VCS [5] which
> stores conflict data in some kinds of commit as part of a general
> "working state is always committable and auto-committed"
> state-management strategy; I may be misunderstanding something, but I
> *think* the resulting conflict-resolution information ends up being
> reusable in a manner theoretically equivalent to the strategy
> described by Buga as referenced above.
>
> These kinds of discussions frequently seem to feature git experts
> saying "I have a script for my version of this problem" (Elijah,
> Junio, Johannes Schindelin, ...), or even "I have a VCS for this
> problem" :), but I seem to be too stupid or impatient to dig
> through/understand whether or when these things will work for a
> regular joe and how to use them.
>
> The temptation, obviously(?), is to write a "rebase a merge" script to
> do something like Sergey Organov's V2 proposal referenced above... but
> it feels like I'd be spending a bunch of time and ultimately just
> making things worse for the community, rather than better - helping
> myself based on my (very limited, but still above average)
> understanding of merge mechanics, in a way that leaves the general
> public message / status just as unsatisfactory/unhelpful.
>
> Does anyone have an existing simpler answer? Ideally I'm looking for
> something like:

I believe there is a paper that highlights that even diff's aren't
unique. So I don't expect merges to be resolvable in the general case.
It's why we have software engineers;-) 

We also have to distinguish between interactive and automatic rebase,
and how much information could be provided to the user about the
previous merges (in the insn), and during resolution of a current merge
conflict compared to the prior conflict. The interactive rebase could
allow early resolution guidance from the users (e.g. highlighting likely
semantic conflicts which shouldn't be auto resolved, which to use
rerere, etc)
> ---
> * When you have a merge in your history, and you are rebasing, follow
> steps XXXXXX, involving this publicly available gist, or contrib
> script, or experimental flag, and it will probably do what you want.
> If there is a (new) conflict when rebasing the merge commit, you can
> expect conflicts to be presented as YYYYY, because rebasing a merge in
> this "informed" way can fundamentally involve multiple different
> steps/phases of conflict resolution - rebase conflicts vs merge
> conflicts.
> * Something like this will likely be introduced as a new rebase option
> in a future release, something like "--reapply-merges", or
> "--rebase-merges-better", because it will always require the user to
> understand that the three-way conflicts presented as part of such an
> "informed" merge rebase are subtly different to regular rebase or
> merge conflicts.
> ---
>
> Is it possible to get that sort of simplistic message for this complex topic?
>
> My apologies if this request is a duplicate - obviously a pointer to
> some sort of existing summary would be perfect.
>
> Thanks,
> Tao
>
> [1]: https://lore.kernel.org/git/20220413164336.101390-1-eantoranz@gmail.com/
> [2]: https://lore.kernel.org/git/CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com/
> [3]: https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
> [4]: https://public-inbox.org/git/a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com/
> [5]: https://github.com/martinvonz/jj
(I'm away 3 days, hence early comments)
--
Philip
