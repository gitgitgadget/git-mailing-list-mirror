Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAEBC4361A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0324221F4
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 19:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgLCTtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 14:49:14 -0500
Received: from mail.javad.com ([54.86.164.124]:53416 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgLCTtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 14:49:14 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 1671E3E96D;
        Thu,  3 Dec 2020 19:48:33 +0000 (UTC)
Received: from osv by osv with local (Exim 4.92)
        (envelope-from <sorganov@gmail.com>)
        id 1kkuad-0003zR-Hf; Thu, 03 Dec 2020 22:48:31 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
Date:   Thu, 03 Dec 2020 22:48:31 +0300
In-Reply-To: <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
        (Elijah Newren's message of "Wed, 2 Dec 2020 23:54:08 -0800")
Message-ID: <871rg6hdrk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> These patch series implement new set of options governing the diff output
>> of merge commits, all under the umbrella of the single --diff-merges=<mode>
>> option. Most of the new options being synonyms for -m/-c/--cc options,
>> there is also additional functionality provided, allowing to get the format
>> of "-p --first-parent" without change in history traversal that
>> --first-parent option causes.
>>
>> The net result of these series are the following new options:
>>
>> --diff-merges=   |  old equivalent
>> -----------------+----------------
>> first-parent     | --first-parent (only format implications)
>> separate         | -m
>> combined         | -c
>> dense-combined   | --cc
>
> Interesting.  I have some local patches implementing another choice,
> with the new flag --remerge-diff.  This flag will cause `git show` or
> `git log` to automatically remerge the two parents in a 2-parent merge
> commit, and then diff the merge commit against that automatic merge,
> showing the result.  Thus, the diff for a merge commit is likely to be
> empty if the merge was clean, and is likely to show the removal of
> conflict markers if the merge was not clean.
>
> I'm curious how it'd interact with this new option.  Would it also get
> a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
> can't come up with anything better.

Maybe, --diff-merges=remerge?

>
> Also, I'm curious how it'd interact with another option I added, named
> --remerge-diff-only.  This latter option modifies revision traversal
> in that it skips octopus merges, root commits, and single parent
> commits IF no cherry-pick or revert information can be found.  If it
> finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
> finds a 1-parent commit with cherry-pick or revert information, it'll
> do an in memory repeat of that cherry-pick (or revert) and then diff
> the actual commit against what the automatic cherry-pick would
> perform.  Again, that likely means an empty diff if the automatic
> cherry-pick was clean, and showing any changes made by the user to
> complete the original cherry-pick (such as deleting conflict markers
> and picking which chunks from which side to keep) if the automatic
> cherry-pick was not clean.  (I suspect --remerge-diff-only is much
> more likely to be used with `git show` than with `git log`.)  Anyway,
> your changes seem to suggest that anything relating to how diffs for
> merges are handled should be documented in the same section, but
> --remerge-diff-only doesn't fit.  And it'd seem odd to have
> --remerge-diff and --remerge-diff-only not show up in adjacently but
> be split into separate sections.  Any ideas?

Sounds like commits limiting option to me. I think it could be named by
its limiting behavior only, say, --remerges. Then it will imply
--diff-merges=remerge, that'd allow user to re-define diff format if she
needs to.

I mean, it looks very similar to --first-parent to me in the ways it
could be defined/implemented. Recall that --first-parent now implies
--diff-merges=first-parent.

[...]

>>
>> Updates in v1:
>
> A minor point, but this should have been labelled v2.  The unlabelled
> original submission is v1.

Well, I did consider it when prepared v1, but given:

  git format-patch --reroll-count=0

produces [PATCH], it only sounds natural to follow with

  git format-patch --reroll-count=1

that produces [PATCH v1].

Thanks,
-- Sergey Organov
