Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1800C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84CB60F55
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhHBUBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:01:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60227 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHBUBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:01:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 409E9DD3B7;
        Mon,  2 Aug 2021 16:01:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x+cSWxZgmVZkmW7E0GXPyfSKDcgJdO1GItiZ8g
        1BgDs=; b=FDlhR0v4mEEDa4UvFtRiC9f1PlqtXl1zgzV1N3Xir+7sYtU4v4QbYL
        BiiLp1yqep07Owjj55STCtNb0BuWb8ah6iMWR4HW/cV4Fg2cv1IoJIqf9LXvpZjE
        V+B2UB4L9ZW54RkjOiDunb70fC+07FVY+GksWeRXlz/CFh2ppRsfw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB494DD3B6;
        Mon,  2 Aug 2021 16:01:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83C22DD3B4;
        Mon,  2 Aug 2021 16:01:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
References: <cover.1624858240.git.ps@pks.im> <cover.1627896460.git.ps@pks.im>
        <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
Date:   Mon, 02 Aug 2021 13:01:03 -0700
In-Reply-To: <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 2 Aug 2021 11:38:15 +0200")
Message-ID: <xmqqwnp3vcow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E49C2E2-F3CC-11EB-B250-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/commit-graph.c b/commit-graph.c
> index 3860a0d847..a81d5cebc0 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -864,6 +864,48 @@ static int fill_commit_in_graph(struct repository *r,
>  	return 1;
>  }


Describe return-value here.  0 for not-found, !0 for found?

> +static int find_object_id_in_graph(const struct object_id *id, struct commit_graph *g, uint32_t *pos)
> +{
> +	struct commit_graph *cur_g = g;
> +	uint32_t lex_index;
> +
> +	while (cur_g && !bsearch_graph(cur_g, (struct object_id *)id, &lex_index))
> +		cur_g = cur_g->base_graph;
> +
> +	if (cur_g) {
> +		*pos = lex_index + cur_g->num_commits_in_base;
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Likewise, or as this is public, perhaps in commit-graph.h next to
its declaration.

> +int find_object_in_graph(struct repository *repo, struct object *object)
> +{
> +	struct commit *commit;
> +	uint32_t pos;
> +
> +	if (object->parsed) {
> +		if (object->type != OBJ_COMMIT)
> +			return -1;
> +		return 0;

This is puzzling---at least it is not consistent with what the
function name says ("please say if you find _this_ object in the
commit-graph file"---if that is not what this function does, it
needs a comment before the implementation).

The caller had object and we has already been parsed.  If the
function were "with help from commit-graph, please tell me if you
can positively say this is a commit", the above is understandable.
If we know positively that it is not commit, we say "no, it is not a
commit" (which may be suboptimal---if the caller falls back to
another codepath, the object will still not be a commit) and if we
know it is a commit, we can say "yes, it definitely is a commit" and
the caller can stop there.

I guess my only problem with this function is that its name and what
it does does not align.  If the caller uses it for the real purpose
of the function I guessed, then the logic itself may be OK.

> +	}
> +
> +	if (!repo->objects->commit_graph)
> +		return -1;

There is no commit-graph, then we decline to make a decision, which
makes sense.

> +	if (!find_object_id_in_graph(&object->oid, repo->objects->commit_graph, &pos))
> +		return -1;

If it does not exist in the graph, we cannot tell, either.

> +	commit = object_as_type(object, OBJ_COMMIT, 1);
> +	if (!commit)
> +		return -1;
> +	if (!fill_commit_in_graph(repo, commit, repo->objects->commit_graph, pos))
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uint32_t *pos)
>  {
>  	uint32_t graph_pos = commit_graph_position(item);
> @@ -871,18 +913,7 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  		*pos = graph_pos;
>  		return 1;
>  	} else {
> -		struct commit_graph *cur_g = g;
> -		uint32_t lex_index;
> -
> -		while (cur_g && !bsearch_graph(cur_g, &(item->object.oid), &lex_index))
> -			cur_g = cur_g->base_graph;
> -
> -		if (cur_g) {
> -			*pos = lex_index + cur_g->num_commits_in_base;
> -			return 1;
> -		}
> -
> -		return 0;
> +		return find_object_id_in_graph(&item->object.oid, g, pos);

And I think this one is a op-op refactoring that does not change the
behaviour of find_commit_in_graph()?  It might be easier if done in
a separate preparatory step, but it is small enough.

> diff --git a/commit-graph.h b/commit-graph.h
> index 96c24fb577..f373fab4c0 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -139,6 +139,8 @@ int write_commit_graph(struct object_directory *odb,
>  		       enum commit_graph_write_flags flags,
>  		       const struct commit_graph_opts *opts);
>  
> +int find_object_in_graph(struct repository *repo, struct object *object);
> +
>  #define COMMIT_GRAPH_VERIFY_SHALLOW	(1 << 0)
>  
>  int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags);
> diff --git a/revision.c b/revision.c
> index 671b6d6513..c3f9cf2998 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -362,10 +362,12 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  	struct object *object = lookup_unknown_object(revs->repo, oid);
>  
>  	if (object->type == OBJ_NONE) {
> -		int type = oid_object_info(revs->repo, oid, NULL);
> -		if (type < 0 || !object_as_type(object, type, 1)) {
> -			object = NULL;
> -			goto out;
> +		if (find_object_in_graph(revs->repo, object) < 0) {
> +			int type = oid_object_info(revs->repo, oid, NULL);
> +			if (type < 0 || !object_as_type(object, type, 1)) {
> +				object = NULL;
> +				goto out;
> +			}
>  		}
>  	}
