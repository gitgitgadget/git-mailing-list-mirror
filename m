Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11263C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E754D2072D
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 19:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgHUT6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:58:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:37544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHUT6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 15:58:23 -0400
Received: (qmail 20257 invoked by uid 109); 21 Aug 2020 19:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2020 19:58:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31749 invoked by uid 111); 21 Aug 2020 19:58:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Aug 2020 15:58:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Aug 2020 15:58:22 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/5] strmap: add more utility functions
Message-ID: <20200821195822.GE1165@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <5bda171d0c1562573800d4bcbfac4799f01d9c20.1598035949.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5bda171d0c1562573800d4bcbfac4799f01d9c20.1598035949.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 21, 2020 at 06:52:27PM +0000, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> This adds a number of additional convienence functions I want/need:
>   * strmap_empty()
>   * strmap_get_size()
>   * strmap_remove()
>   * strmap_for_each_entry()
>   * strmap_free()
>   * strmap_get_item()
> 
> I suspect the first four are self-explanatory.

Yup, all make sense. We might also want real iterators rather than
strmap_for_each_entry(), which can be a bit more convenient given the
lack of lambdas in C. But I'd be happy to wait until a caller arises.

> strmap_free() differs from strmap_clear() in that the data structure is
> not reusable after it is called; strmap_clear() is not sufficient for
> the API because without strmap_free() we will leak memory.

Hmm, I missed in the previous function that strmap_clear() is actually
leaving allocated memory. I think this is bad, because it's unlike most
of our other data structure clear() functions.

We could work around it with the lazy-init stuff I mentioned in my last
email (i.e., _don't_ strmap_init() at the end of strmap_clear(), and
just let strmap_put() take care of initializing if somebody actually
adds something again).

But IMHO this is a sign that we should be fixing hashmap() to work like
that, too.

> strmap_get_item() is similar to strmap_get() except that instead of just
> returning the void* value that the string maps to, it returns the
> string_list_item that contains both the string and the void* value (or
> NULL if the string isn't in the map).  This is helpful because it avoids
> multiple lookups, e.g. in some cases a caller would need to call:
>   * strmap_contains() to check that the map has an entry for the string
>   * strmap_get() to get the void* value
>   * <do some work to update the value>
>   * strmap_put() to update/overwrite the value

That makes sense. If you follow my suggestion to drop string_list_item,
then it would be OK to return the whole str_entry. (I forgot to mention
in the last patch, but perhaps strmap_entry would be a more distinctive
name).

> diff --git a/strmap.h b/strmap.h
> index eb5807f6fa..45d0a4f714 100644
> --- a/strmap.h
> +++ b/strmap.h
> @@ -21,6 +21,11 @@ void strmap_init(struct strmap *map);
>  /*
>   * Remove all entries from the map, releasing any allocated resources.
>   */
> +void strmap_free(struct strmap *map, int free_values);
> +
> +/*
> + * Same as calling strmap_free() followed by strmap_init().
> + */
>  void strmap_clear(struct strmap *map, int free_values);

I guess the docstring was a bit inaccurate in the previous patch, then. :)

-Peff
