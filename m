Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 966131F404
	for <e@80x24.org>; Tue, 23 Jan 2018 18:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751751AbeAWSS3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jan 2018 13:18:29 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56047 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbeAWSS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jan 2018 13:18:28 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 417EFB4DDE;
        Tue, 23 Jan 2018 13:18:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YCyNGye3nzIVgakXuBkNmzx/Ivw=; b=hT6MNd
        +MEqptx/3aEU6B+A9Z4R2/rWpdudREQGF9PEdJZkiOkVmaswh2POhX3UyfP+0Wat
        UuJqH4afiddcAgl++pZU9YQHrsswxhqZjI3CWiUYKuHX7+w/49Zsv5j/SZ51jt6B
        PNg/sPXGLwyrFYxGIifQsA4wlYVIlWI9BTX70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EFi6Cp53/y/xna9NLGzf87cShj9VjpZT
        ZxpLt5hhcpqzH2j6Vkam16yVybWP5yTpMF9oDPV2RxkwEW86Wz5O3Wp53nRtoVTf
        s+82af1hWm/HrlzBv07+UwG4PUMND03jGRAc5FpXaIbppjt5/fRa+0Eg021sz+GZ
        p1ODE6n0K8k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 38FBEB4DDD;
        Tue, 23 Jan 2018 13:18:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB9D2B4DDC;
        Tue, 23 Jan 2018 13:18:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fsck: fix leak when traversing trees
References: <20180120074351.GA12439@whir>
Date:   Tue, 23 Jan 2018 10:18:24 -0800
In-Reply-To: <20180120074351.GA12439@whir> (Eric Wong's message of "Sat, 20
        Jan 2018 07:43:51 +0000")
Message-ID: <xmqqpo60iglr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDAEFF58-0069-11E8-8B20-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> While fsck_walk/fsck_walk_tree/parse_tree populates "struct tree"
> idempotently, it is still up to the fsck_walk caller to call
> free_tree_buffer.
>
> Fixes: ad2db4030e42890e ("fsck: remove redundant parse_tree() invocation")

Yup, we can see that that commit did stop freeing the tree buffer.
Thanks.

>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  These APIs could probably be made to be less error-prone,
>  but at least this stops my little machine from OOM-ing.
>
>  builtin/fsck.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 04846d46f9..92ce775a74 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -171,7 +171,13 @@ static void mark_object_reachable(struct object *obj)
>  
>  static int traverse_one_object(struct object *obj)
>  {
> -	return fsck_walk(obj, obj, &fsck_walk_options);
> +	int result = fsck_walk(obj, obj, &fsck_walk_options);
> +
> +	if (obj->type == OBJ_TREE) {
> +		struct tree *tree = (struct tree *)obj;
> +		free_tree_buffer(tree);
> +	}
> +	return result;
>  }
>  
>  static int traverse_reachable(void)
