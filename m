Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F0CC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E671B2229C
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 02:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgLOCxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 21:53:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:60820 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgLOCxi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 21:53:38 -0500
Received: (qmail 11890 invoked by uid 109); 15 Dec 2020 02:52:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 02:52:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7167 invoked by uid 111); 15 Dec 2020 02:52:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 14 Dec 2020 21:52:53 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 14 Dec 2020 21:52:52 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] git-2.30.0-rc0 - Compile Fails on HPE NonStop
Message-ID: <X9glBJnlLMTW6Dns@coredump.intra.peff.net>
References: <035d01d6d26e$8c255260$a46ff720$@nexbridge.com>
 <xmqqeejraiw7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeejraiw7.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 06:43:36PM -0800, Junio C Hamano wrote:

> diff --git c/git-compat-util.h w/git-compat-util.h
> index 7d509c5022..58cd0761be 100644
> --- c/git-compat-util.h
> +++ w/git-compat-util.h
> @@ -273,7 +273,8 @@ struct itimerval {
>  
>  #ifdef NO_SETITIMER
>  static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
> -	; /* nothing */
> +	errno = ENOSYS;
> +	return -1; /* not implemented */
>  }
>  #endif
>  
> Alternatively we could pretend that the call always succeeds by
> without touching errno and returning 0.  That might be safer, but I
> dunno which one we want, and I do not have a system affected by the
> choice.

I think this is a sensible choice. Before the conversion to an inline,
the code was removed entirely! So anybody checking the return value
would have seen an error, and we do not have to worry much about
breaking them.

For new callers, anybody checking the return value would probably
appreciate the warning that support for the function is optional (OTOH,
they would probably not find out themselves, but rather when Randall
tells them ;) ).

It would be nice to have a way to warn them even on platforms that have
setitimer(), but I can't think of an easy way.

> > Aside from inlining bodies, this should not have compiled on any platform:
> >
> > static inline void strset_remove(struct strset *set, const char *str)
> > {
> >         return strmap_remove(&set->map, str, 0);
> > }
> >
> > What is really intended here?
> 
> I think we should just drop "return"; a void function should be
> called in void context without requiring a value, even if that
> return expects no value.

Yeah, I think that is right. I checked earlier iterations of the series
to see if perhaps strmap_remove() had previously returned a value, but
it never did in any on the list.

> diff --git i/strmap.h w/strmap.h
> index c4c104411b..1e152d832d 100644
> --- i/strmap.h
> +++ w/strmap.h
> @@ -165,7 +165,7 @@ static inline int strintmap_contains(struct strintmap *map, const char *str)
>  
>  static inline void strintmap_remove(struct strintmap *map, const char *str)
>  {
> -	return strmap_remove(&map->map, str, 0);
> +	strmap_remove(&map->map, str, 0);
>  }

So yeah, I think that is the right fix. +cc Elijah for any other
insight.

-Peff
