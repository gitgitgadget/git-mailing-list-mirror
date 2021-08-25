Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F7C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93680611AF
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhHYA6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:58:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:58380 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234058AbhHYA6d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:58:33 -0400
Received: (qmail 21187 invoked by uid 109); 25 Aug 2021 00:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Aug 2021 00:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4055 invoked by uid 111); 25 Aug 2021 00:57:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Aug 2021 20:57:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 24 Aug 2021 20:57:47 -0400
From:   Jeff King <peff@peff.net>
To:     Krzysztof =?utf-8?Q?=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc:     git@vger.kernel.org
Subject: Re: git log --encoding=HTML is not supported
Message-ID: <YSWVi8uLHZCTtG0l@coredump.intra.peff.net>
References: <9896630.2IqcCWsCYL@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9896630.2IqcCWsCYL@localhost.localdomain>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 11:00:03AM +0200, Krzysztof Żelechowski wrote:

> Co robiłeś/-aś zanim pojawił się błąd? (Kroki, aby odtworzyć problem)
> { git log --oneline --encoding=HTML stl_function.h; }
> 
> Co powinno się stać? (Oczekiwane zachowanie)
> 828176ba490 libstdc++: Improve doxygen comments in &lt;bits/stl_function.h>
> 
> Co stało się zamiast tego? (Rzeczywiste zachowanie)
> 828176ba490 libstdc++: Improve doxygen comments in <bits/stl_function.h>

I can't read the non-English parts of the email, but I gather you were
expecting "--encoding=HTML" to escape syntactically significant HTML
characters. It's not that kind of "encoding", but more "which character
set are you using" (utf8 vs iso8859-1, etc).

We feed the encoding "HTML" to iconv_open(), which of course has no idea
what that is. It's unfortunate, though, that we don't even print a
warning, and instead just quietly leave the text intact. I wonder if we
should do something like:

diff --git a/pretty.c b/pretty.c
index 535eb97fa6..708b618cfe 100644
--- a/pretty.c
+++ b/pretty.c
@@ -672,7 +672,11 @@ const char *repo_logmsg_reencode(struct repository *r,
 	 * If the re-encoding failed, out might be NULL here; in that
 	 * case we just return the commit message verbatim.
 	 */
-	return out ? out : msg;
+	if (!out) {
+		warning("unable to reencode commit to '%s'", output_encoding);
+		return msg;
+	}
+	return out;
 }
 
 static int mailmap_name(const char **email, size_t *email_len,

As far as what you're trying to accomplish, HTML-escaping isn't
something Git supports. You'll have to run the output through an
external escaping mechanism.

-Peff
