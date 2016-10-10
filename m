Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A521207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 00:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbcJJAAi (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 20:00:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:54767 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750869AbcJJAAi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 20:00:38 -0400
Received: (qmail 5940 invoked by uid 109); 10 Oct 2016 00:00:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 00:00:38 +0000
Received: (qmail 25511 invoked by uid 111); 10 Oct 2016 00:00:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 09 Oct 2016 20:00:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Oct 2016 20:00:35 -0400
Date:   Sun, 9 Oct 2016 20:00:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use strbuf_add_unique_abbrev() for adding short hashes,
 part 3
Message-ID: <20161010000035.mfcf55wqfcbcnarh@sigill.intra.peff.net>
References: <c830e99d-4fc9-b001-cce3-38f66dc2c678@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c830e99d-4fc9-b001-cce3-38f66dc2c678@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 08, 2016 at 05:38:47PM +0200, René Scharfe wrote:

> Call strbuf_add_unique_abbrev() to add abbreviated hashes to strbufs
> instead of taking detours through find_unique_abbrev() and its static
> buffer.  This is shorter in most cases and a bit more efficient.
> 
> The changes here are not easily handled by a semantic patch because
> they involve removing temporary variables and deconstructing format
> strings for strbuf_addf().

Yeah, the thing to look for here is whether the sha1 variable holds the
same value at both times.

These all look OK to me. Mild rambling below.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 5200d5c..9041c2f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -202,9 +202,9 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
>  		strbuf_addf(&o->obuf, "virtual %s\n",
>  			merge_remote_util(commit)->name);
>  	else {
> -		strbuf_addf(&o->obuf, "%s ",
> -			find_unique_abbrev(commit->object.oid.hash,
> -				DEFAULT_ABBREV));
> +		strbuf_add_unique_abbrev(&o->obuf, commit->object.oid.hash,
> +					 DEFAULT_ABBREV);
> +		strbuf_addch(&o->obuf, ' ');

I've often wondered whether a big strbuf_addf() is more efficient than
several strbuf_addstrs. It amortizes the size-checks, certainly, though
those are probably not very big. It shouldn't matter much for amortizing
the cost of malloc, as it's very unlikely to have a case where:

  strbuf_addf("%s%s", foo, bar);

would require one malloc, but:

  strbuf_addstr(foo);
  strbuf_addstr(bar);

would require two (one of the strings would have to be around the same
size as the ALLOC_GROW() doubling).

So it probably doesn't matter much in practice (not that most of these
cases are very performance sensitive anyway). Mostly just something I've
pondered while tweaking strbuf invocations.

And anyway, in this case replacing find_unique_abbrev lets us write
directly into the final buffer rather than copying through a static
buffer, so it's almost certainly a win there.

> diff --git a/pretty.c b/pretty.c
> index 25efbca..0c31495 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -544,15 +544,13 @@ static void add_merge_info(const struct pretty_print_context *pp,
>  	strbuf_addstr(sb, "Merge:");
>  
>  	while (parent) {
> -		struct commit *p = parent->item;
> -		const char *hex = NULL;
> +		struct object_id *oidp = &parent->item->object.oid;
> +		strbuf_addch(sb, ' ');
>  		if (pp->abbrev)
> -			hex = find_unique_abbrev(p->object.oid.hash, pp->abbrev);
> -		if (!hex)
> -			hex = oid_to_hex(&p->object.oid);

Wow, this existing code was hard to follow. I wondered when
find_unique_abbrev() would return NULL, but it never does. This "if
(!hex)" should have been an "else" all along.

> +			strbuf_add_unique_abbrev(sb, oidp->hash, pp->abbrev);
> +		else
> +			strbuf_addstr(sb, oid_to_hex(oidp));

...which I see you changed here, though perhaps it is not immediately
obvious that it is correct without knowing find_unique_abbrev's return
value assumptions.

Just thinking aloud, I've also wondered if strbuf_addoid() would be
handy.  We already have oid_to_hex_r(). In fact, you could write it
already as:

  strbuf_add_unique_abbrev(sb, oidp->hash, 0);

but that is probably not helping maintainability. ;)

> diff --git a/submodule.c b/submodule.c
> index 2de06a3..476f60b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -392,10 +392,9 @@ static void show_submodule_header(FILE *f, const char *path,
>  	}
>  
>  output_header:
> -	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
> -			find_unique_abbrev(one->hash, DEFAULT_ABBREV));
> -	if (!fast_backward && !fast_forward)
> -		strbuf_addch(&sb, '.');
> +	strbuf_addf(&sb, "%s%sSubmodule %s ", line_prefix, meta, path);
> +	strbuf_add_unique_abbrev(&sb, one->hash, DEFAULT_ABBREV);
> +	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");

Spelling out ".." and "..." as you do makes this much clearer, IMHO.

-Peff
