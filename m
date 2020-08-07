Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE678C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A485F2086A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgHGD1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:27:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:51234 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgHGD1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 23:27:25 -0400
Received: (qmail 28055 invoked by uid 109); 7 Aug 2020 03:27:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 Aug 2020 03:27:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8945 invoked by uid 111); 7 Aug 2020 03:27:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Aug 2020 23:27:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Aug 2020 23:27:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
Message-ID: <20200807032723.GA15119@coredump.intra.peff.net>
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
 <20200807000126.GC8085@camp.crustytoothpaste.net>
 <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 06, 2020 at 05:23:07PM -0700, Junio C Hamano wrote:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5637114b8d..7a0fb7a045 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -252,8 +252,10 @@ typedef unsigned long uintptr_t;
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
>  #else
> -#define precompose_str(in,i_nfd2nfc)
> -#define precompose_argv(c,v)
> +static inline void precompose_argv(int argc, const char **argv)
> +{
> +	; /* nothing */
> +}

This one looks safe and seems like an improvement, since it's our own
function that we're redefining.

But this one for example:

> -#define flockfile(fh)
> -#define funlockfile(fh)
> +static inline void flockfile(FILE *fh)
> +{
> +	; /* nothing */
> +}
> +static inline void funlockfile(FILE *fh)
> +{
> +	; /* nothing */
> +}

is re-defining a name that's usually reserved for the system (at least
on POSIX systems). For most systems that define it, we'd actually use
the system version (and not compile this code at all). But there may be
systems where we choose not to (either the system version is deficient,
or we're testing the fallback code on a more-capable system, or our
#ifndef check isn't sufficient on that system for some reason).

If the system defines it as a macro, we'd probably get a garbled
compiler error as the macro is expanded here. Adding #undef flockfile,
etc beforehand would help. I'm not sure if the current code might give
us a macro redefinition warning on such a system.

If the system defines it as a function, we'd probably get redefinition
warnings.

So...I dunno. Those are all theoretical complaints. But I also think
what it's buying is not very big:

  - unlike precompose_argv(), modern POSIX-compliant systems (which we
    all tend to develop on) don't hit this fallback code. So your
    average developer is likely to see any problems here.

  - this is really the tip of the portability iceberg anyway. In the
    example that motivated this thread, you were catching failures to
    adjust to strvec. But in code like this:

      #ifdef FOO
      void some_func(int x, const char *y)
      {
              struct argv_array whatever = ARGV_ARRAY_INIT;
	      ...
      }
      #else
      void some_func(int x, const char *y)
      {
              /* do nothing */
      }
      #endif

    You'd still fail to notice the problem if you're not compiling with
    -DFOO. I think we have to accept that the compiler on a given
    platform won't be able to catch everything. That's why we have CI on
    many platforms, plus people building and reporting problems on their
    own systems.

> @@ -270,7 +272,9 @@ struct itimerval {
>  #endif
>  
>  #ifdef NO_SETITIMER
> -#define setitimer(which,value,ovalue)
> +static inline int setitimer(int which, const struct itimerval *value, struct itimerval *newvalue) {
> +	; /* nothing */
> +}
>  #endif

Same reasoning applies to this one, plus the added bonus that we'd need
that struct type defined. brian mentioned using "void *". That works as
long as the system doesn't define setitimer() itself with the real
types. Another option is to forward declare "struct itimerval" (which
_should_ be OK even if the system does so, since our forward declaration
has no details). But again, I'm not sure if it's worth the hassle.

-Peff
