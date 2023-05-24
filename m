Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF1C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 20:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjEXUdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 16:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEXUdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 16:33:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5318C
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:33:22 -0700 (PDT)
Received: (qmail 25020 invoked by uid 109); 24 May 2023 20:33:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 May 2023 20:33:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27622 invoked by uid 111); 24 May 2023 20:33:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 May 2023 16:33:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 May 2023 16:33:21 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Tribo Dar <3bodar@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] builtin/submodule--helper.c: handle missing submodule
 URLs
Message-ID: <20230524203321.GD892557@coredump.intra.peff.net>
References: <f7a8de14fe255286e62fc46d0a3083189f46bcc6.1684944140.git.me@ttaylorr.com>
 <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2023 at 03:51:43PM -0400, Taylor Blau wrote:

> In e0a862fdaf (submodule helper: convert relative URL to absolute URL if
> needed, 2018-10-16), `prepare_to_clone_next_submodule()` lost the
> ability to handle URL-less submodules, due to a change from:
> 
>     if (repo_get_config_string_const(the_repostiory, sb.buf, &url))
>         url = sub->url;
> 
> to
> 
>     if (repo_get_config_string_const(the_repostiory, sb.buf, &url)) {
>         if (starts_with_dot_slash(sub->url) ||
>             starts_with_dot_dot_slash(sub->url)) {
>                 /* ... */
>             }
>     }

This patch looks pretty good to me. I read your v1 and the word "gross"
also crossed my mind at the "--url" handling. This one is much better.
I did have a few questions, though (below).

If I understand correctly, this is not at all new in the -rc releases,
but just something that happened to get unearthed? I.e., it can wait
until post-release.

> , which will segfault when `sub->url` is NULL, since both
> `starts_with_dot_slash()` does not guard its arguments as non-NULL.

Funny gramm-o, presumably from editing: "both" is plural, but "does" and
"its" are singular. I think the gist of it is communicated, though.

> Guard the checks to both of the above functions by first checking
> whether `sub->url` is non-NULL. There is no need to check whether `sub`
> itself is NULL, since we already perform this check earlier in
> `prepare_to_clone_next_submodule()`.

Good, thanks for checking (and communicating) that possible gotha.

> By adding a NULL-ness check on `sub->url`, we'll fall into the 'else'
> branch, setting `url` to `sub->url` (which is NULL). Before attempting
> to invoke `git submodule--helper clone`, check whether `url` is NULL,
> and die() if it is.

If I hadn't read v1, I might wonder whether this die() is consistent
with the existing behavior. But the point is that submodule--helper
would have barfed in such a case anyway, so we are just trading one
error for another.

One side effect, though, is that this die() will take down the whole
superproject process. Whereas I think the intent of the submodule code
is to keep going, handling other submodules, even if one fails. This
isn't a failure exactly (more of a misconfiguration, if I understand
it). But should we be somehow returning an error instead?

I say "somehow" because it's not clear how to work that in with the
needs_cloning return value (obviously we can say "0", but that is the
same as the "skipped" code path; we presumably want to tell the caller
there was a failure, so it affects the ultimate return code).

> +test_expect_success 'update submodules without url set in .gitconfig' '

Should this be .gitmodules in the title?

-Peff
