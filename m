Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B2C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0262063A
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389652AbgDAQnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:43:42 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:41440 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389362AbgDAQnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 12:43:41 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jJgSn-0000Hu-8r; Wed, 01 Apr 2020 17:43:38 +0100
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     phillip.wood@dunelm.org.uk, George Spelvin <lkml@SDF.ORG>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <20200331000018.GD9199@SDF.ORG>
 <7fbe0ddc-74a3-b6b5-09b1-bff171382d0e@iee.email>
 <ef1a1475-45b3-8696-ed1e-b28f7b655ece@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <60cd00c2-7aba-3d74-11fa-d4443f6cd83e@iee.email>
Date:   Wed, 1 Apr 2020 17:43:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ef1a1475-45b3-8696-ed1e-b28f7b655ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 31/03/2020 14:36, Phillip Wood wrote:
> Hi Philip, George and Johannes
>
> I really like the idea of being able to extend or rewind an existing
> rebase to reedit commits.
>
> On 31/03/2020 11:57, Philip Oakley wrote:
>> Hi george,
>>
>> On 31/03/2020 01:00, George Spelvin wrote:
>>> Thinking about Philip Oakley's suggestion, it dawned on me that
>>> we can *already* do a nested rebase manually, and having a less
>>> manual alias for the procedure would be reasonable.
>>>
>>> Suppose the last four commits are O-A-B-C, and whether they were
>>> created
>>> by this rebase or existed before is irrelevant.
>>>
>>> If I want to rebase --nested -i O, then I --edit-todo and
>>
>> Maybe `--rework` as a possible alternate option name, if the concept of
>> it being truly nested process does not work out?
>
> or `--rewind` ?

A possibility, though it feels a bit narrow in suggesting the capabilities
>
>>> prepend the following four lines:
>>> reset O
>>> pick A
>>> pick B
>>> pick C
>>>
>>> If a nested rebase command does just that, I think it would cover my
>>> use case.  If it adds a comment saying "nested rebase ends here",
>>> it's easy to cancel the nested rebase if there was a mistake.
>>>
>>> A slightly fancier thing a nestrd rebase could do is see if any of the
>>> newly created picks are also used in merges that were already in the
>>> todo
>>> list.  In that case, follow the pick by a label command and update the
>>> later merge to refer to the label.
>
> If we're going to support rewinding a rebase that creates merges then
> this is a prerequisite otherwise it wont work properly. It will also
> need to update any existing labels that refer to a commits that get
> rewritten when rewinding.

I would agree that the `label` instruction would need expanding to allow
arbitrary refs (e.g. specific oids and other branches) to be labelled
rather than just a presumed 'HEAD' ref. I did notice the man page
doesn't actually define the format of the extra instructions (there was
fun with awkward chars in label names on Windows).

I'm of the opinion that we don't re-label/rename the previous labels -
they are what they are, but we do offer the ability to provide new
labels. Hence the extension to the label format to allow the labelling
of arbitrary refs, not just HEAD, along with showing existing progress,
so folks can _see_ the new oids etc.
>
> When cancelling the nested rebase we need to take care to restore any
> labels to their previous value if they have been updated by the nested
> rebase. We also need to restore the list or rewritten commits so that
> we don't report that we've rewritten the commits from the nested
> rebase that we're aborting. These two requirements unfortunately make
> it difficult to implement the nested rebase just by updating the todo
> list. 

I'm against the original conceptual idea of 'nesting' (or rewinding).
What's done is done, it's in the object store, as is all the old
original work, so we have a wider foundation to build from.  Clearly we
are not in a clean work-state, with the half complete jobs, so it's more
of a recovery activity than clean coding (from the user perspective).

> It needs to save the current labels (and reference the commits
> somewhere so they don't get gc'd) and the rewritten-list. `git rebase
> --abort` (or whatever we end up using to abort the nested part of the
> rebase) needs to restore the labels and rewritten-list. I think it
> should probably restore the todo list as well - if the original part
> of the todo list gets edited during the nested rebase should we drop
> those changes to the list or keep them when the nested rebase is aborted?

If we haven't aborted, then we just have the actual sequence of work,
with some of the commits, ultimately, being left as unconnected stubs
(once their temporary tips have gone upon completion of the rebase -
could they be explicitly dropped?).  On completion, those abandoned
commits could be explicitly marked as having been removed in the various
book-keeping lists and logs (if it was useful and helpful). I think this
is a different conceptual view of the work of the rebase - resolve process.
>
> Best Wishes
>
> Phillip
--
Philip
