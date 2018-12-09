Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E7E20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 00:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLIAvn (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 19:51:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52759 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbeLIAvn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 19:51:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 57E4F207BE;
        Sat,  8 Dec 2018 19:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eWbVEyftsh1IZjtqKcjwAADYK3c=; b=Piorrg
        lPt6qC/EoYi7zM1AlaNSPM43bJTgafHpOI86RfH3lb5+2moOOC+XM8V0hqNmFi6K
        r2+J0KA8nMPczyBB7mxTbpqzmz7iojtzyR6VGJYD9qlVxO8ICBui+TrMEuPuiK2i
        Zns8APskX7fowO9BRW2+5/HWl+q7OTmGg8aTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D3Po95YXN4D3UGH6b8jkizyAMy3+DRN6
        yGDzuY1xpl7xHRMz3OgEBhTNuRm5zO0ApOCzk2MsgCVd22zbeaTQ4O/+ojRNqqPx
        MfqF4ibx7dV5h3TnEvrWheikK8Mhg3XshmL1Gyy2Cmnf+15Gwz+qQfZTAKjQmE6o
        DbJwKQGnpQY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F7B0207BD;
        Sat,  8 Dec 2018 19:51:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED4C1207BC;
        Sat,  8 Dec 2018 19:51:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Subject: Re: [PATCH on master v2] revision: use commit graph in get_reference()
References: <20181204224238.50966-1-jonathantanmy@google.com>
        <20181207215034.213211-1-jonathantanmy@google.com>
Date:   Sun, 09 Dec 2018 09:51:28 +0900
In-Reply-To: <20181207215034.213211-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 7 Dec 2018 13:50:34 -0800")
Message-ID: <xmqqwooj5xpr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 915FCE36-FB4C-11E8-A5EA-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching into a repository, a connectivity check is first made by
> check_exist_and_connected() in builtin/fetch.c that runs:
> ...
> Another way to accomplish this effect would be to modify parse_object()
> to use the commit graph if possible; however, I did not want to change
> parse_object()'s current behavior of always checking the object
> signature of the returned object.

Sounds good.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This patch is now on master.

OK.  

Obviously that won't apply to the base for v1 without conflicts, and
it of course applies cleanly on 'master', but the result of doing so
will cause the same conflicts when sb/more-repo-in-api is merged on
top, which means that the same conflicts need to be resolved if this
wants to be merged to 'next' (or 'pu', FWIW).

> diff --git a/commit-graph.c b/commit-graph.c
> index 40c855f185..a571b523b7 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -374,24 +375,41 @@ static int find_commit_in_graph(struct commit *item, struct commit_graph *g, uin
>  	}
>  }
>  
> -static int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)
> +static struct commit *parse_commit_in_graph_one(struct repository *r,
> +						struct commit_graph *g,
> +						struct commit *shell,
> +						const struct object_id *oid)

Now the complexity of the behaviour of this function deserves to be
documented in a comment in front.  Let me see if I can get it
correctly without such a comment by explaining the function aloud.

The caller may or may not have already obtained an in-core commit
object for a given object name, so shell could be NULL but otherwise
it could be used for optimization.  When shell==NULL, the function
looks up the commit object using the oid parameter instead.  The
returned in-core commit has the parents etc. filled as if we ran
parse_commit() on it.  If the commit is not yet in the graph, the
caller may get a NULL even if the commit exists.

