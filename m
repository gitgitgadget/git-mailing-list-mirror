Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951B42036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbdJGTdO (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:33:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:36404 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751425AbdJGTdO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:33:14 -0400
Received: (qmail 15076 invoked by uid 109); 7 Oct 2017 19:33:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 19:33:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3711 invoked by uid 111); 7 Oct 2017 19:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 15:33:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Oct 2017 15:33:11 -0400
Date:   Sat, 7 Oct 2017 15:33:11 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH v2 1/5] test-list-objects: List a subset of object ids
Message-ID: <20171007193311.c2izgofpyh357yi7@sigill.intra.peff.net>
References: <20170925095452.66833-1-dstolee@microsoft.com>
 <20170925095452.66833-2-dstolee@microsoft.com>
 <20171005084249.sdkimglkxqh2vi4i@sigill.intra.peff.net>
 <xmqqvaju6i3p.fsf@gitster.mtv.corp.google.com>
 <20171005100001.do5m4zhexcsltvw7@sigill.intra.peff.net>
 <6222f65a-c518-74a4-9df4-89bf997425cb@gmail.com>
 <20171006141128.rkuhd4m7hp2f7vvx@sigill.intra.peff.net>
 <d5b3107f-76ec-8e8c-d7f5-d0f1ec75b1c9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5b3107f-76ec-8e8c-d7f5-d0f1ec75b1c9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2017 at 03:12:08PM -0400, Derrick Stolee wrote:

> In my local copy, I added a test to p4211-line-log.sh that runs "git log
> --raw -r" and tested it on three copies of the Linux repo. In order, they
> have 1 packfile (0 loose), 24 packfiles (0 loose), and 23 packfiles
> (~324,000 loose).
> 
> 4211.6: git log --raw -r  43.34(42.62+0.65)   40.47(40.16+0.27)  -6.6%
> 4211.6: git log --raw -r  88.77(86.54+2.12)   82.44(81.87+0.52)  -7.1%
> 4211.6: git log --raw -r 108.86(103.97+4.81) 103.92(100.63+3.19) -4.5%
> 
> We have moderate performance gains for this command, despite the command
> doing many more things than just checking abbreviations.

Yeah, while it's less exciting than seeing the 90% numbers for a
micro-benchmark, I think this represents real-world gains (and 5-7% is
nothing to sneeze at).

You might also try adding "--format=%h" or --oneline to your invocation,
which would compute abbreviations for each commit (making your workload
more abbrev-heavy and possibly showing off the difference more).

I also think "-r" isn't doing anything. Recursive diffs are the default
for the "log" porcelain (even for --raw).

> I plan to re-roll my patch on Monday including the following feedback items:
> 
> * Remove test-list-objects and test-abbrev in favor of a new "git log"
>   performance test.
> 
> * Fix binary search overflow error.
> 
> * Check response from open_pack_index(p) in find_abbrev_len_for_pack().
>   I plan to return without failure on non-zero result, which results in
>   no failure on a bad pack and the abbreviation length will be the
>   minimum required among all valid packs. (Thanks Stefan!)

That all sounds reasonable to me.

> - Teach 'cat-file' to --batch-check='%(objectsize:short)'. (Peff already
>   included a patch, perhaps that could be reviewed separately.)

I think I'll let it lie in the list archive for now unless somebody has
a real use case for it (though I'm tempted to add it purely for
completionism, since it's so easy).

-Peff
