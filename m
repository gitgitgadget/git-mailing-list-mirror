Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B2C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 20:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDF76108D
	for <git@archiver.kernel.org>; Sun, 30 May 2021 20:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhE3U4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 16:56:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:41458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhE3U4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 16:56:22 -0400
Received: (qmail 18764 invoked by uid 109); 30 May 2021 20:54:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 20:54:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21782 invoked by uid 111); 30 May 2021 20:54:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 16:54:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 16:54:42 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [QUESTION] how to quickly find an oid in the git repository
Message-ID: <YLP7kuFNfVZK+xCK@coredump.intra.peff.net>
References: <CAOLTT8SS8Wypho7eCCGH7LtOLwM6tWCzp8mGGEVASBC80MwJ5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8SS8Wypho7eCCGH7LtOLwM6tWCzp8mGGEVASBC80MwJ5A@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 30, 2021 at 02:53:24PM +0800, ZheNing Hu wrote:

> When I tried to make cat-file --batch use ref-filter logic,
> I encountered this problem:
> 
> get_oid_with_context() does not really let me know
> if an oid is in the git repository. E.g.
> 
> get_oid_with_context(the_repository,
> "0000000000000000000000000000000000000000",...)
> 
> will return FOUND. (I really want it to tell me MISSING_OBJECT
> or something else)

Right, it's purely a name->oid lookup.

> On the other hand, oid_object_info_extended() will parse an object
> in depth, using it will seriously affect performance. So I want to know
> if there is a function that can quickly find the oid? I searched in
> `object-name.c`, `object-file.c`, and there seems to be no clue...

You should be able to use oid_object_info_extended() here. It will try
to do as little work as possible to fulfill the items requested in the
object_info struct. So a blank one (or even passing NULL) will return an
error if the object doesn't exist, but not otherwise.

There's also has_object_file(), which is essentially a wrapper for this.

-Peff
