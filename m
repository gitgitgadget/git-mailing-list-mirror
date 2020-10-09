Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033CBC433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BBD22261
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388880AbgJIP36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgJIP35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 11:29:57 -0400
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C93C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 08:29:57 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kQuLD-00080x-3v; Fri, 09 Oct 2020 17:29:55 +0200
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
Date:   Fri, 9 Oct 2020 17:29:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1602257397;60b371db;
X-HE-SMSGID: 1kQuLD-00080x-3v
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.10.2020 15:22, Derrick Stolee wrote:
> On 10/8/2020 8:50 AM, Derrick Stolee wrote:
>> On 10/8/2020 8:06 AM, Jeff King wrote:
>>> But regardless, it seems unfriendly that we can't
>>> get out of it while merging the graphs. Doing this obviously makes the
>>> problem go away:
>>>
>>> diff --git a/commit-graph.c b/commit-graph.c
>>> index cb042bdba8..ae1f94ccc4 100644
>>> --- a/commit-graph.c
>>> +++ b/commit-graph.c
>>> @@ -2023,8 +2023,11 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>>>  
>>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>>  			  &ctx->commits.list[i]->object.oid)) {
>>> -			die(_("unexpected duplicate commit id %s"),
>>> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
>>> +			/*
>>> +			 * quietly ignore duplicates; these could come from
>>> +			 * incremental graph files mentioning the same commit.
>>> +			 */
>>> +			continue;
>>>  		} else {
>>>  			unsigned int num_parents;
>>>  
>>>
>>> but it's not clear to me if that's papering over another bug, or
>>> gracefully handling a situation that we ought to be.
>>
>> I think this is a good thing to do, at minimum. As I discussed above,
>> the "input data" of the incremental commit-graph chain with duplicate
>> commits across layers isn't actually _invalid_. It's unexpected based
>> on what Git "should" be doing.
> 
> As I was working on my own version of this, I realized that just
> commenting here still creates duplicate commits in the new layer,
> which is even MORE unexpected. It could cause some confusion with
> the binary search, but likely that is still fine. The only "real"
> issue is that it is wasted data.
> 
> I'll send [1] to the list soon (after build & test validation),
> but it includes copying the pointers to a new "de-duplicated" list.

Thanks both for digging into it.

I think I have a starting point for what goes wrong. I found a local
repo with another broken commit graph. And after some fiddling the
following script can reproduce it. I tried with git/git first but that
seems not to trigger that.

# rm -rf dummy
mkdir dummy
cd dummy

git init

git remote add origin https://github.com/tango-controls/cppTango
git remote add fork1 https://github.com/bourtemb/cppTango
git remote add fork2 https://github.com/t-b/cppTango
git fetch --all --jobs 12
git commit-graph verify
rm -rf .git/objects/info/commit-graphs/
git commit-graph verify
git fetch --jobs 12
git remote add fork3 git@github.com:t-b/cppTango.git
git commit-graph verify
git remote add fork4 git@github.com:t-b/cppTango.git
git fetch --jobs 12
git commit-graph verify

The last verify outputs

commit-graph generation for commit
029341567c24582030592585b395f4438273263f is 1054 != 1
commit-graph generation for commit
1e8d10aec7ca6075f622c447d416071390698124 is 4294967295 != 1171
commit-graph generation for commit
296e93516189c0134843fd56ac4f10d36ccf284f is 1054 != 1
commit-graph generation for commit
4c0a7a3cd369d06b99d867be6b47a96c519efd7f is 1054 != 1
commit-graph has non-zero generation number for commit
4d39849950d3dc02b7426c780ac7991ec7221176, but zero elsewhere
commit-graph has non-zero generation number for commit 4
[....]

Does that reproduce on your end as well?

Thomas
