Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4AC01F453
	for <e@80x24.org>; Tue, 30 Apr 2019 21:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfD3VjE (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 17:39:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:45096 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726061AbfD3VjE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 17:39:04 -0400
Received: (qmail 27603 invoked by uid 109); 30 Apr 2019 21:39:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 21:39:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12820 invoked by uid 111); 30 Apr 2019 21:39:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 17:39:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 17:39:02 -0400
Date:   Tue, 30 Apr 2019 17:39:02 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Multiple hook support
Message-ID: <20190430213902.GC16290@sigill.intra.peff.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424004948.728326-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 24, 2019 at 12:49:43AM +0000, brian m. carlson wrote:

> I've talked with some people about this approach, and they've indicated
> they would prefer a configuration-based approach.

I think I'm some people. :)

I agree with the thoughts that Jonathan pointed out in [1], but I wanted
to raise a few points that are more directly related to hook features:

  1. Config is resolved at run-time, making it much easier to have
     system or user-level hooks (as opposed to our current system of
     on-disk files, which require copying or symlinking hooks ahead of
     time into each repository you want to impact).

  2. Config values let you easily run hooks from multiple sources (e.g.,
     a hook specified in /etc/gitconfig, one in ~/.gitconfig, and then a
     repo-level hook in .git/config). Even with a "hook.d" feature like
     this, you are back to doing lots of symlinks within the ".d"
     directory to get this behavior.

     I specifically worry that adding ".d" directories is a step in the
     wrong direction because our solution will probably make this point
     _worse_ than whatever custom trampolines people are already using.

  3. A well-designed config schema can leave room for more
     configuration. E.g., one of the big questions with multi-hooks is
     the error semantics. But what if we had:

       [hook "pre-receive"]
       command = my-hook-cmd
       command = another-hook-cmd
       # stop running and return failure at first non-zero exit
       errorBehavior = stop-on-first
       # ...or run all and return error if _any_ failed
       errorBehavior = report-any-error
       # ...or run and report if any _accepted_
       errorBehavior = report-any-success

      Those are just off the top of my head. But my point is that by
      staking out a config section for each hook, it gives us a place to
      naturally add new config options. And we can do it on a per-hook
      basis, which I think will be important since each hook has its own
      semantics.

      Now that's not _strictly_ necessary. We could still have
      "hook.pre-receive.errorBehavior" and just assume
      "hook.pre-receive.command" is "$GIT_DIR/hooks/pre-receive". But I
      think doing the whole thing from config makes the behavior simple
      and consistent (and the backwards compatibility is easy -- if they
      aren't using the new command config, we really do behave "as if"
      they had set it to the file in the hooks directory).

So I agree with your general sentiment that the multi-hook support
is conceptually orthogonal to switching to a config-based system. But I
think it's worth considering whether we want to do something
config-based first:

  - if we introduce it later, it saves us from having _three_ ways to do
    the same thing

  - I think it provides a more natural way to express the options that
    will inevitably grow once we have multi-hook support

-Peff

[1] https://public-inbox.org/git/20190424023438.GE98980@google.com/
