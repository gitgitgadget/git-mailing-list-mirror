Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FA81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750849AbeBOFRB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:17:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:53302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750730AbeBOFRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:17:00 -0500
Received: (qmail 315 invoked by uid 109); 15 Feb 2018 05:17:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:17:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7095 invoked by uid 111); 15 Feb 2018 05:17:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:17:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:16:58 -0500
Date:   Thu, 15 Feb 2018 00:16:58 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 02/23] ref-filter: add return value to some functions
Message-ID: <20180215051658.GB18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4311-ab635cac-1d48-47ee-90e1-f178f134db1c-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f4311-ab635cac-1d48-47ee-90e1-f178f134db1c-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Add return flag to format_ref_array_item(), show_ref_array_item(),
> get_ref_array_info() and populate_value() for further using.
> Need it to handle situations when item is broken but we can not invoke
> die() because we are in batch mode and all items need to be processed.

OK. The source of these errors would eventually be calls in
populate_value(), but we don't flag any errors there yet (well, we do,
but they all end up in die() for now). So I'd expect to see later in the
series those die() calls converted to errors (I haven't looked further
yet; just making a note to myself).

> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1356,8 +1356,9 @@ static const char *get_refname(struct used_atom *atom, struct ref_array_item *re
>  
>  /*
>   * Parse the object referred by ref, and grab needed value.
> + * Return 0 if everything was successful, -1 otherwise.
>   */

We discussed off-list the concept that the caller may want to know one
of three outcomes:

  - we completed the request, having accessed the object
  - we completed the request, but it didn't require accessing any
    objects
  - an error occurred accessing the object

Since callers like "cat-file" would need to check has_sha1_file()
manually in the second case. Should this return value actually be an
enum, which would make it easier to convert later to a tri-state?

> -static void populate_value(struct ref_array_item *ref)
> +static int populate_value(struct ref_array_item *ref)
>  {
>  	void *buf;
>  	struct object *obj;
> @@ -1482,7 +1483,7 @@ static void populate_value(struct ref_array_item *ref)
>  		}
>  	}
>  	if (used_atom_cnt <= i)
> -		return;
> +		return 0;

Most of these conversions are obviously correct, because they just turn
a void return into one with a value. But this one is trickier:

> @@ -2138,9 +2144,10 @@ void format_ref_array_item(struct ref_array_item *info,
>  		ep = strchr(sp, ')');
>  		if (cp < sp)
>  			append_literal(cp, sp, &state);
> -		get_ref_atom_value(info,
> -				   parse_ref_filter_atom(format, sp + 2, ep),
> -				   &atomv);
> +		if (get_ref_atom_value(info,
> +				       parse_ref_filter_atom(format, sp + 2, ep),
> +				       &atomv))
> +			return -1;
>  		atomv->handler(atomv, &state);
>  	}

since it affects the control flow. Might we be skipping any necessary
cleanup in the function if we see an error?

It looks like we may have called push_stack_element(), but we'd never
get to the end of the function where we call pop_stack_element(),
causing us to leak.

-Peff
