Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 482F41F437
	for <e@80x24.org>; Fri, 27 Jan 2017 23:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdA0Xbm (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 18:31:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54085 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750757AbdA0Xbk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 18:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E668164C58;
        Fri, 27 Jan 2017 18:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DIB02FMSxDd386foN6n5lVrOJ9U=; b=lQ8Fw8
        po5CriqVmZrNyUxUbW/sz+VC89DgTuT/NItoulLEtAQOo7F8GTrMbAM2VQib9w/4
        JrShdSsoNfkzn25pVAmcO5htpgXLk+55lQFW7kZhrpt5glHQJtBUMGHEbrhgg+F+
        0o2WeL9MK4Pvig2aWlPionmozKS7+oASx7IuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QoazazdlpYJQdtsZkkvuhRtEHmKl7adT
        cVZVer+niVbAHc/E7OKDEs1RjV2/DYQsZeAn0fFw4WM+z1ptwupbaHuPVL+smoV7
        mg9w9yCOVHq4RX6aVPdscvGe5NKxP/YzzUB6rxhCW4eZ6RaTjysEvJlC3Mitlfg+
        3iWlUWkiflo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DEBEE64C57;
        Fri, 27 Jan 2017 18:31:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02A6264C56;
        Fri, 27 Jan 2017 18:31:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] pack-objects: enforce --depth limit in reused deltas
References: <20170127220143.boo5phhgogqlucsj@sigill.intra.peff.net>
        <20170127220233.mwg36mgxdklwz7lr@sigill.intra.peff.net>
Date:   Fri, 27 Jan 2017 15:31:36 -0800
In-Reply-To: <20170127220233.mwg36mgxdklwz7lr@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 27 Jan 2017 17:02:33 -0500")
Message-ID: <xmqqinp0xep3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BFA656E2-E4E8-11E6-B235-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Since 898b14c (pack-objects: rework check_delta_limit usage,
> 2007-04-16), we check the delta depth limit only when
> figuring out whether we should make a new delta. We don't
> consider it at all when reusing deltas, which means that
> packing once with --depth=250, and then again with
> --depth=50, the second pack my still contain chains larger
> than 50.

"may still contain", methinks.

> ...
>
> This patch bounds the length of delta chains in the output
> pack based on --depth, regardless of whether they are caused
> by cross-pack deltas or existed in the input packs. This
> fixes the problem, but does have two possible downsides:
>
>   1. High-depth aggressive repacks followed by "normal"
>      repacks will throw away the high-depth chains.

I actually think it is a feature that the normal one that runs later
is allowed to fix an over-deep delta chain.

>   2. If you really do want to store high-depth deltas on
>      disk, they may be discarded and new delta computed when
>      serving a fetch, unless you set pack.depth to match
>      your high-depth size.

Likewise.

> ... But we may
> visit an object through multiple delta paths, ...

Yes, good thinking.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 8841f8b36..2b08c8121 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1539,6 +1539,8 @@ static int pack_offset_sort(const void *_a, const void *_b)
>   *   2. Updating our size/type to the non-delta representation. These were
>   *      either not recorded initially (size) or overwritten with the delta type
>   *      (type) when check_object() decided to reuse the delta.
> + *
> + *   3. Resetting our delta depth, as we are now a base object.
>   */
>  static void drop_reused_delta(struct object_entry *entry)
>  {
> @@ -1552,6 +1554,7 @@ static void drop_reused_delta(struct object_entry *entry)
>  			p = &(*p)->delta_sibling;
>  	}
>  	entry->delta = NULL;
> +	entry->depth = 0;
>  
>  	oi.sizep = &entry->size;
>  	oi.typep = &entry->type;

Makes sense.

>  static void break_delta_chains(struct object_entry *entry)
>  {
> @@ -1587,6 +1593,18 @@ static void break_delta_chains(struct object_entry *entry)
>  		 */
>  		entry->dfs_state = DFS_ACTIVE;
>  		break_delta_chains(entry->delta);
> +
> +		/*
> +		 * Once we've recursed, our base (if we still have one) knows
> +		 * its depth, so we can compute ours (and check it against
> +		 * the limit).
> +		 */
> +		if (entry->delta) {
> +			entry->depth = entry->delta->depth + 1;
> +			if (entry->depth > depth)
> +				drop_reused_delta(entry);
> +		}

;-)  Surprisingly simpple and effective.

> diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
> new file mode 100755
> index 000000000..236d60fe6
> --- /dev/null
> +++ b/t/t5316-pack-delta-depth.sh
> @@ -0,0 +1,93 @@
> +#!/bin/sh
> +
> +test_description='pack-objects breaks long cross-pack delta chains'
> +. ./test-lib.sh
> +
> +# This mirrors a repeated push setup:
> +#
> +# 1. A client repeatedly modifies some files, makes a
> +#      commit, and pushes the result. It does this N times
> +#      before we get around to repacking.
> +#
> +# 2. Each push generates a thin pack with the new version of
> +#    various objects. Let's consider some file in the root tree
> +#    which is updated in each commit.
> +#
> +#    When generating push number X, we feed commit X-1 (and
> +#    thus blob X-1) as a preferred base. The resulting pack has
> +#    blob X as a thin delta against blob X-1.
> +#
> +#    On the receiving end, "index-pack --fix-thin" will
> +#    complete the pack with a base copy of tree X-1.

blob? tree? I think the argument would work the same way for either
type of objects, but the previous paragraph is using blob as the
example, so s/tree/blob/ here?

> +# 3. In older versions of git, if we used the delta from
> +#    pack X, then we'd always find blob X-1 as a base in the
> +#    same pack (and generate a fresh delta).
> +#
> +#    But with the pack mru, we jump from delta to delta
> +#    following the traversal order:
> +# ...
> +# Now we have blob X as a delta against X-1, which is a delta
> +# against X-2, and so forth.

> +# Note that this whole setup is pretty reliant on the current
> +# packing heuristics. We double-check that our test case
> +# actually produces a long chain. If it doesn't, it should be
> +# adjusted (or scrapped if the heuristics have become too unreliable)

IOW, we want something that says "we first check X and if X still
holds, then we expect Y to also hold; if X no longer hold, do not
bother to test that Y holds".  Nice food for thought.  Perhaps we
want a way to express that in our test framework, or is X in the
above merely another way to say "prerequisite"?

> +test_expect_success 'packing produces a long delta' '
> +	# Use --window=0 to make sure we are seeing reused deltas,
> +	# not computing a new long chain.
> +	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
> +	test 9 = "$(max_chain pack-$pack.pack)"
> +'
> +
> +test_expect_success '--depth limits depth' '
> +	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
> +	test 5 = "$(max_chain pack-$pack.pack)"
> +'
> +
> +test_done
