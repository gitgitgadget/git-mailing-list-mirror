Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5FA5211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 23:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeLEXPa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 18:15:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57796 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeLEXP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 18:15:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 438B8120158;
        Wed,  5 Dec 2018 18:15:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sXVZ10v2haPv1hBJq4pcPpZZEAY=; b=YxVetD
        o6YB4jpUJbxnLRdOVtsIKUrTI2Q9JSISZ4nGFVb/Ld0a9XTcGWUpXQU6JWlb3biK
        5zDHtmOLtf1nlcsU/tb378p47712l8A9HC2wQDTBIm6+UwruHPy175N/4xFJDmWi
        bUcTnLyykYe+KYoFOaQqZdxQSewFTEgeNrq5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uRPdGZz0pNI7kQIHjxs3eQxd23KaScLO
        Ghzj0kcflgA9yuHEply3Qdcl52YoRC9d+kXPuRhqO8ptef3mlCVbaY2rUTkMfbOI
        dEKKCx4B/qmKt7vP9mAB9u7fHcq0gXayB8SeV40bTFjOKQ/1FAcFROrHhLCApHXo
        3ZF1swmD8LI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C61C120157;
        Wed,  5 Dec 2018 18:15:25 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A7F4D120155;
        Wed,  5 Dec 2018 18:15:24 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH on sb/more-repo-in-api] revision: use commit graph in get_reference()
References: <20181204224238.50966-1-jonathantanmy@google.com>
Date:   Thu, 06 Dec 2018 08:15:23 +0900
In-Reply-To: <20181204224238.50966-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 4 Dec 2018 14:42:38 -0800")
Message-ID: <xmqqin07bm5w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A528DAAE-F8E3-11E8-B61C-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Looking at the bigger picture, the speed of the connectivity check
> during a fetch might be further improved by passing only the negotiation
> tips (obtained through --negotiation-tip) instead of "--all". This patch
> just handles the low-hanging fruit first.

That sounds like a good direction, when having to list excessive
number of refs is the primary problem.  When fetching their 'master'
into our 'remotes/origin/master' and doing nothing else, we may end
up showing only the latter, which will miss optimization opportunity
a lot if the latest change made over there is to merge in the change
we asked them to pull earlier (which would be greatly helped if we
let them know about the tip of the topic they earlier pulled from
us), but also avoids having to send irrelevant refs that point at
tags addded to months old states.  So there is a subtle trade-off
between sending more refs to reduce the resulting packfile, and
sending fewer refs to reduce the cost of the "have" exchange.

Changing the way to throw each object pointed at by a ref into the
queue to be emitted in the "have" exchange from regular object
parsing to peeking of precomputed data would reduce the local cost
of "have" exchange, but it does not reduce the network cost at all,
though.

As to the change being specific to get_reference() and not to
parse_object(), I think what we see here is probably better, simply
because parse_object() is not in the position to asssume that it is
likely to be asked to parse commits, but I think get_reference() is,
after looking at its callsites in revision.c.

I do share the meta-comment concern with Peff, though.

> ---
>  revision.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index b5108b75ab..e7da2c57ab 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -212,7 +212,20 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  {
>  	struct object *object;
>  
> -	object = parse_object(revs->repo, oid);
> +	/*
> +	 * If the repository has commit graphs, repo_parse_commit() avoids
> +	 * reading the object buffer, so use it whenever possible.
> +	 */
> +	if (oid_object_info(revs->repo, oid, NULL) == OBJ_COMMIT) {
> +		struct commit *c = lookup_commit(revs->repo, oid);
> +		if (!repo_parse_commit(revs->repo, c))
> +			object = (struct object *) c;
> +		else
> +			object = NULL;
> +	} else {
> +		object = parse_object(revs->repo, oid);
> +	}
> +
>  	if (!object) {
>  		if (revs->ignore_missing)
>  			return object;
