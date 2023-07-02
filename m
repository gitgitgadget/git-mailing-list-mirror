Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57DDEB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 20:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGBU1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGBU1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 16:27:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ECA1BB
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 13:27:27 -0700 (PDT)
Received: (qmail 9257 invoked by uid 109); 2 Jul 2023 20:27:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 02 Jul 2023 20:27:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15741 invoked by uid 111); 2 Jul 2023 20:27:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 02 Jul 2023 16:27:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 2 Jul 2023 16:27:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Jan =?utf-8?Q?Kl=C3=B6tzke?= <jan@kloetzke.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Steve Kemp <steve@steve.org.uk>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] ref-filter: handle nested tags in --points-at option
Message-ID: <20230702202722.GA1052071@coredump.intra.peff.net>
References: <20230701205703.1172505-1-jan@kloetzke.net>
 <20230702125611.GA1036686@coredump.intra.peff.net>
 <df912fc4-601b-4d43-c6e4-aa5f74ec031f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df912fc4-601b-4d43-c6e4-aa5f74ec031f@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 02, 2023 at 06:25:13PM +0200, René Scharfe wrote:

> >> -	if (obj->type == OBJ_TAG)
> >> -		tagged_oid = get_tagged_oid((struct tag *)obj);
> >> -	if (tagged_oid && oid_array_lookup(points_at, tagged_oid) >= 0)
> >> -		return tagged_oid;
> >
> > This code is moved into the loop body, but your version there drops the
> > "if (tagged_oid)" check. I think that is OK (and even preferable),
> > though. In get_tagged_oid() we will die() if the tagged object is NULL
> > (though even before switching to that function this check was
> > questionable, because it is "tag->tagged" that may be NULL, and we were
> > dereferencing that unconditionally).
> 
> The check is necessary in the current code because tagged_oid is NULL if
> obj is not a tag.  The new code no longer needs it.

Oh, right. Probably:

	if (obj->type == OBJ_TAG) {
		const struct object_id *tagged_oid = get_tagged_oid((struct tag *)obj);
		if (oid_array_lookup(points_at, tagged_oid) >= 0)
			return tagged_oid;
	}

would have been a better way to write the original, but the new one with
the loop is better still. ;)

I also notice that the function returns a pointer to an oid, even though
the sole caller only cares about a boolean result. Not that big a deal,
though the memory lifetime of the return value is confusing.  We might
return "tagged_oid" which points to a struct that will live forever, but
we might also return "oid" directly, which points to memory passed in
from the caller with a limited lifetime.

-Peff
