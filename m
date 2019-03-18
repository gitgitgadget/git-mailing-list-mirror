Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DF7120248
	for <e@80x24.org>; Mon, 18 Mar 2019 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfCRVvK (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 17:51:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:55610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbfCRVvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 17:51:09 -0400
Received: (qmail 11480 invoked by uid 109); 18 Mar 2019 21:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 18 Mar 2019 21:51:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24050 invoked by uid 111); 18 Mar 2019 21:51:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 18 Mar 2019 17:51:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2019 17:51:07 -0400
Date:   Mon, 18 Mar 2019 17:51:07 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
Message-ID: <20190318215107.GH29661@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190318161502.7979-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 18, 2019 at 05:14:58PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This series is unrelated (and does not conflict with) my in-flight gc
> contention series
> (https://public-inbox.org/git/20190315155959.12390-1-avarab@gmail.com/),
> but the "git-gc" docs should be updated to discuss the
> core.filesRefLockTimeout option and how it impacts contention, see 8/8
> in that series for context. I.e. "you may have contention, but
> core.filesRefLockTimeout can mitigate blah blah".
> 
> I was going to do that, but then thought that we should also mention
> that on the server-side we mitigate most/all of the contention via the
> quarantine, see "QUARANTINE ENVIRONMENT" in
> git-receive-pack(1). I.e. we:
> 
>  1. Get the temp pack
>  2. OK it (fsck, hooks etc.)
>  3. Move *complete* previously temp packs over
>  4. Update the refs
> 
> I.e. we are immune from the "concurrently with another process" race,
> but of course something concurrently updating the "server" repo
> without a quarantine environment may be subject to that race.
> 
> The only problem is that the last couple of paragraphs may be
> wrong. That's just my understanding from a brief reading of
> 722ff7f876c ("receive-pack: quarantine objects until pre-receive
> accepts", 2016-10-03) so I didn't want to include that in this
> series. Peff (or others), any comments?

I don't think the quarantine stuff should impact contention at all. It's
only quarantining the objects, which are the least contentious part of
Git (because object content is idempotent, so we don't do any locking
there, and with two racing processes, one will just "win").

-Peff
