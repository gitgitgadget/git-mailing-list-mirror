Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785C41FF6D
	for <e@80x24.org>; Tue, 29 Nov 2016 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756171AbcK2GjQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 01:39:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:48252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756062AbcK2GiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 01:38:03 -0500
Received: (qmail 29488 invoked by uid 109); 29 Nov 2016 06:38:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 06:38:01 +0000
Received: (qmail 8038 invoked by uid 111); 29 Nov 2016 06:38:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 01:38:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 01:37:59 -0500
Date:   Tue, 29 Nov 2016 01:37:59 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161129010538.GA121643@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 28, 2016 at 05:05:38PM -0800, Brandon Williams wrote:

> On 11/28, Junio C Hamano wrote:
> > * bw/grep-recurse-submodules (2016-11-22) 6 commits
> >  - grep: search history of moved submodules
> >  - grep: enable recurse-submodules to work on <tree> objects
> >  - grep: optionally recurse into submodules
> >  - grep: add submodules as a grep source type
> >  - submodules: load gitmodules file from commit sha1
> >  - submodules: add helper functions to determine presence of submodules
> > 
> >  "git grep" learns to optionally recurse into submodules
> > 
> >  Has anybody else seen t7814 being flakey with this series?
> 
> Which tests in particular are you seeing issues with?  I can't see any
> issues running it locally.

It looks like tests 14 and 15 are racy. The whole script usually passes,
but if I run it under my stress script[1], it fails within 5-10 seconds
on one of those two.

The failures always look like (this one is from test 15, but the one in
test 14 is similar):

  --- expect      2016-11-29 06:26:37.874664486 +0000
  +++ actual      2016-11-29 06:26:37.878664486 +0000
  @@ -1,2 +1 @@
  -file:foobar
   sub-moved/file:foobar

I haven't dug into it, but I don't see anything obviously racy-looking
in the test, so presumably it's in the code. Without looking, but
knowing the nature of the code, I'd guess the probable avenues are:

  1. A read() or write() that gets split under load (just because
     there's processes piping to other processes here).

  2. Grep threads doing more complicated stuff that needs to take a
     lock. You might try building with -fsanitize=thread to see if it
     turns up anything.

-Peff

[1] https://github.com/peff/git/blob/meta/stress
