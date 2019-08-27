Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DCA1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbfH0S7b (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 14:59:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:58426 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727064AbfH0S7b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 14:59:31 -0400
Received: (qmail 27192 invoked by uid 109); 27 Aug 2019 18:59:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Aug 2019 18:59:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4369 invoked by uid 111); 27 Aug 2019 19:00:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Aug 2019 15:00:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Aug 2019 14:59:30 -0400
From:   Jeff King <peff@peff.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, git@vger.kernel.org,
        entwicklung@pengutronix.de
Subject: Re: git slow unless piped to cat
Message-ID: <20190827185929.GA3150@sigill.intra.peff.net>
References: <20190827081559.mt5wjpdvqzn62dib@pengutronix.de>
 <20190827084111.GU20404@szeder.dev>
 <20190827085637.g6cpnuofpteyfqfz@pengutronix.de>
 <1566897126.4102.5.camel@pengutronix.de>
 <20190827094407.GV20404@szeder.dev>
 <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190827100427.u3a5uvmylm5vddn2@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 12:04:27PM +0200, Uwe Kleine-König wrote:

> 	$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"; time env GIT_CONFIG_NOSYSTEM=1 HOME=/nonexistant XDG_CONFIG_HOME=/nonexistant git --no-pager show --no-color --no-decorate v5.2
> 	...
> 
> 	real	0m1.041s
> 	user	0m0.000s
> 	sys	0m0.021s
> 
> 	$ git for-each-ref |wc -l
> 	10013
> 
> So this is indeed the problem.

That's not that many refs. Are they mostly unpacked? Loose refs are
awful on a cold cache, since it's one inode per ref (or worse, since it
has walk the directories, too).

Try:

  find .git/refs -type f | wc -l

to see the loose ones. If there are a lot, try:

  git pack-refs --prune --all

(or just "git gc", which does this).

Modern versions of Git should delete any leftover empty directories
after pruning the loose variants, but I think won't go out of their way
to remove ones they didn't delete from. And those are still expensive to
walk on a cold cache. If it's still slow, try:

  find .git/refs/* -type d | xargs rmdir -v

-Peff
