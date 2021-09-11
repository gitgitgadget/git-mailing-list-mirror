Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5C8C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AC261212
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 17:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhIKRJG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 13:09:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:45104 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKRJG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 13:09:06 -0400
Received: (qmail 12808 invoked by uid 109); 11 Sep 2021 17:07:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Sep 2021 17:07:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22453 invoked by uid 111); 11 Sep 2021 17:07:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Sep 2021 13:07:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Sep 2021 13:07:52 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
Message-ID: <YTziaNywmCMn07IS@coredump.intra.peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 06:08:42PM +0200, René Scharfe wrote:

> fill_midx_entry() finds the position of an object ID and passes it to
> nth_midxed_pack_entry(), which uses the position to look up the object
> ID for its own purposes.  Inline the latter into the former to avoid
> that lookup.

Ah, I see what you mean now by "inline" in the other part of the thread.

Yes, I think this makes sense since there is no other reasonable caller
of the nth_midxed_pack_entry() helper (and its one caller is itself
trivial).

> @@ -304,8 +307,7 @@ static int nth_midxed_pack_entry(struct repository *r,
>  	if (!is_pack_valid(p))
>  		return 0;
> 
> -	nth_midxed_object_oid(&oid, m, pos);
> -	if (oidset_contains(&p->bad_objects, &oid))
> +	if (oidset_contains(&p->bad_objects, oid))
>  		return 0;

So we get to avoid the nth_midxed_object_oid() copy entirely. Very nice.

Compared to the code before your series, we still have an extra function
call to oidset_contains(), which will (in the common case) notice we
have no entries and immediately return. But I think that's getting into
pointless micro-optimization.

-Peff
