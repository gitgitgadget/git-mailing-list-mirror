Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E600C433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34787208B3
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 12:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHML6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:58:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:57528 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbgHML6U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 07:58:20 -0400
Received: (qmail 18624 invoked by uid 109); 13 Aug 2020 11:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Aug 2020 11:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13010 invoked by uid 111); 13 Aug 2020 11:58:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Aug 2020 07:58:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 13 Aug 2020 07:58:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: factor out print_oid()
Message-ID: <20200813115815.GA3098633@coredump.intra.peff.net>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 01:11:18PM +0200, René Scharfe wrote:

> Simplify the output code by splitting it up and reducing duplication.
> Reuse the logic for printing object IDs -- anonymized if needed -- by
> moving it to its own function, print_oid().

Looks sane overall, though somehow we added 4 extra lines while reducing
duplication. ;)

> +static void print_oid(const struct object_id *oid, int anonymize)
> +{
> +	const char *oid_hex = oid_to_hex(oid);
> +	if (anonymize)
> +		oid_hex = anonymize_oid(oid_hex);
> +	fputs(oid_hex, stdout);
> +}

Would anyone ever pass anything except the global "anonymize" into this
function (certainly neither of the new callers does). I get that it
takes us on a possible road towards moving the globals to locals, but in
the meantime, shadowing the global name just seems more confusing to me.

> @@ -470,21 +478,19 @@ static void show_filemodify(struct diff_queue_struct *q,
>  		case DIFF_STATUS_TYPE_CHANGED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_ADDED:
> +			printf("M %06o ", spec->mode);

This makes the output a bit more lego-like (i.e., hard to see what the
full line will look like from the code), but it already was pretty
bad because of using print_path(). I think that's fine.

> @@ -724,12 +730,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  		else
>  			printf("merge ");
>  		if (mark)
> -			printf(":%d\n", mark);
> +			printf(":%d", mark);

This line gets repeated, too. I guess we could have a print_mark(), but
there is really no logic here except "put a colon in front of it", so
probably not worthwhile.

-Peff
