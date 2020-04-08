Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B31FC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40764206BE
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDHVyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:54:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726494AbgDHVyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 17:54:24 -0400
Received: (qmail 13846 invoked by uid 109); 8 Apr 2020 21:54:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 Apr 2020 21:54:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13221 invoked by uid 111); 8 Apr 2020 22:04:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Apr 2020 18:04:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Apr 2020 17:54:23 -0400
From:   Jeff King <peff@peff.net>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] oidmap: make oidmap_free independent of struct layout
Message-ID: <20200408215423.GA3468797@coredump.intra.peff.net>
References: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408040659.14511-1-abhishekkumar8222@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 08, 2020 at 09:36:58AM +0530, Abhishek Kumar wrote:

> c8e424c introduced hashmap_free_entries, which can free any struct
> pointer, regardless of the hashmap_entry field offset.
> 
> oidmap does not make use of this flexibilty, hardcoding the offset to
> zero instead. Let's fix this by passing struct type and member to
> hashmap_free_entries.

I'm not sure how much this improves anything.

We're now telling the hashmap code how to get to our "struct
oidmap_entry" pointer by using the correct offset there. But we know
that offset will always be 0, because we put our internal hashmap entry
at the start of oidmap_entry.

What you can't do is:

  struct foo {
    int first_member;
    struct oidmap_entry not_the_first_member;
  };

and work directly with "struct foo" pointers. You have to convert
oidmap_entry pointers into foo pointers with container_of() or similar.
And that is true both before and after your patch.

That said, I don't mind doing this as a cleanup; there's a subtle
dependency on the location of internal_entry within object_entry,
and this would move towards getting rid of it.

-Peff
