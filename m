Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02638C433E0
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19D921D95
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 21:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGNH8IN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHEVBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:01:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58362 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgHEVBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 17:01:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B7BD76D72;
        Wed,  5 Aug 2020 17:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2sZZw3ToRtLqX9xO3uq6hZlxkKM=; b=VGNH8I
        N/VrWcJAGM3TMYH6xXE8iQ8cNN/rog20CdlFSnXCarf8mqxb2rbE3ZwLFkUrK68L
        /Zxwrh63FcDpd77gbZ1NsHyJ9Ekg1ndRYTAkDnACIhUwohJRXawSYVKZb7j1+Bxy
        srw2JODIM/AKkfxymyVk6RnaZvtxiJgXVV3TA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZQYea//b3kl3SIZBQvZAvr7rHzYctf/z
        yg7kfSqxDkWPZuSEl611XSyJsYCMQ3hhsElZT5vd7/c3Lh9kqnM9QEu5KUTXDW7j
        MyUjNopRKEvAvzdb82LB7jVHlbg4VxME2Z8HsJOj1fK+PasMEYQXpYGeGPv7MYjO
        SsM37jG/+nc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0249876D71;
        Wed,  5 Aug 2020 17:01:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CAED76D70;
        Wed,  5 Aug 2020 17:01:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 12/14] commit-graph: add large-filters bitmap chunk
References: <cover.1596480582.git.me@ttaylorr.com>
        <cover.1596646576.git.me@ttaylorr.com>
        <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
Date:   Wed, 05 Aug 2020 14:01:29 -0700
In-Reply-To: <100b26d7c8a5e7ce21a950f33791eadab74e8e70.1596646576.git.me@ttaylorr.com>
        (Taylor Blau's message of "Wed, 5 Aug 2020 13:02:58 -0400")
Message-ID: <xmqqbljoolhy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5FD9506-D75E-11EA-8EB9-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -71,6 +72,10 @@ struct commit_graph {
>  	const unsigned char *chunk_base_graphs;
>  	const unsigned char *chunk_bloom_indexes;
>  	const unsigned char *chunk_bloom_data;
> +	const unsigned char *chunk_bloom_large_filters;
> +
> +	size_t bloom_large_to_alloc;
> +	struct bitmap bloom_large;

Hmph, is the API rich enough to allow users to release the resource
used by such an embedded bitmap?  I ask becuase...

> @@ -2503,6 +2577,7 @@ void free_commit_graph(struct commit_graph *g)
>  	}
>  	free(g->filename);
>  	free(g->bloom_filter_settings);
> +	bitmap_free(g->bloom_large);
>  	free(g);
>  }

... this hunk cannot be possibly correct as-is, and cannot be made
correct without changing g->bloom_large to a pointer into a heap
allocated bitmap, because bitmap_free() wants to not just release
the resource held by the bitmap but the bitmap itself.
