Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DF8211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 01:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbeLFBcU (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 20:32:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63758 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFBcU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 20:32:20 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D34412145D;
        Wed,  5 Dec 2018 20:32:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dj8iYvDd3B3Q/pQaHH32T5u9buM=; b=WH75WG
        LUGqoZQmNf21pofYHRZ4WVH1h76JL3PFE5gIVGEaD137u2+N/PLmvZc7s74Usvt0
        QR8X8YYntVcswfmA2jXS9TfxrGCZW09rCUibpQpqkfLze+7fxHU5C+xFUfwrg7aS
        kFnZ5yg3sHC4KQNVZJsS6cynimpcy7fce4BjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sbwjHn5HMtOIPcYqD44+4ez2D/Gth45Y
        65E0KGdvqoawdJha3WSctN/JcTXf0kqNmw4Dr0nCtEEetQqYfvMEv6yqBA8PCA2l
        fUNHpBD7wpVhqglnVKpIMKArrWxfPgmIrMLIBVmYuyOdu2QxAyKGSofTeP2USnTL
        GxcelVdlM50=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3649912145C;
        Wed,  5 Dec 2018 20:32:18 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8CA49121459;
        Wed,  5 Dec 2018 20:32:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH 1/2] commit-graph, fuzz: Add fuzzer for commit-graph
References: <cover.1544048946.git.steadmon@google.com>
        <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
Date:   Thu, 06 Dec 2018 10:32:16 +0900
In-Reply-To: <53e62baaa8769bf8e90991e32e0d123cc6629559.1544048946.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 5 Dec 2018 14:32:50 -0800")
Message-ID: <xmqqmupja19b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C46CFBDA-F8F6-11E8-9614-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> @@ -108,27 +106,61 @@ struct commit_graph *load_commit_graph_one(const char *graph_file)
>  		die(_("graph file %s is too small"), graph_file);
>  	}
>  	graph_map = xmmap(NULL, graph_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	ret = parse_commit_graph(graph_map, fd, graph_size);

OK, assuming that the new helper returns NULL from all places in the
original that would have jumped to the cleanup-fail label, this would
do the same thing (it may not be the right thing to exit, but that
is OK for the purpose of this change).

> +	if (ret == NULL) {
> +		munmap(graph_map, graph_size);
> +		close(fd);
> +		exit(1);
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * This function is intended to be used only from load_commit_graph_one() or in
> + * fuzz tests.
> + */

Hmph, is that necessary to say?  

"Right now, it has only these two callers" is sometimes handy for
those without good static analysis tools, like "git grep" ;-), but I
do not think of a reason why a new caller we'll add in the future,
who happens to have the data of the graph file in-core, should not
be allowed to call this function.


> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size)
> +{
> +	const unsigned char *data, *chunk_lookup;
> +	uint32_t i;
> +	struct commit_graph *graph;
> +	uint64_t last_chunk_offset;
> +	uint32_t last_chunk_id;
> +	uint32_t graph_signature;
> +	unsigned char graph_version, hash_version;
> +
> +	/*
> +	 * This should already be checked in load_commit_graph_one, but we still
> +	 * need a check here for when we're calling parse_commit_graph directly
> +	 * from fuzz tests. We can omit the error message in that case.
> +	 */

In the same spirit, I am dubious of the longer-term value of this
comment.  As an explanation of why this conversion is correct in the
proposed log message for this change, it perfectly makes sense,
though.

> +	if (graph_size < GRAPH_MIN_SIZE)
> +		return NULL;
> +

The load_commit_graph_one() grabbed graph_map out of xmmap() so it
is guaranteed to be non-NULL, but we need to check graph_map != NULL
when we're calling this directly from the fuzz tests, exactly in the
same spirit that we check graph_size above.  Besides, these are to
make sure future callers won't misuse the API.

>  	data = (const unsigned char *)graph_map;

And the reset of the function is the same as the original modulo
jumping to the cleanup_fail label has been replaced with returning
NULL.

Looks good.

> ...
> -
> -cleanup_fail:
> -	munmap(graph_map, graph_size);
> -	close(fd);
> -	exit(1);
>  }
>  
>  static void prepare_commit_graph_one(struct repository *r, const char *obj_dir)
> diff --git a/fuzz-commit-graph.c b/fuzz-commit-graph.c
> new file mode 100644
> index 0000000000..420851d0d2
> --- /dev/null
> +++ b/fuzz-commit-graph.c
> @@ -0,0 +1,18 @@
> +#include "object-store.h"
> +#include "commit-graph.h"
> +
> +struct commit_graph *parse_commit_graph(void *graph_map, int fd,
> +					size_t graph_size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
> +
> +int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
> +{
> +	struct commit_graph *g;
> +
> +	g = parse_commit_graph((void *) data, -1, size);
> +	if (g)
> +		free(g);
> +
> +	return 0;
> +}
