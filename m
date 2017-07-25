Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D5341F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdGYTNu (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 15:13:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:48714 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751141AbdGYTNt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 15:13:49 -0400
Received: (qmail 8394 invoked by uid 109); 25 Jul 2017 19:13:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 19:13:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20571 invoked by uid 111); 25 Jul 2017 19:14:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 15:14:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2017 15:13:47 -0400
Date:   Tue, 25 Jul 2017 15:13:47 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Farshid Zavareh <fhzavareh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
Message-ID: <20170725191347.e2p7goxho2rcemz4@sigill.intra.peff.net>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
 <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
 <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
 <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 06:06:49PM +1000, Andrew Ardill wrote:

> Let's have a look:
> 
> $ git rev-list --objects --all |
>   git cat-file --batch-check='%(objectsize:disk) %(objectsize)
> %(deltabase) %(rest)'
> 174 262 0000000000000000000000000000000000000000
> 171 260 0000000000000000000000000000000000000000
> 139 212 0000000000000000000000000000000000000000
> 47 36 0000000000000000000000000000000000000000
> 377503831 2310238304 0000000000000000000000000000000000000000 data.txt
> 47 36 0000000000000000000000000000000000000000
> 500182546 3740427683 0000000000000000000000000000000000000000 data.txt
> 47 36 0000000000000000000000000000000000000000
> 447340264 3357717475 0000000000000000000000000000000000000000 data.txt
> 
> Yep, all zlib.

OK, that makes sense.

> What do you think is a reasonable config for storing text files this
> large, to get good delta compression, or is it more of a trial and
> error to find out what works best?

I think it would really depend on what's in your repo. If you just have
gigantic text files and no big binaries, and you have enough RAM to do
diffs on the text files, it's not unreasonable to just send
core.bigfilethreshold to something really big and not worry about it.

In general, a diff is going to want memory at least 2x the size of the
file (for the old and new images). And we tend to keep in memory all of
the images for a single tree-diff at one time (so if you touched two
gigantic files in one commit, then "git log -p" is probably going to
peak at having all four before/after images in memory at once).

If you just want deltas but not diffs, you can probably do:

  echo '*.gigantic -diff' >.gitattributes
  git config core.bigfilethreshold 10G

I think that will turn off streaming of the blobs in some code paths,
too. But hopefully a _single_ copy of each file would be OK to hold in
RAM. If it's not, you might also be able to get away with packing once
with:

  git -c core.bigfilethreshold=10G repack -adf

and then further repacks will carry those deltas forward. I think we
only apply the limit when actively searching for new deltas, not when
reusing existing ones.

As you can see, core.bigfilethreshold is a pretty blunt instrument. It
might be nice if .gitattributes understood other types of patterns
besides filenames, so you could do something like:

  echo '[size > 500MB] delta -diff' >.gitattributes

or something like that. I don't think it's come up enough for anybody to
care too much about it or work on it.

-Peff
