Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CCE6207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 14:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934093AbcI2Oz0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 10:55:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:49930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbcI2OzY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 10:55:24 -0400
Received: (qmail 32021 invoked by uid 109); 29 Sep 2016 14:55:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 14:55:23 +0000
Received: (qmail 1993 invoked by uid 111); 29 Sep 2016 14:55:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 29 Sep 2016 10:55:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Sep 2016 10:55:20 -0400
Date:   Thu, 29 Sep 2016 10:55:20 -0400
From:   Jeff King <peff@peff.net>
To:     "Kyle J. McKay" <mackyle@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
Message-ID: <20160929145520.dgyj57df4tyqrl4y@sigill.intra.peff.net>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
 <CA+55aFyfvvqq1c=hZcuL-yPavp2tjzx8r3bFJnMY7DAE7YcB=Q@mail.gmail.com>
 <841D4FC2-9673-486A-8D94-8967188CCC60@gmail.com>
 <20160929132425.of7m5t4tsqcb6bbk@sigill.intra.peff.net>
 <2FECD796-7B92-41BB-A0AF-57650FF7E78D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2FECD796-7B92-41BB-A0AF-57650FF7E78D@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 07:36:27AM -0700, Kyle J. McKay wrote:

> On Sep 29, 2016, at 06:24, Jeff King wrote:
> 
> > > If you are doing "git show 235234" it should pick the tag (if it
> > > peels to a
> > > committish) because Git has already set a precedent of preferring
> > > tags over
> > > commits when it disambiguates ref names and otherwise pick the
> > > commit.
> > 
> > I'm not convinced that picking the tag is actually helpful in this case;
> > I agree with Linus that feeding something to "git show" almost always
> > wants to choose the commit.
> 
> Since "git show" peels tags you end up seeing the commit it refers to
> (assuming it's a committish tag).

Yes, but it's almost certainly _not_ the commit you meant. From your
example:

>    c512b03:
>       c512b035556eff4d commit Merge branch 'rc/maint-reflog-msg-for-forced
>       c512b0344196931a tag    (v0.99.9a) GIT 0.99.9a

If I'm looking for the commit c512b03, then it almost certainly isn't
v0.99.9a. That tag's commit is e634aec. Or another way of thinking about
it: you want to guess what the _writer_ of the note meant. Why would
somebody write "c512b03" when they could have written "v0.99.9a"? And
they certainly would not have written it if they meant "e634aec". :)

> > I also don't think tag ambiguity in short sha1s is all that interesting.
> 
> The Linux repository has this:
> 
>    901069c:
>       901069c71415a76d commit iwlagn: change Copyright to 2011
>       901069c5c5b15532 tag    (v2.6.38-rc4) Linux 2.6.38-rc4

Sure, I'm not surprised there's a collision. But I'd expect those to be
a tiny fraction of collisions. Here's the breakdown of object types in
my clone of linux.git:

  $ git cat-file --batch-all-objects --batch-check='%(objecttype)' |
    sort | uniq -c
  1421198 blob
   618073 commit
      479 tag
  2877913 tree

That's a hundredth of a percent tag objects.  The chance that you have
_a_ 7-hex collision with a tag is relatively high. But the chance that
any given collision involves a tag is rather small.

-Peff
