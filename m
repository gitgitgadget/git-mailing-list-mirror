Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C961FF72
	for <e@80x24.org>; Thu, 19 Oct 2017 02:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbdJSCtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 22:49:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57198 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751643AbdJSCtV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 22:49:21 -0400
Received: (qmail 28957 invoked by uid 109); 19 Oct 2017 02:49:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Oct 2017 02:49:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5506 invoked by uid 111); 19 Oct 2017 02:49:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Oct 2017 22:49:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Oct 2017 22:49:19 -0400
Date:   Wed, 18 Oct 2017 22:49:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrey Okoshkin <a.okoshkin@samsung.com>, git@vger.kernel.org,
        pclouds@gmail.com, l.s.r@web.de, avarab@gmail.com, krh@redhat.com,
        rctay89@gmail.com, Ivan Arishchenko <i.arishchenk@samsung.com>,
        Mikhail Labiuk <m.labiuk@samsung.com>
Subject: Re: [PATCH] commit: check result of resolve_ref_unsafe
Message-ID: <20171019024919.ram3bzabt5fra2lc@sigill.intra.peff.net>
References: <CGME20171018170047epcas2p4310be357e11e194d6d08ac3bdc478ba3@epcas2p4.samsung.com>
 <0e396c24-167f-901e-9122-cdc17164ec1e@samsung.com>
 <20171018183453.lr67zw455bkdmrlz@sigill.intra.peff.net>
 <xmqqo9p4j7eu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo9p4j7eu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 09:41:29AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Tangential to your patch, I also wondered why we did not pass
> > RESOLVE_REF_READING to resolve_ref_unsafe(). I think the answer is that
> > for symref lookups, we normally don't pass it so that we can handle
> > dangling symrefs. Of course we _just_ wrote HEAD ourselves, so we'd
> > expect it to exist, so it shouldn't really matter either way.
> 
> If we do expect it to exist, shouldn't we checking with READING and
> catching a funny situation if it arises?

Maybe. In the normal case it would not matter. If we _do_ find it gone,
I guess that is a sign that somebody is racing with us and changed HEAD
after we made the commit.

TBH, I think the "most right" thing would be to actually capture the ref
that HEAD points to when we actually make the commit, remember it, and
then report it here (the whole function of this code is just to say "I
made a commit on branch X"). But I don't know how much trouble it is
worth going to for that. It's buried behind a ref_transaction, and I
don't think builtin/commit.c ever sees the real name (though maybe it
would be a good feature of the transaction to record the destinations of
any symrefs we updated).

-Peff
