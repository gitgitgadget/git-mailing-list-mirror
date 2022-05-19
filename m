Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63AFC433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiESUPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiESUPF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:15:05 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD4FC9ECD
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:15:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BBA211C0D7;
        Thu, 19 May 2022 16:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V5mrra170BK3LVjOnChQ05ubImbaMmrwCqQ7eZ
        b0pug=; b=r0iU803bbi6BgZhQXXi7it4Dq8CIRyuaQfMCBz/dHROs4w6TCQpcd4
        QrrhsnUDNcV32WTZHKEMydIE6TEFoQwv+3wjniuH7fvaM/o+be+g6TZIzuprHUph
        p8SnVsZC2gsUYlgPs3NdOJMJgLMEOIiNCGIBrt4N/xAFaGo8YJwX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 39A6011C0D5;
        Thu, 19 May 2022 16:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0341411C0D4;
        Thu, 19 May 2022 16:15:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 05/10] cache-tree: implement cache_tree_find_path()
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
        <c977001c033e8689f6d0ca52a6021bde61b1b476.1652982759.git.gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 13:14:59 -0700
In-Reply-To: <c977001c033e8689f6d0ca52a6021bde61b1b476.1652982759.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 19 May 2022
        17:52:33 +0000")
Message-ID: <xmqqczg9mg8s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CA823D4-D7B0-11EC-B116-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path)
> +{
> +	const char *slash;
> +	int namelen;
> +	struct cache_tree_sub *down;
> +
> +	if (!it)
> +		return NULL;
> +	slash = strchrnul(path, '/');
> +	namelen = slash - path;
> +	it->entry_count = -1;
> +	if (!*slash) {
> +		int pos;
> +		pos = cache_tree_subtree_pos(it, path, namelen);
> +		if (0 <= pos)
> +			return it->down[pos]->cache_tree;
> +		return NULL;
> +	}
> +	down = find_subtree(it, path, namelen, 0);
> +	if (down)
> +		return cache_tree_find_path(down->cache_tree, slash + 1);
> +	return NULL;
> +}

The tail recursion (and the one in the orginal) may want to be
trivially converted to iteration with "goto".

It is somewhat surprising that we didn't have any external interface
to expose a sub-part of the cache_tree at all so far.  It may be
because the API was so well designed that the abstraction did not
have to be exposed.  I dunno.

> diff --git a/cache-tree.h b/cache-tree.h
> index 8efeccebfc9..f75f8e74dcd 100644
> --- a/cache-tree.h
> +++ b/cache-tree.h
> @@ -29,6 +29,8 @@ struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const char *);
>  
>  int cache_tree_subtree_pos(struct cache_tree *it, const char *path, int pathlen);
>  
> +struct cache_tree *cache_tree_find_path(struct cache_tree *it, const char *path);
> +
>  void cache_tree_write(struct strbuf *, struct cache_tree *root);
>  struct cache_tree *cache_tree_read(const char *buffer, unsigned long size);
