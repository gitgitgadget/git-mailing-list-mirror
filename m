Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0461FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 17:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755142AbdC1Rmn (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 13:42:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:53026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753242AbdC1Rmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 13:42:42 -0400
Received: (qmail 4078 invoked by uid 109); 28 Mar 2017 17:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 17:42:16 +0000
Received: (qmail 10457 invoked by uid 111); 28 Mar 2017 17:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 13:42:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 13:42:14 -0400
Date:   Tue, 28 Mar 2017 13:42:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/21] object_id part 7
Message-ID: <20170328174214.t5szqndtf4bwsnhz@sigill.intra.peff.net>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170328073159.k3xemw6auh3iedgs@sigill.intra.peff.net>
 <20170328111315.i6rhhy4pj6hhf4bs@genre.crustytoothpaste.net>
 <20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328173536.ylwesrj7jbreztcy@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 01:35:36PM -0400, Jeff King wrote:

> I thought I'd knock this out quickly before I forgot about it. But it
> actually isn't so simple.
> 
> The main caller in read_head_info() does indeed just pass strlen(line)
> as the length in each case. But the cert parser really does need us to
> respect the line length. So we either have to pass it in, or tie off the
> string.
> 
> The latter looks something like the patch below (on top of a minor
> tweak around "eol" handling). It's sufficiently ugly that it may not
> count as an actual cleanup, though. I'm OK if we just drop the idea.

Here's that minor tweak, in case anybody is interested. It's less useful
without that follow-on that touches "eol" more, but perhaps it increases
readability on its own.

-- >8 --
Subject: [PATCH] receive-pack: simplify eol handling in cert parsing

The queue_commands_from_cert() function wants to handle each
line of the cert individually. It looks for "\n" in the
to-be-parsed bytes, and special-cases each use of eol (the
end-of-line variable) when we didn't find one.  Instead, we
can just set the end-of-line variable to end-of-cert in the
latter case.

For advancing to the next line, it's OK for us to move our
pointer past end-of-cert, because our loop condition just
checks for pointer inequality. And it doesn't even violate
the ANSI C "no more than one past the end of an array" rule,
because we know in the worst case we've hit the terminating
NUL of the strbuf.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 5d9e4da0a..58de2a1a9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1524,8 +1524,10 @@ static void queue_commands_from_cert(struct command **tail,
 
 	while (boc < eoc) {
 		const char *eol = memchr(boc, '\n', eoc - boc);
-		tail = queue_command(tail, boc, eol ? eol - boc : eoc - boc);
-		boc = eol ? eol + 1 : eoc;
+		if (!eol)
+			eol = eoc;
+		tail = queue_command(tail, boc, eol - boc);
+		boc = eol + 1;
 	}
 }
 
-- 
2.12.2.845.g55fcf8b10

