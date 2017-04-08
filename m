Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A670B1FAFB
	for <e@80x24.org>; Sat,  8 Apr 2017 09:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbdDHJk0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 05:40:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:58444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdDHJkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 05:40:25 -0400
Received: (qmail 638 invoked by uid 109); 8 Apr 2017 09:40:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 09:40:23 +0000
Received: (qmail 10388 invoked by uid 111); 8 Apr 2017 09:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Apr 2017 05:40:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Apr 2017 05:40:21 -0400
Date:   Sat, 8 Apr 2017 05:40:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 3/3] read-cache: speed up add_index_entry during
 checkout
Message-ID: <20170408094021.jdpx5l7kfv423zgj@sigill.intra.peff.net>
References: <20170407212047.64950-1-git@jeffhostetler.com>
 <20170407212047.64950-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170407212047.64950-4-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 07, 2017 at 09:20:47PM +0000, git@jeffhostetler.com wrote:

> This helps performance on very large repositories.
> 
> ================
> Before and after numbers on index with 1M files
> ./p0004-read-tree.sh
> 0004.2: read-tree work1 (1003037)          3.21(2.54+0.62)
> 0004.3: switch base work1 (3038 1003037)   7.49(5.39+1.84)
> 0004.5: switch work1 work2 (1003037)       11.91(8.38+3.00)
> 0004.6: switch commit aliases (1003037)    12.22(8.30+3.06)
> 
> ./p0004-read-tree.sh
> 0004.2: read-tree work1 (1003040)          2.40(1.65+0.73)
> 0004.3: switch base work1 (3041 1003040)   6.07(4.12+1.66)
> 0004.5: switch work1 work2 (1003040)       10.23(6.76+2.92)
> 0004.6: switch commit aliases (1003040)    10.53(6.97+2.83)
> ================

By the way, you may want to try:

  $ cd t/perf
  $ ./run HEAD^ HEAD p0004-read-tree.sh

which gives you the before/after in a nice table, with percentage
changes:

  Test                                       HEAD^             HEAD                  
  -----------------------------------------------------------------------------------
  0004.2: read-tree work1 (1003065)          2.34(1.90+0.42)   1.91(1.51+0.38) -18.4%
  0004.3: switch base work1 (3066 1003065)   5.12(4.14+0.96)   4.45(3.55+0.88) -13.1%
  0004.5: switch work1 work2 (1003065)       8.55(6.63+1.87)   7.78(5.76+2.00) -9.0% 
  0004.6: switch commit aliases (1003065)    8.59(6.75+1.80)   7.64(5.92+1.70) -11.1%

The results are stored for each tested version, so you can re-run just a
single test and then re-output the results with "./aggregate.perl HEAD^
HEAD p0004-read-tree.sh".

The "run" script obviously builds each version behind the scenes, so you
probably also want to set GIT_PERF_MAKE_OPTS as appropriate (at the very
least "-j16" makes it more pleasant).

-Peff
