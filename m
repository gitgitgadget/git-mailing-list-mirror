Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C34F1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeLRRWk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:22:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:45090 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726812AbeLRRWj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:22:39 -0500
Received: (qmail 998 invoked by uid 109); 18 Dec 2018 17:22:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 17:22:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14922 invoked by uid 111); 18 Dec 2018 17:22:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 12:22:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 12:22:37 -0500
Date:   Tue, 18 Dec 2018 12:22:37 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v3 1/3] ref-filter: add worktreepath atom
Message-ID: <20181218172236.GA28455@sigill.intra.peff.net>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
 <20181216215759.24011-2-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216215759.24011-2-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 01:57:57PM -0800, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> Add an atom proving the path of the linked worktree where this ref is
> checked out, if it is checked out in any linked worktrees, and empty
> string otherwise.

I stumbled over the word "proving" here. Maybe "showing" would be more
clear?

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 901faef1bf..9590f7beab 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -209,6 +209,10 @@ symref::
>  	`:lstrip` and `:rstrip` options in the same way as `refname`
>  	above.
>  
> +worktreepath::
> +	The absolute path to the worktree in which the ref is checked
> +	out, if it is checked out in any linked worktree. ' ' otherwise.
> +

Normally single-quotes are used in asciidoc to emphasize text, and the
quotes aren't passed through. Asciidoc (and asciidoctor) do seem to
render the literal quotes here, which is good. I wonder if it would be
more clear to just write it out, though, like:

  ...any linked worktree. Otherwise, replaced with a single space.

Also, why are we replacing it with a single space? Wouldn't the empty
string be more customary (and work with the other "if empty, then do
this" formatting options)?

> @@ -34,6 +36,8 @@ static struct ref_msg {
>  	"ahead %d, behind %d"
>  };
>  
> +static struct worktree ** worktrees;

Minor style nit: we put the "*" in a pointer declaration next to the
variable name, without intervening whitespace. Like:

  static struct worktree **worktrees;

> @@ -75,6 +79,12 @@ static struct expand_data {
>  	struct object_info info;
>  } oi, oi_deref;
>  
> +struct reftoworktreeinfo_entry {
> +    struct hashmap_entry ent; // must be the first member!
> +    char * ref; // key into map
> +    struct worktree * wt;
> +};

A few style nits:

  - the "*" space thing from above (it's in other places below, too, but
    I won't point out each)

  - we prefer "/* */" comments, even for single-liners

  - since we do all-lowercase identifiers, use more underscores to break
    things up. E.g., ref_to_worktree_entry.

Here we store the refname as a separate variable, but then point to the
worktree itself to access wt->path. Why do we treat these differently?
I.e., I'd expect to see either:

  1. Each entry holding a single worktree object, and using its head_ref
     and path fields, like:

       struct ref_to_worktree_entry {
               struct hashmap_entry ent; /* must be first */
	       struct worktree *wt;
       };
       ....
       entry = xmalloc(sizeof(*entry));
       entry->wt = wt;
       hashmap_entry_init(entry, strhash(wt->head_ref));
       ...
       strbuf_addstr(&out, result->wt->path);


  2. Each entry containing just the bits it needs, like:

       struct ref_to_worktree_entry {
               struct hashmap_entry ent; /* must be first */
	       char *ref;
	       char *path;
       };
       ...
       /*
        * We could use FLEXPTR_ALLOC_STR() here, but it doesn't actually
	* support holding _two_ strings. Separate allocations probably
	* aren't a huge deal here, since there are only a handful of
	* worktrees.
	*/
       entry = xmalloc(sizeof(*entry));
       entry->ref = wt->head_ref;
       entry->path = wt->path;
       hashmap_entry_init(entry, strhash(entry->ref));
       ...
       strbuf_addstr(&out, result->path);


I think the first one is strictly preferable unless we're worried about
the lifetime of the "struct worktree" going away. I don't think that's
an issue, though; they are ours until we call free_worktrees().

> @@ -114,6 +124,7 @@ static struct used_atom {
>  		} objectname;
>  		struct refname_atom refname;
>  		char *head;
> +		struct hashmap reftoworktreeinfo_map;
>  	} u;
>  } *used_atom;

This uses one map for each %(worktree) we use. But won't they all be the
same? It would ideally be associated with the ref-filter.  There's no
ref-filter context struct to hold this kind of data, just static globals
in ref-filter.c (including this used_atom struct!). That's something
we'll probably need to fix in the long run, but I think it would be
reasonable to just have:

  static struct hashmap ref_to_worktree_map;

next to the declaration of used_atom_cnt, need_symref, etc. And then
those can all eventually get moved into a struct together.

