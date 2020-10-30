Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3710C4363A
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B67A221FF
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 14:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgJ3OjH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 10:39:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:42544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgJ3OjH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 10:39:07 -0400
Received: (qmail 7346 invoked by uid 109); 30 Oct 2020 14:39:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Oct 2020 14:39:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21764 invoked by uid 111); 30 Oct 2020 14:39:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2020 10:39:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Oct 2020 10:39:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 08/10] strmap: add functions facilitating use as a
 string->int map
Message-ID: <20201030143906.GH3277724@coredump.intra.peff.net>
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com>
 <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc8d702f98f94fd9202d227d19be43a912467e84.1602549650.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 12:40:48AM +0000, Elijah Newren via GitGitGadget wrote:

> Although strmap could be used as a string->int map, one either had to
> allocate an int for every entry and then deallocate later, or one had to
> do a bunch of casting between (void*) and (intptr_t).
> 
> Add some special functions that do the casting.  Also, rename put->set
> for such wrapper functions since 'put' implied there may be some
> deallocation needed if the string was already found in the map, which
> isn't the case when we're storing an int value directly in the void*
> slot instead of using the void* slot as a pointer to data.

I think this is worth doing. That kind of casting is an implementation
detail, and it's nice for callers not to have to see it.

You might want to mention that this _could_ be done as just accessors to
strmap, but using a separate struct provides type safety against
misusing pointers as integers or vice versa.

> A note on the name: if anyone has a better name suggestion than
> strintmap, I'm happy to take it.  It seems slightly unwieldy, but I have
> not been able to come up with a better name.

I still don't have a better suggestion on the name. Another convention
could be to name map types as "map_from_to". So "struct map_str_int".
But it's pretty ugly, and strmap would become "map_str_ptr" or
something. As ugly as "strintmap" is, I like it better.

> +void strintmap_incr(struct strintmap *map, const char *str, intptr_t amt)
> +{
> +	struct strmap_entry *entry = find_strmap_entry(&map->map, str);
> +	if (entry) {
> +		intptr_t *whence = (intptr_t*)&entry->value;
> +		*whence += amt;
> +	}
> +	else
> +		strintmap_set(map, str, amt);
> +}

Incrementing a missing entry auto-vivifies it at 0.  That makes perfect
sense, but might be worth noting above the function in the header file.

Though maybe it's a little weird since strintmap_get() takes a default
value. Why don't we use that here? I'd have to see how its used, but
would it make sense to set a default value when initializing the map,
rather than providing it on each call?

> +/*
> + * strintmap:
> + *    A map of string -> int, typecasting the void* of strmap to an int.

Are the size and signedness of an int flexible enough for all uses?

I doubt the standard makes any promises about the relationship between
intptr_t and int, but I'd be surprised if any modern platform has an
intptr_t that isn't at least as big as an int (on most 32-bit platforms
they'll be the same, and on 64-bit ones intptr_t is strictly bigger).

Would any callers care about using the full 32-bits, though? I.e., would
they prefer casting through uintptr_t to an "unsigned int"?

-Peff
