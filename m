Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8848C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 22:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBNWkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 17:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBNWkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 17:40:20 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51314305C9
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 14:40:19 -0800 (PST)
Received: (qmail 3486 invoked by uid 109); 14 Feb 2023 22:40:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 22:40:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6939 invoked by uid 111); 14 Feb 2023 22:40:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 17:40:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 17:40:17 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
Message-ID: <Y+wN0agVK9ZQU/sT@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
 <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
 <xmqqmt5f535i.fsf@gitster.g>
 <Y+wLoFKXhlugxrh1@coredump.intra.peff.net>
 <xmqqwn4j3mhy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn4j3mhy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 02:34:01PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > but I have a feeling that it gets more readable if we flip the break
> > conditional and the loop condition.
> 
> Yeah, the somewhoat unusual loop structure was what motivated me to
> look at its corner case.  Flipping the logic around may make it more
> straight forward.

It does indeed. I pulled the logic from skip_prefix(), thinking that by
relying on it I would avoid making a stupid mistake. Oh well. :)

Doing it like this is much more readable:

diff --git a/refs.c b/refs.c
index d8ce7e9ee1..725adafcd8 100644
--- a/refs.c
+++ b/refs.c
@@ -1323,12 +1323,12 @@ static const char *match_parse_rule(const char *refname, const char *rule,
 	 * in the rule. This is basically skip_prefix(), but
 	 * ending at percent in the prefix, rather than end-of-string.
 	 */
-	do {
+	while (*rule != '%') {
 		if (!*rule)
 			BUG("rev-parse rule did not have percent");
-		if (*rule == '%')
-			break;
-	} while (*refname++ == *rule++);
+		if (*refname++ != *rule++)
+			return 0;
+	}
 
 	/*
 	 * Check that we matched all the way to the "%" placeholder,

I'll hold on to that (plus an adjustment to the comment below to match,
and perhaps a test for this negative-match case) for a day or so to give
anybody else a chance to comment, and then send out a v2 tomorrow.

-Peff
