Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770CBC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 400C36103E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhDGV1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:27:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232890AbhDGV1o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:27:44 -0400
Received: (qmail 18087 invoked by uid 109); 7 Apr 2021 21:27:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 21:27:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23292 invoked by uid 111); 7 Apr 2021 21:27:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 17:27:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 17:27:32 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] [GSOC] ref-filter: use single strbuf for all output
Message-ID: <YG4jxKQ3z1R+8Jfz@coredump.intra.peff.net>
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
 <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.927.v2.git.1617809209164.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 03:26:48PM +0000, ZheNing Hu via GitGitGadget wrote:

> diff --git a/ref-filter.c b/ref-filter.c
> index f0bd32f71416..27bbf9b6c8ac 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2435,6 +2435,26 @@ int format_ref_array_item(struct ref_array_item *info,
>  	return 0;
>  }
>  
> +void show_ref_array_items(struct ref_array_item **info,
> +			 const struct ref_format *format,
> +			 size_t n)
> +{
> +	struct strbuf final_buf = STRBUF_INIT;
> +	struct strbuf error_buf = STRBUF_INIT;
> +	size_t i;
> +
> +	for (i = 0; i < n; i++) {
> +		if (format_ref_array_item(info[i], format, &final_buf, &error_buf))
> +			die("%s", error_buf.buf);
> +		fwrite(final_buf.buf, 1, final_buf.len, stdout);
> +		strbuf_reset(&error_buf);
> +		strbuf_reset(&final_buf);
> +		putchar('\n');
> +	}
> +	strbuf_release(&error_buf);
> +	strbuf_release(&final_buf);
> +}

I think this is a reasonable direction to take the solution: wrapping
the loop so that the reuse of the buffers can be included there.

But I do wonder if we should go the opposite direction, and get rid of
show_ref_array_item() entirely. It only has two callers, both of which
could just write the loop themselves. That is more code, but perhaps it
would make it more clear what is going on in those callers, and to give
them more flexibility.

I notice there's a third user of the ref-filter.c code in
builtin/branch.c that does not use show_ref_array_item(). Instead, it
loops itself and calls format_ref_array_item(). I think this is because
it is sometimes columnizing the results. Perhaps git-tag and
for-each-ref would want to learn the same trick, in which case they'd be
happy to have the open-coded loop.

Either way, it probably makes sense to introduce the same optimization
to the case in builtin/branch.c.

-Peff
