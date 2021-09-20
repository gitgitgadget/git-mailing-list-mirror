Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9367AC433F5
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F11F61077
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 11:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhITLlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:41:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:62649 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232528AbhITLlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 07:41:50 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mSHeo-0004iC-6o; Mon, 20 Sep 2021 12:40:22 +0100
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
 <87k0jcb01k.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <88dfc31a-187c-6609-0df6-d6b970b1a136@iee.email>
Date:   Mon, 20 Sep 2021 12:40:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87k0jcb01k.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2021 00:44, Ævar Arnfjörð Bjarmason wrote:
> On Sun, Sep 19 2021, Jeff King wrote:
>
>> On Sat, Sep 18, 2021 at 03:18:47PM +0100, Philip Oakley wrote:
>>
>>> Is there a method within `git rev-list` to trim side branch merges where
>>> the merge's tree is identical to the first parent's commit-tree?
>>> [...]
>>> From my reading of the `rev-list` manual this is similar to the <paths>
>>> TREESAME capability, but without specifying any paths (maybe just `.` ?).
>> Yes, I'd just do "git log ." for this. I don't think there's another way
>> to trigger simplification. In try_to_simplify_commit(), we bail early
>> unless revs->prune is set, and that is set only by the presence of
>> pathspecs or by --simplify-by-decoration.
>>
>>> * Is there a proper term for the treesame condition of the commit-tree
>>> (as recorded in the commit object)?
>> In a one-parent commit, I'd just call it an empty commit. For a merge,
>> it is really I'd probably call it an "ours" merge, since one obvious way
>> to get there is with "git merge -s ours" (of course you can also just
>> resolve all conflicts in favor of one parent). I don't know of another
>> name (besides treesame, of course, but that generally implies a
>> particular scope of interest given by a pathspec).
> Isn't it a "theirs" merge, not "ours"? Per the description Philip has:
>
>     In the Git-for Windows repository, the previous releases are
>     'deadheaded' by merging with the upstream git, and simply taking the
>     upstream's tree unconditionally[...]

In that sense, yes. From the gfw branch's perspective, the merge is 100%
that of git/master. It provides an 'out-of-line' commit onto which the
gfw patches can be rebased.
It's almost identical to a ball-of-mud progressive (incremental) merge,
but neatly refactored.
>
> I.e. if you're taking your tree unconditionally it's -s ours, but -s
> theirs for theirs. Except of course for the small matter of us not
> having a "-s theirs" yet.

There used to be a `theirs` strategy but (IIRC) it was removed by Linus
years ago (before I discovered git and it's ability to distribute
control..).

One thing that catches me, and I think others, is how the 'strategies'
work. IIUC a merge will look at each line in the diff, and accept any
change on either side that has no conflicts within the context zone.
It's only when there are changes from both sides that the selection
strategy kicks in. But it is difficult to describe, so it's easy to be
confused.

It doesn't look like this type of rebasing workflow for a
multi-platform/product scenarios was considered at the time. [1-4]

Either way, having a few clues (where to look in the code) to including
a `--deadhead` history simplification is useful.
>
> I had a WIP patch a while ago for a "-s theirs -X N", for what sounds
> like a similar use-case:
> https://lore.kernel.org/git/87sh7sdtc1.fsf@evledraar.gmail.com/

[1]
https://stackoverflow.com/questions/173919/is-there-a-theirs-version-of-git-merge-s-ours
[2]
https://lore.kernel.org/git/alpine.DEB.1.00.0807290123300.2725@eeepc-johanness/
[3] https://lore.kernel.org/git/7vtzen7bul.fsf@gitster.siamese.dyndns.org/
[4]
https://lore.kernel.org/git/xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com/
