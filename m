Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBECC433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B9F72053B
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I9oGsYmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgFDRfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:35:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50829 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgFDRfN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:35:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F1BE5BF4E2;
        Thu,  4 Jun 2020 13:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LFGsB/VGx1oeVcYzdqPC87GePNA=; b=I9oGsY
        mrbElE8aTKRUiY9fw/RLzU9tKU4goR3NK71Eulvw3VNEpUPwcvZpr4X7ldzUWWVN
        NkQ1tUmOSe/CMdiYMLXlr5Mo/Ban4bl/wkCALU0E3hcrp0ZmghubQi0aZRCRGsXk
        h+ByyqHb7h6XylWejm8wG2OLFY1qkHnzeBnk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mcos2P6awI7bi+fs2XboUSrWqVGf/euG
        U/QoO4uaci9HlTGNxifdXOaLf0f7K1TCsuYNAo+12KniDgWSl/1TIC6hPM6atUm+
        Y+ZLWzWyxoK64McSkKFm3lQR+re9eu2Ac05quV1G9luhap21XtAMjMAWJjc1zYCn
        4NhCQAh4DT4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBA07BF4E0;
        Thu,  4 Jun 2020 13:35:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 305B4BF4DC;
        Thu,  4 Jun 2020 13:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, jnareb@gmail.com
Subject: Re: [GSoC Patch 1/3] commit: introduce helpers for generation slab
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
        <20200604072759.19142-2-abhishekkumar8222@gmail.com>
Date:   Thu, 04 Jun 2020 10:35:05 -0700
In-Reply-To: <20200604072759.19142-2-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Thu, 4 Jun 2020 12:57:57 +0530")
Message-ID: <xmqqk10mpwdy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB58F91C-A689-11EA-B57F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> The struct member generation refers to "generation number" (or more
> broadly, a reachablity index value) used by commit-graph to reduce time
> taken to walk commits. However, generation is not useful in other
> contexts and bloats the struct.
>
> Let's move it to a commit-slab and shrink the struct by four bytes.
>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 27 +++++++++++++++++++++++++++
>  commit-graph.h |  5 +++++
>  commit.h       |  3 ---
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index e3420ddcbf..63f419048d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -87,6 +87,33 @@ static int commit_pos_cmp(const void *va, const void *vb)
>  	       commit_pos_at(&commit_pos, b);
>  }
>  
> +define_commit_slab(generation_slab, uint32_t);
> +static struct generation_slab generation_slab = COMMIT_SLAB_INIT(1, generation_slab);
> +
> +uint32_t generation(const struct commit *c)
> +{
> +	uint32_t *gen = generation_slab_peek(&generation_slab, c);
> +
> +	return gen ? *gen : GENERATION_NUMBER_INFINITY;
> +}
> +
> +static void set_generation(const struct commit *c, const uint32_t generation)
> +{
> +	unsigned int i = generation_slab.slab_count;
> +	uint32_t *gen = generation_slab_at(&generation_slab, c);
> +
> +	/*
> +	 * commit-slab initializes with zero, overwrite this with
> +	 * GENERATION_NUMBER_INFINITY
> +	 */
> +	for (; i < generation_slab.slab_count; ++i) {

Style: favor post-increment over pre-increment when there is no
difference, especially when updating the loop control in for() loop.

> +		memset(generation_slab.slab[i], GENERATION_NUMBER_INFINITY,
> +		       generation_slab.slab_size * sizeof(uint32_t));
> +	}
> +
> +	*gen = generation;
> +}
> +
>  static int commit_gen_cmp(const void *va, const void *vb)
>  {
>  	const struct commit *a = *(const struct commit **)va;
> diff --git a/commit-graph.h b/commit-graph.h
> index 4212766a4f..653bd041ad 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -8,6 +8,10 @@
>  #include "object-store.h"
>  #include "oidset.h"
>  
> +#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> +#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> +#define GENERATION_NUMBER_ZERO 0
> +

Makes sense to move it from commit.h, I guess.

>  #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
>  #define GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD "GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD"
>  #define GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS "GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS"
> @@ -137,4 +141,5 @@ void free_commit_graph(struct commit_graph *);
>   */
>  void disable_commit_graph(struct repository *r);
>  
> +uint32_t generation(const struct commit *c);
>  #endif
> diff --git a/commit.h b/commit.h
> index 1b2dea5d85..cc610400d5 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -11,9 +11,6 @@
>  #include "commit-slab.h"
>  
>  #define COMMIT_NOT_FROM_GRAPH 0xFFFFFFFF
> -#define GENERATION_NUMBER_INFINITY 0xFFFFFFFF
> -#define GENERATION_NUMBER_MAX 0x3FFFFFFF
> -#define GENERATION_NUMBER_ZERO 0
>  
>  struct commit_list {
>  	struct commit *item;
