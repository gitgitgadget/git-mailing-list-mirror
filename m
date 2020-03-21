Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F41C4332E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D82D20753
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 05:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HpTDvWVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgCUFB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 01:01:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62729 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCUFB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 01:01:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC20A44756;
        Sat, 21 Mar 2020 01:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kkYMEs0V9tzCxTaaQCtiCY4dRGQ=; b=HpTDvW
        VUnzf1YNvr1aba/SOSNA8cKhx5UNGrafusOhs0Il/1rchnrfd/y7bvENgSRDV2Z+
        Bc4AdDf9jPFjVs0oQy4TNphuqSz9+INgex2F9ZZNm3yYmnTZJWYswI7BXAnF9mbF
        782CanNxWfcPwgElcTNG9EqJ3/YQ2keipt93o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bU+EYvYzLmtibpS5oc4dxJMama/VwleE
        r/EdypcMI4t1PNvCH3fD83hAzhd+7QTECpWTWhmQRo1z6VHBtreEaJnDSfW2BObe
        ugDtCNkwJ8WukYu4zkHyoo6sXBnZw76DWQrONEw4J6XtbDoV+J82Qrx4rKTqguGR
        lGcQh7QvUPU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C132744755;
        Sat, 21 Mar 2020 01:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 46DB144754;
        Sat, 21 Mar 2020 01:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH 1/1] commit-graph.c: avoid unnecessary tag dereference when merging
References: <cover.1584762087.git.me@ttaylorr.com>
        <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
Date:   Fri, 20 Mar 2020 22:01:54 -0700
In-Reply-To: <4c79a9ea909ebff8c0987bcf95692da92e79bda4.1584762087.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 20 Mar 2020 21:44:23 -0600")
Message-ID: <xmqqk13e9u7x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15E3F93E-6B31-11EA-BD74-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When performing a 'git commit-graph write' with '--split', the
> commit-graph machinery calls 'merge_commit_graph()' after deciding on a
> split strategy to optionally clean up any existing commit-graph
> layers that were made obsolete by the split strategy [1].
>
> At this time, 'merge_commit_graph()' checks each commit that it writes
> into the merged graph to make sure that it still exists in the object
> store.
>
> To do this, it uses 'lookup_commit_reference_gently()', which accepts
> either a commit object, or a tag that refers to a commit. However, since
> all 'oid' arguments passed to this function are from within the
> commit-graphs being merged, we never pass a commit reference, and so any
> time we spend in 'deref_tag()' is wasted.

Ahh, so my question on the cover letter was utterly off the mark.
It is that feeding a commit to deref_tag() is unneeded.  It is quite
surprising to hear that deref_tag() call is _so_ expensive that it
wastes 7% of the total cycles.

The patch itself looks good.

Thanks.


>  	for (i = 0; i < g->num_commits; i++) {
>  		struct object_id oid;
> -		struct commit *result;
> +		struct commit *result = NULL;
>  
>  		display_progress(ctx->progress, i + 1);
>  
>  		load_oid_from_graph(g, i + offset, &oid);
>  
>  		/* only add commits if they still exist in the repo */
> -		result = lookup_commit_reference_gently(ctx->r, &oid, 1);
> +		if (repo_has_object_file(ctx->r, &oid)) {
> +			result = lookup_commit(ctx->r, &oid);
> +			if (repo_parse_commit(ctx->r, result))
> +				result = NULL;
> +		}
>  
>  		if (result) {
>  			ctx->commits.list[ctx->commits.nr] = result;
