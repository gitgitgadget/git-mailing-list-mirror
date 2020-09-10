Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559DDC43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B920731
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIJVmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:53230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgIJMVb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 08:21:31 -0400
Received: (qmail 19976 invoked by uid 109); 10 Sep 2020 12:21:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 12:21:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18392 invoked by uid 111); 10 Sep 2020 12:21:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 08:21:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 08:21:11 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/6] quote_path: give flags parameter to quote_path()
Message-ID: <20200910122111.GA57925@coredump.intra.peff.net>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
 <20200908205224.4126551-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908205224.4126551-3-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 08, 2020 at 01:52:20PM -0700, Junio C Hamano wrote:

> -char *quote_path(const char *in, const char *prefix, struct strbuf *out)
> +char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned flags)
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  	const char *rel = relative_path(in, prefix, &sb);
>  	strbuf_reset(out);
> -	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
> +	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
>  	strbuf_release(&sb);

Here we take "flags", but then we pass it along in place of
quote_c_style_counted()'s "no_dq" parameter. That seems unlikely to be
the right thing (and indeed, it's reverted in the next commit).

> --- a/quote.h
> +++ b/quote.h
> @@ -72,7 +72,7 @@ void write_name_quoted_relative(const char *name, const char *prefix,
>  				FILE *fp, int terminator);
>  
>  /* quote path as relative to the given prefix */
> -char *quote_path(const char *in, const char *prefix, struct strbuf *out);
> +char *quote_path(const char *in, const char *prefix, struct strbuf *out, unsigned);

The meaning of the last parameter is left a bit vague. :) Maybe worth
calling it "unsigned flags" (I don't mind omitting parameter names when
they are obvious, but I don't think this counts).

-Peff
