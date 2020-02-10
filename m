Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C93EC352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 20:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D93E20715
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 20:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBJUh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:37:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:56810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727003AbgBJUh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 15:37:26 -0500
Received: (qmail 1466 invoked by uid 109); 10 Feb 2020 20:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Feb 2020 20:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25987 invoked by uid 111); 10 Feb 2020 20:46:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 Feb 2020 15:46:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 Feb 2020 15:37:25 -0500
From:   Jeff King <peff@peff.net>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200210203725.GA620581@coredump.intra.peff.net>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 05:04:09AM +0000, Heba Waly via GitGitGadget wrote:

>     The advice API is currently a little bit confusing to call. quoting from
>     [1]:
>     
>     When introducing a new advice message, you would
>     
>      * come up with advice.frotz configuration variable
>     
>      * define and declare advice_frotz global variable that defaults to
>        true
>     
>      * sprinkle calls like this:
>     
>       if (advice_frotz)
>         advise(_("helpful message about frotz"));
>     
>     A new approach was suggested in [1] which this patch is based upon.

I agree that the current procedure is a bit painful, and I think this is
a step in the right direction. But...

>     After this patch the plan is to migrate the rest of the advise calls to
>     advise_ng and then finally remove advise() and rename advise_ng() to
>     advise()

...this step may not be possible, for a few reasons:

  1. Some of the sites do more than just advise(). E.g., branch.c checks
     the flag and calls both error() and advise().

  2. Some callers may have to do work to generate the arguments. If I
     have:

       advise("advice.foo", "some data: %s", generate_data());

     then we'll call generate_data() even if we'll throw away the result
     in the end.

Similarly, some users of advice_* variables do not call advise() at all
(some call die(), some like builtin/rm.c stuff the result in a strbuf,
and I don't even know what's going on with wt_status.hints. :)

So I think you may need to phase it in a bit more, like:

  a. introduce want_advice() which decides whether or not to show the
     advice based on a config key. I'd also suggest making the "advice."
     part of the key implicit, just to make life easier for the callers.

  b. introduce advise_key() which uses want_advice() and advise() under
     the hood to do what your advise_ng() is doing here.

  c. convert simple patterns of:

       if (advice_foo)
          advise("bar");

     into:

       advise_key("foo", "bar");

     and drop advice_foo where possible.

  d. handle more complex cases one-by-one. For example, with something
     like:

       if (advice_foo)
         die("bar");

     we probably want:

       if (want_advice("foo"))
         die("bar");

     instead. Using string literals is more accident-prone than
     variables (because the compiler doesn't notice if we misspell them)
     but I think is OK for cases where we just refer to the key once.
     For others (e.g., advice_commit_before_merge has 13 mentions),
     either keep the variable. Or alternatively make a wrapper like:

       int want_advice_commit_before_merge(void)
       {
               return want_advice("commitbeforemerge");
       }

     if we want to drop the existing mechanism to load all of the
     variables at the beginning.

-Peff
