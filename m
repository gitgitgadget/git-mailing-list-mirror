Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C34C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 18:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbiBKSvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 13:51:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiBKSvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 13:51:19 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247BC57
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 10:51:16 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D4FC16AA5B;
        Fri, 11 Feb 2022 13:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jDv5PpxzV9iGBEXL5ydvDVdqeZVuUxpQo3bzq0
        aRshQ=; b=fvsWRrHmAYMdHAIBLzzusye3Gpgp+0avVipF9bufvazT7WHSV27olm
        3XI2EQCz0wvFWksVo3ATGSQygmE1GdQxv807WMf7T+Otb54yxI7QQgjxSH/FBui+
        L3oeHBhW8N4NnhP2OxRiKS3lq0NmLDb2hp6k94EFGG0R+2SHF/VLo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 563DA16AA5A;
        Fri, 11 Feb 2022 13:51:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7C0616AA59;
        Fri, 11 Feb 2022 13:51:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH v3 1/4] log: fix memory leak if --graph is passed
 multiple times
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
Date:   Fri, 11 Feb 2022 10:51:12 -0800
In-Reply-To: <20220211163627.598166-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Fri, 11 Feb 2022 09:36:24 -0700")
Message-ID: <xmqqsfspb5jz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96199BE8-8B6B-11EC-AF76-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +void graph_clear(struct git_graph *graph)
> +{
> +	if (!graph)
> +		return;
> +
> +	free(graph->columns);
> +	free(graph->new_columns);
> +	free(graph->mapping);
> +	free(graph->old_mapping);

These four are pointer members that graph_init() allocates storage
for, so releasing resources held by these four members in clear()
makes it symmetrical.

The .columns and .new_columns members are arrays of "struct column",
but each element in the array does not own any external memory, so
freeing the arrays is sufficient.  The .mapping and .old_mapping
members are arrays of int and freeing them is also sufficient.

Looking good.

> +	free(graph);
> +}
> +
>  static void graph_update_state(struct git_graph *graph, enum graph_state s)
>  {
>  	graph->prev_state = graph->state;
> diff --git a/graph.h b/graph.h
> index 8313e293c7..e88632a014 100644
> --- a/graph.h
> +++ b/graph.h
> @@ -139,6 +139,11 @@ void graph_set_column_colors(const char **colors, unsigned short colors_max);
>   */
>  struct git_graph *graph_init(struct rev_info *opt);
>  
> +/*
> + * Free a struct git_graph.
> + */
> +void graph_clear(struct git_graph *graph);
> +
>  /*
>   * Update a git_graph with a new commit.
>   * This will cause the graph to begin outputting lines for the new commit
> diff --git a/revision.c b/revision.c
> index ad4286fbdd..816061f3d9 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2426,6 +2426,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--graph")) {
>  		revs->topo_order = 1;
>  		revs->rewrite_parents = 1;
> +		graph_clear(revs->graph);
>  		revs->graph = graph_init(revs);

Makes sense.  Will queue.

>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
