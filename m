Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267EB20193
	for <e@80x24.org>; Fri,  2 Sep 2016 19:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755228AbcIBTOq (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:14:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755244AbcIBTO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:14:28 -0400
Received: (qmail 17646 invoked by uid 109); 2 Sep 2016 19:14:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 19:14:27 +0000
Received: (qmail 26946 invoked by uid 111); 2 Sep 2016 19:14:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 02 Sep 2016 15:14:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2016 15:14:25 -0400
Date:   Fri, 2 Sep 2016 15:14:25 -0400
From:   Jeff King <peff@peff.net>
To:     Beau Martinez <beau@beaumartinez.com>
Cc:     git@vger.kernel.org
Subject: Re: git add =?utf-8?Q?-p=E2=80=94splittin?= =?utf-8?Q?g?= hunks,
 limit is too large
Message-ID: <20160902191425.ki7nfhlqgnihoqpw@sigill.intra.peff.net>
References: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEtDOuV+0CKRSu9mJa27+yQKJ-QRyNmwecrZKaaCh0St+VagZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 02, 2016 at 03:36:58PM +0100, Beau Martinez wrote:

> I'd like to inquire as to why `git add -p` can only split hunks so
> much. The limit is too large; why can't you split until each hunk is
> only a line? I often have to run `edit` and split them manually
> myself.

There's some previous discussion in this thread:

  http://public-inbox.org/git/200805232221.45406.trast@student.ethz.ch/t/#u

and further back, this message:

  http://public-inbox.org/git/7vbq8v7cdx.fsf@gitster.siamese.dyndns.org/

I think one problem is that in a given contiguous hunk, not all of the
lines are independent, because edits are represented as a pair of -/+
lines. E.g., if the preimage is:

  one
  two
  four

and the postimage is:

  one
  two modified
  three
  four

your diff will be:

   one
  -two
  +two modified
  +three
   four

The ideal split is two groups:

  -two
  +two modified

  +three

So you could possibly achieve that by specifying the exact line to split
at. But let's imagine "two" was the missing item, and we modified
"three". Then your diff is:

   one
  -three
  +two
  +three modified
   four

Now the related lines are non-adjacent! I don't think there's a general
solution, and of course it can get arbitrarily complicated, with many
interleaved pairs. I don't think we can rely on figuring out which lines
form a pair. In this toy example it's obvious, but in real diffs the
lines might not bear any resemblance.

Splitting to single lines means you need to remember to add the matched
pairs, which might be arbitrarily far apart.  That's not really any
different than dumping the hunk in your editor, but I find there that
it's easy to rearrange and group things as appropriate.

> I'd like to contribute a patch to change it, although my C is rusty.
> Are there resources that will help me to do this?

The good news (or maybe the bad) is that "add -p" is implemented
entirely in Perl. :) It's in git-add--interactive.perl.

-Peff
