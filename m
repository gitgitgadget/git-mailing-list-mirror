Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61770C433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4612C20674
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 09:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgHPJL5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 05:11:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbgHPJL4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 05:11:56 -0400
Received: (qmail 24433 invoked by uid 109); 16 Aug 2020 09:11:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Aug 2020 09:11:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6829 invoked by uid 111); 16 Aug 2020 09:11:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Aug 2020 05:11:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 16 Aug 2020 05:11:54 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] dir: fix problematic API to avoid memory leaks
Message-ID: <20200816091154.GC1221900@coredump.intra.peff.net>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <b9310e9941e91336258edd97a913e5908180720e.1597561152.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9310e9941e91336258edd97a913e5908180720e.1597561152.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 06:59:11AM +0000, Elijah Newren via GitGitGadget wrote:

> Digging further, I found that despite the pretty clear documentation
> near the top of dir.h that folks were supposed to call clear_directory()
> when the user no longer needed the dir_struct, there were four callers
> that didn't bother doing that at all.  However, two of them clearly
> thought about leaks since they had an UNLEAK(dir) directive, which to me
> suggests that the method to free the data was too unclear.  I suspect
> the non-obviousness of the API and its holes led folks to avoid it,
> which then snowballed into further problems with the entries[],
> ignored[], parent_hashmap, and recursive_hashmap problems.

The UNLEAK() ones are sort-of my fault, and are a combination of:

  - The commit adding them says "in some cases (e.g., dir_struct) we
    don't even have a function which knows how to free all of the struct
    members". I'm not sure if why I didn't fix clear_directory() as you
    did. I may not have known about it, or I may have been lazy. Or more
    likely I was simply holding the UNLEAK() hammer, so it looked like a
    nail. ;)

  - My focus was on making leak-checker output cleaner. And it wasn't
    clear for cases where we're about to exit the program whether we
    should be actually freeing (which has small but non-zero cost) or
    just annotating (which is zero-cost, but clearly has confused some
    people about how UNLEAK() was meant to be used). I think I'm leaning
    these days towards "free if it is easy to do so".

So this definitely seems like a good direction to me.

> Rename clear_directory() to dir_free() to be more in line with other
> data structures in git, and introduce a dir_init() to handle the
> suggested memsetting of dir_struct to all zeroes.  I hope that a name
> like "dir_free()" is more clear, and that the presence of dir_init()
> will provide a hint to those looking at the code that there may be a
> corresponding dir_free() that they need to call.

I think having a pair of matched calls is good. I _thought_ we had
established a pattern that we should prefer "clear" to "free" for cases
where the struct itself its not freed. But grepping around, I see there
are a few exceptions (hashmap_free() is the big one, and then
oidmap_free() which is built around it seems to have inherited it).

The rest seem to follow that pattern, though: attr_check_free,
cache_tree_free, and submodule_cache_free all actually free the pointer
passed in. And "git grep '_clear(' *.h" shows lots of
clear-but-don't-free examples.

Would dir_clear() make the pairing more obvious, but keep the clear
name?

(I also wouldn't be opposed to changing hashmap and oidmap to use the
name "clear", but that's obviously a separate patch).

>  builtin/add.c          |  4 ++--
>  builtin/check-ignore.c |  4 ++--
>  builtin/clean.c        |  8 ++++----
>  builtin/grep.c         |  3 ++-
>  builtin/ls-files.c     |  4 ++--
>  builtin/stash.c        |  4 ++--
>  dir.c                  |  7 ++++++-
>  dir.h                  | 19 ++++++++++---------
>  merge.c                |  3 ++-
>  wt-status.c            |  4 ++--
>  10 files changed, 34 insertions(+), 26 deletions(-)

That patch itself looks good except for two minor points:

>  /* Frees memory within dir which was allocated.  Does not free dir itself. */
> -void clear_directory(struct dir_struct *dir)
> +void dir_free(struct dir_struct *dir)
>  {
>  	int i, j;
>  	struct exclude_list_group *group;

As I mentioned in my previous email, I think it would be nice if this
called dir_init() at the end, so that the struct is always in a
consistent state.

> diff --git a/dir.h b/dir.h
> index 7d76d0644f..7c55c1a460 100644
> --- a/dir.h
> +++ b/dir.h
> [...]
> - * - Use `dir.entries[]`.
> + * - Use `dir.entries[]` and `dir.ignored[]`.
>   *
>   * - Call `clear_directory()` when the contained elements are no longer in use.
>   *

This last line should become dir_free() / dir_clear().

-Peff
