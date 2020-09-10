Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672E2C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A00A208E4
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgIJVmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:53242 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730791AbgIJMi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 08:38:57 -0400
Received: (qmail 20104 invoked by uid 109); 10 Sep 2020 12:38:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 12:38:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18449 invoked by uid 111); 10 Sep 2020 12:38:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 08:38:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 08:38:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] quote: turn 'nodq' parameter into a set of flags
Message-ID: <20200910123843.GC57925@coredump.intra.peff.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
 <20200908205224.4126551-7-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908205224.4126551-7-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 01:52:24PM -0700, Junio C Hamano wrote:

> quote_c_style() and its friend quote_two_c_style() both take an
> optional "please omit the double quotes around the quoted body"
> parameter.  Turn it into a flag word, assign one bit out of it,
> and call it CQUOTE_NODQ bit.

Sounds reasonable.

If this shared the same "flags" namespace as quote_path(), then we
really could pass quote_path() flags along. And in fact, that could be
the first step to just teaching quote_c_style() the "if it has spaces,
then quote it" rule. Maybe not worth spending more time on, but just
thinking out loud after my earlier comments.

> @@ -272,6 +272,7 @@ static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
>  		count += (l);                           \
>  	} while (0)
>  
> +	int no_dq = !!(flags & CQUOTE_NODQ);
>  	size_t len, count = 0;
>  	const char *p = name;

Looking at the context, I wondered how this was not adding a
decl-after-statement (and how we were not already complaining about the
existing ones). But the reason is that the code above it is part of a
macro.

-Peff
