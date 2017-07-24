Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FFC203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 18:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbdGXSLY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 14:11:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:47326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753299AbdGXSLU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 14:11:20 -0400
Received: (qmail 8946 invoked by uid 109); 24 Jul 2017 18:11:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 18:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11617 invoked by uid 111); 24 Jul 2017 18:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 14:11:36 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 14:11:18 -0400
Date:   Mon, 24 Jul 2017 14:11:18 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     Farshid Zavareh <fhzavareh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
Message-ID: <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
 <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 02:58:38PM +1000, Andrew Ardill wrote:

> On 24 July 2017 at 13:45, Farshid Zavareh <fhzavareh@gmail.com> wrote:
> > I'll probably test this myself, but would modifying and committing a 4GB
> > text file actually add 4GB to the repository's size? I anticipate that it
> > won't, since Git keeps track of the changes only, instead of storing a copy
> > of the whole file (whereas this is not the case with binary files, hence the
> > need for LFS).
> 
> I decided to do a little test myself. I add three versions of the same
> data set (sometimes slightly different cuts of the parent data set,
> which I don't have) each between 2 and 4GB in size.
> Each time I added a new version it added ~500MB to the repository, and
> operations on the repository took 35-45 seconds to complete.
> Running `git gc` compressed the objects fairly well, saving ~400MB of
> space. I would imagine that even more space would be saved
> (proportionally) if there were a lot more similar files in the repo.

Did you tweak core.bigfilethreshold? Git won't actually try to find
deltas on files larger than that (500MB by default). So you might be
seeing just the effects of zlib compression, and not deltas.

You can always check the delta status after a gc by running:

  git rev-list --objects --all |
  git cat-file --batch-check='%(objectsize:disk) %(objectsize) %(deltabase) %(rest)'

That should give you a sense of how much you're saving due to zlib (by
comparing the first two numbers for a copy that isn't a delta; i.e.,
with an all-zeros delta base) and how much due to deltas (how much
smaller the first number is for an entry that _is_ a delta).

-Peff
