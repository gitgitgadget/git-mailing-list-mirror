Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C5F11F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeHKXYW (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:24:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:51320 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727333AbeHKXYW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 19:24:22 -0400
Received: (qmail 1063 invoked by uid 109); 11 Aug 2018 16:48:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 16:48:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28585 invoked by uid 111); 11 Aug 2018 16:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 12:49:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 12:48:57 -0400
Date:   Sat, 11 Aug 2018 12:48:57 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fsck: use strbuf_getline() to read skiplist file
Message-ID: <20180811164856.GB27393@sigill.intra.peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 05:39:27PM +0200, René Scharfe wrote:

> The char array named "buffer" is unlikely to contain a NUL character, so
> printing its contents using %s in a die() format is unsafe.  Clang's
> ASan reports running over the end of buffer in the recently added
> skiplist tests in t5504-fetch-receive-strict.sh as a result.
> 
> Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
> is always NUL-terminated.  As a side-effect this also adds support for
> skiplist files with CRLF line endings.

Nice. Two other side effects, both of which I think are good:

 - this is likely faster for a large skiplist due to fewer syscalls

 - this will no longer complain about a sha1 with a missing newline at
   the end-of-file (it will quietly handle it as if the newline were
   there)

And one I'm not sure about:

 - a read() error will now be quietly ignored; I guess we'd have to
   check ferror(fp) to cover this. I'm not sure if it matters.

>  fsck.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Code itself looks good to me (assuming we don't care about the read()
error thing).

-Peff
