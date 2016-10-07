Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D06207EC
	for <e@80x24.org>; Fri,  7 Oct 2016 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936176AbcJGAxU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 20:53:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:53758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935974AbcJGAxT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 20:53:19 -0400
Received: (qmail 16562 invoked by uid 109); 7 Oct 2016 00:46:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Oct 2016 00:46:37 +0000
Received: (qmail 1632 invoked by uid 111); 7 Oct 2016 00:46:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Oct 2016 20:46:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2016 20:46:35 -0400
Date:   Thu, 6 Oct 2016 20:46:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] use strbuf_add_unique_abbrev() for adding short
 hashes, part 2
Message-ID: <20161007004635.xbuaxvc6eyfkyyma@sigill.intra.peff.net>
References: <b7a61c78-3c46-375c-4cc3-7c363e551bc6@web.de>
 <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29e75b7b-6dd0-8c52-e444-cad1ba613cd0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 09:11:58PM +0200, René Scharfe wrote:

> Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
> instead of taking detours through find_unique_abbrev() and its static
> buffer.  This is shorter and a bit more efficient.
> [...]
> diff --git a/diff.c b/diff.c
> index a178ed3..be11e4e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3109,7 +3109,7 @@ static void fill_metainfo(struct strbuf *msg,
>  		}
>  		strbuf_addf(msg, "%s%sindex %s..", line_prefix, set,
>  			    find_unique_abbrev(one->oid.hash, abbrev));
> -		strbuf_addstr(msg, find_unique_abbrev(two->oid.hash, abbrev));
> +		strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);
>  		if (one->mode == two->mode)
>  			strbuf_addf(msg, " %06o", one->mode);
>  		strbuf_addf(msg, "%s\n", reset);

This one is an interesting case, and maybe a good example of why blind
coccinelle usage can have some pitfalls. :)

We get rid of the strbuf_addstr(), but notice that we leave untouched
the find_unique_abbrev() call immediately above. There was a symmetry to
the two that has been lost.

Probably either:

  strbuf_addf(msg, "%s%sindex %s..%s", line_prefix, set
	find_unique_abbrev(one->oid.hash, abbrev),
	find_unique_abbrev(two->oid.hash, abbrev));

or:

  strbuf_addf(msg, "%s%sindex ", line_prefix, set);
  strbuf_add_unique_abbrev(msg, one->oid.hash, abbrev);
  strbuf_addstr(msg, "..");
  strbuf_add_unique_abbrev(msg, two->oid.hash, abbrev);

would be a more appropriate refactoring. The problem is in the original
patch (which also lacks symmetry; either this predates the multi-buffer
find_unique_abbrev, or the original author didn't know about it), but I
think your refactor makes it slightly worse.

I noticed because I have another series which touches these lines, and
it wants to symmetrically swap out find_unique_abbrev for something
else. :) I don't think it's a big enough deal to switch now (and I've
already rebased my series which will touch these lines), but I wanted to
mention it as a thing to watch out for as we do more of these kinds of
automated transformations.

> --- a/submodule.c
> +++ b/submodule.c
> @@ -396,7 +396,7 @@ static void show_submodule_header(FILE *f, const char *path,
>  			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
>  	if (!fast_backward && !fast_forward)
>  		strbuf_addch(&sb, '.');
> -	strbuf_addstr(&sb, find_unique_abbrev(two->hash, DEFAULT_ABBREV));
> +	strbuf_add_unique_abbrev(&sb->hash, two, DEFAULT_ABBREV);

This one is a similar situation, I think.

-Peff
