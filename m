Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1884C43467
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5577A2083B
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 09:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgJHJwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 05:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgJHJwH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 05:52:07 -0400
Received: from wp156.webpack.hosteurope.de (wp156.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:84a3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58CC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 02:52:07 -0700 (PDT)
Received: from p5099125b.dip0.t-ipconnect.de ([80.153.18.91] helo=[192.168.100.43]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kQSai-0003ZG-Gu; Thu, 08 Oct 2020 11:52:04 +0200
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Jeff King <peff@peff.net>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
Message-ID: <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
Date:   Thu, 8 Oct 2020 11:52:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201007210609.GA1984296@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1602150727;628b5b42;
X-HE-SMSGID: 1kQSai-0003ZG-Gu
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.10.2020 23:06, Jeff King wrote:
> On Wed, Oct 07, 2020 at 10:28:36PM +0200, Thomas Braun wrote:
> 
>> $ git --version
>> git version 2.29.0.rc0.windows.1
>>
>> Since I upgraded to that version (thanks to dscho for providing these so
>> early) I'm seeing occasionally
>>
>> $ git fetch origin +refs/head/abcd:refs/remotes/origin/abcd
>> fatal: unexpected duplicate commit id
>> 31a13139875bc5f49ddcbd42b4b4d3dc18c16576
> 
> That message comes from the commit-graph code:
> 
>   $ git grep unexpected.duplicate.commit.id '*.c'
>   commit-graph.c:                 die(_("unexpected duplicate commit id %s"),
> 
> So presumably it's related to the fetch.writeCommitGraph feature, though
> I thought it was not on by default (for a while it was tied to
> feature.experimental, but I think even that is not true in 2.29). Do you
> have that option set?

Yes I do have that set. The error also vanishes if I turn it off via
git -c fetch.writeCommitGraph=false ...

> The message is in sort_and_scan_merged_commits(), which is trying to
> join multiple incremental commit-graph files together. Presumably you
> have two such files with the same commit appearing in both. I think we
> try to avoid that (by omitting commits from new incrementals that
> already appear in another one), but I wonder if there is a race or other
> condition that can cause it. In which case this code ought to be more
> lenient, and just quietly ignore the duplicate.

Thanks for the explanation. Yes I do have multiple commit graph files.

$ ls -lh objects/info/commit-graphs
total 445K
-r--r--r-- 1 thomas 197121  123 Oct  8 11:29 commit-graph-chain
-r--r--r-- 1 thomas 197121 3.2K Oct  8 11:29
graph-6444f51143e12b3f34c031e60a672d2b29d1c09e.graph
-r--r--r-- 1 thomas 197121 434K Oct  8 11:29
graph-6d467862fac6cadecf90c11a054b8883234defec.graph
-r--r--r-- 1 thomas 197121 1.9K Oct  8 11:29
graph-6ed4c0bfb0adcc15a7dc58159b3652a23d6d8c14.graph

> Is it possible to share the contents of your .git directory? If not, can
> you look in .git/objects/info/ and see if there are multiple
> commit-graph files (and if so, possibly share those; they don't contain
> any identifying info).

Yes sure, I can share that [1]. Thanks for looking into that.

[1]:
http://byte-physics.de/Downloads/dotGitWriteCommitGraphDuplicatedCommitIssue.tar.gz
