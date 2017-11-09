Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3A0D1F442
	for <e@80x24.org>; Thu,  9 Nov 2017 13:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754750AbdKIN3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 08:29:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:51052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754685AbdKIN3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 08:29:41 -0500
Received: (qmail 27464 invoked by uid 109); 9 Nov 2017 13:29:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Nov 2017 13:29:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23696 invoked by uid 111); 9 Nov 2017 13:29:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 Nov 2017 08:29:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Nov 2017 08:29:39 -0500
Date:   Thu, 9 Nov 2017 08:29:39 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joseph Strauss <josephst@bhphoto.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug - Status - Space in Filename
Message-ID: <20171109132939.3v2z6sf22b4tnwpq@sigill.intra.peff.net>
References: <655aaa9d2abf4be1b6ade0574d88c999@EXMBX01B.bhphotovideo.local>
 <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqvaikjfoj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 09, 2017 at 12:26:20PM +0900, Junio C Hamano wrote:

> The difference in d->head_path part is dealing about renames, which
> is irrelevant for showing unmerged paths, but the key difference is
> that the _unmerged() forgets to add the enclosing "" around the
> result of quote_path().
> 
> It seems that wt_shortstatus_other() shares the same issue.  Perhaps
> this will "fix" it?
> 
> Having said all that, the whole "quote path using c-style" was
> designed very deliberately to treat SP (but not other kind of
> whitespaces like HT) as something we do *not* have to quote (and
> more importantly, do not *want* to quote, as pathnames with SP in it
> are quite common for those who are used to "My Documents/" etc.), so
> it is arguably that what is broken and incorrect is the extra
> quoting with dq done in wt_shortstatus_status().  It of course is
> too late to change the rules this late in the game, though.

Yeah, I think the original sin is using " -> " in the --porcelain output
(which just got it from --short). That should have been a HT all along
to match the rest of the diff code. The --porcelain=v2 format gets this
right.

> Perhaps a better approach is to refactor the extra quoting I moved
> to this emit_with_optional_dq() helper into quote_path() which
> currently is just aliased to quote_path_relative().  It also is
> possible that we may want to extend the "no_dq" parameter that is
> given to quote_c_style() helper from a boolean to a set of flag
> bits, and allow callers to request "I want SP added to the set of
> bytes that triggers the quoting".

Yeah, I had the same thought upon digging into the code.

That said, if this is the only place that has this funny quoting, it may
not be worth polluting the rest of the code with the idea that quoting
spaces is a good thing to do.

> diff --git a/wt-status.c b/wt-status.c
> index bedef256ce..472d53d596 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1671,6 +1671,20 @@ static void wt_longstatus_print(struct wt_status *s)
>  		wt_longstatus_print_stash_summary(s);
>  }
>  
> +static const char *emit_with_optional_dq(const char *in, const char *prefix, 
> +					  struct strbuf *out)
> +{
> +	const char *one;
> +
> +	one = quote_path(in, prefix, out);
> +	if (*one != '"' && strchr(one, ' ') != NULL) {
> +		putchar('"');
> +		strbuf_addch(out, '"');
> +		one = out->buf;
> +	}
> +	return one;
> +}

This puts part of its output to stdout, and the other part into a
strbuf. That works for these callers, but maybe just emitting the whole
thing to stdout would be less confusing (and I suspect would clean up
the callers a bit, who would not have to worry about the strbuf at all).

-Peff
