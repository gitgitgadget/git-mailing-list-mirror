Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5798C71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 02:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5FC20809
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 02:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgLAC2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 21:28:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:46636 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgLAC2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 21:28:16 -0500
Received: (qmail 22208 invoked by uid 109); 1 Dec 2020 02:27:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 02:27:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22155 invoked by uid 111); 1 Dec 2020 02:27:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Nov 2020 21:27:35 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Nov 2020 21:27:35 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
Message-ID: <X8WqFynk23yWT6E3@coredump.intra.peff.net>
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
 <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 07:30:06PM -0500, Taylor Blau wrote:

> @@ -147,7 +148,7 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
>  	strbuf_complete(&report_path, '/');
> 
>  	strbuf_addstr(&report_path, "git-bugreport-");
> -	strbuf_addftime(&report_path, option_suffix, localtime(&now), 0, 0);
> +	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
>  	strbuf_addstr(&report_path, ".txt");

I briefly wondered if we'd want a strbuf_addftime() variant that just
takes a time_t. But the choice of localtime vs gmtime makes this
awkward, not to mention the gymnastics we do in show_date() to get
things into the author's zone. So this looks good to me.

We might also want to do this on top:

-- >8 --
Subject: [PATCH] banned.h: mark non-reentrant gmtime, etc as banned

The traditional gmtime(), localtime(), ctime(), and asctime() functions
return pointers to shared storage. This means they're not thread-safe,
and they also run the risk of somebody holding onto the result across
multiple calls (where each call invalidates the previous result).

All callers should be using gmtime_r() or localtime_r() instead.

The ctime_r() and asctime_r() functions are OK in that respect, but have
no check that the buffer we pass in is long enough (the manpage says it
"should have room for at least 26 bytes"). Since this is such an
easy-to-get-wrong interface, and since we have the much safer stftime()
as well as its more conveinent strbuf_addftime() wrapper, let's likewise
ban both of those.

Signed-off-by: Jeff King <peff@peff.net>
---
TBH, ctime() and its variants are so awful that I doubt anybody would
try to use them, but it doesn't hurt to err on the side of caution.

 banned.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/banned.h b/banned.h
index 60a18d4403..7ab4f2e492 100644
--- a/banned.h
+++ b/banned.h
@@ -29,4 +29,17 @@
 #define vsprintf(buf,fmt,arg) BANNED(vsprintf)
 #endif
 
+#undef gmtime
+#define gmtime(t) BANNED(gmtime)
+#undef localtime
+#define localtime(t) BANNED(localtime)
+#undef ctime
+#define ctime(t) BANNED(ctime)
+#undef ctime_r
+#define ctime_r(t, buf) BANNED(ctime_r)
+#undef asctime
+#define asctime(t) BANNED(asctime)
+#undef asctime_r
+#define asctime_r(t, buf) BANNED(asctime_r)
+
 #endif /* BANNED_H */
-- 
2.29.2.853.g04e16501f9

