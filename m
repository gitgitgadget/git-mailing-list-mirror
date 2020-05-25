Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF5C433DF
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2CC207D8
	for <git@archiver.kernel.org>; Mon, 25 May 2020 17:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388615AbgEYR3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 13:29:51 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:17144 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388230AbgEYR3v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 13:29:51 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jdGv6-0008jw-3Z; Mon, 25 May 2020 18:29:48 +0100
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com>
 <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com>
 <nycvar.QRO.7.76.6.2005071626340.56@tvgsbejvaqbjf.bet>
 <1a03a7b4-f436-83c5-f825-3b68c07785e9@iee.email>
 <4f2ddbba-a9ba-a96a-36c1-b233ea861575@gmail.com>
 <fc616e86-dfc1-fccf-d22b-ad2aee0d1b16@iee.email>
 <nycvar.QRO.7.76.6.2005180522230.55@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9a9e7432-7a74-f46e-9a77-b8acaa9a974f@iee.email>
Date:   Mon, 25 May 2020 18:29:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2005180522230.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 18/05/2020 04:27, Johannes Schindelin wrote:
> Hi Philip,
>
> On Mon, 18 May 2020, Philip Oakley wrote:
>
>> On 08/05/2020 17:57, Andrei Rybak wrote:
>>> On 2020-05-08 18:43, Philip Oakley wrote:
>>>> On 07/05/2020 15:27, Johannes Schindelin wrote:
>>>> Is this ability to have a commit message `fixup! <commit-hash>` documented?
>>>> I've looked a few times in the past and didn't find it. The docs for
>>>> `git commit --fixup=` doesn't put the oid in the commit's subject line,
>>>> rather it puts the subject of the referent commit after the "fixup! ".
>>>>
>>>> Searching from a different direction I've just seen it is mentioned in
>>>> the v1.7.4 release notes.
>>>>
>>>> Would a doc fix to clarify this be appropriate or have I missed something?
>>>>
>>>> Philip
>>> Yes, it's documented in description of --autosquash: "A commit matches the `...`
>>> if the commit subject matches, or if the `...` refers to the commit's hash."
>> The docs don't  clarify if a full oid has is required, or a unique
>> abbreviation within the repository, or just unique within the rebase
>> instruction sheet.
> It's even worse: _any_ valid reference will do. As you can see from
> https://github.com/git/git/blob/efcab5b7a3d2/sequencer.c#L5359-L5381, the
> search goes like this:
>
>   - For the remainder of the `fixup! <remainder>` line:
>
> 	1. If it is identical to the oneline of any commit mentioned in a
> 	   previously-seen `pick` line, pick that as target.
>
> 	2. Otherwise, if the remainder can be looked up as a commit
> 	   (think: `fixup! master~3`) _and_ that commit was mentioned in
> 	   a previously-seen `pick` line, pick that as target.
>
> 	3. If all else fails, and if the remainder is the _start_ of a
> 	   oneline of a commit previously seen in a `pick` line, pick that
> 	   as target (if multiple lines match, use the first one).
>
> Do feel free to put that into a native-speaker form of a patch to improve
> the documentation.
>
>
Sorry for the delay on a reply to this one.  I do have a small couple of
patches to slightly improve the docs. Hope to send soon.

I'm thinking that for the longer term it may need a section covering
fixup/squash, so as to cover all the different user interaction stages,
e.g. the commit options, and commit message; and then the initial
interactive instruction sheet, and on-going edits of the instruction
sheet when the rebase pauses.

In particular, the (assuming proper understanding) the interjection
between the almost identical 1 & 3  [identical vs start of the oneline
of a commit in the `pick` (insn) list...], of the ability to specify an
almost arbitrary rev. I still have to check the code to see what it
does/tries to do.

Philip 
