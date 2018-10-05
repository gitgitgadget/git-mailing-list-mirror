Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A95BF1F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeJEXvc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:43260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727746AbeJEXvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:51:32 -0400
Received: (qmail 19399 invoked by uid 109); 5 Oct 2018 16:52:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 16:52:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13065 invoked by uid 111); 5 Oct 2018 16:51:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 12:51:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 12:51:58 -0400
Date:   Fri, 5 Oct 2018 12:51:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
Message-ID: <20181005165157.GC11254@sigill.intra.peff.net>
References: <pull.10.git.gitgitgadget@gmail.com>
 <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
 <d1b58614-989f-5998-6c53-c19eee409a2f@web.de>
 <dd798e76-922f-a113-4408-e3892bee3b44@gmail.com>
 <223b14f7-213f-4d22-4776-22dcfd1806c2@web.de>
 <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b95417a-c8fb-4f1e-cb09-c36804a3a4d0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 12:59:02AM +0200, René Scharfe wrote:

> We could also do something like this to reduce the amount of manual
> casting, but do we want to?  (Macro at the bottom, three semi-random
> examples at the top.)
> [...]
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5f2e90932f..f9e78d69a2 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1066,6 +1066,18 @@ static inline void sane_qsort(void *base, size_t nmemb, size_t size,
>  		qsort(base, nmemb, size, compar);
>  }
>  
> +#define DEFINE_SORT(name, elemtype, one, two, code)			\
> +static int name##_compare(const void *one##_v_, const void *two##_v_)	\
> +{									\
> +	elemtype const *one = one##_v_;					\
> +	elemtype const *two = two##_v_;					\
> +	code;								\
> +}									\
> +static void name(elemtype *array, size_t n)				\
> +{									\
> +	QSORT(array, n, name##_compare);				\
> +}

Interesting. When I saw the callers of this macro, I first thought you
were just removing the casts from the comparison function, but the real
value here is the matching QSORT() wrapper which provides the type
safety.

I'm not wild about declaring functions inside macros, just because it
makes tools like ctags like useful (but I have certainly been guilty of
it myself). I'd also worry that taking "code" as a macro parameter might
not scale (what happens if the code has a comma in it?)

I think we can address that last part by switching the definition order.
Like:

  #define DEFINE_SORT(name, elemtype, one, two) \
  static int name##_compare(const void *, const void *);                \
  static void name(elemtype *array, size_t n)                           \
  {                                                                     \
	QSORT(array, n, name##_compare);                                \
  }                                                                     \
  static int name##_compare(const void *one##_v_, const void *two##_v_) \
  {                                                                     \
	elemtype const *one = one##_v_;					\
	elemtype const *two = two##_v_;					\

And then expecting the caller to do:

  DEFINE_SORT(foo, struct foo, a, b)
     /* code goes here */
  }

The unbalanced braces are nasty, though (and likely to screw up editor
formatting, highlighting, etc).

I wonder if it would be possible to just declare the comparison function
with its real types, and then teach QSORT() to do a type check. That
would require typeof() at least, but it would be OK for the type-check
to be available only to gcc/clang users, I think.

I'm not quite sure what that type-check would look like, but I was
thinking something along the lines of (inside the QSORT macro):

  do {
    /* this will yield a type mismatch if fed the wrong function */
    int (*check)(const typeof(array), const typeof(array)) = compar;
    sane_qsort(array, n, sizeof(*array), n);
  } while (0)

I have no idea if that even comes close to compiling, though.

-Peff
