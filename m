Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FC620899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdHBReO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:34:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:55824 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752055AbdHBReO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:34:14 -0400
Received: (qmail 9702 invoked by uid 109); 2 Aug 2017 17:34:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 17:34:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10666 invoked by uid 111); 2 Aug 2017 17:34:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Aug 2017 13:34:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Aug 2017 13:34:11 -0400
Date:   Wed, 2 Aug 2017 13:34:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Richard Jones <richardj@backbase.com>, git@vger.kernel.org
Subject: Re: Git log --tags isn't working as expected
Message-ID: <20170802173411.tu7wyuehcktxge6o@sigill.intra.peff.net>
References: <CACq05g+4HH9L_fiFLR8php=w5JkqB0792SzR9EZU-o+QHuoM8A@mail.gmail.com>
 <20170802083200.3rmnz6mx2wfoarng@sigill.intra.peff.net>
 <xmqqa83idjlj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa83idjlj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 02, 2017 at 09:23:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >   3. Use --simplify-by-decoration to show a particular range of commits,
> >      but limit to ones that actually have a ref pointing at them. Like:
> >
> >        git log <COMMIT_ID>..HEAD --simplify-by-decoration
> 
> Nit: dashed options come first and then revs and then pathspecs.

Well, sort of. It does work just fine, and always has. I always thought
we were following the GNU-style liberal option ordering.

By the way, I noticed something funny that I forgot to mention:

  git log --tags=does-not-exist

shows HEAD, because the logic to kick in the default only asks "were we
given any refs to start the traversal?". I think it probably should
consider a wildcard with no matches to override the default, and show
nothing.

I haven't decided if it should be empty-but-success, or give an error.
And if an error, if it is "you tried to give me refs, but they showed
nothing" or "you gave me a wildcard that matched nothing". The
distinction matters for:

  git log --tags=does-not-exist --tags=does-exist

which currently allows the empty wildcard to be a noop.

-Peff
