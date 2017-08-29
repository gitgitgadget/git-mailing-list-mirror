Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618EB20285
	for <e@80x24.org>; Tue, 29 Aug 2017 08:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdH2ImT (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 04:42:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:51734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751537AbdH2Il5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 04:41:57 -0400
Received: (qmail 6062 invoked by uid 109); 29 Aug 2017 08:41:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 08:41:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8350 invoked by uid 111); 29 Aug 2017 08:42:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 04:42:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 04:41:55 -0400
Date:   Tue, 29 Aug 2017 04:41:55 -0400
From:   Jeff King <peff@peff.net>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 3/3] merge-recursive: change current file dir
 string_lists to hashmap
Message-ID: <20170829084155.irpfdixu4kcygzrv@sigill.intra.peff.net>
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-4-kewillf@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170828202829.3056-4-kewillf@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 28, 2017 at 02:28:29PM -0600, Kevin Willford wrote:

> The code was using two string_lists, one for the directories and
> one for the files.  The code never checks the lists independently
> so we should be able to only use one list.  The string_list also
> is a O(log n) for lookup and insertion.  Switching this to use a
> hashmap will give O(1) which will save some time when there are
> millions of paths that will be checked.

Makes sense. I think when this code was written we didn't have the
generalized hashmap.c, which is why it relies on string lists.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index d47f40ea81..ef4fe5f09f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -24,6 +24,26 @@
>  #include "dir.h"
>  #include "submodule.h"
>  
> +struct path_hashmap_entry {
> +	struct hashmap_entry;
> +	char path[FLEX_ARRAY];
> +};

This seems like a good use of FLEX_ARRAY.

> +static unsigned int (*pathhash)(const char *path);
> +static int (*pathcmp)(const char *a, const char *b);

These global function pointers are sufficiently out of the ordinary that
it might be worth adding a comment about how they're intended to be
set and used.

I also suspect they could be stuffed into the merge_options struct along
with the hashmap itself, and then passed via the cmp_data pointer (which
is relatively new-ish; I won't be surprised if you wrote this patch
before that existed and forward-ported it).

> +static int path_hashmap_cmp(const void *cmp_data,
> +			    const void *entry,
> +			    const void *entry_or_key,
> +			    const void *keydata)
> +{
> +	const struct path_hashmap_entry *a = entry;
> +	const struct path_hashmap_entry *b = entry_or_key;
> +	const char *key = keydata;
> +
> +	return pathcmp(a->path, key ? key : b->path);
> +}

The hashmap interface makes its cmp functions a bit tricky to write, but
this all looks correct to me.

> @@ -642,6 +662,8 @@ static void add_flattened_path(struct strbuf *out, const char *s)
>  
>  static char *unique_path(struct merge_options *o, const char *path, const char *branch)
>  {
> +	struct path_hashmap_entry dummy;
> +	struct path_hashmap_entry *entry;
>  	struct strbuf newpath = STRBUF_INIT;
>  	int suffix = 0;
>  	size_t base_len;
> @@ -650,14 +672,17 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
>  	add_flattened_path(&newpath, branch);
>  
>  	base_len = newpath.len;
> -	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
> -	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
> +	hashmap_entry_init(&dummy, pathhash(newpath.buf));
> +	while (hashmap_get(&o->current_file_dir_set, &dummy, newpath.buf) ||
>  	       (!o->call_depth && file_exists(newpath.buf))) {
>  		strbuf_setlen(&newpath, base_len);
>  		strbuf_addf(&newpath, "_%d", suffix++);
> +		hashmap_entry_init(&dummy, pathhash(newpath.buf));
>  	}

I think you can use hashmap_get_from_hash() here to avoid dealing with
"dummy" yourself.

> @@ -1941,8 +1966,7 @@ int merge_trees(struct merge_options *o,
>  	if (unmerged_cache()) {
>  		struct string_list *entries, *re_head, *re_merge;
>  		int i;
> -		string_list_clear(&o->current_file_set, 1);
> -		string_list_clear(&o->current_directory_set, 1);
> +		hashmap_init(&o->current_file_dir_set, path_hashmap_cmp, NULL, 512);

This hunk seems funny. string_list_clear() assumes the input is an
already-initialized string list, and we drop all of its entries. But
hashmap_init assumes we have an _uninitialized_ chunk of memory, and
throws away whatever was there.

Do we ever hit this code path when there's actually something in the
hashmap?

I'd think we would want to hashmap_init() at the same place we used to
string_list_init(). I.e., in init_merge_options.

> @@ -1978,6 +2002,8 @@ int merge_trees(struct merge_options *o,
>  		string_list_clear(re_head, 0);
>  		string_list_clear(entries, 1);
>  
> +		hashmap_free(&o->current_file_dir_set, 1);

Ah, I think this answers my question above. We only care about the
contents during this one bit of code, so we do an init/free pair. And
since there's no "clear" function for a hashmap that drops the entries
without resetting things like the comparison function, we _have_ to
call hashmap_init in the earlier hunk.

That does make me wonder if it would be sane to just declare the hashmap
local to this block, which would make its lifetime much more clear. I
guess having it in merge_options is convenient for passing it around,
though.

> @@ -2179,8 +2205,8 @@ void init_merge_options(struct merge_options *o)
> [...]

The rest of the patch looks like a straight-forward conversion. With the
understanding I have above, I think everything here is correct, but
there are a few minor bits it might be worth addressing to make the code
more clear.

-Peff
