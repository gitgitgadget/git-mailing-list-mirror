Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B370D1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 03:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJUDVp (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 23:21:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:53602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726770AbfJUDVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 23:21:45 -0400
Received: (qmail 28257 invoked by uid 109); 21 Oct 2019 03:21:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 Oct 2019 03:21:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5092 invoked by uid 111); 21 Oct 2019 03:24:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 20 Oct 2019 23:24:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 20 Oct 2019 23:21:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-progress: fix test failures on big-endian systems
Message-ID: <20191021032144.GB13083@sigill.intra.peff.net>
References: <b0bec82e-ad0a-32f6-e2e6-e1f0e6920639@physik.fu-berlin.de>
 <20190731071755.GF4545@pobox.com>
 <f1ce445e-6954-8e7b-2dca-3a566ce689a5@physik.fu-berlin.de>
 <20191019233706.GM29845@szeder.dev>
 <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36fmor7o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 21, 2019 at 09:52:11AM +0900, Junio C Hamano wrote:

> I can sympathize, but I do not think it is worth inventing OPT_U64()
> or adding "int total_i" whose value is assigned to "u64 total" after
> parsing a command line arg with OPT_INTEGER() into the former.
> 
> Catching a pointer whose type is not "int*" passed at the third
> position of OPT_INTGER() mechanically may be worth it, though.
> Would Coccinelle be a suitable tool for that kind of thing?

I wondered if we could be a bit more clever with the definition of
"struct option". Something like:

diff --git a/parse-options.h b/parse-options.h
index 38a33a087e..99c7ff466d 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -126,7 +126,10 @@ struct option {
 	enum parse_opt_type type;
 	int short_name;
 	const char *long_name;
-	void *value;
+	union {
+		int *intp;
+		const char *strp;
+	} value;
 	const char *argh;
 	const char *help;
 

which would let the compiler complain about the type mismatch (of course
it can't help you if you assign to "intp" while trying to parse a
string).

Initializing the union from a compound literal becomes more painful,
but:

  1. That's mostly hidden behind OPT_INTEGER(), etc.

  2. I think we're OK with named initializers these days. I.e., I think:

        { OPTION_INTEGER, 'f', "--foo", { .intp = &foo } }

     would work OK.

I didn't even try compiling to see how painful the fallout might be,
though.

-Peff
