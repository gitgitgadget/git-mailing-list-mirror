Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9821DC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A30060F70
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhKBPpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:45:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:51562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231526AbhKBPpr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:45:47 -0400
Received: (qmail 2980 invoked by uid 109); 2 Nov 2021 15:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 02 Nov 2021 15:43:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7204 invoked by uid 111); 2 Nov 2021 15:43:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 02 Nov 2021 11:43:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 2 Nov 2021 11:43:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dongsheng Song <dongsheng.song@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf_addftime(): handle "%s" manually
Message-ID: <YYFcj0Y9ApBU9j+V@coredump.intra.peff.net>
References: <CAE8XmWpK0ubcTXOaxBKGKh1qU+73Rr181wMAM7KAAX_A5PEYOw@mail.gmail.com>
 <YX5Zo9uV7qG73p6R@coredump.intra.peff.net>
 <CAE8XmWqexT89v0R+iVcjOHF+WsF1caMu+toY_gyNmJ6BU_L=ZQ@mail.gmail.com>
 <xmqqcznldobz.fsf@gitster.g>
 <YX9nLJZXB3rOrMru@coredump.intra.peff.net>
 <xmqq1r3zd9k5.fsf@gitster.g>
 <YYEihoLbEGi44dDb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYEihoLbEGi44dDb@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 07:35:35AM -0400, Jeff King wrote:

> @@ -1019,6 +1024,13 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
>  			strbuf_addstr(&munged_fmt, "%%");
>  			fmt++;
>  			break;
> +		case 's':
> +			strbuf_addf(&munged_fmt, "%"PRItime,
> +				    tm_to_time_t(tm) -
> +				    3600 * (tz_offset / 100) -
> +				    60 * (tz_offset % 100));
> +			fmt++;
> +			break;

Looks like we may need something like this squashed in:

diff --git a/strbuf.c b/strbuf.c
index 33015b33df..995394f38e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1026,7 +1026,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 			break;
 		case 's':
 			strbuf_addf(&munged_fmt, "%"PRItime,
-				    tm_to_time_t(tm) -
+				    (timestamp_t)tm_to_time_t(tm) -
 				    3600 * (tz_offset / 100) -
 				    60 * (tz_offset % 100));
 			fmt++;

because tm_to_time_t() returns an actual time_t, which will vary in
size. The 32-bit CI job complains:

  strbuf.c:1028:29: error: format '%lld' expects argument of type 'long long int', but argument 3 has type 'long int' [-Werror=format=]

-Peff
