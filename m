Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEBE2018A
	for <e@80x24.org>; Fri,  1 Jul 2016 19:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbcGATjO (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 15:39:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:39316 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932069AbcGATjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 15:39:13 -0400
Received: (qmail 26459 invoked by uid 102); 1 Jul 2016 19:39:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 15:39:13 -0400
Received: (qmail 21692 invoked by uid 107); 1 Jul 2016 19:39:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Jul 2016 15:39:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jul 2016 15:39:09 -0400
Date:	Fri, 1 Jul 2016 15:39:09 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>
Subject: Re: [PATCH 1/4] push options: {pre,post}-receive hook learns about
 push options
Message-ID: <20160701193909.GA23141@sigill.intra.peff.net>
References: <20160630005951.7408-1-sbeller@google.com>
 <20160630005951.7408-2-sbeller@google.com>
 <20160701071410.GG5358@sigill.intra.peff.net>
 <CAGZ79kaDCLm3BBURJKfkYWKKvozkFTGCn0wGiQCtspUvtQBd+g@mail.gmail.com>
 <20160701175950.GB16235@sigill.intra.peff.net>
 <CAPc5daWjSW5KM4uUyEBbb+765t50+dUsewF52uPrCiT1HW=NAQ@mail.gmail.com>
 <20160701181102.GA16695@sigill.intra.peff.net>
 <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr3bdxirw.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 01, 2016 at 12:25:39PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Compare to:
> >
> >   if test "$GIT_PUSH_VAR_force" = true
> >      ...
> 
> OK.  As this is a new feature, I guess it is not too bad if we tell
> users that they cannot have duplicate keys in their <key,val> data
> they ask Git to transport.  They can do the key1=val1 key2=val2
> numbering themselves if that is really needed.

That was sort of my question. _Is it_ too bad or not? It's hard to say
without knowing the use cases.

I'm OK with the more flexible scheme if it's something people really
want to use. Though perhaps with your suggestion, we can have our cake
and eat it, too. If we codify the key1/key2 thing by converting:

  git push --push-var=foo=one --push-var=foo=two

into:

  GIT_PUSH_VAR_foo=one
  GIT_PUSH_VAR_foo1=two

then a hook can either:

  - just use $GIT_PUSH_VAR_foo if they only know how to handle a single
    value

  - handle a list like:

     if test -n "$GIT_PUSH_VAR_foo"
     then
       # non-empty list
       echo first value is $GIT_PUSH_VAR_foo
       i=1
       while true; do
         eval "test -z \$GIT_PUSH_VAR_foo$i" && break
	 eval "echo value \$i is \$GIT_PUSH_VAR_foo$i"
       done
     fi

That's ugly, of course, but not really uglier than the parsing required
for the COUNT proposal.

I'm assuming that git actually knows about and enforces that things are
"key=value". I'm not sure how you'd get by without that (you'd have to
infer the meaning of a parameter by its position, which seems like a
recipe for mistakes and incompatibilities).

-Peff
