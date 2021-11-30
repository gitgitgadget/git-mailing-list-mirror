Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED21C433FE
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 22:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345106AbhK3WrS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 17:47:18 -0500
Received: from siwi.pair.com ([209.68.5.199]:19097 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236587AbhK3WrE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 17:47:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 54B0E3F48AB;
        Tue, 30 Nov 2021 17:43:29 -0500 (EST)
Received: from msranlcmt20.fareast.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 07DA83F4868;
        Tue, 30 Nov 2021 17:43:28 -0500 (EST)
Subject: Re: [PATCH 0/2] Set GIT_TRACE2_EVENT_NESTING in test-lib.sh
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        me@ttaylorr.com, Derrick Stolee <derrickstolee@github.com>
References: <pull.1085.git.1638193666.gitgitgadget@gmail.com>
 <YaUegEGxfAf72O9Z@coredump.intra.peff.net>
 <86555f24-e7c4-64cb-a55c-7e2580e895f2@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8c80be3d-7151-272c-dc42-377380bf9754@jeffhostetler.com>
Date:   Tue, 30 Nov 2021 17:43:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <86555f24-e7c4-64cb-a55c-7e2580e895f2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/30/21 10:34 AM, Derrick Stolee wrote:
> On 11/29/2021 1:40 PM, Jeff King wrote:
>> On Mon, Nov 29, 2021 at 01:47:44PM +0000, Derrick Stolee via GitGitGadget wrote:
>>
>>> As reported by Ævar [1] and diagnosed by Peff in a reply, the default
>>> GIT_TRACE2_EVENT_NESTING is set so low that tests that look for trace2
>>> events can start failing due to an added trace2 region. This can even be
>>> subtle, including the fact that the progress API adds trace2 regions when in
>>> use (which can depend on the verbose output of a test script).
>>
>> I think this is a good change for fixing the immediate problem of the
>> test suite failing.
>>
>> But I have to wonder if this is masking a problem that real users will
>> see. Aren't we silently discarding trace2 output that could be useful to
>> somebody debugging or trying to get performance metrics?
>>
>> I.e., should we be bumping the internal nesting max of 2 to something
>> higher? If that would that cause problems with existing metrics, should
>> we be designing new metrics to avoid nesting?
> 
> One thing this makes me think about is that we might want to
> have items such as trace2_data_intmax() and trace2_data_string()
> not be subject to the nesting limit. Only have the nesting apply
> to the regions (which nest).
> 
> CC'ing Jeff Hostetler for his thoughts on that idea. We will have
> a discussion offline to see if the progress regions have started
> to cause inconsistencies in our existing telemetry stream of
> internal users.
> 
> Thanks,
> -Stolee
> 


yeah, I set a fairly conservative nesting limit.  my fear was that
someone would add a region or data event to something that recurses
deeply -- like treewalking or directory scanning -- which in a monorepo
would be bad since we might get millions of rows of data.

most of the useful timing data comes from the higher level regions,
such as we spent x% scanning tracked files and y% scanning untracked
files.  once we get down inside a particular "concept", the directory-
by-directory numbers aren't usually that useful (and/or the overhead of
logging every directory we visit dominates).

WRT allowing data events to ignore the nesting limit, we have the
same monorepo risk if for example someone logs how many files were
in each directory visited, the name of every untracked file, or every
file that had some property of interest.  That might look fine on a
shallow WT, but might generate an unusable amount of data on a large
repo.  so i'd recommend we proceed carefully here.  (i'm not against
it, i'm just saying we should think about it.)


using trace2 in a test to confirm that a piece of code was visited
or not visited is cool, but something i don't think i anticipated.
so i agree that we should increase the limit in the test suite.


and yes, the addition of trace2 calls inside the progress code
complicates the nesting.  I'm wondering if the progress code should
always emit the trace2 events, regardless of whether the progress msg
itself appears on the user's console.  That way we have consistent
logging -- the whole point of adding the region in the progress
code was to bracket the time spent doing the thing that needed
progress messaging after all.  the fact that you don't have a console
doesn't change the fact that there's an expensive computation there.

(i'd also consider changing the "total_objects" data event to include
include the region title so that they are more easily identified in a
grep, but I digress.)


Thanks,
Jeff

