Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363E0EB64DD
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjF0I5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjF0I5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:57:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54081BC8
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:57:02 -0700 (PDT)
Received: (qmail 3908 invoked by uid 109); 27 Jun 2023 08:57:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:57:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15227 invoked by uid 111); 27 Jun 2023 08:57:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:57:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:57:01 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] strbuf: simplify strbuf_expand_literal_cb()
Message-ID: <20230627085701.GK1226768@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <ded69969-158d-b05f-fdd4-91b26e9b502b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ded69969-158d-b05f-fdd4-91b26e9b502b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 10:44:00PM +0200, René Scharfe wrote:

> Now that strbuf_expand_literal_cb() is no longer used as a callback,
> drop its "_cb" name suffix and unused context parameter.

Makes sense.

Since most callers just call "format += len", it kind of feels like the
appropriate interface might be more like:

  strbuf_expand_literal(&sb, &format);

to auto-advance the format. But I guess that gets weird with this
caller:

> @@ -1395,7 +1395,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  	char **slot;
> 
>  	/* these are independent of the commit */
> -	res = strbuf_expand_literal_cb(sb, placeholder, NULL);
> +	res = strbuf_expand_literal(sb, placeholder);
>  	if (res)
>  		return res;

which is still in the "return the length" mentality (OTOH, if it
advanced the local copy of the placeholder pointer nobody would mind).

I dunno. It is a little thing, and I am OK with it either way (I would
not even think of changing it if you were not already touching the
function).

-Peff
