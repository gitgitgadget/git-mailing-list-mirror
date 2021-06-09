Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81827C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1B6124C
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhFIEBj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:01:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:49842 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhFIEBi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:01:38 -0400
Received: (qmail 876 invoked by uid 109); 9 Jun 2021 03:59:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Jun 2021 03:59:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17063 invoked by uid 111); 9 Jun 2021 03:59:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 23:59:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 23:59:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: use starts_with() when checking scissors
Message-ID: <YMA8sDr/uuJ9Tst6@coredump.intra.peff.net>
References: <20190401215334.18678-1-rybak.a.v@gmail.com>
 <20210608204841.2793591-1-rybak.a.v@gmail.com>
 <YL/n1b641m+wuVHG@coredump.intra.peff.net>
 <xmqq35trn5f1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35trn5f1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 09, 2021 at 11:22:10AM +0900, Junio C Hamano wrote:

> The posted patch _might_ make it easier to read, but I do not think
> it improves safety at all.  At the point of doing memcmp(), we know
> that *c is not NUL and because we are dealing with NUL-terminated
> string, we know we can check c[1] (otherwise we wouldn't even be
> able to see if c is pointing at the end of string), so we check c[0]
> and c[1] against four variants of two-byte scissors patterns.  The
> current code uses memcmp() of 2 bytes, which is perfectly safe under
> the condition, and starts_with() would also be equally safe.
> 
> If we were to teach new scissors sequence that is longer than two
> bytes, then starts_with() would start becoming safer, but that will
> not happen, so...

Right, I agree the current code is safe. The main value would be trying
to make the correctness of the code more apparent. Perhaps a comment
would be better there, like:

diff --git a/mailinfo.c b/mailinfo.c
index ccc6beb27e..25b606db28 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -705,12 +705,17 @@ static int is_scissors_line(const char *line)
 			perforation++;
 			continue;
 		}
+		/*
+		 * passing 2 bytes to memcmp is safe here; we have at least
+		 * one non-NUL character from the loop condition, plus a
+		 * terminating NUL
+		 */
 		if ((!memcmp(c, ">8", 2) || !memcmp(c, "8<", 2) ||
 		     !memcmp(c, ">%", 2) || !memcmp(c, "%<", 2))) {
 			in_perforation = 1;
 			perforation += 2;
 			scissors += 2;
-			c++;
+			c++; /* only 1 here to account for loop increment */
 			continue;
 		}
 		in_perforation = 0;

Though since this is code we'd not plan to modify, and presumably
anybody touching it would have to fully grok the loop anyway, it might
not be that important.

I dunno. I offer it as an alternative (and am happy to add a commit
message). But I'm fine with leaving it as-is, too.

-Peff
