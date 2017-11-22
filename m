Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6EB420954
	for <e@80x24.org>; Wed, 22 Nov 2017 23:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdKVX6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 18:58:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:38240 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751525AbdKVX6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 18:58:53 -0500
Received: (qmail 8499 invoked by uid 109); 22 Nov 2017 23:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 23:58:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5930 invoked by uid 111); 22 Nov 2017 23:59:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 18:59:09 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 18:58:51 -0500
Date:   Wed, 22 Nov 2017 18:58:51 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/3] Introduce BUG_ON(cond, msg) MACRO
Message-ID: <20171122235851.GE8577@sigill>
References: <20171122223827.26773-1-sbeller@google.com>
 <20171122232457.GA8577@sigill>
 <20171122232814.GH11671@aiede.mtv.corp.google.com>
 <20171122233905.GC8577@sigill>
 <20171122234532.GI11671@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122234532.GI11671@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 03:45:32PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Yes. I'd be fine having a single-argument BUG_ON() like that. But then,
> > I'm not sure what it's buying us over assert().
> 
> It lets you build with NDEBUG.

But why do you want to build with NDEBUG if nothing uses assert()? ;)

I'm being a little glib, but I think there really is a chicken-and-egg
question here. Why are people building with NDEBUG if they don't want to
disable asserts? Do they do it out of habit? A misguided sense of
performance optimization? Does it do something else I'm not aware of?

> It also goes through our own die()
> handler, which means that e.g. the error message gets propagated over
> remote transports.

BUG() doesn't go through our die handler. It hits vreportf(), which does
do some minor munging, but it always goes to stderr. Error message
propagation over the remote protocol happens either:

  1. From a parent process muxing our stderr onto the sideband.

  2. Via special wrappers like receive-pack's rp_error().

The only program I know that sets a custom die handler to change the
reporting is git-http-backend (and there it only applies to die("BUG"),
not BUG(), so with the latter you'd get a hard hangup instead of an
attempt at an http 500).

> Please please please, don't rely on side-effects from assert().  They
> will cause me to run into pain over time.  This issue alone might be
> worth banning use of assert() in the codebase, if we can't trust
> reviewers to catch problematic examples (fortunately reviewers have
> been pretty good about that so far, but banning it would free up their
> attention to focus on other aspects of a patch).

Yes, obviously side effects in an assert() are horrible. But I haven't
noticed that being a problem in our code base.

For the record, I'm totally fine with banning assert() in favor of a
custom equivalent. I just don't think we've seen any real problems with
assert in our codebase so far.

-Peff
