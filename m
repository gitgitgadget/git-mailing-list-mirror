Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFEE1F42D
	for <e@80x24.org>; Thu, 24 May 2018 21:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967242AbeEXVGM (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 17:06:12 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:50025 "EHLO
        18.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967154AbeEXVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 17:06:11 -0400
X-Greylist: delayed 2374 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2018 17:06:10 EDT
Received: from player728.ha.ovh.net (unknown [10.109.105.61])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 903F71B2F6C
        for <git@vger.kernel.org>; Thu, 24 May 2018 22:26:35 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id E435454009A;
        Thu, 24 May 2018 22:26:30 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
From:   Kevin Bracey <kevin@bracey.fi>
Message-ID: <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
Date:   Thu, 24 May 2018 23:26:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523173523.GB10299@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 2304435638251983069
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrgeekgdekiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/05/2018 20:35, Jeff King wrote:
> On Wed, May 23, 2018 at 01:32:46PM -0400, Jeff King wrote:
>
>> On Wed, May 23, 2018 at 07:10:58PM +0200, SZEDER Gábor wrote:
>>
>>>    $ git log --oneline master..ba95710a3b -- ci/
>>>    ea44c0a594 Merge branch 'bw/protocol-v2' into jt/partial-clone-proto-v2
>>>
>>>
>>> I keep some older builds around, and it does not reproduce with v1.6.6.3
>>> (that's my usual goto for "old"). Bisecting turns up d0af663e42
>>> (revision.c: Make --full-history consider more merges, 2013-05-16).  It
>>> looks like an unintended change (the commit message claims that the
>>> non-full-history case shouldn't be affected).
> There's more discussion in the thread at:
>
>    https://public-inbox.org/git/1366658602-12254-1-git-send-email-kevin@bracey.fi/
>
> I haven't absorbed it all yet, but I'm adding Junio to the cc.
>

In this case, we're hitting a merge commit which is not on master, but 
it has two parents which both are. Which, IIRC, means the merge commit 
is INTERESTING with two UNINTERESTING parents; and we are TREESAME to 
only one of them.

The commit changing the logic of TREESAME you identified believes that 
those TREESAME changes for merges which were intended to improve fuller 
history modes shouldn't affect the simple history "because partially 
TREESAME merges are turned into normal commits". Clearly that didn't 
happen here.

I think we need to look at why that isn't happening, and if it can be 
made to happen. The problem is that this commit is effectively the base 
of the graph - it's got a double-connection to the UNINTERESTING set, 
and maybe that prevented the simple history "follow 1 TREESAME" logic 
from kicking in. Maybe it won't follow 1 TREESAME to UNINTERESTING.

I know there were quite a few changes later in the series to try to 
reconcile the simple and full history, for the cases where the simple 
history takes a weird path because of its love of TREESAME parents, 
hiding evil merges. But I believe the simple history behaviour was 
supposed to remain as-is - take first TREESAME always.

Kevin


