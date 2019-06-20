Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C5F1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 18:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfFTS1q (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 14:27:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:46284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726883AbfFTS1q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 14:27:46 -0400
Received: (qmail 25085 invoked by uid 109); 20 Jun 2019 18:27:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 18:27:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17458 invoked by uid 111); 20 Jun 2019 18:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 14:28:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 14:27:43 -0400
Date:   Thu, 20 Jun 2019 14:27:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/17] khash: rename oid helper functions
Message-ID: <20190620182743.GC18704@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074141.GO3713@sigill.intra.peff.net>
 <xmqqwohgnocu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwohgnocu.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 10:44:17AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For use in object_id hash tables, we have oid_hash() and oid_equal().
> > But these are confusingly similar to the existing oideq() and the
> > oidhash() we plan to add to replace sha1hash().
> >
> > The big difference from those functions is that rather than accepting a
> > const pointer to the "struct object_id", we take the arguments by value
> > (which is a khash internal convention). So let's make that obvious by
> > calling them oidhash_by_value() and oideq_by_value().
> >
> > Those names are fairly horrendous to type, but we rarely need to do so;
> > they are passed to the khash implementation macro and then only used
> > internally. Callers get to use the nice kh_put_oid_map(), etc.
> 
> The pass-by-value interface feels a bit unforunate but hopefully
> "static inline" would help us avoid actually copying the struct left
> and right as we make calls to them X-<.

Yeah, exactly. I think it should end up quite fast, though if anybody
(René?) wants to try tweaking khash and timing it, be my guest.

I do think if it took the more usual pass-by-const-pointer we'd probably
still end up with the exact same code from an optimizing compiler, since
all of the references and dereferences would cancel out once it was
inlined.

-Peff
