Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30EC7C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F273D611AD
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 06:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhDKGto (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 02:49:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57832 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhDKGtm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 02:49:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DE0FB9E90;
        Sun, 11 Apr 2021 02:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MKM2MHNeGQIF2kY1pDIg92fCw/E=; b=TokWMp
        Xexr0X5VwohBrUFkZFJ+1cD2qlloRRJjA2SrhTrQcUdUNQs9bAFiykNd4ZFkk77k
        dRYDN8lmcYT9jiiqnogs3FKjZLDMBjygt6fNnfZ7p7ey/lmg9ogbJu3Oq3lHC0xd
        Ku6FqgpPrHo29H3Z6yt/sFYqWsxP5fK6pON3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pvOp6MEABJXeVbpZuLlugMs7MN18sqx/
        Td9ywEmQENQgBVbOAThXjwAXPOkox3L+/54sTGLXNuWDzDpla83v1Tv6W6Hx5C0A
        nPYMHk12tcblRp7TQN36L03Q8O2+00bCPApERcZN2n0euRz60JdTi8t4LS2ghwVw
        d48n8oZcn5k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94D07B9E8F;
        Sun, 11 Apr 2021 02:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F54DB9E8E;
        Sun, 11 Apr 2021 02:49:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/8] list-objects: support filtering by tag and commit
References: <cover.1615813673.git.ps@pks.im> <cover.1617967252.git.ps@pks.im>
        <80193d6ba38254aab3dd2cda39cabf12986fd939.1617967252.git.ps@pks.im>
Date:   Sat, 10 Apr 2021 23:49:24 -0700
In-Reply-To: <80193d6ba38254aab3dd2cda39cabf12986fd939.1617967252.git.ps@pks.im>
        (Patrick Steinhardt's message of "Fri, 9 Apr 2021 13:28:07 +0200")
Message-ID: <xmqqfszxiadn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DBF0A8C-9A92-11EB-BA19-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Object filters currently only support filtering blobs or trees based on
> some criteria. This commit lays the foundation to also allow filtering
> of tags and commits.
>
> No change in behaviour is expected from this commit given that there are
> no filters yet for those object types.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  list-objects-filter.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  list-objects-filter.h |  2 ++
>  list-objects.c        | 22 +++++++++++++++++++---
>  3 files changed, 61 insertions(+), 3 deletions(-)
>
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 39e2f15333..0ebfa52966 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -82,6 +82,16 @@ static enum list_objects_filter_result filter_blobs_none(
>  	default:
>  		BUG("unknown filter_situation: %d", filter_situation);
>  
> +	case LOFS_TAG:
> +		assert(obj->type == OBJ_TAG);
> +		/* always include all tag objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +	case LOFS_COMMIT:
> +		assert(obj->type == OBJ_COMMIT);
> +		/* always include all commit objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		/* always include all tree objects */
> @@ -173,6 +183,16 @@ static enum list_objects_filter_result filter_trees_depth(
>  	default:
>  		BUG("unknown filter_situation: %d", filter_situation);
>  
> +	case LOFS_TAG:
> +		assert(obj->type == OBJ_TAG);
> +		/* always include all tag objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +	case LOFS_COMMIT:
> +		assert(obj->type == OBJ_COMMIT);
> +		/* always include all commit objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
>  	case LOFS_END_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		filter_data->current_depth--;
> @@ -267,6 +287,16 @@ static enum list_objects_filter_result filter_blobs_limit(
>  	default:
>  		BUG("unknown filter_situation: %d", filter_situation);
>  
> +	case LOFS_TAG:
> +		assert(obj->type == OBJ_TAG);
> +		/* always include all tag objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +	case LOFS_COMMIT:
> +		assert(obj->type == OBJ_COMMIT);
> +		/* always include all commit objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		/* always include all tree objects */
> @@ -371,6 +401,16 @@ static enum list_objects_filter_result filter_sparse(
>  	default:
>  		BUG("unknown filter_situation: %d", filter_situation);
>  
> +	case LOFS_TAG:
> +		assert(obj->type == OBJ_TAG);
> +		/* always include all tag objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
> +	case LOFS_COMMIT:
> +		assert(obj->type == OBJ_COMMIT);
> +		/* always include all commit objects */
> +		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
>  	case LOFS_BEGIN_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		dtype = DT_DIR;
> diff --git a/list-objects-filter.h b/list-objects-filter.h
> index cfd784e203..9e98814111 100644
> --- a/list-objects-filter.h
> +++ b/list-objects-filter.h
> @@ -55,6 +55,8 @@ enum list_objects_filter_result {
>  };
>  
>  enum list_objects_filter_situation {
> +	LOFS_COMMIT,
> +	LOFS_TAG,
>  	LOFS_BEGIN_TREE,
>  	LOFS_END_TREE,
>  	LOFS_BLOB
> diff --git a/list-objects.c b/list-objects.c
> index a5a60301cb..0c524a81ac 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -217,8 +217,14 @@ static void process_tag(struct traversal_context *ctx,
>  			struct tag *tag,
>  			const char *name)
>  {
> -	tag->object.flags |= SEEN;
> -	ctx->show_object(&tag->object, name, ctx->show_data);
> +	enum list_objects_filter_result r;
> +
> +	r = list_objects_filter__filter_object(ctx->revs->repo, LOFS_TAG,
> +					       &tag->object, "", 0, ctx->filter);

s/0/NULL/

> +	if (r & LOFR_MARK_SEEN)
> +		tag->object.flags |= SEEN;
> +	if (r & LOFR_DO_SHOW)
> +		ctx->show_object(&tag->object, name, ctx->show_data);
>  }
>  
>  static void mark_edge_parents_uninteresting(struct commit *commit,
> @@ -368,6 +374,12 @@ static void do_traverse(struct traversal_context *ctx)
>  	strbuf_init(&csp, PATH_MAX);
>  
>  	while ((commit = get_revision(ctx->revs)) != NULL) {
> +		enum list_objects_filter_result r;
> +
> +		r = list_objects_filter__filter_object(ctx->revs->repo,
> +				LOFS_COMMIT, &commit->object,
> +				NULL, NULL, ctx->filter);
> +
>  		/*
>  		 * an uninteresting boundary commit may not have its tree
>  		 * parsed yet, but we are not going to show them anyway
> @@ -382,7 +394,11 @@ static void do_traverse(struct traversal_context *ctx)
>  			die(_("unable to load root tree for commit %s"),
>  			      oid_to_hex(&commit->object.oid));
>  		}
> -		ctx->show_commit(commit, ctx->show_data);
> +
> +		if (r & LOFR_MARK_SEEN)
> +			commit->object.flags |= SEEN;
> +		if (r & LOFR_DO_SHOW)
> +			ctx->show_commit(commit, ctx->show_data);
>  
>  		if (ctx->revs->tree_blobs_in_commit_order)
>  			/*
