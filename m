Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF021F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 18:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbcHOSzE (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 14:55:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:55679 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753103AbcHOSzE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 14:55:04 -0400
Received: (qmail 4007 invoked by uid 109); 15 Aug 2016 18:55:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 18:55:03 +0000
Received: (qmail 18110 invoked by uid 111); 15 Aug 2016 18:55:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Aug 2016 14:55:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Aug 2016 14:55:01 -0400
Date:	Mon, 15 Aug 2016 14:55:01 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Andreas Schwab <schwab@linux-m68k.org>,
	Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
Message-ID: <20160815185500.htgrz3t2wkztg4ww@sigill.intra.peff.net>
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
 <20160815120916.6iobqirqbg76exms@sigill.intra.peff.net>
 <8737m63phh.fsf@linux-m68k.org>
 <20160815180905.znnz6evufsne5wy6@sigill.intra.peff.net>
 <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh9alhoor.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 11:28:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Aug 15, 2016 at 07:34:50PM +0200, Andreas Schwab wrote:
> >
> >> On Aug 15 2016, Jeff King <peff@peff.net> wrote:
> >> 
> >> > And implicit in your test is the other bug, which is that deleting the
> >> > last key in a section leaves the empty header. I think it's related to
> >> > the same issue.
> >> 
> >> Indiscriminately removing empty section headers may break comments that
> >> have been put there on purpose.
> >
> > I know, but we do not even do so discriminately.
> 
> I notice that we have thought about all the issues when we last
> discussed it in 2013.  Refining a message from the earlier thread,
> as it illustrates tricky cases in which we have to be careful.

Thanks for digging up the threads that I was too lazy to find.

I agree with most everything here, though I would be happy if somebody
even wrote a patch to handle the "easy" cases.

> So a comment outside [section "name"] is tricky; it needs some
> mechanism (or convention) to tell us if it is about the particular
> section, or it is about the location in the configuration file.

Keep in mind that even "outside" is hard, because sections do not
explicitly close.

So in:

  [core]
  foo = bar

  # here are my remotes

  [remote "github"]
  url = ...

How do we know that the comment is "outside" and not part of [core]?

We can perhaps guess so because there are no keys after it in the
section, though there are some special cases, like:

  [core]
  foo = bar
  # This isn't necessary anymore because...
  # xyzzy = false

or even:

  [core]
  foo = bar # needed because of xyzzy

You can probably make reasonable cases based on heuristics around
newlines, but that is even further into "convention" territory.

-Peff
