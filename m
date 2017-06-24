Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2EA520401
	for <e@80x24.org>; Sat, 24 Jun 2017 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbdFXOTo (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 10:19:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751313AbdFXOTo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 10:19:44 -0400
Received: (qmail 7294 invoked by uid 109); 24 Jun 2017 14:19:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 24 Jun 2017 14:19:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24045 invoked by uid 111); 24 Jun 2017 14:19:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 24 Jun 2017 10:19:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jun 2017 10:19:41 -0400
Date:   Sat, 24 Jun 2017 10:19:41 -0400
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170624141941.usy2pyhid3jrf3ku@sigill.intra.peff.net>
References: <20170601082203.50397-1-larsxschneider@gmail.com>
 <20170601082203.50397-6-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170601082203.50397-6-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 10:22:03AM +0200, Lars Schneider wrote:

> Some `clean` / `smudge` filters might require a significant amount of
> time to process a single blob (e.g. the Git LFS smudge filter might
> perform network requests). During this process the Git checkout
> operation is blocked and Git needs to wait until the filter is done to
> continue with the checkout.
> 
> Teach the filter process protocol (introduced in edcc858) to accept the
> status "delayed" as response to a filter request. Upon this response Git
> continues with the checkout operation. After the checkout operation Git
> calls "finish_delayed_checkout" which queries the filter for remaining
> blobs. If the filter is still working on the completion, then the filter
> is expected to block. If the filter has completed all remaining blobs
> then an empty response is expected.
> 
> Git has a multiple code paths that checkout a blob. Support delayed
> checkouts only in `clone` (in unpack-trees.c) and `checkout` operations.

It might be worth giving a reason in this last paragraph. I think the
reason is "because it's more complicated for the caller, as they have to
be OK with out-of-order processing and remembering to go back and handle
the delayed cases".

Speaking of which, _are_ we OK with out-of-order processing in things
like checkout? Certainly we care about deleting items before checking
out new ones (so getting rid of "foo/bar" to make room for "foo" and
vice versa).  I guess it's OK as long as the delayed items are always
filters that check out new items.

> +Delay
> +^^^^^
> +
> +If the filter supports the "delay" capability, then Git can send the
> +flag "can-delay" after the filter command and pathname. This flag
> +denotes that the filter can delay filtering the current blob (e.g. to
> +compensate network latencies) by responding with no content but with
> +the status "delayed" and a flush packet.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> can-delay=1
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +packet:          git< status=delayed
> +packet:          git< 0000
> +------------------------

OK, so the client has to opt into delay for each entry. Makes sense.

> +If the filter supports the "delay" capability then it must support the
> +"list_available_blobs" command. If Git sends this command, then the
> +filter is expected to return a list of pathnames of blobs that are
> +available. The list must be terminated with a flush packet followed
> +by a "success" status that is also terminated with a flush packet. If
> +no blobs for the delayed paths are available, yet, then the filter is
> +expected to block the response until at least one blob becomes
> +available. The filter can tell Git that it has no more delayed blobs
> +by sending an empty list.
> +------------------------
> +packet:          git> command=list_available_blobs
> +packet:          git> 0000
> +packet:          git< pathname=path/testfile.dat
> +packet:          git< pathname=path/otherfile.dat
> +packet:          git< 0000
> +packet:          git< status=success
> +packet:          git< 0000
> +------------------------

Earlier I proposed just having the client ask "give me something that's
ready". This introduces an extra round-trip to say "show me what's
ready" and ask for it. But I think that's OK, as it should be a local
process running over a pipe. The important thing is that the client is
able to always fetch without blocking when something is ready, and to
block when nothing is ready, which this does. Good.

> +After Git received the pathnames, it will request the corresponding
> +blobs again. These requests contain a pathname and an empty content
> +section. The filter is expected to respond with the smudged content
> +in the usual way as explained above.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> 0000
> +packet:          git> 0000  # empty content!
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000  # empty list, keep "status=success" unchanged!
> +------------------------

