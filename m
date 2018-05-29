Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3201F51C
	for <e@80x24.org>; Tue, 29 May 2018 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbeE2Ik7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 04:40:59 -0400
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:44929 "EHLO
        8.mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeE2Ik4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 04:40:56 -0400
X-Greylist: delayed 7798 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 May 2018 04:40:56 EDT
Received: from player772.ha.ovh.net (unknown [10.109.108.93])
        by mo68.mail-out.ovh.net (Postfix) with ESMTP id B0DCCE4DD3
        for <git@vger.kernel.org>; Tue, 29 May 2018 08:11:50 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player772.ha.ovh.net (Postfix) with ESMTPSA id E819A74007E;
        Tue, 29 May 2018 08:11:46 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
 <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
 <20180528220651.20287-1-szeder.dev@gmail.com>
From:   Kevin Bracey <kevin@bracey.fi>
Message-ID: <7de5c4b3-800c-960d-2942-7aa562df8879@bracey.fi>
Date:   Tue, 29 May 2018 09:11:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180528220651.20287-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 17232461027938635997
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrheejgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/05/2018 01:06, SZEDER Gábor wrote:
>
> So, without investing nearly enough time to understand what is going
> on, I massaged the above diffs into this:
Cool.

> +				treesame_parents = xmalloc(sizeof(*treesame_parents));
There's no need to actually record a list here. This is just for the 
simple history. We are only interested into becoming a non-merge to 1 
treesame parent, so I think we just need to record a pointer to the 
first one we see, just as this would exit immediately for the first 
relevant one. For the full-history case, we already have the full "which 
parents are treesame" recording mechanism just above, but it only kicks 
in for merge commits and only when settings require it. Adding a malloc 
here would be significant machinery overhead.
> FWIW, the test suite passes with the above patch applied.
I doubt there's an existing case like this anywhere in the revision test 
suite :) . And this patch is focused enough that it *should* only be 
changing the behaviour of this very specific case. As such, it does feel 
a little like a kludge, but I think it's fine because it's aligning the 
simple-history analysis with the "analyse relevant parents if any, else 
analyse irrelevant" rule of the full-history.
>
> And here is the small PoC test case to illustrate the issue, which
> fails without but succeeds with the above patch.  Eventually it should
> be part of 't6012-rev-list-simplify.sh', of course, but I haven't
> looked into that yet.
It may be there's enough criss-crossy history to test here to merit 
breaking out into a second test series.

+#   B---M2   master
+#  / \ /
+# A   X
+#  \ / \
+#   C---M1   b2
+#
+# and modify 'file' in commits 'A' and 'B', so one of 'M1's parents
+# ('B') is TREESAME wrt. 'file'.

I guess we'll be wanting test cases for A..B2, B..B2 and C..B2, and some 
where the the base is "some other child of B or C".  "B..B2" is no 
longer a pure set subtraction for simplification as B is UNINTERESTING 
(ie not in the set) but RELEVANT (because you named it as a bottom 
commit), so B..B2 actually still leaves M1 with 2 relevant parents. 
You'd want test cases covering B relevant+C irrelevant and B 
irrelevant+C relevant, which means subtracting them without naming them 
- so name a child of one.

And then we need to think about whether we want it displayed in each of 
the other modes for each of those queries...

Kevin

