Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7AA81FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbcLFPZy (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 10:25:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:52470 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752242AbcLFPZx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 10:25:53 -0500
Received: (qmail 25841 invoked by uid 109); 6 Dec 2016 15:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 15:25:31 +0000
Received: (qmail 14489 invoked by uid 111); 6 Dec 2016 15:26:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 10:26:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 10:25:30 -0500
Date:   Tue, 6 Dec 2016 10:25:30 -0500
From:   Jeff King <peff@peff.net>
To:     Matthew Patey <matthew.patey2167@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: stash staged file move loses original file deletion
Message-ID: <20161206152530.snccf7buiosst3e4@sigill.intra.peff.net>
References: <CAFQpxxKbn4vBMzVcLZgBVvuL2fsOGNMHR1WC+aTOG_RAWkZ_Gg@mail.gmail.com>
 <20161206142446.5ba3wc625p5o6nct@sigill.intra.peff.net>
 <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQpxx+PJ3FSoH9DFWyEw+ZLagji9Qou+aY9EB8A+=t+QX0o2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 02:45:05PM +0000, Matthew Patey wrote:

> Thanks for the reply! I agree that it is weird that applying a stash with a
> move only puts the addition back in the index, and thanks for the tip on
> "index" to properly apply that. For this case I was focusing on the
> behavior of the second stash/apply, with the first stash/apply as an
> example of how to get into a weird state that triggers the odd behavior of
> the second.

Oh, heh, I totally missed that.

I agree that the second stash not saving the deletion seems like a bug.
Oddly, just stashing a deletion, like:

  rm a
  git stash
  git stash apply

does store it. So it's not like we can't represent the deletion. Somehow
the presence of "b" in the index matters.

It looks like the culprit may be this part of create_stash():

  git diff --name-only -z HEAD -- >"$TMP-stagenames"

That is using the "git diff" porcelain, which will respect renames, and
the --name-only bit mentions only "b".

If you run:

  git -c diff.renames=false stash

then it works.

-Peff
