Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D694120281
	for <e@80x24.org>; Tue, 23 May 2017 16:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759972AbdEWQqq (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 12:46:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:56803 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757306AbdEWQqp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 12:46:45 -0400
Received: (qmail 25622 invoked by uid 109); 23 May 2017 16:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 16:46:43 +0000
Received: (qmail 1450 invoked by uid 111); 23 May 2017 16:47:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 12:47:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 12:46:41 -0400
Date:   Tue, 23 May 2017 12:46:41 -0400
From:   Jeff King <peff@peff.net>
To:     ch <cr@onlinehome.de>
Cc:     git@vger.kernel.org
Subject: Re: Passing revs to git-bundle-create via stdin
Message-ID: <20170523164641.u3rd7bgc7ifvu2su@sigill.intra.peff.net>
References: <76491764-cd43-ef7f-fbfc-939a15f2fb77@onlinehome.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76491764-cd43-ef7f-fbfc-939a15f2fb77@onlinehome.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 01:44:55AM +0200, ch wrote:

> I'm using git bundles to create (incremental) backups of my local repositories.
> This works quite well but for certain repositories I'm getting unexpectedly big
> incremental bundles. I did some testing and from what I can tell it seems
> git-bundle-create has issues processing revs passed via stdin. To illustrate
> the problem I have included a small bash script below.
> 
> I'm using Git for Windows 2.13.0.windows.1 (64-bit). Unfortunately I don't have
> access to a non-Windows box to check whether it's a problem specific to the
> Windows port.

Thanks for an easy reproduction recipe. I see the problem on Linux, too.

I think what's happening is that git-bundle actually runs _two_
traversals using the command-line arguments. It kicks off an external
rev-list via compute_and_write_prerequisites(), and then feeds the
arguments again to setup_revisions(). The first one eats all of stdin,
and the second just sees an empty input.

You can see it working if you do:

  $ git bundle create from-terminal.git --all --stdin
  ^feature
  ^master^
  [press ^D, i.e., ctrl-d]
  ^feature
  ^master^
  [press ^D again]

Hitting ^D tells the terminal driver to send an EOF; the first one goes
to the child rev-list, and then we repeat the input to get read by the
second traversal. The result is identical to your command-line-only
output. I have no idea if the ^D thing works at all on Windows, but I
don't mean it even as a workaround. It was just a way of confirming my
guess about the double-read.

The real solutions I can think of are:

  1. Teach git-bundle not to require the double-read. I'm not sure why
     it's written the way it is, but presumably it would be tricky to
     undo it (or we would have just written it the other way in the
     first place!)

  2. Git-bundle could buffer stdin and feed it to the two traversals. I
     think this actually ends up a little tricky, because the second
     traversal is done in-process (so we'd have to actually re-feed the
     buffer to our stdin via a "struct async", which feels pretty
     hacky).

  3. git-bundle could natively support --stdin, reading each line and
     convert it into traversal arguments. This is the quickest way to
     make your example work, but I suspect there will be funky corner
     cases (because we'd have to replicate the same rules that
     revision.c uses to read its input).

None of those are incredibly appealing.

-Peff
