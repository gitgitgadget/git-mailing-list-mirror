Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEBE1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 05:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfACFkq (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 00:40:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:53474 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726126AbfACFkq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 00:40:46 -0500
Received: (qmail 20473 invoked by uid 109); 3 Jan 2019 05:40:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 05:40:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7627 invoked by uid 111); 3 Jan 2019 05:40:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 00:40:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 00:40:43 -0500
Date:   Thu, 3 Jan 2019 00:40:43 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v4 1/3] ref-filter: add worktreepath atom
Message-ID: <20190103054043.GG20047@sigill.intra.peff.net>
References: <20181220145931.GB27361@sigill.intra.peff.net>
 <20181224084756.49952-1-nbelakovski@gmail.com>
 <20181224084756.49952-2-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181224084756.49952-2-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 24, 2018 at 12:47:54AM -0800, nbelakovski@gmail.com wrote:

> [...]

Thanks for keeping with this.  I think we're getting quite close, though
I did find a few small-ish issues.

> @@ -34,6 +36,8 @@ static struct ref_msg {
>  	"ahead %d, behind %d"
>  };
>  
> +static struct worktree **worktrees;
> +

Maybe define this near "struct hashmap ref_to_worktree_map" so it's
more obvious that the two are related?

> @@ -75,6 +79,11 @@ static struct expand_data {
>  	struct object_info info;
>  } oi, oi_deref;
>  
> +struct ref_to_worktree_entry {
> +    struct hashmap_entry ent; /* must be the first member! */
> +    struct worktree *wt; /* key is wt->head_ref */
> +};

Indent with spaces?

> -static int used_atom_cnt, need_tagged, need_symref;
> +static int used_atom_cnt, need_tagged, need_symref, has_worktree;
> +static struct hashmap ref_to_worktree_map;

Makes sense. I thought at first has_worktree was a flag that we might
care about between parsing and formatting, but it's really just a flag
to say "we lazy-loaded the worktree list".

> +static int worktree_hashmap_cmpfnc(const void *unused_lookupdata, const void *existing_hashmap_entry_to_test,
> +				   const void *unused_key, const void *keydata_aka_refname)
> +{
> +	const struct ref_to_worktree_entry *e = existing_hashmap_entry_to_test;
> +	return strcmp(e->wt->head_ref, keydata_aka_refname);
> +}

So from the discussion in the cover letter, this needs to be more like:

  static int worktree_hashmap_cmpfnc(const void *unused_lookupdata,
                                     const void *ve1, const void *ve2,
				     const void *keydata_aka_refname)
  {
	const struct ref_to_worktree_entry *e1 = ve1, *e2 = ve2;
	return strcmp(e1->wt->head_ref, keydata_aka_refname ?
		                        keydata_aka_refname :
					e2->wt->head_ref);
  }

> +static int worktree_atom_parser(const struct ref_format *format,
> +				struct used_atom *atom,
> +				const char *arg,
> +				struct strbuf *unused_err)
> +{
> +	int i;
> +	if (has_worktree)
> +		return 0;

Minor style nit, but please put a space between the declarations and the
start of the code (not strictly necessary for a short function which has
no other linebreaks, like the cmpfunc above, but here I think it's
confusing not to).

> +	worktrees = get_worktrees(0);
> +
> +	hashmap_init(&ref_to_worktree_map, worktree_hashmap_cmpfnc, NULL, 0);
> +
> +	for (i = 0; worktrees[i]; i++) {
> +		if (worktrees[i]->head_ref) {
> +			struct ref_to_worktree_entry *entry;
> +			entry = xmalloc(sizeof(*entry));
> +			entry->wt = worktrees[i];
> +			hashmap_entry_init(entry, strhash(worktrees[i]->head_ref));
> +
> +			hashmap_add(&ref_to_worktree_map, entry);
> +		}
> +	}

Makes sense to load the map.

> +static const char *get_worktree_path(const struct used_atom *atom, const struct ref_array_item *ref)
> +{
> +	struct strbuf val = STRBUF_INIT;
> +	struct hashmap_entry entry;
> +	struct ref_to_worktree_entry *lookup_result;
> +
> +	hashmap_entry_init(&entry, strhash(ref->refname));
> +	lookup_result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname);
> +
> +	strbuf_addstr(&val, lookup_result ? lookup_result->wt->path : "");
> +
> +	return strbuf_detach(&val, NULL);
> +}

And that makes sense to look up an item in it. Good.

Adding an empty string to a strbuf is a noop, so that part might more
clearly be written as just:

  if (lookup_result)
	strbuf_addstr(&val, lookup_result->wt->path);

We return a "const char *" here, but the result is always allocated. Do
we leak the result? Or should this return a "char *"?

I think there are a lot of other atoms that leak currently, but that is
being fixed in another topic that is currently in pu.

> @@ -2020,6 +2085,11 @@ void ref_array_clear(struct ref_array *array)
>  		free_array_item(array->items[i]);
>  	FREE_AND_NULL(array->items);
>  	array->nr = array->alloc = 0;
> +	if (has_worktree)
> +	{
> +		hashmap_free(&ref_to_worktree_map, 1);
> +		free_worktrees(worktrees);
> +	}

Here we free everything, but we don't unset has_worktree. So anybody
trying to format more refs afterward would see our freed worktree list.

We probably want:

  has_worktree = 0;

here. Or simpler still, I think get_worktrees() will always return a
non-NULL list (even if it is empty). So you could just drop has_worktree
entirely, and use:

  if (worktrees)
	return; /* already loaded */;

in the loading function, and:

  free_worktrees(worktrees);
  worktrees = NULL;

here.

> +test_expect_success '"add" a worktree' '
> +	mkdir worktree_dir &&
> +	git worktree add -b master_worktree worktree_dir master
> +'
> +
> +test_expect_success 'validate worktree atom' '
> +	{
> +	echo master: $PWD &&
> +	echo master_worktree: $PWD/worktree_dir &&
> +	echo side: not checked out
> +	} > expect &&

Minor style nit: use "} >expect" without the extra space.

This checks the actual directories. Good. I can never remember the rules
for when to use $PWD versus $(pwd) on Windows. We may run afoul of the
distinction here.

-Peff
