Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC7BEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGCF4s (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCF4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:56:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB2C2
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:56:29 -0700 (PDT)
Received: (qmail 9007 invoked by uid 109); 3 Jul 2023 05:56:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:56:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2303 invoked by uid 111); 3 Jul 2023 05:56:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:56:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:56:27 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 09/16] refs/packed-backend.c: implement jump lists to
 avoid excluded pattern(s)
Message-ID: <20230703055627.GF3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <386ed468fa7157e90f2f7324199a68974a7860cc.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <386ed468fa7157e90f2f7324199a68974a7860cc.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:42AM -0400, Taylor Blau wrote:

> Second, note that the jump list is best-effort, since we do not handle
> loose references, and because of the meta-character issue above. The
> jump list may not skip past all references which won't appear in the
> results, but will never skip over a reference which does appear in the
> result set.

I wonder if we should be advertising this in a docstring comment above
the relevant function. The problem may be that there are several such
functions. I just think that it's a gotcha that may affect somebody who
wants to call the function, and they're not going to think to dig up
this commit message.

>     $ hyperfine \
>       'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"' \
>       'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"'
>     Benchmark 1: git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"
>       Time (mean ± σ):     802.7 ms ±   2.1 ms    [User: 691.6 ms, System: 147.0 ms]
>       Range (min … max):   800.0 ms … 807.7 ms    10 runs
> 
>     Benchmark 2: git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"
>       Time (mean ± σ):       4.7 ms ±   0.3 ms    [User: 0.7 ms, System: 4.0 ms]
>       Range (min … max):     4.3 ms …   6.7 ms    422 runs
> 
>     Summary
>       'git.compile for-each-ref --format="%(objectname) %(refname)" --exclude="refs/pull"' ran
>       172.03 ± 9.60 times faster than 'git for-each-ref --format="%(objectname) %(refname)" | grep -vE "^[0-9a-f]{40} refs/pull/"'

This measurement is cheating a little, I think, because the earlier
patch to implement --exclude sped that up from ~800ms to ~100ms (because
we avoid writing and all of the ref-filter malloc slowness for the
excluded entries). So the better comparison is between two invocations
with "--exclude", but before/after this patch. You should still see a
20x speedup (100ms down to 5).

> @@ -802,14 +826,34 @@ struct packed_ref_iterator {
>   */
>  static int next_record(struct packed_ref_iterator *iter)
>  {
> -	const char *p = iter->pos, *eol;
> +	const char *p, *eol;
>  
>  	strbuf_reset(&iter->refname_buf);
>  
> +	/*
> +	 * If iter->pos is contained within a skipped region, jump past
> +	 * it.
> +	 *
> +	 * Note that each skipped region is considered at most once,
> +	 * since they are ordered based on their starting position.
> +	 */
> +	while (iter->jump_cur < iter->jump_nr) {
> +		struct jump_list_entry *curr = &iter->jump[iter->jump_cur];
> +		if (iter->pos < curr->start)
> +			break; /* not to the next jump yet */
> +
> +		iter->jump_cur++;
> +		if (iter->pos < curr->end) {
> +			iter->pos = curr->end;
> +			break;
> +		}
> +	}

It took me a minute to convince myself that this second "break" was
right. If we get to it, we know that iter->pos (the current record we
are looking at) is in the current jump region. So it makes sense to
advance to curr->end. But might we hit another jump region immediately?

I guess not, because earlier we would have coalesced the jump regions.
So either there is a non-excluded entry there _or_ we would have
coalesced the later region into a single larger region. So breaking is
the right thing to do.

> +	for (pattern = excluded_patterns; *pattern; pattern++) {
> +		struct jump_list_entry *e;
> +
> +		/*
> +		 * We can't feed any excludes with globs in them to the
> +		 * refs machinery.  It only understands prefix matching.
> +		 * We likewise can't even feed the string leading up to
> +		 * the first meta-character, as something like "foo[a]"
> +		 * should not exclude "foobar" (but the prefix "foo"
> +		 * would match that and mark it for exclusion).
> +		 */
> +		if (has_glob_special(*pattern))
> +			continue;

OK, and here's where we could split "foo[ac]" into "fooa" and "foob" if
we wanted. But I think it is a very good idea to leave that out of this
initial patch. :)

> +	/*
> +	 * As an optimization, merge adjacent entries in the jump list
> +	 * to jump forwards as far as possible when entering a skipped
> +	 * region.
> +	 *
> +	 * For example, if we have two skipped regions:
> +	 *
> +	 *	[[A, B], [B, C]]
> +	 *
> +	 * we want to combine that into a single entry jumping from A to
> +	 * C.
> +	 */
> +	last_disjoint = iter->jump;
> +
> +	for (i = 1, j = 1; i < iter->jump_nr; i++) {
> +		struct jump_list_entry *ours = &iter->jump[i];
> +
> +		if (ours->start == ours->end) {
> +			/* ignore empty regions (no matching entries) */
> +			continue;

Dropping empty regions makes sense, but our iteration starts at "1"
(because the rest of the checks are inherently looking at last_disjoint
before deciding if each region is worth keeping). So we'd fail to throw
away iter->jump[0] if it is empty, I think.

That could be fixed here by iterating from 0 and checking for a NULL
last_disjoint, but maybe it would be easier to avoid allocating at all
in the earlier loop, when we find that start == end?

> +		} else if (ours->start <= last_disjoint->end) {
> +			/* overlapping regions extend the previous one */
> +			last_disjoint->end = last_disjoint->end > ours->end
> +				? last_disjoint->end : ours->end;

OK, this covers both ([A,C],[B,D]) via "<" and ([A,B],[B,C]) via "=".
Good.

> +		} else {
> +			/* otherwise, insert a new region */
> +			iter->jump[j++] = *ours;
> +			last_disjoint = ours;
> +
> +		}

And this is the rest. Good. There's an extra blank line here before the
closing brace.

-Peff
