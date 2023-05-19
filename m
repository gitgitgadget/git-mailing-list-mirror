Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2FC77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 09:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjESJGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjESJGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 05:06:15 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA70F1712
        for <git@vger.kernel.org>; Fri, 19 May 2023 02:06:00 -0700 (PDT)
Received: (qmail 12437 invoked by uid 109); 19 May 2023 09:05:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 09:05:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 324 invoked by uid 111); 19 May 2023 09:05:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 May 2023 05:05:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 May 2023 05:05:59 -0400
From:   Jeff King <peff@peff.net>
To:     Hanno =?utf-8?B?QsO2Y2s=?= <hanno@hboeck.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: git push --quiet is not quiet
Message-ID: <20230519090559.GA3515410@coredump.intra.peff.net>
References: <20230519101505.416d0963.hanno@hboeck.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519101505.416d0963.hanno@hboeck.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2023 at 10:15:05AM +0200, Hanno Böck wrote:

> I believe this is a bug in git: According to the man page for git push,
> the -q/--quiet parameter should "Suppress all output".
> 
> However, it does not. To reproduce: Create a commit in a repo and run:
> git push -q
> remote: Resolving deltas: 100% (1/1), completed with 1 local object.

That message is coming from the remote side over the stderr sideband; we
don't interpret it locally, so we don't know whether it's a real error
or just chatter. We must pass it on to the user. So the bug is that the
remote side is showing progress output, even though we've asked for
--quiet.

That is usually handled by sending a "quiet" capability over the
protocol. E.g., if you do something like this:

  git init --bare dst.git
  GIT_TRACE_PACKET=1 git push dst.git HEAD

You should see the server advertise that it knows about the "quiet"
capability:

  packet:         push< 0000000000000000000000000000000000000000 capabilities^{}\0report-status report-status-v2 delete-refs side-band-64k quiet atomic ofs-delta object-format=sha1 agent=git/2.41.0.rc0.368.gaafabc8979

And then when the client responds, it asks for "quiet":

  packet:         push> 0000000000000000000000000000000000000000 b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06 refs/heads/master\0 report-status-v2 side-band-64k quiet object-format=sha1 agent=git/2.41.0.rc0.368.gaafabc8979

What is your push destination? If you run your push with GIT_TRACE_PACKET=1
in the environment, does the other side say that it supports "quiet"?

As a guess, I wondered if you might be pushing to GitHub. And indeed,
they do not support quiet. Here's the advertisement from pushing to a
test repo over ssh:

  push< 60e3601d029e7e4ed799be13225cbc221d7d9894 refs/heads/main\0report-status report-status-v2 delete-refs side-band-64k ofs-delta atomic push-options object-format=sha1 agent=github/spokes-receive-pack-14212a8c32379761bfb7c8707291458d5acdd11e

So I think this is a bug / lack of feature in GitHub's server
implementation.  It used to be a thin proxy around Git (and Git has
supported "quiet" since c207e34f7733 in 2012). But I suspect they may
have recently replaced it with something more custom (based on the agent
field).

+cc a few relevant GitHubbers

-Peff
