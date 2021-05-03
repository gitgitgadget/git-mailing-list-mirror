Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3ADC43460
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3AE611AC
	for <git@archiver.kernel.org>; Mon,  3 May 2021 20:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhECUOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 16:14:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:43440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhECUOR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 16:14:17 -0400
Received: (qmail 7373 invoked by uid 109); 3 May 2021 20:13:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 May 2021 20:13:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7101 invoked by uid 111); 3 May 2021 20:13:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 May 2021 16:13:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 May 2021 16:13:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/9] fsck_tree(): fix shadowed variable
Message-ID: <YJBZYt8ivlTDHpRM@coredump.intra.peff.net>
References: <YI12hK4X/gfl3u29@coredump.intra.peff.net>
 <YI12stO48egyiHjv@coredump.intra.peff.net>
 <87y2cwvz9e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y2cwvz9e.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 03, 2021 at 01:15:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Commit b2f2039c2b (fsck: accept an oid instead of a "struct tree" for
> > fsck_tree(), 2019-10-18) introduced a new "oid" parameter to
> > fsck_tree(), and we pass it to the report() function when we find
> [...]
> 
> Have you considered just passing down the "obj" instead of the "oid"?
> It's a bit of a bigger change, but seems to be worth it in this case as
> the below diff (on top of master) shows. We spend quite a bit of effort
> peeling an "obj" just to pass oid/type further down the stack.

That would be undoing the point of the referenced commit above. More
discussion in this thread:

  https://lore.kernel.org/git/20191018044103.GA17625@sigill.intra.peff.net/

but the gist is:

  - there were bugs caused by looking at the object structs; not having
    it make sure we can't introduce similar bugs

  - using oids and buffers makes it possible for code to avoid having
    object structs at all. index-pack could take advantage of this (to
    reduce memory usage), but nobody has yet written that patch.

-Peff
