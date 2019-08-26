Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADB71F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbfHZRw3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:52:29 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56387 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbfHZRw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:52:29 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CC676DA3C;
        Mon, 26 Aug 2019 13:52:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QofTWAO1o1PhU+suJpp5KtOPfGI=; b=vqNxiP
        c1z1mQarFHx+NaahLzNQ69J05Qi18HhYkrjsetP1l1kY3vnCIJm+vYXdxSFaiPGn
        vHkcWNzBrEDF6TiwJfqkIcyy2srH89WXzBz8ec4UgD27UHNGMEbTAFQqwlSoPHkc
        yjCMQx0qWF6F2ALYz5dIRjK0IHkZ8ZrEKnk/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ec7SfWdULJnv87/DTr9ZN5O2Rlur2miO
        r5efWwvVozCymULmwZ/g8vymxosjEIba4Lqp93mFpInGVqQxdybx+ZWxd2KJaZV8
        BBvV+XPnczaJmIkCtduWCwA+JSMv09zhrgCqqc+wO7BRAR2Dv80K0Gn5K/XgXihN
        DCDx2q0bAdQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 349EE6DA3B;
        Mon, 26 Aug 2019 13:52:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6066F6DA39;
        Mon, 26 Aug 2019 13:52:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, stefanbeller@gmail.com
Subject: Re: [PATCH] commit: free the right buffer in release_commit_memory
References: <20190826020137.4703-1-mh@glandium.org>
Date:   Mon, 26 Aug 2019 10:52:22 -0700
In-Reply-To: <20190826020137.4703-1-mh@glandium.org> (Mike Hommey's message of
        "Mon, 26 Aug 2019 11:01:37 +0900")
Message-ID: <xmqqk1azhl0p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42A95E82-C82A-11E9-80B2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> The index field in the commit object is used to find the buffer
> corresponding to that commit in the buffer_slab. Resetting it first
> means free_commit_buffer is not going to free the right buffer.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Wow, good find.  Ever since 14ba97f8 ("alloc: allow arbitrary
repositories for alloc functions", 2018-05-15) introduced the
release function, it was doing the wrong thing.

I think the real damage at most would have been just leaked memory,
because (1) commit.c::free_commit_buffer() uses FREE_AND_NULL() to
null-out the pointer, so calling free for the 0-th slab entry over
and over will not cause us to double-free, and (2) the only caller
of this function is object.c::parsed_object_pool_clear() that wants
to release resources from all objects.  There won't be a case like
"after releasing resource for 15th commit and we try to look at the
buffer for 0th commit, and the latter is gone by mistake, resulting
us to dereference freed piece of memory".

That would explain why we didn't see a failure report earlier.

Again, thanks for finding and fixing.  Will queue.

>
> diff --git a/commit.c b/commit.c
> index a98de16e3d..3fe5f8fa9c 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -364,8 +364,8 @@ struct object_id *get_commit_tree_oid(const struct commit *commit)
>  void release_commit_memory(struct parsed_object_pool *pool, struct commit *c)
>  {
>  	set_commit_tree(c, NULL);
> -	c->index = 0;
>  	free_commit_buffer(pool, c);
> +	c->index = 0;
>  	free_commit_list(c->parents);
>  
>  	c->object.parsed = 0;
