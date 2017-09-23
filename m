Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA1E6202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 04:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750778AbdIWE2A (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 00:28:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:47766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750707AbdIWE2A (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 00:28:00 -0400
Received: (qmail 23509 invoked by uid 109); 23 Sep 2017 04:28:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 04:28:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10812 invoked by uid 111); 23 Sep 2017 04:28:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 00:28:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 00:27:57 -0400
Date:   Sat, 23 Sep 2017 00:27:57 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] object_array: add and use `object_array_pop()`
Message-ID: <20170923042757.ozl4qnmrsnd64mfc@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <80eaae517f73f57137db6adfcaef2e8ce16576c1.1506120292.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80eaae517f73f57137db6adfcaef2e8ce16576c1.1506120292.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 01:34:53AM +0200, Martin Ågren wrote:

> In a couple of places, we pop objects off an object array `foo` by
> decreasing `foo.nr`. We access `foo.nr` in many places, but most if not
> all other times we do so read-only, e.g., as we iterate over the array.
> But when we change `foo.nr` behind the array's back, it feels a bit
> nasty and looks like it might leak memory.
> 
> Leaks happen if the popped element has an allocated `name` or `path`.
> At the moment, that is not the case. Still, 1) the object array might
> gain more fields that want to be freed, 2) a code path where we pop
> might start using names or paths, 3) one of these code paths might be
> copied to somewhere where we do, and 4) using a dedicated function for
> popping is conceptually cleaner.

All good reasons, I think.

> Introduce and use `object_array_pop()` instead. Release memory in the
> new function. Document that popping an object leaves the associated
> elements in limbo.

The interface looks appropriate for all of the current cases. Though I
do suspect there's a bit of catch-22 here. If a caller _did_ care about
the "name" and "path" fields, then this pop function would be
inappropriate, because it returns only the object field.

So in the most general form, you'd want:

  while (foo.nr) {
	  struct object_array_entry *e = object_array_pop(&foo);

	  ... do stuff with e->name, etc ...

	  object_array_release_entry(e);
  }

But that is certainly more cumbersome for these callers. I think we can
punt on that until it becomes necessary (which likely is never).

> Make the new function return NULL on an empty array. This is consistent
> with `pop_commit()` and allows the following:
> 
> 	while ((o = object_array_pop(&foo)) != NULL) {
> 		// do something
> 	}
> 
> But as noted above, we don't need to go out of our way to avoid reading
> `foo.nr`. This is probably more readable:
> 
> 	while (foo.nr) {
> 		... o = object_array_pop(&foo);
> 		// do something
> 	}

Agreed that the latter is more readable (though I am also happy that the
pop function does something sensible for an empty array).

> The name of `object_array_pop()` does not quite align with
> `add_object_array()`. That is unfortunate. On the other hand, it matches
> `object_array_clear()`. Arguably it's `add_...` that is the odd one out,
> since it reads like it's used to "add" an "object array". For that
> reason, side with `object_array_clear()`.

Yes, we're dreadfully inconsistent here. I tend to prefer noun_verb()
when "noun" is a struct we're operating on. But we have quite a bit of
verb_noun(). I find that noun_verb() is a bit more discoverable (e.g.,
tab completion does something sensible), but I'm not sure if it's worth
trying to do a mass-conversion.

Perhaps it's something that should be mentioned in CodingGuidelines, if
it isn't already.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  builtin/fast-export.c |  3 +--
>  builtin/fsck.c        |  7 +------
>  builtin/reflog.c      |  2 +-
>  object.c              | 13 +++++++++++++
>  object.h              |  7 +++++++
>  shallow.c             |  2 +-
>  6 files changed, 24 insertions(+), 10 deletions(-)

The patch itself looks good, with one tiny nit:

> diff --git a/object.h b/object.h
> index 0a419ba8d..b7629fe92 100644
> --- a/object.h
> +++ b/object.h
> @@ -115,6 +115,13 @@ int object_list_contains(struct object_list *list, struct object *obj);
>  /* Object array handling .. */
>  void add_object_array(struct object *obj, const char *name, struct object_array *array);
>  void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
> +/*
> + * Returns NULL if the array is empty. Otherwise, returns the last object
> + * after removing its entry from the array. Other resources associated
> + * with that object are left in an unspecified state and should not be
> + * examined.
> + */
> +struct object *object_array_pop(struct object_array *array);

I'm very happy to see a comment over the declaration here. But I think
it's a bit more readable if we put a blank line between the prior
function and the start of that comment.

-Peff
