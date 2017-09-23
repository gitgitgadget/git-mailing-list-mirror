Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0A57202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 04:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750722AbdIWEEK (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 00:04:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750705AbdIWEEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 00:04:09 -0400
Received: (qmail 22567 invoked by uid 109); 23 Sep 2017 04:04:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 04:04:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10614 invoked by uid 111); 23 Sep 2017 04:04:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 00:04:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 00:04:06 -0400
Date:   Sat, 23 Sep 2017 00:04:06 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/6] object_array: use `object_array_clear()`, not
 `free()`
Message-ID: <20170923040406.d6sw52ov2amjzkl4@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <f325af4048bc14d6194da169b02de7d18fff8471.1506120292.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f325af4048bc14d6194da169b02de7d18fff8471.1506120292.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 01:34:52AM +0200, Martin Ågren wrote:

> Instead of freeing `foo.objects` for an object array `foo` (sometimes
> conditionally), call `object_array_clear(&foo)`. This means we don't
> poke as much into the implementation, which is already a good thing, but
> also that we release the individual entries as well, thereby fixing at
> least one memory-leak (in diff-lib.c).
> 
> If someone is holding on to a pointer to an element's `name` or `path`,
> that is now a dangling pointer, i.e., we'd be turning an unpleasant
> situation into an outright bug. To the best of my understanding no such
> long-term pointers are being taken.

It would be nice if we had a good way to verify this automatically, but
I couldn't think of one. It passes the test suite with ASan, but of
course our coverage is not 100%.

We do know a few things:

  1. Any caller which keeps a pointer to the object-entries themselves
     is already broken, since we free that already. We only have to care
     about the name and path strings.

  2. Any caller which uses add_object_array() has a NULL path, so we
     don't have to worry about leaving that dangling.

  3. Most of the callers outside of revision.c use a NULL name argument,
     as well.

So let's see:

> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index e237d927a..6b34f23e7 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -182,8 +182,8 @@ static int commit_is_complete(struct commit *commit)
>  			found.objects[i].item->flags |= SEEN;
>  	}
>  	/* free object arrays */
> -	free(study.objects);
> -	free(found.objects);
> +	object_array_clear(&study);
> +	object_array_clear(&found);
>  	return !is_incomplete;
>  }

These ones always have NULL names and paths, so are good.

(An orthogonal low-hanging fruit: these probably ought to use
OBJECT_ARRAY_INIT instead of memset. Maybe a good #leftoverbits for some
of the Outreachy applicants).

> diff --git a/diff-lib.c b/diff-lib.c
> index 2a52b0795..4e0980caa 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -549,7 +549,6 @@ int index_differs_from(const char *def, int diff_flags,
>  	rev.diffopt.flags |= diff_flags;
>  	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
>  	run_diff_index(&rev, 1);
> -	if (rev.pending.alloc)
> -		free(rev.pending.objects);
> +	object_array_clear(&rev.pending);
>  	return (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0);
>  }

This one gets the entries from setup_revisions(), so they may have
actual names. It calls diff_flush() before the clear, though, so I'm
pretty sure we would have dropped any queued entries (and I'm also
pretty sure that the queued entries make their own copies of any names
anyway). So this one isn't trivial, but I think it's fine.

> diff --git a/submodule.c b/submodule.c
> index 36f45f5a5..79fd01f7b 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1728,7 +1728,7 @@ static int find_first_merges(struct object_array *result, const char *path,
>  			add_object_array(merges.objects[i].item, NULL, result);
>  	}
>  
> -	free(merges.objects);
> +	object_array_clear(&merges);
>  	return result->nr;
>  }

Another always-NULL case.

> @@ -1833,7 +1833,7 @@ int merge_submodule(struct object_id *result, const char *path,
>  			print_commit((struct commit *) merges.objects[i].item);
>  	}
>  
> -	free(merges.objects);
> +	object_array_clear(&merges);
>  	return 0;
>  }

This one is fed by the "result" array of find_first_merges(), which is
also always-NULL.

> diff --git a/upload-pack.c b/upload-pack.c
> index 7efff2fbf..ec0eee8fc 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -888,7 +888,7 @@ static void receive_needs(void)
>  		}
>  
>  	shallow_nr += shallows.nr;
> -	free(shallows.objects);
> +	object_array_clear(&shallows);
>  }

Also always NULL.

So I think all of these cases are good (and weren't actually leaking in
the first place, since the only thing to get rid of was the entries
themselves).

> The way we handle `study` in builting/reflog.c still looks like it might
> leak. That will be addressed in the next commit.

This confused me for a minute, since the leak is not visible in the
context. ;) But reading the next commit, it makes sense.

-Peff
