Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017A01F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfKHIyP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:54:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:42872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727649AbfKHIyO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:54:14 -0500
Received: (qmail 13363 invoked by uid 109); 8 Nov 2019 08:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Nov 2019 08:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10094 invoked by uid 111); 8 Nov 2019 08:57:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Nov 2019 03:57:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Nov 2019 03:54:13 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] "fatal: bad object .alternate" during fetch with alternates
Message-ID: <20191108085413.GA4356@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1911041053190.46@tvgsbejvaqbjf.bet>
 <20191106205907.GA4122@sigill.intra.peff.net>
 <20191106214201.GB8521@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911071349590.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1911071349590.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 01:58:04PM +0100, Johannes Schindelin wrote:

> So what about the idea of ignoring (with a warning) them instead,
> without bothering to try saying much about the alternate itself? I.e.
> something like this patch (which is admittedly a bit verbose because it
> _also_ has to update a signature):
>
> [...]
> @@ -1569,7 +1569,11 @@ static void add_one_alternate_ref(const struct object_id *oid,
>  	struct add_alternate_refs_data *data = vdata;
>  	struct object *obj;
> 
> -	obj = get_reference(data->revs, name, oid, data->flags);
> +	if (!(obj = get_reference(data->revs, name, oid, data->flags, 1))) {
> +		warning("ignoring stale alternate reference to '%s'",
> +			oid_to_hex(oid));
> +		return;
> +	}
>  	add_rev_cmdline(data->revs, obj, name, REV_CMD_REV, data->flags);
>  	add_pending_object(data->revs, obj, name);
>  }

I don't think it makes sense to tie this to "--alternate-refs" in this
way. I think there are two ways to look at resolving this:

  - for the UNINTERESTING side of a traversal, we might be willing to
    ignore a missing object. But then it would apply equally to
    non-alternates, too. (And we do this already, but not for ref tips,
    since those aren't just "stale" but rather indicative of a
    corruption).

  - any alternate-ref borrowing is an optimization and thus best-effort.
    So we should treat them specially, whether UNINTERESTING or not. But
    then I think the right place to do that is not inside rev-list, but
    in for_each_alternate_ref(), or even in the for-each-ref run inside
    the alternate repository. Then it would help rev-list, but also
    avoid advertising the bogus object across a push/fetch.

-Peff
