Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B539AC54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 866112074F
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 21:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tElvZL6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDWVhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:37:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60889 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgDWVhA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 17:37:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B314CDB78;
        Thu, 23 Apr 2020 17:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+2FLjOdVxt+FKZ+qLgtQpWiM66E=; b=tElvZL
        6NAcQSHfj0HLUu8ww0EAL5IglCpb0dx51UByabRGb6rtdzmgS4XD5VRnah/QWM9e
        heU3WoA1qOvJlkuQxT/wjB0gqljF4Pj4ttvN+hdCatwzyjzD3wOOC74hra15yBmQ
        gN3wL5WEMDHmRUrUm/ZVDI0HUYUHfVnkjx8Xs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wICiVfjTqx7vhmN0LmXeFcBFw+SwKY//
        gfvZy7YUWGpVvyF+5ItoKLTd7w8Zy8qA1HYCAr8R3MNRifeBCOcyKY9hV1rUNNpn
        SbruZYM4WnE/vIcq/vPgHAB2FUkCvvxmRufwsTYYphw8wBFlc/Mp0l7tuiLnZ4wz
        LXg6guTx/6s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4B1E7CDB77;
        Thu, 23 Apr 2020 17:36:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 91421CDB76;
        Thu, 23 Apr 2020 17:36:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] blame: drop unused parameter from maybe_changed_path
References: <20200423210303.GA1635761@coredump.intra.peff.net>
Date:   Thu, 23 Apr 2020 14:36:53 -0700
In-Reply-To: <20200423210303.GA1635761@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 23 Apr 2020 17:03:03 -0400")
Message-ID: <xmqqk125g9ze.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8DAD6174-85AA-11EA-B67E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We don't use the "parent" parameter at all (probably because the bloom
> filter for a commit is always defined against a single parent anyway).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is on top of ds/blame-on-bloom, which just made it to next.
>
> I _think_ this is the right solution, but perhaps the function should be
> verifying that we're looking at the right parent?

Hmph, "solution" to what problem?  Ah, the fact that parent is an
unused parameter?

find_origin() runs a tree-diff over "parent" and "origin->commit",
with literal pathspec limited to the single path.

And the Bloom filter addition changed the code so that we first
consult the filter when "origin->commit"'s first parent *is*
"parent".  Presumably, by asking maybe_changed_path about "origin",
as "origin" knows what the commit is (i.e. "origin->commit") and
what path we are talking about (i.e. "origin->path"), it can answer
"does origin->commit change origin->path relative to its first
parent?" and it can do so only for the first parent?

The way I read bloom.c::get_bloom_filter(), it only computes a
diff-tree between the given commit and its first parent (or an empty
tree), so I think the above is correct.

Thanks.

>
>  blame.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/blame.c b/blame.c
> index 9fbf79e47c..da7e28800e 100644
> --- a/blame.c
> +++ b/blame.c
> @@ -1263,7 +1263,6 @@ struct blame_bloom_data {
>  static int bloom_count_queries = 0;
>  static int bloom_count_no = 0;
>  static int maybe_changed_path(struct repository *r,
> -			      struct commit *parent,
>  			      struct blame_origin *origin,
>  			      struct blame_bloom_data *bd)
>  {
> @@ -1355,8 +1354,7 @@ static struct blame_origin *find_origin(struct repository *r,
>  		if (origin->commit->parents &&
>  		    !oidcmp(&parent->object.oid,
>  			    &origin->commit->parents->item->object.oid))
> -			compute_diff = maybe_changed_path(r, parent,
> -							  origin, bd);
> +			compute_diff = maybe_changed_path(r, origin, bd);
>  
>  		if (compute_diff)
>  			diff_tree_oid(get_commit_tree_oid(parent),
