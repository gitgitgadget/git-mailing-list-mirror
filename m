Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F897EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbjHKPLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbjHKPLF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:11:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644512D79
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:11:04 -0700 (PDT)
Received: (qmail 16533 invoked by uid 109); 11 Aug 2023 15:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 15:11:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26401 invoked by uid 111); 11 Aug 2023 15:11:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 11:11:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 11:11:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] describe: fix --no-exact-match
Message-ID: <20230811151102.GE2303200@coredump.intra.peff.net>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
 <4eea7e15-6594-93e2-27b5-3d6e3c0baac6@web.de>
 <20230808212720.GA760752@coredump.intra.peff.net>
 <xmqqzg3156sy.fsf@gitster.g>
 <20230809140902.GA775795@coredump.intra.peff.net>
 <22e5a87a-cd35-9793-5b6f-6eb368fdf40e@web.de>
 <20230810004127.GD795985@coredump.intra.peff.net>
 <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09f499ad-28a5-0d8b-8af6-97475bdc614b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 09:10:33PM +0200, René Scharfe wrote:

> > I'm not sure there's a portable and non-insane way of doing what we want
> > here. At least at compile-time.
> 
> We need a wrapper with the correct signature.  The wrapper is plugged
> into struct option.  The typed callback is called by the wrapper and
> can be used for a type check in the struct macro.  Demo patch below.

OK, clever. So we have two functions, one with a real body, and the
other which is used with the void pointer. How do we make sure that the
real-body one matches the type passed to OPT_CALLBACK(), if it is only
seeing the void wrapper? I guess that is this bit in short_name:

> +#define OPT_CALLBACK_F_T(s, l, v, a, h, f, cb) { \
> +	.type = OPTION_CALLBACK, \
> +	.short_name = (s) + (0 ? cb(NULL, NULL, 0, (v)) : 0), \

which would cause the compiler to barf, and presumably eliminate the
dead code (or at the very least never call it at runtime).

So I think that works. Though...

> +#define DEFINE_PARSE_OPT_CB(name)				\
> +static inline int name ## __void(const struct option *opt,	\
> +				 const char *arg, int unset)	\
> +{								\
> +	return name(opt, arg, unset, opt->value);		\
> +}								\

we are defining an inline function with the explicit goal of passing it
as a function pointer. I don't remember all of the standard's rules
here. Are we guaranteed that it will create a linkable version if
necessary?

We could probably drop the "inline" (and perhaps would need to add
MAYBE_UNUSED in such a case).

> diff --git a/builtin/describe.c b/builtin/describe.c
> index b28a4a1f82..ce16c36de2 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -558,15 +558,17 @@ static void describe(const char *arg, int last_one)
>  	strbuf_release(&sb);
>  }
> 
> -static int option_parse_exact_match(const struct option *opt, const char *arg,
> -				    int unset)
> +static int option_parse_exact_match(const struct option *opt UNUSED,
> +				    const char *arg, int unset, int *value)
>  {
>  	BUG_ON_OPT_ARG(arg);
> 
> -	max_candidates = unset ? DEFAULT_CANDIDATES : 0;
> +	*value = unset ? DEFAULT_CANDIDATES : 0;
>  	return 0;
>  }
> 
> +DEFINE_PARSE_OPT_CB(option_parse_exact_match);

I wondered about combining these, like:

  DEFINE_PARSE_OPT_CB(option_parse_exact_match, int) {
	...the real body here...
  }

But I guess that may confuse non-compiler parsers, and it doesn't leave
room for annotations like the UNUSED above (which ironically is still
needed, since now we pass opt->value as its own parameter).

So I dunno. Clever, for sure, and I think it would work. I'm not sure if
the extra code merits the return or not.

-Peff
