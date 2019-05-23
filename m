Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D7320380
	for <e@80x24.org>; Thu, 23 May 2019 10:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfEWKY7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 06:24:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727434AbfEWKY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 06:24:58 -0400
Received: (qmail 10522 invoked by uid 109); 23 May 2019 10:24:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 May 2019 10:24:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29215 invoked by uid 111); 23 May 2019 10:25:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 23 May 2019 06:25:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 May 2019 06:24:56 -0400
Date:   Thu, 23 May 2019 06:24:56 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] server-info: do not list unlinked packs
Message-ID: <20190523102456.GA6583@sigill.intra.peff.net>
References: <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
 <20190515203839.zixx23bwzeyto6a3@dcvr>
 <20190515214806.GA31693@sigill.intra.peff.net>
 <20190523085959.4q76pokx2gy6wqq7@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523085959.4q76pokx2gy6wqq7@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 08:59:59AM +0000, Eric Wong wrote:

> > We never delete entries from the in-memory packed_git list; a reprepare
> > only adds to the list. You'd need to teach update_server_info() to
> > ignore packs which are no longer present (or switch to exec-ing a
> > separate update-server-info binary).
> 
> Ah, checking files_exists() and setting a bit seems sufficient.

Yes, though we do we even need to store the bit?

I.e.,

> @@ -199,12 +200,16 @@ static void init_pack_info(const char *infofile, int force)
>  		 */
>  		if (!p->pack_local)
>  			continue;
> +		if (!file_exists(p->pack_name)) {
> +			p->pack_unlinked = 1;
> +			continue;
> +		}
>  		i++;
>  	}
>  	num_pack = i;
>  	info = xcalloc(num_pack, sizeof(struct pack_info *));
>  	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
> -		if (!p->pack_local)
> +		if (!p->pack_local || p->pack_unlinked)
>  			continue;
>  		assert(i < num_pack);
>  		info[i] = xcalloc(1, sizeof(struct pack_info));

If we just check file_exists() in the second loop, then this is entirely
local to update_server_info(). And other users of packed_git do not have
to wonder who is responsible for setting that flag in the global list.

It does mean you'd over-allocate the array (and num_pack would have to
be adjusted down to "i" after the second loop), but that's not a big
deal.  I do think the whole two-loop thing would be more readable if we
simply grew it on the fly with ALLOC_GROW().

-Peff
