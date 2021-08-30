Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9159C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D265360FD9
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 18:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbhH3SVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 14:21:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:34060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238553AbhH3SUX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 14:20:23 -0400
Received: (qmail 510 invoked by uid 109); 30 Aug 2021 18:19:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Aug 2021 18:19:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8896 invoked by uid 111); 30 Aug 2021 18:19:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Aug 2021 14:19:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Aug 2021 14:19:28 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge-recursive: use fspathcmp() in path_hashmap_cmp()
Message-ID: <YS0hMILaN2ODfM3y@coredump.intra.peff.net>
References: <512abaef-d71c-9308-6a62-f37b4de69e60@web.de>
 <YSvsQcGNpCMZwS8o@nand.local>
 <60e9baf4-4e76-71a8-e6bb-1af87486994d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <60e9baf4-4e76-71a8-e6bb-1af87486994d@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 30, 2021 at 05:09:34PM +0200, René Scharfe wrote:

> > diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> > index 36ff07bd4b..ab34bdfecd 100644
> > --- a/t/helper/test-hashmap.c
> > +++ b/t/helper/test-hashmap.c
> > @@ -28,10 +28,7 @@ static int test_entry_cmp(const void *cmp_data,
> >         e1 = container_of(eptr, const struct test_entry, ent);
> >         e2 = container_of(entry_or_key, const struct test_entry, ent);
> >
> > -       if (ignore_case)
> > -               return strcasecmp(e1->key, key ? key : e2->key);
> > -       else
> > -               return strcmp(e1->key, key ? key : e2->key);
> > +       return fspathcmp(e1->key, key ? key : e2->key);
> >  }
> >
> >  static struct test_entry *alloc_test_entry(unsigned int hash,
> >
> 
> That's a local variable named "ignore_case", not the one declared in
> environment.c that fspathcmp() uses, so this would change the behavior.
> The helper code does not include cache.h, so this is not even a case of
> variable shadowing, just two different variables for similar purposes
> in different places having the same name.

Yikes, good catch. Perhaps it's overkill, but I wonder if a comment
like:

  /*
   * Do not use fspathcmp() here; our behavior depends on the local
   * ignore_case variable, not the usual Git-wide global.
   */

would help.

I double-checked the spot I suggested. I think it is actually using the
global (though I got it right through sheer luck).

-Peff
