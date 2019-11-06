Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124451F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbfKFCXG (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:23:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64213 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfKFCXG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:23:06 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10765A1030;
        Tue,  5 Nov 2019 21:23:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XUqaOdlLKiBdkyGrRIegOc9FyAM=; b=x/77pT
        q87Nb9YFMu2sqCYbIPa9zxSOL/GZfrYg63+2iG6MoYFaujXaFzO57f0JWQY4MSUG
        SDTeiiZ7BDhF6GjO6pu2Bam87gcwvQdESSAPXthXUls1qBJw21efTA1I1Z89brwW
        63tJAMidLb8FJ3TAU1QflkmeXG2UsNftvDing=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lams+otjQcbuKyIqm1/x77sq1GL+6xtX
        gja6oeABjAthxLkIOMgQSGMOXF6hBSeI8uhn0XH/uzt39jkva+R98gFLKQSs6rvG
        03zb+pv2NItSE7eY7pOIra9Zd37QssswYW6ZUQetfgmYnswEfRTg66HT58TBJ9BJ
        rwvoKlToVmU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09195A102F;
        Tue,  5 Nov 2019 21:23:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 368E9A102C;
        Tue,  5 Nov 2019 21:23:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 31/32] commit-graph.c: fix code that could convert the result of an integer multiplication to a larger type
References: <20191104095923.116086-1-gitter.spiros@gmail.com>
        <20191104095923.116086-2-gitter.spiros@gmail.com>
Date:   Wed, 06 Nov 2019 11:23:00 +0900
In-Reply-To: <20191104095923.116086-2-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Mon, 4 Nov 2019 09:59:22 +0000")
Message-ID: <xmqq7e4dwxob.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B8F9818-003C-11EA-9A40-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Fix the LGTM warning fired by the rule that finds code that could convert the result of an integer
> multiplication to a larger type. Since the conversion applies after the multiplication,
> arithmetic overflow may still occur.

Overly long?

>  	chunk_offsets[0] = 8 + (num_chunks + 1) * GRAPH_CHUNKLOOKUP_WIDTH;
>  	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
> -	chunk_offsets[2] = chunk_offsets[1] + hashsz * ctx->commits.nr;
> -	chunk_offsets[3] = chunk_offsets[2] + (hashsz + 16) * ctx->commits.nr;
> +	chunk_offsets[2] = chunk_offsets[1] + (uint64_t)hashsz * ctx->commits.nr;
> +	chunk_offsets[3] = chunk_offsets[2] + ((uint64_t)hashsz + 16) * ctx->commits.nr;

chunk_offsets[] is u64[], while hashsz and is uint and
ctx->commits.nr is int.  OK.

> @@ -1426,7 +1426,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  	}
>  	if (ctx->num_commit_graphs_after > 1) {
>  		chunk_offsets[num_chunks + 1] = chunk_offsets[num_chunks] +
> -						hashsz * (ctx->num_commit_graphs_after - 1);
> +						(uint64_t)hashsz * (ctx->num_commit_graphs_after - 1);

Likewise.

> @@ -1454,7 +1454,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
>  			    num_chunks);
>  		ctx->progress = start_delayed_progress(
>  			progress_title.buf,
> -			num_chunks * ctx->commits.nr);
> +			(uint64_t)num_chunks * ctx->commits.nr);

Hmph, do we need this?  I understand that the second parameter to
the callee is u64, so the caller needs to come up with u64 without
overflow, but doesn't that automatically get promoted?

>  	}
>  	write_graph_chunk_fanout(f, ctx);
>  	write_graph_chunk_oids(f, hashsz, ctx);
