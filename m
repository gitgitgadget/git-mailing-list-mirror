Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A98A1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754816AbeBOFhS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:37:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:53362 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754813AbeBOFhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:37:17 -0500
Received: (qmail 1536 invoked by uid 109); 15 Feb 2018 05:37:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:37:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7245 invoked by uid 111); 15 Feb 2018 05:38:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:38:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:37:15 -0500
Date:   Thu, 15 Feb 2018 00:37:15 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 08/23] ref-filter: reuse parse_ref_filter_atom()
Message-ID: <20180215053714.GH18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f434b-3f93f5b7-0fad-4777-ab9b-79c48b2b41d2-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f434b-3f93f5b7-0fad-4777-ab9b-79c48b2b41d2-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Continue migrating formatting logic from cat-file to ref-filter.
> Reuse parse_ref_filter_atom() for unifying all processes in ref-filter
> and further removing of mark_atom_in_object_info().

OK, now it looks we're moving in a good direction.

One thing that puzzles me:

> @@ -401,20 +420,14 @@ static int is_atom(const char *atom, const char *s, int slen)
>  static void mark_atom_in_object_info(const char *atom, int len,
>  				    struct expand_data *data)
>  {
> -	if (is_atom("objectname", atom, len))
> -		; /* do nothing */
> -	else if (is_atom("objecttype", atom, len))
> +	if (is_atom("objecttype", atom, len))
>  		data->info.typep = &data->type;
>  	else if (is_atom("objectsize", atom, len))
>  		data->info.sizep = &data->size;
> -	else if (is_atom("objectsize:disk", atom, len))
> -		data->info.disk_sizep = &data->disk_size;
>  	else if (is_atom("rest", atom, len))
>  		data->split_on_whitespace = 1;
>  	else if (is_atom("deltabase", atom, len))
>  		data->info.delta_base_sha1 = data->delta_base_oid.hash;
> -	else
> -		die("unknown format element: %.*s", len, atom);
>  }

Why do some of these atoms go away and not others? It seems like we're
now relying on ref-filter to parse some of the common ones using its
existing atom-parser. But wouldn't it have objecttype and objectsize
already, then?

-Peff
