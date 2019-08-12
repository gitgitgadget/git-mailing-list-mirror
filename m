Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507B01F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 16:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfHLQiO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 12:38:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:40834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726263AbfHLQiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 12:38:14 -0400
Received: (qmail 26268 invoked by uid 109); 12 Aug 2019 16:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Aug 2019 16:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24092 invoked by uid 111); 12 Aug 2019 16:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2019 12:41:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Aug 2019 12:38:13 -0400
From:   Jeff King <peff@peff.net>
To:     Gregory Szorc <gregory.szorc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Non-robust lock files in containers can lead to repo corruption
Message-ID: <20190812163812.GB26231@sigill.intra.peff.net>
References: <qimq0i$49gn$1@blaine.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <qimq0i$49gn$1@blaine.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 10, 2019 at 09:05:33AM -0700, Gregory Szorc wrote:

> I tracked down a source of Git corrupting repositories to lock file
> design not being robust when containers / PID namespaces are present.
> 
> In my case, the corruption stemmed from premature release of the `git
> gc` lock in the gc.pid file. But since the lock file code for that file
> is in gc.c, there could be other lock files in Git affected by the same
> design limitation as well.

I don't think there are. Most of Git's locks are predicated purely on
the existence of the lockfile (with the intent that they'd work over
systems like NFS). The gc lock is a weird one-off.

And while it's not great for multiple gc's to run at the same time
(because it wastes CPU), two of them running at the same time shouldn't
cause a corruption. If you have a reproducible demonstration where that
happens, I'd be very interested to see it.

-Peff
