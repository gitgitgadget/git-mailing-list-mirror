Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70400202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 06:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbdJBGvD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 02:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57314 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbdJBGvC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 02:51:02 -0400
Received: (qmail 10326 invoked by uid 109); 2 Oct 2017 06:51:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 06:51:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26361 invoked by uid 111); 2 Oct 2017 06:51:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 02:51:43 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 02:51:00 -0400
Date:   Mon, 2 Oct 2017 02:51:00 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v6 7/7] ref-filter.c: parse trailers arguments with
 %(contents) atom
Message-ID: <20171002065100.cjawz6pvxjj2w5nr@sigill.intra.peff.net>
References: <20171002052326.GA10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002052524.12627-1-me@ttaylorr.com>
 <20171002052524.12627-7-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002052524.12627-7-me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 01, 2017 at 10:25:24PM -0700, Taylor Blau wrote:

> The %(contents) atom takes a contents "field" as its argument. Since
> "trailers" is one of those fields, extend contents_atom_parser to parse
> "trailers"'s arguments when used through "%(contents)", like:
> 
>   %(contents:trailers:unfold,only)
> 
> A caveat: trailers_atom_parser expects NULL when no arguments are given
> (see: `parse_ref_filter_atom`). This is because string_list_split (given
> a maxsplit of -1) returns a 1-ary string_list* containing the given
> string if the delimiter could not be found using `strchr`.
> 
> To simulate this behavior without teaching trailers_atom_parser to
> accept strings with length zero, conditionally pass NULL to
> trailers_atom_parser if the arguments portion of the argument to
> %(contents) is empty.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  ref-filter.c            |  7 ++++---
>  t/t6300-for-each-ref.sh | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 3 deletions(-)

This patch seems to fail a bunch of tests in t6300.

> diff --git a/ref-filter.c b/ref-filter.c
> index 43ed10a5e..6c26b4733 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -212,9 +212,10 @@ static void contents_atom_parser(const struct ref_format *format, struct used_at
>  		atom->u.contents.option = C_SIG;
>  	else if (!strcmp(arg, "subject"))
>  		atom->u.contents.option = C_SUB;
> -	else if (!strcmp(arg, "trailers"))
> -		atom->u.contents.option = C_TRAILERS;
> -	else if (skip_prefix(arg, "lines=", &arg)) {
> +	else if (skip_prefix(arg, "trailers", &arg)) {
> +		skip_prefix(arg, ":", &arg);
> +		trailers_atom_parser(format, atom, *arg ? NULL : arg);

I think your logic is flipped. You want "*arg ? arg : NULL";

-Peff
