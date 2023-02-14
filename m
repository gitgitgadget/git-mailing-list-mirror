Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CFFC636D4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 01:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjBNBjF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 20:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjBNBjE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 20:39:04 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A183A9B
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 17:39:03 -0800 (PST)
Received: (qmail 24085 invoked by uid 109); 14 Feb 2023 01:39:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 01:39:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27679 invoked by uid 111); 14 Feb 2023 01:39:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Feb 2023 20:39:02 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Feb 2023 20:39:02 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
Message-ID: <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
 <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 05:58:06PM -0500, Eric Sunshine wrote:

> I am able to reproduce the broken behavior on maOS 10.13.

That's helpful.

> > Are your on-disk bytes different?
> 
> I get the exact same results (on HFS+) as you show:

Hmm, so we can probably rule out HFS weirdness (and anyway, I guess we'd
be getting the name from the HEAD file, which would be stored verbatim).

If you do something like the patch below:

diff --git a/refs.c b/refs.c
index e31dbcda59..2fa53fef7f 100644
--- a/refs.c
+++ b/refs.c
@@ -1350,7 +1350,8 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 		return xstrdup(refname);
 
 	/* buffer for scanf result, at most refname must fit */
-	short_name = xstrdup(refname);
+	warning("strlen(refname) = %d", (int)strlen(refname));
+	short_name = xcalloc(1, 2*strlen(refname));
 
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
@@ -1362,6 +1363,7 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 			continue;
 
 		short_name_len = strlen(short_name);
+		warning("strlen(short_name) = %d", (int)short_name_len);
 
 		/*
 		 * in strict mode, all (except the matched one) rules

Does it help at all? And if so, is short_name_len longer than we might
expect it to be (I get 39 for the full refname and 28 for the scanf'd
name).  I'm having trouble coming up with a reason that the scanf value
_would_ be unexpectedly long, but just trying to rule things out.

-Peff
