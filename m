Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BD5C46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 17:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjANRQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 12:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjANRQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 12:16:00 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577983CB
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 09:15:59 -0800 (PST)
Received: (qmail 30048 invoked by uid 109); 14 Jan 2023 17:15:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 14 Jan 2023 17:15:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11999 invoked by uid 111); 14 Jan 2023 17:15:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Jan 2023 12:15:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 14 Jan 2023 12:15:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
Message-ID: <Y8LjTYhTycp/tTBn@coredump.intra.peff.net>
References: <xmqqv8l9n5fj.fsf@gitster.g>
 <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
 <xmqqv8l9ks86.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8l9ks86.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 14, 2023 at 08:15:21AM -0800, Junio C Hamano wrote:

> Yeah, I like that approach.
> 
> But not this one ...
> 
> > +	CURL_IGNORE_DEPRECATION(
> > +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> > +				 get_curl_allowed_protocols(0));
> > +		curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> > +				 get_curl_allowed_protocols(-1));
> > +	)
> >
> > though I think that was introduced only in 7.87.0 along with the
> > deprecation warnings themselves, so we'd need to have a fallback like:
> >
> >   #ifndef CURL_IGNORE_DEPRECATION(x)
> >   #define CURL_IGNORE_DEPRECATION(x) x
> >   #endif
> 
> ... as much.

I agree it's pretty ugly. The one advantage it has is that we'd be
informed of _other_ curl deprecations that might be more interesting to
us.

On the other hand, I don't know how useful those deprecations are going
to be, as it depends on the timeframe. If the deprecation is added for
the same version of libcurl that implements the alternative (which is
roughly the case here), then we'd always be stuck supporting the old and
new forms (old for backwards compatibility, and new to silence the
deprecation warning). We care a lot more about the deprecation once the
alternative has been around for a while, and/or the old way of doing
things is about to be removed. And if we just wait until that removal,
then we do not have to rely on deprecation warnings. The build will
break just fine on its own. :)

-Peff
