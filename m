Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79BB207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S975362AbdDYEqp (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:46:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:39547 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753754AbdDYEqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:46:44 -0400
Received: (qmail 21597 invoked by uid 109); 25 Apr 2017 04:46:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 04:46:44 +0000
Received: (qmail 32010 invoked by uid 111); 25 Apr 2017 04:47:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 00:47:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Apr 2017 00:46:41 -0400
Date:   Tue, 25 Apr 2017 00:46:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fast-export: deletion action first
Message-ID: <20170425044641.sx5uoql4oiug6iq7@sigill.intra.peff.net>
References: <1493079137-1838-1-git-send-email-miguel.torroja@gmail.com>
 <20170425032927.74btvfcexbdq4rmz@sigill.intra.peff.net>
 <xmqqfugxw1us.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfugxw1us.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 24, 2017 at 09:24:59PM -0700, Junio C Hamano wrote:

> > So we sort deletions first. And the bit that the context doesn't quite
> > show here is that we then compare renames and push them to the end.
> > Everything else will compare equal.
> 
> Wait--we also allow renames?  Rename is like delete in the context
> of discussing d/f conflicts, in that it tells us that the source
> path will be missing in the end result.  If you rename a file "d" to
> "e", then there is a room for you to create a directory "d" to store
> a file "d/f" in.  Shouldn't it participate also in this "delete
> before add to avoid d/f conflict" logic?

Hrm. Yeah, I agree that case is problematic. But putting the renames
early creates the opposite problem. If you delete "d/f" to make way for
a rename to a file "d", then that deletion has to come first.

So naively you might think that pure deletions come first, then renames.
But I think you could have dependencies within the renames. For
instance:

  git init
  mkdir a b c
  seq 1 1000 >a/f
  seq 1001 2000 >b/f
  seq 2001 3000 >c/f
  git add .
  git commit -m base

  git mv a tmp
  git mv b/f a; rmdir b
  git mv c/f b; rmdir c
  git mv tmp/f c; rmdir tmp

There's no correct order there; it's a cycle.

So I suspect that any reader that accepts renames needs to be able to
handle the inputs in any order (I'd also suspect that many
implementations _don't_, but get by because people don't do silly things
like this in practice).

Anyway. I don't think Miguel's patch needs to solve all of the lingering
rename cases. But I am curious whether it makes some rename cases worse,
because the depth-sorting was kicking in before and making them work.

-Peff