>  {
>  	uint32_t pos;
>  
> -	if (item->object.parsed)
> -		return 1;
> +	if (shell && shell->object.parsed)
> +		return shell;
>  
> -	if (find_commit_in_graph(item, g, &pos))
> -		return fill_commit_in_graph(item, g, pos);
> +	if (shell && shell->graph_pos != COMMIT_NOT_FROM_GRAPH) {
> +		pos = shell->graph_pos;
> +	} else if (bsearch_graph(g, shell ? &shell->object.oid : oid, &pos)) {
> +		/* bsearch_graph sets pos */

Please spell an empty statement like so:

		; /* comment */

> +	} else {
> +		return NULL;

We come here when the commit (either came from shell or from oid) is
not found by bsearch_graph().  "Is the caller prepared for it, and
how?" is a natural question a reader would have.  Let's read on.

> +	}
>  
> -	return 0;
> +	if (!shell) {
> +		shell = lookup_commit(r, oid);
> +		if (!shell)
> +			return NULL;
> +	}
> +
> +	fill_commit_in_graph(shell, g, pos);
> +	return shell;
>  }
>  
> -int parse_commit_in_graph(struct repository *r, struct commit *item)
> +struct commit *parse_commit_in_graph(struct repository *r, struct commit *shell,
> +				     const struct object_id *oid)
>  {
>  	if (!prepare_commit_graph(r))
>  		return 0;
> -	return parse_commit_in_graph_one(r->objects->commit_graph, item);
> +	return parse_commit_in_graph_one(r, r->objects->commit_graph, shell,
> +					 oid);
>  }
>  
>  void load_commit_graph_info(struct repository *r, struct commit *item)
> @@ -1025,7 +1043,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g)
>  		}
>  
>  		graph_commit = lookup_commit(r, &cur_oid);
> -		if (!parse_commit_in_graph_one(g, graph_commit))
> +		if (!parse_commit_in_graph_one(r, g, graph_commit, NULL))
>  			graph_report("failed to parse %s from commit-graph",
>  				     oid_to_hex(&cur_oid));
>  	}
> diff --git a/commit-graph.h b/commit-graph.h
> index 9db40b4d3a..8b7b5985dc 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -13,16 +13,20 @@ struct commit;
>  char *get_commit_graph_filename(const char *obj_dir);
>  
>  /*
> - * Given a commit struct, try to fill the commit struct info, including:
> + * If the given commit (identified by shell->object.oid or oid) is in the
> + * commit graph, returns a commit struct (reusing shell if it is not NULL)
> + * including the following info:
>   *  1. tree object
>   *  2. date
>   *  3. parents.
>   *
> - * Returns 1 if and only if the commit was found in the packed graph.
> + * If not, returns NULL. See parse_commit_buffer() for the fallback after this
> + * call.
>   *
> - * See parse_commit_buffer() for the fallback after this call.
> + * Either shell or oid must be non-NULL. If both are non-NULL, oid is ignored.
>   */

OK, the eventual caller is the caller of this thing, which should
have been prepared to see NULL for a commit that is too new.  So
that should be OK.

> -int parse_commit_in_graph(struct repository *r, struct commit *item);
> +struct commit *parse_commit_in_graph(struct repository *r, struct commit *shell,
> +				     const struct object_id *oid);
>  
>  /*
>   * It is possible that we loaded commit contents from the commit buffer,
> diff --git a/commit.c b/commit.c
> index d13a7bc374..88eb580c5a 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -456,7 +456,7 @@ int parse_commit_internal(struct commit *item, int quiet_on_missing, int use_com
>  		return -1;
>  	if (item->object.parsed)
>  		return 0;
> -	if (use_commit_graph && parse_commit_in_graph(the_repository, item))
> +	if (use_commit_graph && parse_commit_in_graph(the_repository, item, NULL))
>  		return 0;
>  	buffer = read_object_file(&item->object.oid, &type, &size);
>  	if (!buffer)
> diff --git a/revision.c b/revision.c
> index 13e0519c02..05fddb5880 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -213,7 +213,10 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
>  {
>  	struct object *object;
>  
> -	object = parse_object(revs->repo, oid);
> +	object = (struct object *) parse_commit_in_graph(revs->repo, NULL, oid);
> +	if (!object)
> +		object = parse_object(revs->repo, oid);

OK and this is such a caller.  I think a general rule of thumb is
that we need to access recent history a lot more often than the
older part of the history, and having to fall back for more recent
commits feels a bit disturbing, but I do not see an easy way to
reverse the performance characteristics offhand.
