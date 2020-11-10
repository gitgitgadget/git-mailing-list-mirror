Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A8DC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A7DA2067D
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJUGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:06:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:53294 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKJUGF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 15:06:05 -0500
Received: (qmail 9041 invoked by uid 109); 10 Nov 2020 20:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 20:06:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4596 invoked by uid 111); 10 Nov 2020 20:06:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 15:06:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 15:06:04 -0500
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 12/21] trailer: handle configured nondefault separators
 explicitly
Message-ID: <20201110200604.GE1987088@coredump.intra.peff.net>
References: <20201025212652.3003036-1-anders@0x63.nu>
 <20201025212652.3003036-13-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025212652.3003036-13-anders@0x63.nu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 25, 2020 at 10:26:43PM +0100, Anders Waldenborg wrote:

>  static void print_item(FILE *outfile, const struct trailer_item *item)
>  {
>  	if (item->token) {
>  		const char *tok = item->token;
> +		const char *sep = (char []){separators[0], ' ', '\0'};

I don't think this syntax is likely to be sufficiently portable, as
you're defining a variable length array implicitly. I think:

  char orig_sep[] = { separators[0], ' ', '\0' };
  const char *sep = orig_sep;

would work. Though I suspect that just making this:

> -		c = last_non_space_char(tok);
> -		if (!c)
> -			return;
> -		if (strchr(separators, c))
> -			fputs(tok, outfile);
> -		else
> -			fprintf(outfile, "%s%c ", tok, separators[0]);
> +		fprintf(outfile, "%s%s", tok, sep);

into:

  fprintf(outfile, "%s", tok);
  if (conf && conf->nondefault_separator)
	fprintf(outfile, "%s", conf->nondefault_separator);
  else
	fprintf(outfile, "%c ", separators[0]);

might be simpler for a reader to follow, even though it's a little more
verbose.

-Peff
