Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E4C433C1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9861A07
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbhCXSnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:43:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:47744 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237632AbhCXSnn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:43:43 -0400
Received: (qmail 14205 invoked by uid 109); 24 Mar 2021 18:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Mar 2021 18:43:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20669 invoked by uid 111); 24 Mar 2021 18:43:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Mar 2021 14:43:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Mar 2021 14:43:42 -0400
From:   Jeff King <peff@peff.net>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH] pack-objects: fix comment of reused_chunk.difference
Message-ID: <YFuIXvQSUzbJgDLp@coredump.intra.peff.net>
References: <20210323032050.97700-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323032050.97700-1-chiyutianyi@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 11:20:50AM +0800, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> As record_reused_object(offset, offset - hashfile_total(out)) said,
> reused_chunk.difference should be the offset of original packfile minus
> the offset of the generated packfile. But the comment presented an opposite way.
> [...]
>
> @@ -810,8 +810,8 @@ static struct reused_chunk {
>  	/* The offset of the first object of this chunk in the original
>  	 * packfile. */
>  	off_t original;
> -	/* The offset of the first object of this chunk in the generated
> -	 * packfile minus "original". */
> +	/* The difference for "original" minus the offset of the first object of
> +	 * this chunk in the generated packfile. */
>  	off_t difference;

The naming and comments here came from Christian's upstreaming of the
topic (cc'd). In the original, this was just called "offset". And there
was no comment, so it couldn't be wrong. ;)

I think your suggestion here is correct. The value comes from the
"offset" parameter of record_reused_object(), and we pass:

  record_reused_object(offset, offset - hashfile_total(out));

(where "offset" here is the pack position in the original packfile). So
it is definitely "original_offset - output_offset".

All of which is a long-winded way of saying "looks good to me". :)

-Peff
