Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1964C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 21:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DD7207D8
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 21:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgFLVeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:34:03 -0400
Received: from dovecot.mat.umk.pl ([158.75.2.81]:52108 "EHLO
        poczta1.mat.umk.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFLVeC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 17:34:02 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jun 2020 17:34:01 EDT
Received: from dovecot.mat.umk.pl (localhost.localdomain [127.0.0.1])
        by poczta1.mat.umk.pl (Postfix) with ESMTP id 7F25F9568B9;
        Fri, 12 Jun 2020 23:26:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mat.umk.pl
Received: from poczta1.mat.umk.pl ([127.0.0.1])
        by dovecot.mat.umk.pl (poczta1.mat.umk.pl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id hrqByV-YRseu; Fri, 12 Jun 2020 23:26:56 +0200 (CEST)
Received: from [192.168.0.2] (host-89-229-7-83.dynamic.mm.pl [89.229.7.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jnareb)
        by poczta1.mat.umk.pl (Postfix) with ESMTPSA id 7DDE79568B7;
        Fri, 12 Jun 2020 23:26:56 +0200 (CEST)
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [GSoC Patch v3 0/4] Move generation, graph_pos to a slab
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f7f2cee7-c4c3-0b68-c164-bcb9b6839219@gmail.com>
Date:   Fri, 12 Jun 2020 23:26:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.06.2020, Abhishek Kumar wrote:

> The struct commit is used in many contexts. However, members
> `generation` and `graph_pos` are only used for commit graph related
> operations and otherwise waste memory.
> 
> This wastage would have been more pronounced as we transition to
> generation number v2, which uses 64-bit generation number instead of
> current 32-bits.

I think s/would have been/would be/1, but I am not native English
speaker.

> 
> While the overall test suite runs slightly faster than master
> (series: 27m10s, master: 27ms34s, faster by 2.35%), certain commands
> like `git merge-base --is-ancestory` are slowed by nearly 40% as
> discovered by SDEZER Gabor [1].

First, the name is SZEDER Gábor.

Second, it would be nice to have some specific examples, like for
example the results of running `git merge-base --is-ancestory` in
specific repository, and from specific starting point.

It might be good idea to also show performance change for a command
that handles large amount of commits but does not use the commit-graph,
like for example `git gc`.

> 
> Derrick Stolee believes the slow down is attributable to the underlying
> algorithm rather than the slowness of commit-slab access [2] and we will
> follow-up on that in a later series.

Would it be possible to show profiling results?

> 
> I did not mention maximum RSS in the commit messages as they were nearly
> identical (series: 68104kb, master: 68040kb, fewer by <0.1%). This leads
> me to conclude that either the test using maximum memory involves commit
> graph or did not involve the struct commit at all. The move to
> commit-slab reduces memory footprint for the cases where struct commit
> is used but members generation and graph position are not. Average RSS
> would have been a good and more representative measure, but
> unfortunately time(1) could not measure it on my system.

What operating system do you use?

> 
> With this, I feel the patch will require minor fixes, if any. I am
> moving ahead with working the next step of "Implement Generation Number
> v2" that is proper handling of commit-graph format change.

All right.  It should be not a problem to rebase series on top of
different implementation of [inline-able] helper function if it
turns out that the move to slab serious affects negatively performance.

> 
> Based on the discussions, I feel we should compute both generation
> number v1 and the date offset value with storing date offsets in a new
> chunk as the cost is mostly from walking the commits.

Should we store offsets and corrected commit date on the slab,
or just the corrected date (with offset applied)?  We should be
using corrected commit date only; offset can be recomputed if
needed, e.g. when writing the commit-graph.

> 
> Abhishek Kumar (4):
>    alloc: introduce parsed_commits_count
>    commit-graph: introduce commit_graph_data_slab
>    commit: move members graph_pos, generation to a slab
>    commit-graph: minimize commit_graph_data_slab access
> 
>   alloc.c                         |   6 +-
>   blame.c                         |   2 +-
>   bloom.c                         |   7 +-
>   commit-graph.c                  | 122 ++++++++++++++++++++++++--------
>   commit-graph.h                  |  10 +++
>   commit-reach.c                  |  69 +++++++++++-------
>   commit.c                        |   8 ++-
>   contrib/coccinelle/commit.cocci |  18 +++++
>   revision.c                      |  20 +++---
>   9 files changed, 188 insertions(+), 74 deletions(-)
> 

