Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4558C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8124A60D42
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 02:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbhJLCaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:30:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:37332 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhJLCaB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 22:30:01 -0400
Received: (qmail 30300 invoked by uid 109); 12 Oct 2021 02:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 02:28:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31218 invoked by uid 111); 12 Oct 2021 02:27:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Oct 2021 22:27:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Oct 2021 22:27:59 -0400
From:   Jeff King <peff@peff.net>
To:     Robin Dupret <robin.dupret@gmail.com>
Cc:     git@vger.kernel.org, Robin Dupret <robin.dupret@hey.com>
Subject: Re: [PATCH] http-backend: remove a duplicated code branch
Message-ID: <YWTyr6joJlyi1TPe@coredump.intra.peff.net>
References: <20211011192546.1571-1-robin.dupret@hey.com>
 <20211011192546.1571-2-robin.dupret@hey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011192546.1571-2-robin.dupret@hey.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 09:25:46PM +0200, Robin Dupret wrote:

> Signed-off-by: Robin Dupret <robin.dupret@hey.com>

You signed-off, which is good (and necessary for contributing a patch).
This is a good place to say "why". Even if it is "because it makes the
code more readable", it is good to say that rather than leave readers
guessing (though of course people won't necessarily agree ;) ).

> ---
>  http-backend.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/http-backend.c b/http-backend.c
> index e7c0eeab23..3d6e2ff17f 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -466,9 +466,7 @@ static void run_service(const char **argv, int buffer_input)
>  	struct child_process cld = CHILD_PROCESS_INIT;
>  	ssize_t req_len = get_content_length();
>  
> -	if (encoding && !strcmp(encoding, "gzip"))
> -		gzipped_request = 1;
> -	else if (encoding && !strcmp(encoding, "x-gzip"))
> +	if (encoding && (!strcmp(encoding, "gzip") || !strcmp(encoding, "x-gzip")))
>  		gzipped_request = 1;

I think this conversion is correct, and I do find the resulting slightly
easier to read. I wondered if the two conditions might have come
separately, but no, they were both there in the initial 556cfa3b6d
(Smart fetch and push over HTTP: server side, 2009-10-30).

We do frown a bit on making small style changes like this. This kind of
churn isn't dramatically improving the quality of the code, and it
carries the risk of regression (if there is something subtle that you or
the reviewers missed) and creates a maintenance burden (it may conflict
with other patches, though I doubt it in this case, and it creates work
for reviewers and the maintainer to apply).

So...I dunno. I don't mind it, but it is not a pattern we like to
encourage in general. Let's see what Junio thinks.

-Peff