> @@ -461,6 +497,7 @@ static struct {
>  	{ "flag", SOURCE_NONE },
>  	{ "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
>  	{ "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
> +	{ "worktreepath", SOURCE_NONE, FIELD_STR, worktree_atom_parser },
>  	{ "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
>  	{ "end", SOURCE_NONE },
>  	{ "if", SOURCE_NONE, FIELD_STR, if_atom_parser },

Marking as SOURCE_NONE makes sense.

> +static const char * get_worktree_info(const struct used_atom *atom, const struct ref_array_item *ref)
> +{
> +	struct strbuf val = STRBUF_INIT;
> +	struct reftoworktreeinfo_entry * entry;
> +	struct reftoworktreeinfo_entry * lookup_result;
> +
> +	FLEXPTR_ALLOC_STR(entry, ref, ref->refname);
> +	hashmap_entry_init(entry, strhash(entry->ref));
> +	lookup_result = hashmap_get(&(atom->u.reftoworktreeinfo_map), entry, NULL);
> +	free(entry);

We shouldn't need to do an allocation just for a lookup. That's what the
extra "keydata" parameter is for in the comparison function. And I guess
this is what led you to have "char *ref" in the struct, rather than
reusing wt->head_ref (because you don't have a "struct worktree" here).

You should be able to do it like this:

  struct hashmap_entry entry;
  struct ref_to_worktree_entry *result;

  hashmap_entry_init(entry, strhash(ref->refname));
  result = hashmap_get(&ref_to_worktree_map, &entry, ref->refname));
  ...

and then your comparison function would look like this:

  int ref_to_worktree_hashcmp(const void *data,
                              const void *entry,
			      const void *entry_or_key,
			      const void *keydata)
  {
          const struct ref_to_worktree_entry *a = entry;
          const struct ref_to_worktree_entry *b = entry;
	  if (keydata)
	          return strcmp(a->wt->head_ref, keydata);
	  else
	          return strcmp(a->wt->head_ref, b->wt->head_ref);
  }

If you're thinking that this API is totally confusing and hard to figure
out, I agree. It's optimized to avoid extra allocations. I wish we had a
better one for simple cases (especially string->string mappings like
this).

Speaking of comparison functions, I didn't see one in your patch. Don't
you need to pass one to hashmap_init?

> +	if (lookup_result)
> +	{
> +		if (!strncmp(atom->name, "worktreepath", strlen(atom->name)))
> +			strbuf_addstr(&val, lookup_result->wt->path);
> +	}
> +	else
> +		strbuf_addstr(&val, " ");

What's this extra strncmp about? If we're _not_ a worktreepath atom,
we'd still do the lookup only to put nothing in the string?

I think we'd only call this function when populate_value() sees a
worktreepath atom, though:

> @@ -1537,6 +1596,10 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>  
>  		if (starts_with(name, "refname"))
>  			refname = get_refname(atom, ref);
> +		else if (starts_with(name, "worktreepath")) {
> +			v->s = get_worktree_info(atom, ref);
> +			continue;
> +		}

So it would be OK to drop the check of atom->name again inside
get_worktree_info().

> @@ -2013,7 +2076,14 @@ void ref_array_clear(struct ref_array *array)
>  	int i;
>  
>  	for (i = 0; i < used_atom_cnt; i++)
> +	{
> +		if (!strncmp(used_atom[i].name, "worktreepath", strlen("worktreepath")))
> +		{
> +			hashmap_free(&(used_atom[i].u.reftoworktreeinfo_map), 1);
> +			free_worktrees(worktrees);
> +		}

And if we move the mapping out to a static global, then this only has to
be done once, not once per atom. In fact, I think this could double-free
"worktrees" with your current patch if you have two "%(worktree)"
placeholders, since "worktrees" already is a global.

> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fc067ed672..add70a4c3e 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -441,4 +441,19 @@ test_expect_success '--merged is incompatible with --no-merged' '
>  	test_must_fail git for-each-ref --merged HEAD --no-merged HEAD
>  '
>  
> +test_expect_success '"add" a worktree' '
> +	mkdir worktree_dir &&
> +	git worktree add -b master_worktree worktree_dir master
> +'
> +
> +test_expect_success 'validate worktree atom' '
> +	cat >expect <<-\EOF &&
> +	master: checked out in a worktree
> +	master_worktree: checked out in a worktree
> +	side: not checked out in a worktree
> +	EOF
> +	git for-each-ref --format="%(refname:short): %(if)%(worktreepath)%(then)checked out in a worktree%(else)not checked out in a worktree%(end)" refs/heads/ >actual &&
> +	test_cmp expect actual
> +'

It's probably worth testing that the path we get is actually sane, too.
I.e., expect something more like:

   cat >expect <<-\EOF
   master: $PWD
   master: $PWD/worktree
   side: not checked out
   EOF
   git for-each-ref \
     --format="%(refname:short): %(if)%(worktreepath)%(then)%(worktreepath)%(else)not checked %out%(end)

(I wish there was a way to avoid that really long line, but I don't
think there is).

-Peff
