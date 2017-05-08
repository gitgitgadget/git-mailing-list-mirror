Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6A41FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdEHVzb (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:55:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:47669 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750808AbdEHVza (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:55:30 -0400
Received: (qmail 25528 invoked by uid 109); 8 May 2017 21:55:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 21:55:28 +0000
Received: (qmail 17229 invoked by uid 111); 8 May 2017 21:55:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 May 2017 17:55:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 May 2017 17:55:25 -0400
Date:   Mon, 8 May 2017 17:55:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Smith <whydoubt@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 02/10] Move textconv_object to be with other textconv
 methods
Message-ID: <20170508215525.gcyzzntqvm52mqcc@sigill.intra.peff.net>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170505052729.7576-3-whydoubt@gmail.com>
 <xmqqwp9v6vw2.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ4k7qVKE7OpSEELorwSx5hUgJksLAeNgVGs0w1JC_Ffg@mail.gmail.com>
 <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1ss0cg8t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 08, 2017 at 10:02:58AM +0900, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > I guess it is ok for now and in this series, but we may want
> > to split up diff.[ch] in the future into multiple finer grained files.
> 
> For what end?  Such a split would require more symbols internal to
> diff.[ch] to become external, which is a big downside, so we need to
> have a large reward to compensate it if we were to go there.

I think there are two sides to that coin. Let's say you have a file with
five functions (and you can replace function with structs, global
variables, etc; any unit of complexity that might or might not be
externally visible):

  /* called by both a() and b() */
  static void a_and_b_helper();

  /* called by a() */
  static void a_helper();
  void a();

  /* called by b() */
  static void b_helper();
  void b();

When they are in the same file, b() and b_helper() can see a_helper(),
even though they don't need it. And that means increased complexity in
dealing with a_helper(), because its visibility is larger than
necessary. We have to worry about what a change to it might do to b()
(or more realistically, c(), d(), etc).

If we split this apart, we end up with three files:

   common.c:
     void a_and_b_helper();

   a.c:
     static void a_helper();
     void a();

   b.c:
     static void b_helper();
     void b();

The specific helpers have less visibility, which is good. The public
functions a() and b() were already public, so no change. But now the
common helper is public, too, even though nobody except a() and b() care
about it.

So it's a tradeoff. And the important question is: is the bleed-over
between a() and b() worse than the common bits being made public?  That
can't be answered without looking at how many distinct "a" and "b"-like
chunks there are in the file, and what the common bits look like. I'm
not sure of the answer for diff.c. Without digging, both ends of the
spectrum seem equally plausible to me: that it is mostly a set of N
distinct units which could be split apart, or that it really is a few
public functions calling the same common core over and over.

And a follow-on question is what we can do to mitigate the cost of
making the common code public. We could advertise a_and_b_helper() only
in diff-internal.h, and then makes it only semi-public (anybody can
include that, of course, but including diff-internal.h seems like it
ought to be a red flag). That only helps the programmer, though; we'd
still be losing out on compiler optimizations and static analysis that
only looks at one translation unit at a time.

Phew. That ended up a little long-winded. All of it is to say that I
don't think it makes sense to reject a split out-of-hand, but nor is it
always a good thing. It depends on what's in the file.

-Peff
