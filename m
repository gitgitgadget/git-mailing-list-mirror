Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC30C433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB1F92074B
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 10:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGPKlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:41:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:58902 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPKlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 06:41:50 -0400
Received: (qmail 22486 invoked by uid 109); 16 Jul 2020 10:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jul 2020 10:41:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22704 invoked by uid 111); 16 Jul 2020 10:41:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jul 2020 06:41:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jul 2020 06:41:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] upload-pack: do not lazy-fetch "have" objects
Message-ID: <20200716104149.GA376357@coredump.intra.peff.net>
References: <20200715223112.2018556-1-jonathantanmy@google.com>
 <xmqqpn8wie21.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn8wie21.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 15, 2020 at 03:55:18PM -0700, Junio C Hamano wrote:

> Fixing issues hit by real users reactively is a necessary and good
> thing, but this is not the first time we patch callers of
> has_object_file() for this kind of "we are merely trying to
> determine the boundary of what we have, so that we know what we need
> to add to this repository" queries, I am afraid.
> 
> Perhaps it is a good idea to sweep all the hits from "git grep -e
> has_object_file \*.c" and audit the codebase to see if there are
> other problematic ones?

Interestingly, the case fixed here was mentioned after the three-dashes
in this patch:

  https://lore.kernel.org/git/20191127123211.GG22221@sigill.intra.peff.net/

That thread was about OBJECT_INFO_QUICK, but I think any "we are finding
the boundary" hunt should consider whether that's appropriate, too. In
that case they are really the same issue: we do not want to expend
effort A on the unlikely chance P that we will find the object and save
ourselves effort B. The magnitude of A and B, and the probability P may
be different for the two optimizations, though.

I think the instance fixed here _probably_ could be converted to QUICK
as well. It saves extra refreshes of the pack directory when a client
asks for an object we don't have. That's usually not too expensive, but
can be in some cases (many alternates, slow NFS filesystems, client has
many objects we don't). In the worst case, using QUICK would mean we can
get fooled by a simultaneous repack into thinking we don't have an
object we _do_ have, and end up negotiating a worse pack for the client.

> Thanks.  Will queue.

That said, yeah, I think Jonathan's patch is a strict improvement by
itself.

-Peff
