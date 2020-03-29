Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667FBC43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C18206F6
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgC2PC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:02:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:54946 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728142AbgC2PC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 11:02:28 -0400
Received: (qmail 2287 invoked by uid 109); 29 Mar 2020 15:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 29 Mar 2020 15:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9338 invoked by uid 111); 29 Mar 2020 15:12:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 29 Mar 2020 11:12:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 29 Mar 2020 11:02:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] test-lib-functions: simplify packetize() stdin code
Message-ID: <20200329150226.GA16068@coredump.intra.peff.net>
References: <20200327080210.GA604725@coredump.intra.peff.net>
 <20200327080300.GA605934@coredump.intra.peff.net>
 <xmqq1rpdhaid.fsf@gitster.c.googlers.com>
 <20200328112010.GC639140@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328112010.GC639140@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 07:20:10AM -0400, Jeff King wrote:

> > 	perl -e '
> > 		my $data = do { local $?; <STDIN> };
> >                 printf "%04x%s", length($data), $data;
> > 	'
> > 
> > That's one process but much heavier than cat/wc/printf/cat, I guess.
> 
> Yeah, I was tempted to do that, but ${#packet} is even one process
> shorter. :) It might be worth simplifying the stdin path above, but it's
> much less important if most of those call-sites go away.

Here it is as a patch on top. I doubt it matters that much (there are
only two stdin calls in the whole suite). So I'm not sure if this patch
should be "eh, why not?" or "meh, pointless churn".

-- >8 --
Subject: [PATCH] test-lib-functions: simplify packetize() stdin code

The code path in packetize() for reading stdin needs to handle NUL
bytes, so we can't rely on shell variables. However, the current code
takes a whopping 4 processes and uses a temporary file. We can do this
much more simply and efficiently by using a single perl invocation (and
we already rely on perl in the matching depacketize() function).

We'll keep the non-stdin code path as it is, since that uses zero extra
processes.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib-functions.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 216918a58c..88b7dbd69a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1373,11 +1373,10 @@ packetize() {
 		packet="$*"
 		printf '%04x%s' "$((4 + ${#packet}))" "$packet"
 	else
-		cat >packetize.tmp &&
-		len=$(wc -c <packetize.tmp) &&
-		printf '%04x' "$(($len + 4))" &&
-		cat packetize.tmp &&
-		rm -f packetize.tmp
+		perl -e '
+			my $packet = do { local $/; <STDIN> };
+			printf "%04x%s", 4 + length($packet), $packet;
+		'
 	fi
 }
 
-- 
2.26.0.581.g322f77c0ee

