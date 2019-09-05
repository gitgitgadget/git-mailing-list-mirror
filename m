Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD10E1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfIEWtB (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:49:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:41338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726073AbfIEWtA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:49:00 -0400
Received: (qmail 10239 invoked by uid 109); 5 Sep 2019 22:49:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:49:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32273 invoked by uid 111); 5 Sep 2019 22:50:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:50:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:48:59 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
Message-ID: <20190905224859.GA28660@sigill.intra.peff.net>
References: <20190905082459.26816-1-s-beyer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190905082459.26816-1-s-beyer@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 10:24:59AM +0200, Stephan Beyer wrote:

> Compiler heuristics for detection of potentially uninitialized variables
> may change between compiler versions and enabling link-time optimization
> may find new warnings.  Indeed, compiling with gcc 9.2.1 and enabled
> link-time optimization feature resulted in a few hits that are fixed by
> this patch in the most naïve way.  This allows to compile git using the
> DEVELOPER=1 switch (which sets -Werror) and using the -flto flag.

Lots of discussion in this thread. Let's try to turn it into some
patches. :)

After the patches below, I can compile cleanly with gcc 9.2.1 using
-flto with both -O2 and -O3 (some of the cases only seemed to trigger
for me with -O3).

I've ordered them in decreasing value. The first one is a real bugfix,
the second is a related cleanup. The next 3 are appeasing the compiler,
but I think are a good idea (but note I went more for root causes than
your originals). The last one is perhaps more controversial, but IMHO
worth doing.

  [1/6]: git-am: handle missing "author" when parsing commit
  [2/6]: pack-objects: use object_id in packlist_alloc()
  [3/6]: bulk-checkin: zero-initialize hashfile_checkpoint
  [4/6]: diff-delta: set size out-parameter to 0 for NULL delta
  [5/6]: test-read-cache: drop namelen variable
  [6/6]: pack-objects: drop packlist index_pos optimization

 builtin/am.c               |  4 +++-
 builtin/pack-objects.c     | 33 ++++++++++++++-------------------
 bulk-checkin.c             |  2 +-
 diff-delta.c               |  2 ++
 pack-bitmap-write.c        |  2 +-
 pack-bitmap.c              |  2 +-
 pack-objects.c             | 20 ++++++++++----------
 pack-objects.h             |  6 ++----
 t/helper/test-read-cache.c |  5 ++---
 9 files changed, 36 insertions(+), 40 deletions(-)

-Peff
