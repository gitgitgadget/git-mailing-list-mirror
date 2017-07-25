Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AC21F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbdGYVNJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:13:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:48884 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752605AbdGYVND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:13:03 -0400
Received: (qmail 14426 invoked by uid 109); 25 Jul 2017 21:13:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 21:13:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21558 invoked by uid 111); 25 Jul 2017 21:13:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jul 2017 17:13:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jul 2017 17:13:01 -0400
Date:   Tue, 25 Jul 2017 17:13:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrew Ardill <andrew.ardill@gmail.com>,
        Farshid Zavareh <fhzavareh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Should I store large text files on Git LFS?
Message-ID: <20170725211300.vwlpioy5jes55273@sigill.intra.peff.net>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
 <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
 <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net>
 <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
 <20170725191347.e2p7goxho2rcemz4@sigill.intra.peff.net>
 <xmqq7eywutlt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7eywutlt.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 01:52:46PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As you can see, core.bigfilethreshold is a pretty blunt instrument. It
> > might be nice if .gitattributes understood other types of patterns
> > besides filenames, so you could do something like:
> >
> >   echo '[size > 500MB] delta -diff' >.gitattributes
> >
> > or something like that. I don't think it's come up enough for anybody to
> > care too much about it or work on it.
> 
> But attributes is about paths, at which a blob may or may not exist,
> so it is a bad fit to add conditionals that are based on sizes and
> types.

Do attributes _have_ to be about paths? In practice we often use them to
describe objects, and paths are just the only mechanism we give to refer
to objects.  But it is not actually a correct or rigorous mechanism in
some cases.  For example, imagine I have a .gitattributes with:

  foo -delta
  bar delta

and then imagine I have a tree with both "foo" and "bar" pointing to the
same blob. When I run pack-objects, it wants to know whether to delta
the object. What should it do?

The delta decision is really a property of the object. But the only
mechanism we give for selecting an object is by path, which we know is
not a one-to-one mapping with objects. So the results you get will
depend on which name we happened to see the object under first while
traversing.

I think the case you are getting at is something like clean filters,
where we might not have an object at all. In that case I would argue
that a property of an object could never be satisfied (so neither
"size > 500" nor "size <= 500" could match). Whether object properties
are meaningful is in the eye of the code that is looking up the value.
Or more generally, the set of properties to be matched is in the eye of
the caller. So looking up a clean filter might want to define the size
property based no the working tree size.

-Peff
