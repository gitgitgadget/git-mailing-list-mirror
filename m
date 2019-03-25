Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA89520248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCYXaJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:30:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:35882 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727328AbfCYXaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:30:09 -0400
Received: (qmail 5483 invoked by uid 109); 25 Mar 2019 23:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Mar 2019 23:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13345 invoked by uid 111); 25 Mar 2019 23:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 25 Mar 2019 19:30:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Mar 2019 19:30:07 -0400
Date:   Mon, 25 Mar 2019 19:30:07 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Auto-gc in the background can take a long time to be put in the
 background
Message-ID: <20190325233007.GA23728@sigill.intra.peff.net>
References: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 26, 2019 at 08:22:23AM +0900, Mike Hommey wrote:

> Recently, I've noticed that whenever the auto-gc message shows up about
> being spawned in the background, it still takes a while for git to
> return to the shell.
> 
> I've finally looked at what it was stuck on, and it's 
> `git reflog expire --all` taking more than 30s. I guess the question is
> whether there's a reason this shouldn't run in the background? Another
> is whether there's something that makes this slower than it should be.

The reason is that it takes locks which can interfere with other
operations; see 62aad1849f (gc --auto: do not lock refs in the
background, 2014-05-25).

Unfortunately making it faster is hard. To handle expiring unreachable
items, it has to know what's reachable. Which implies walking the commit
graph. I don't recall offhand whether setting unreachable-expiration to
"never" would skip that part. But if not, that should be low-hanging
fruit.

(I also wonder whether there is really much valuable in keeping
unreachable things for a shorter period of time, and the default should
simply be to just prune everything after 90 days, unreachable or not).

-Peff
