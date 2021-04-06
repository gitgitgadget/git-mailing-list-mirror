Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B4C433B4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5B561154
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 18:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244546AbhDFSE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 14:04:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:42828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236637AbhDFSEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 14:04:25 -0400
Received: (qmail 8386 invoked by uid 109); 6 Apr 2021 18:04:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 18:04:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30799 invoked by uid 111); 6 Apr 2021 18:04:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 14:04:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 14:04:15 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 8/8] rev-list: allow filtering of provided items
Message-ID: <YGyinyL2UU421hoX@coredump.intra.peff.net>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
 <0e26fee8b31e46e87fb9fa1ac599506502a9d622.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e26fee8b31e46e87fb9fa1ac599506502a9d622.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 02:15:05PM +0100, Patrick Steinhardt wrote:

> When providing an object filter, it is currently impossible to also
> filter provided items. E.g. when executing `git rev-list HEAD` , the
> commit this reference points to will be treated as user-provided and is
> thus excluded from the filtering mechanism. This makes it harder than
> necessary to properly use the new `--filter=object:type` filter given
> that even if the user wants to only see blobs, he'll still see commits
> of provided references.
> 
> Improve this by introducing a new `--filter-provided` option to the
> git-rev-parse(1) command. If given, then all user-provided references
> will be subject to filtering.

I think this option is a good thing to have.

The name seems a little confusing to me, as I can read is as both
"please filter the provided objects" and "a filter has been provided".
I guess "--filter-print-provided" would be more clear. And also the
default, so you'd want "--no-filter-print-provided". That's kind of
clunky, though. Maybe "--filter-omit-provided"?

> @@ -694,6 +698,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  			return show_bisect_vars(&info, reaches, all);
>  	}
>  
> +	if (filter_options.filter_wants) {
> +		struct commit_list *c;
> +		for (i = 0; i < revs.pending.nr; i++) {
> +			struct object_array_entry *pending = revs.pending.objects + i;
> +			pending->item->flags |= NOT_USER_GIVEN;
> +		}
> +		for (c = revs.commits; c; c = c->next)
> +			c->item->object.flags |= NOT_USER_GIVEN;
> +	}

You store the flag inside the filter_options struct, which implies to me
that it's something that could be applied per-filter (at least in
theory; the command line option doesn't allow us to distinguish).

But here you treat it as a global flag that munges the NOT_USER_GIVEN
flags. Given that it's inside the filter_options struct, and that you
propagate it via transform_to_combine_type(), I'd have expected the LOFC
code to look at the flag and decide to ignore the whole user-given
concept completely.

To be clear, I don't mind at all having it as a global that applies to
all filters. I don't think the flexibility buys us anything. But since
it only applies to rev-list, why not just make it a global option within
rev-list?

And then these hunks:

> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index bb6f6577d5..2877aa9e96 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -242,6 +242,7 @@ static void transform_to_combine_type(
>  		memset(filter_options, 0, sizeof(*filter_options));
>  		filter_options->sub = sub_array;
>  		filter_options->sub_alloc = initial_sub_alloc;
> +		filter_options->filter_wants = sub_array[0].filter_wants;
>  	}
>  	filter_options->sub_nr = 1;
>  	filter_options->choice = LOFC_COMBINE;
> @@ -290,6 +291,9 @@ void parse_list_objects_filter(
>  		parse_error = gently_parse_list_objects_filter(
>  			&filter_options->sub[filter_options->sub_nr - 1], arg,
>  			&errbuf);
> +		if (!parse_error)
> +			filter_options->sub[filter_options->sub_nr - 1].filter_wants =
> +				filter_options->filter_wants;
>  	}
>  	if (parse_error)
>  		die("%s", errbuf.buf);
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 4d0d0588cc..5e609e307a 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -42,6 +42,12 @@ struct list_objects_filter_options {
>  	 */
>  	enum list_objects_filter_choice choice;
>  
> +	/*
> +	 * "--filter-provided" was given by the user, instructing us to also
> +	 * filter all explicitly provided objects.
> +	 */
> +	unsigned int filter_wants : 1;
> +
>  	/*
>  	 * Choice is LOFC_DISABLED because "--no-filter" was requested.
>  	 */

would not be needed at all.

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index e33805e076..5ff800316b 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -1101,7 +1101,8 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
>  	if (haves_bitmap)
>  		bitmap_and_not(wants_bitmap, haves_bitmap);
>  
> -	filter_bitmap(bitmap_git, wants, wants_bitmap, filter);
> +	filter_bitmap(bitmap_git, (filter && filter->filter_wants) ? NULL : wants,
> +		      wants_bitmap, filter);
>  
>  	bitmap_git->result = wants_bitmap;
>  	bitmap_git->haves = haves_bitmap;

I guess we'd need to pass that flag into prepare_bitmap_walk() here so
it knows not to bother with the wants-filtering. But that seems less bad
that stuffing it into the filter struct.

-Peff
