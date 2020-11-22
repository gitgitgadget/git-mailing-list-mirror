Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B115C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 21:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0066620782
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 21:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8Lk2G8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgKVVuS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 16:50:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58789 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgKVVuS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 16:50:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4741C8A08B;
        Sun, 22 Nov 2020 16:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uHiyEQFHL0uHiJMItEtFDPOsR/4=; b=F8Lk2G
        8HNVZzz7TuM8Ojnk/Gb4h5ZZeb+oQdRSKTRBNNda9WxXKBjOYMV0Kjwx9EpDB2FB
        izr2GgB6JczNWnWMpsxwhnFMiB+HFoThj5BocR8m6Wq3CXq0r6oXyiuK+zV1F1xn
        dKv4BZsNA2JK1UTvXf4XlugxhR+i6ave0TzMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sj9zzw5d1pMlApF1A679DYGO2yrOaOlL
        qOTqqhsxQTOYjI/65EM72y88zKnKWgYbOKzbP+6mg7V3RXopUBzGXxw9Pu72ih2z
        +vkHezJTn3mjvK/hB2m3727sX02iaz68tE9Wfw3BRUlFAP2rAthVXaK8dzMxvUah
        j3uo0kSEMM8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EB998A08A;
        Sun, 22 Nov 2020 16:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1C408A089;
        Sun, 22 Nov 2020 16:50:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, peff@peff.net,
        martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/24] pack-bitmap-write: fill bitmap with commit
 history
References: <cover.1605123652.git.me@ttaylorr.com>
        <cover.1605649533.git.me@ttaylorr.com>
        <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
Date:   Sun, 22 Nov 2020 13:50:15 -0800
In-Reply-To: <8e5607929d66a3c808dbe3a06c312d0cda1ef568.1605649533.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 17 Nov 2020 16:47:24 -0500")
Message-ID: <xmqqy2itoyco.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4950C24-2D0C-11EB-989D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The fill_bitmap_commit() method assumes that every parent of the given
> commit is already part of the current bitmap. Instead of making that
> assumption, let's walk parents until we reach commits already part of
> the bitmap. Set the value for that parent immediately after querying to
> save time doing double calls to find_object_pos() and to avoid inserting
> the parent into the queue multiple times.

Is it because somebody found a case where the assumption does not
hold and the code with the assumption produces a wrong result?  Is
it because we can get a better result without making the assumption
the current code does?

In other words, can we explain why we are making the change in the
proposed log message?

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap-write.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index d2d46ff5f4..361f3305a2 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -12,6 +12,7 @@
>  #include "sha1-lookup.h"
>  #include "pack-objects.h"
>  #include "commit-reach.h"
> +#include "prio-queue.h"
>  
>  struct bitmapped_commit {
>  	struct commit *commit;
> @@ -279,17 +280,30 @@ static void fill_bitmap_tree(struct bitmap *bitmap,
>  }
>  
>  static void fill_bitmap_commit(struct bb_commit *ent,
> -			       struct commit *commit)
> +			       struct commit *commit,
> +			       struct prio_queue *queue)
>  {
>  	if (!ent->bitmap)
>  		ent->bitmap = bitmap_new();
>  
> -	/*
> -	 * mark ourselves, but do not bother with parents; their values
> -	 * will already have been propagated to us
> -	 */
>  	bitmap_set(ent->bitmap, find_object_pos(&commit->object.oid));
> -	fill_bitmap_tree(ent->bitmap, get_commit_tree(commit));
> +	prio_queue_put(queue, commit);
> +
> +	while (queue->nr) {
> +		struct commit_list *p;
> +		struct commit *c = prio_queue_get(queue);
> +
> +		bitmap_set(ent->bitmap, find_object_pos(&c->object.oid));
> +		fill_bitmap_tree(ent->bitmap, get_commit_tree(c));
> +
> +		for (p = c->parents; p; p = p->next) {
> +			int pos = find_object_pos(&p->item->object.oid);
> +			if (!bitmap_get(ent->bitmap, pos)) {
> +				bitmap_set(ent->bitmap, pos);
> +				prio_queue_put(queue, p->item);
> +			}
> +		}
> +	}
>  }
>  
>  static void store_selected(struct bb_commit *ent, struct commit *commit)
> @@ -319,6 +333,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  	struct bitmap_builder bb;
>  	size_t i;
>  	int nr_stored = 0; /* for progress */
> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>  
>  	writer.bitmaps = kh_init_oid_map();
>  	writer.to_pack = to_pack;
> @@ -335,7 +350,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  		struct commit *child;
>  		int reused = 0;
>  
> -		fill_bitmap_commit(ent, commit);
> +		fill_bitmap_commit(ent, commit, &queue);
>  
>  		if (ent->selected) {
>  			store_selected(ent, commit);
> @@ -360,6 +375,7 @@ void bitmap_writer_build(struct packing_data *to_pack)
>  			bitmap_free(ent->bitmap);
>  		ent->bitmap = NULL;
>  	}
> +	clear_prio_queue(&queue);
>  	bitmap_builder_clear(&bb);
>  
>  	stop_progress(&writer.progress);
