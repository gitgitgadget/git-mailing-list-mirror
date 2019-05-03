Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7AC1F453
	for <e@80x24.org>; Fri,  3 May 2019 20:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfECUuz (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 16:50:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:48178 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726022AbfECUuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 16:50:55 -0400
Received: (qmail 6559 invoked by uid 109); 3 May 2019 20:50:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 May 2019 20:50:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14370 invoked by uid 111); 3 May 2019 20:51:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 May 2019 16:51:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2019 16:50:52 -0400
Date:   Fri, 3 May 2019 16:50:52 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: not ok 41 - test ident field is working
Message-ID: <20190503205052.GA17551@sigill.intra.peff.net>
References: <CAH8yC8kqHDDqsu++3an69Oq--hhabV8LGawD3uccykFYQDFvsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kqHDDqsu++3an69Oq--hhabV8LGawD3uccykFYQDFvsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 04:18:02PM -0400, Jeffrey Walton wrote:

> I'm catching one failed self test under a sanitizer build. It looks
> like there's some latent UB present during 'make check'

How are you providing sanitizer options? If you're just putting
-fsanitize=undefined in the compiler flags, that is known to fail. For
example, on some platforms we'll default to unaligned loads when it's
faster and well-defined on that platform.

And that's what you're seeing here:

> read-cache.c:1943:22: runtime error: load of misaligned address 0x7fba278d61ab f
> or type 'unsigned int', which requires 4 byte alignment

since this is a get_be32() call.

You can can add -DNO_UNALIGNED_LOADS to fix this. However, we have some
Makefile logic for doing this already, and:

  make SANITIZE=undefined test

should work. My normal test for memory problems is:

  make SANITIZE=address,undefined test

-Peff
