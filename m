Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC197207EC
	for <e@80x24.org>; Sun, 25 Sep 2016 07:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965568AbcIYHRu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 03:17:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:47665 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934317AbcIYHRt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 03:17:49 -0400
Received: (qmail 21375 invoked by uid 109); 25 Sep 2016 07:17:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 25 Sep 2016 07:17:47 +0000
Received: (qmail 28649 invoked by uid 111); 25 Sep 2016 07:18:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 25 Sep 2016 03:18:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 25 Sep 2016 03:17:44 -0400
Date:   Sun, 25 Sep 2016 03:17:44 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] recursive support for ls-files
Message-ID: <20160925071744.2qcz7cntc7xxpjqv@sigill.intra.peff.net>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1474676014-134568-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2016 at 05:13:31PM -0700, Brandon Williams wrote:

> After looking at the feedback I rerolled a few things, in particular the
> --submodule_prefix option that existed to give a submodule context about where
> it had been invoked from.  People didn't seem to like the idea of exposing this
> to the users (yet anyways) so I removed it as an option and instead have it
> being passed to a child process via an environment variable
> GIT_INTERNAL_SUBMODULE_PREFIX.  This way we don't have to support anything to
> external users at the moment.

I think we can still have it as a command-line argument and declare it
internal. It's not like environment variables cannot also be set by our
callers. :)

I don't mind it as an environment variable, though. In some ways it
makes things easier. I just think "internal versus external" and the
exact implementation are orthogonal.

> Also fixed a bug (and added a test) for the -z options as pointed out by Jeff
> King.

Hmm. It is broken after patch 2, and then fixed in patch 3. Usually we'd
try not to have a broken state in the history. It's less important in
this case, because the breakage is not a regression
(--recurse-submodules is a new feature, so you could consider it "not
working" until the 3rd patch). But I think it's still a good rule to
follow, because it makes the commits easier to review, look at later,
etc.

For that matter, I do not understand why options like "-s" get enabled
in patch 3. I do not mind them starting as disabled in patch 2, but it
seems like "pass along some known-safe options" should be its own patch
somewhere between patches 2 and 3.

There are some other options that are ignored (neither disabled nor
passed along to children). Most of them are related to exclusions, which
I _think_ are safe to ignore (they do not do anything interesting unless
you specify "-o", which is explicitly disabled). I'm not sure about
--with-tree, though (or what it would even mean in the context of
recursing).

-Peff
