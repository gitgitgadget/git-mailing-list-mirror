Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CE31F45F
	for <e@80x24.org>; Tue,  7 May 2019 07:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGHwB (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 03:52:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49916 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726563AbfEGHwA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 03:52:00 -0400
Received: (qmail 18951 invoked by uid 109); 7 May 2019 07:52:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 07:52:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9084 invoked by uid 111); 7 May 2019 07:52:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 03:52:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 03:51:58 -0400
Date:   Tue, 7 May 2019 03:51:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
Message-ID: <20190507075158.GG28060@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318215107.GH29661@sigill.intra.peff.net>
 <87ftrjer8s.fsf@evledraar.gmail.com>
 <20190319001829.GL29661@sigill.intra.peff.net>
 <878svjj4t5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878svjj4t5.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 11:44:06AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Maybe there's some case I haven't thought of that makes this stupid, but
> I wonder if something like a "gc quarantine" might be a fix fo both of
> the the issues you noted above.
> 
> I.e. it seems to me that the main issue is that we conflate "mtime 2
> weeks old because it's unreferenced for 2 weeks" v.s. "mtime 2 weeks old
> because we haven't gotten around to a 'gc'".
> 
> So in such a "gc quarantine" mode when we discover an object/pack that's
> unreachable/purely made up of unreachable objects we'd move the relevant
> loose object/"loose" pack to such a quarantine, which would just be
> .git/unreferenced-objects/{??,pack}/ or whatever.
> 
> AFAICT both cases you mentioned above would be mitigated by this because
> we'd no longer conflate "haven't gc'd this yet and it's 2 weeks old"
> v.s. "hasn't been referenced in 2 weeks".

Michael Haggerty and I have (off-list) discussed variations on that, but
it opens up a lot of new issues.  Moving something into quarantine isn't
atomic. So you've still corrupted the repo, but now it's recoverable by
reaching into the quarantine. Who notices that the repo is corrupt, and
how? When do we expire objects from quarantine?

I think the heart of the issue is really the lack of atomicity in the
operations. You need some way to mark "I am using this now" in a way
that cannot race with "looks like nobody is using this, so I'll delete
it".

And ideally without traversing large bits of the graph on the writing
side, and without requiring any stop-the-world locks during pruning.

> I started looking at this initially because I was wondering if the
> --keep-unreachable mode you modified in e26a8c4721 ("repack: extend
> --keep-unreachable to loose objects", 2016-06-13) could be made to write
> out such "unreferenced" objects into their *own* pack, so we could
> delete them all at once as a batch, and wouldn't create the "ref
> explosions" mentioned in [1].
> 
> But of course without an accompanying quarantine described above doing
> that would just make this race condition worse.

I'm not sure it really makes it worse. The pack would have the same
mtime as the loose objects would.

-Peff
