Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549761F51C
	for <e@80x24.org>; Wed, 30 May 2018 08:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968671AbeE3Ikf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 04:40:35 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:49875 "EHLO
        7.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964979AbeE3Ikd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 04:40:33 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 May 2018 04:40:33 EDT
Received: from player693.ha.ovh.net (unknown [10.109.120.20])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id E5A2C150A2
        for <git@vger.kernel.org>; Wed, 30 May 2018 10:20:49 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id 0A2C04400AE;
        Wed, 30 May 2018 10:20:44 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
 <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
 <20180528220651.20287-1-szeder.dev@gmail.com>
 <20180529210434.GA3857@sigill.intra.peff.net>
From:   Kevin Bracey <kevin@bracey.fi>
Message-ID: <97644280-2187-d314-37ce-2c79935a63bc@bracey.fi>
Date:   Wed, 30 May 2018 11:20:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529210434.GA3857@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 6836745710321045725
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedriedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/05/2018 00:04, Jeff King wrote:
>
> Do we even need to do the parent rewriting here? By definition those
> parents aren't interesting, and we're TREESAME to whatever is in
> treesame_parents. So conceptually it seems like we just need a flag "I
> found a treesame parent", but we only convert that into a TREESAME flag
> if there are no relevant parents.

I think it's necessary to make the rules consistent. To mark the commit 
as TREESAME here when it's not TREESAME to all its parents would be 
inconsistent with the definition of the TREESAME flag used everywhere else:

* Original definition: "A commit is TREESAME if it is treesame to any 
parent"
* d0af66 definition: "A commit is TREESAME if it is treesame to all parents"
* Current 4d8266 definition: "A commit is TREESAME if it is treesame to 
all relevant parents; if no relevant parents then if it is treesame to 
all (irrelevant) parents."

The current problem is that the node is not marked TREESAME, but that's 
consistent with the definition. I think we do have to rewrite the commit 
so it is TREESAME as per the definition. Not flag it as TREESAME in 
violation of it.

It's possible you *could* get away with just flagging, because we never 
recompute the TREESAME flag in simple history mode. But it would be a 
cheat, and it may have other side effects. It means this node would 
remain a special rare case for others to trip up on later.  And I don't 
think it simplifies the scan. Remembering 
"pointer-to-first-treesame-parent" (not a list) for the rewrite is no 
more complex than remembering "bool-there-was-a-treesame-parent".  (A 
bool is what earlier code did - it worked for the original TREESAME 
definition. My patch series dropped that bool without replacement - 
missing this all-irrelevant case).

In the simple history mode, the assumption is we're "simplifying away 
merges up-front" here; we won't (and can't) rewrite parents later in a 
way that needs to recompute TREESAME. In the initial scan when all 
parents are relevant and we matched one, the commit became TREESAME as 
per the new definition immediately because of the rewrite.  This applies 
the equivalent rewrite when no relevant parents, consistent with the 
general concept, and without changing the TREESAME definition.

Kevin