Out of curiosity, what should happen if we re-ask for a pathname that
wasn't mentioned in list_available_blobs? I guess it would depend on the
filter implementation, but probably most would just block (since we
wouldn't have asked for can-delay). The other option is returning an
error, I suppose, but blocking and filling the request sounds
friendlier.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a6b2af39d3..c1a256df8d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -376,6 +376,8 @@ static int checkout_paths(const struct checkout_opts *opts,
>  	state.force = 1;
>  	state.refresh_cache = 1;
>  	state.istate = &the_index;
> +
> +	enable_delayed_checkout(&state);
>  	for (pos = 0; pos < active_nr; pos++) {
>  		struct cache_entry *ce = active_cache[pos];
>  		if (ce->ce_flags & CE_MATCHED) {
> @@ -390,6 +392,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  			pos = skip_same_name(ce, pos) - 1;
>  		}
>  	}
> +	errs |= finish_delayed_checkout(&state);

The changes to the caller here are satisfyingly small.

> diff --git a/cache.h b/cache.h
> index ae4c45d379..523ead1d95 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1543,16 +1543,20 @@ extern int ident_cmp(const struct ident_split *, const struct ident_split *);
>  struct checkout {
>  	struct index_state *istate;
>  	const char *base_dir;
> +	struct delayed_checkout *delayed_checkout;
>  	int base_dir_len;

Should base_dir_len and base_dir be kept together?

I suspect you ordered it this way because...

>  	unsigned force:1,
>  		 quiet:1,
>  		 not_new:1,
>  		 refresh_cache:1;
>  };
> -#define CHECKOUT_INIT { NULL, "" }
> +#define CHECKOUT_INIT { NULL, "", NULL }
> +

...you wanted to add the NULL to the initializer here. But it's not
necessary. Once one element of a struct is initialized, all the
remaining members are initialized according to the usual static rules
(so NULL for pointers). We're already using that to zero out
base_dir_len and the flags (the "" is necessary because we want a real
empty string, not NULL).

Since you want NULL for your new member, you can just leave the
initializer as-is and it will do the right thing.

> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  	if (err)
>  		goto done;
>  
> -	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
> +	err = packet_writel(process->in,
> +		"capability=clean", "capability=smudge", "capability=delay", NULL);

Why do we need to tell the filter we know about delay? Shouldn't it just
need to tell us that it knows about delay, and then we choose whether to
ask for can-delay for particular entries?

> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> +	if (CAP_DELAY & entry->supported_capabilities &&
> +	    dco && dco->state == CE_CAN_DELAY) {

In a complicated conditional with bit operations, we usually put the bit
operation in its own parentheses so it's more obvious that it wasn't
supposed to be "&&". Like:

  if ((CAP_DELAY & entry->supported_capabilities) &&
      dco && dco->state == CE_CAN_DELAY))

The operator precedence is such that it works without them, so this is
just a style question (I'd also usually put the flags field before the
flag itself, but that's really getting into aesthetics).

The dco check here is basically asking if can-delay is enabled for the
whole checkout. Would we ever need to mark a specific entry as
not-delayable? Probably not from the start, but I wondered if something
might get marked as a failure and need to be retried without delay or
similar. It's probably not worth going down that road until some caller
needs it.

> @@ -662,14 +676,78 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> -	err = strcmp(filter_status.buf, "success");
> +	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
> +		dco->state = CE_DELAYED;
> +		string_list_insert(&dco->filters, cmd);
> +		string_list_insert(&dco->paths, path);

These string_list_insert()s have bad worst-case performance, because
they keep the list sorted. So the worst case is reverse-sorted input,
where each entry goes at the front of the existing array and we have to
memmove() the whole array on each insert, and we do O(n^2) byte copies.

The best case is when the input is already sorted. And I think in
general that's how we'll iterate over paths to checkout. The cmds are
more likely to be random, but we're also not likely to have more than a
handful of them. So this is probably an OK data structure to use, at
least for now.

> +	for (;;) {
> +		const char* pre = "pathname=";
> +		const int pre_len = strlen(pre);
> +		line = packet_read_line(process->out, NULL);
> +		if (!line)
> +			break;
> +		err = strlen(line) <= pre_len || strncmp(line, pre, pre_len);
> +		if (err)
> +			goto done;
> +		string_list_insert(delayed_paths, xstrdup(line+pre_len));
> +	}

I think the prefix matching can be done more simply (and slightly more
efficiently) with:

  const char *path;
  ...
  err = !skip_prefix(line, "pathname=", &path);
  if (err)
	goto done;
  string_list_insert(delayed_paths, xstrdup(path));

I notice we loop here, though. Would we want to be resilient to seeing
other keys besides pathname? Something like:

  while ((line = packet_read_line(process->out, NULL)) {
	const char *path;
	if (skip_prefix(line, "pathname=", &path))
		string_list_insert(delayed_paths, xstrdup(path);
	else
		; /* ignore unknown keys */
  }

I can imagine some future where the filter passes back additional
information about the delayed item. It would be nice if older versions
of Git would just quietly ignore that if they don't know how to handle
it.

> +int finish_delayed_checkout(struct checkout *state)
> +{
> +	int errs = 0;
> +	struct string_list_item *filter, *path;
> +	struct delayed_checkout *dco = state->delayed_checkout;
> +
> +	if (!state->delayed_checkout) {
> +		return errs;
> +	}

Style: we'd usually omit the braces here.

> +			if (available_paths.nr <= 0) {
> +				/* Filter responded with no entries. That means
> +				   the filter is done and we can remove the
> +				   filter from the list (see
> +				   "string_list_remove_empty_items" call below).
> +				*/

This is true because we know the filter would block until it had at
least one item to return.

It does seem to put a lot of faith in the filter. What happens if we hit
this conditional and we know that we still have entries in dco->paths to
be handled?

> +			/* In dco->paths we store a list of all delayed paths.
> +			   The filter just send us a list of available paths.
> +			   Remove them from the list.
> +			*/
> +			filter_string_list(&dco->paths, 0,
> +				&remove_available_paths, &available_paths);

This is O(m log n), which is fine. Since both lists are sorted, we could
technically do it in an O(m+n) merge, but I don't think we have a
function to do that easily.

Sorry to harp on run-times, but it's one place I think it would be easy
to subtly screw this up, so I'm trying to pay close attention.

> +			for_each_string_list_item(path, &available_paths) {
> +				struct cache_entry* ce = index_file_exists(
> +					state->istate, path->string,
> +					strlen(path->string), 0);
> +				dco->state = CE_RETRY;
> +				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
> +			}

So once we know something is available, we try again. Which makes sense.
We presumably set dco->state to retry here so that we don't re-ask for
it to be delayed. I guess that sort-of answers my earlier question about
per-entry state. We just use the dco->state as a big hammer. It gets
set to retry on the first time through the loop, and then that applies
to everything for the rest of the checkout. But since we do all of the
initial requests in a single pass, followed by all delayed-resolution in
a second pass, that works fine.

> +	/* At this point we should not have any delayed paths anymore. */
> +	errs |= dco->paths.nr;

And I guess this answers my question above about a filter with no
entries. When we bail from the loop, we'll hit this point and complain.

We probably should call string_list_clear(&dco->paths) here to avoid
leaking the paths on error (possibly we should also print them? Or maybe
they'd be warned about elsewhere).

> @@ -179,11 +254,36 @@ static int write_entry(struct cache_entry *ce,
>  		/*
>  		 * Convert from git internal format to working tree format
>  		 */
> -		if (ce_mode_s_ifmt == S_IFREG &&
> -		    convert_to_working_tree(ce->name, new, size, &buf)) {
> -			free(new);
> -			new = strbuf_detach(&buf, &newsize);
> -			size = newsize;
> +		if (ce_mode_s_ifmt == S_IFREG) {
> +			struct delayed_checkout *dco = state->delayed_checkout;
> +			if (dco && dco->state != CE_NO_DELAY) {
> +				/* Do not send the blob in case of a retry. */
> +				if (dco->state == CE_RETRY) {
> +					new = NULL;
> +					size = 0;
> +				}
> +				ret = async_convert_to_working_tree(
> +					ce->name, new, size, &buf, dco);
> +				if (ret && dco->state == CE_DELAYED) {
> +					free(new);
> +					/* Reset the state of the next blob */
> +					dco->state = CE_CAN_DELAY;
> +					goto finish;
> +				}

Hmm. This "reset the state" bit at the end surprised me. I guess it's
not wrong, but it goes against the mental model I had formed above. ;)

We really are using dco->state as a per-entry state flag. It just
happens to be in a persistent shared struct. I don't think it's wrong,
it was mostly just surprising. I don't know if it's worth trying to
simplify, but I think you could do it by:

  1. Passing back the "was delayed" state from async_convert... in the
     return value or via a separate out-parameter.

  2. Setting dco->state to CE_RETRY at the top of finish_delayed... so
     that it's clear that it's about what phase of the conversation
     we're in.

But I'm OK with it as-is, too.

> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index 5e43faeec1..f0dc0aff4a 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl

I'll admit to skimming the perl changes here, but I didn't see anything
obviously wrong.

-Peff
