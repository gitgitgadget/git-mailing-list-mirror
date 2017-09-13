Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452DB20286
	for <e@80x24.org>; Wed, 13 Sep 2017 18:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdIMSCg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 14:02:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:37340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751106AbdIMSCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 14:02:35 -0400
Received: (qmail 26026 invoked by uid 109); 13 Sep 2017 18:02:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 18:02:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18129 invoked by uid 111); 13 Sep 2017 18:03:10 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:03:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 14:02:33 -0400
Date:   Wed, 13 Sep 2017 14:02:33 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/7] get-tar-commit-id: check write_in_full() return
 against 0
Message-ID: <20170913180232.luxcnx7fbcpbt7bw@sigill.intra.peff.net>
References: <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913171127.ocnitq6wz57ivhrh@sigill.intra.peff.net>
 <20170913175357.GC27425@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170913175357.GC27425@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 10:53:57AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > We ask to write 41 bytes and make sure that the return value
> > is at least 41. This is the same "dangerous" pattern that
> > was fixed in the prior commit (wherein a negative return
> > value is promoted to unsigned), though it is not dangerous
> > here because our "41" is a constant, not an unsigned
> > variable.
> >
> > But we should convert it anyway to avoid modeling a
> > dangerous construct.
> 
> If the above logic is correct, then I suspect this series does not go
> far enough.  write_in_full() would be one of those APIs that is easy
> to misuse and difficult to use correctly, and if so we should fix that
> at the source instead of trying to teach callers not to hold it wrong.

Yes, this series is just removing bad examples. It doesn't do anything
to make write_in_full() less potentially dangerous.

On the other hand, it's no more or less dangerous than write(), which
has the same return-value semantics.

> E.g. what would you think of
> 
>  1. Introduce a write_fully (sorry, I am bad at names) function
>     that returns 0 on success and a coccinelle semantic patch in
>     contrib/coccinelle to migrate callers in "make coccicheck":

Yes, I considered that, though some callers really do care about
assigning the number of bytes written. The fact that write() has the
same problem, plus the fact that there were only 2 buggy instances
across the code base made me think there's not a huge gain to that extra
step.

> @@
> expression E;
> expression F;
> expression G;
> @@
> -write_in_full(E, F, G) < G
> +write_fully(E, F, G)
> 
>  2. Run "make coccicheck" and apply the result.
>  3. Remove the write_in_full function.

There's a step between those where you have to update all of the
write_in_full() callers that store the result. Some of them would be
trivial conversions, but some of them actually care about the length
E.g., the one in imap-send.c, which is the only one I didn't convert
away from "!= len" because it's half of an #ifdef with SSL_write()
(which uses an "int" as the return value!).

> Does read_in_full need a similar treatment?

It might actually return fewer than the requested number of bytes, so it
can't just use "< 0" in the same way (nor be adapted to return 0 on
success).  But I think it's still a bug to do:

  char buf[20];
  size_t len = sizeof(buf);
  if (read_in_full(fd, buf, len) < len)
          die(...);

since that will promote the -1 to a size_t. So it's probably worth
auditing.

-Peff
