Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4181F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 13:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfJIN52 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 09:57:28 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:16309 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJIN52 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 09:57:28 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iICSx-0008AZ-45; Wed, 09 Oct 2019 14:57:23 +0100
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our
 Azure Pipeline
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
 <pull.288.v3.git.gitgitgadget@gmail.com>
 <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.1910062237440.46@tvgsbejvaqbjf.bet>
 <xmqq1rvp5pc0.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910072350300.46@tvgsbejvaqbjf.bet>
 <xmqqzhicnfmr.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910081423250.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9ccbdb9a-845f-a534-29b6-52cfe9eb3229@iee.email>
Date:   Wed, 9 Oct 2019 14:57:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910081423250.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 08/10/2019 13:46, Johannes Schindelin wrote:
> Hi Junio,
>
> On Tue, 8 Oct 2019, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>>> I didn't quite understand this part, though.
>>>>
>>>>      The default creation factor is 60 (roughly speaking, it wants 60% of
>>>>      the lines to match between two patches, otherwise it considers the
>>>>      patches to be unrelated).
>>>>
>>>> Would the updated creation factor used which is 95 (roughly
>>>> speaking) want 95% of the lines to match between two patches?
>>>>
>>>> That would make the matching logic even pickier and reject more
>>>> paring, so I must be reading the statement wrong X-<.
>>> No, I must have written the opposite of what I tried to say, is all.
>> So, cfactor of 60 means at most 60% is allowed to differ and the
>> two patches are still considered to be related, while 95 means only
>> 5% needs to be common?  That would make more sense to me.
> Okay, I not only wrote the opposite of what I wanted to say, I also
> misremembered.
>
> When `range-diff` tries to determine matching pairs of patches, it
> builds an `(m+n)x(m+n)` cost matrix, where `m` is the number of patches
> in the first commit range and `n` is the number of patches in the second
> one.
>
> Why not `m x n`? Well, that's the obvious matrix, and that's what it
> starts with, essentially assigning the number of lines of the diff
> between the diffs as "cost".
>
> But then `git range-diff` extends the cost matrix to allow for _all_ of
> the `m` patches to be considered deleted, and _all_ of the `n` patches
> to be added. As cost, it cannot use a "diff of diffs" because there is
> no second diff. So it uses the number of lines of the one diff it has,
> multiplied by the creation factor interpreted as a percentage.
>
> The naive creation factor would be 100%, which is (almost) as if we
> assumed an empty diff for the missing diff. But that would make the
> range-diff too eager to dismiss rewrites, as experience obviously showed
> (not my experience, but Thomas Rast's, who came up with `tbdiff` after
> all): the diff of diffs includes a diff header, for example.
>
> The interpretation I offered (although I inverted what I wanted to say)
> is similar in spirit to that metric (which is not actually a metric, I
> believe, because I expect it to violate the triangle inequality) is
> obviously inaccurate: the number of lines of the diff of diffs does not
> say anything about the number of matching lines, quite to the contrary,
> it correlates somewhat to the number of non-matching lines.
>
> So a better interpretation would have been:
>
> 	The default creation factor is 60 (roughly speaking, it wants at
> 	most 60% of the diffs' lines to differ, otherwise it considers
> 	them not to be a match.
>
> This is still inaccurate, but at least it gets the idea of the
> range-diff across.
>
> Of course, I will never be able to amend the commit message in
> GitGitGadget anyway, as I have merged that PR already.
>
> Ciao,
> Dscho
Medium term, is this something that could go in the algorithms section 
of the range-diff man page, especially if the upstream commit message is 
already in place.

#leftoverdocs ?

Philip
