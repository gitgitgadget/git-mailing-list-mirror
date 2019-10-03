Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB4E61F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfJCXgl (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 19:36:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55751 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfJCXgl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 19:36:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D3326750;
        Thu,  3 Oct 2019 19:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BkmbPNWHcbuaiun52RY1c/ouc2w=; b=w/wXQR
        1bcLzoty2NZUCPntUAZ5tNgfyshAqL1spJfViEEFD67fiOtd4LXF9ikt8W7gvPlh
        UfSO0kODH8HpHqbXPT3TKLblk67n2hOgM1HR4SWrlCd29mY+3xodaso94wlgTxl3
        bdUwJuimEj+GrQJZc5f5F7xxaNvI3fzGX8fjY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xO/d6waHGVyj6njNC2QBm+6ap6szLx9I
        V3lV0UpYOuay72B1AveDAJYen1cw1GLtfRj3NTsn/xw8u4dfJ//2m2xWLX5dGGFw
        EqdX89AWWaeD8ibUrmXwU9+KHHNUqgm6q11/Puz+0lzNtpjLeqbdzIlu2D28enxQ
        JlzzrlV3WJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A5ED2674F;
        Thu,  3 Oct 2019 19:36:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB8852674E;
        Thu,  3 Oct 2019 19:36:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "William Baker via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, williamtbakeremail@gmail.com,
        stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, William Baker <William.Baker@microsoft.com>
Subject: Re: [PATCH 1/1] fsmonitor: don't fill bitmap with entries to be removed
References: <pull.372.git.gitgitgadget@gmail.com>
        <ce9bf4237e69fcaf2b3e8b50bb88ff61c3b0f710.1570132194.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Oct 2019 08:36:34 +0900
In-Reply-To: <ce9bf4237e69fcaf2b3e8b50bb88ff61c3b0f710.1570132194.git.gitgitgadget@gmail.com>
        (William Baker via GitGitGadget's message of "Thu, 03 Oct 2019
        12:49:56 -0700 (PDT)")
Message-ID: <xmqq7e5l9zb1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A39EB5FA-E636-11E9-96D9-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"William Baker via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  create mode 100755 t/t7519/fsmonitor-env
> ...
> +	if (pos >= istate->cache_nr)
> +		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %"PRIuMAX")",
> +		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);

This is how we show size_t values without using "%z" that we avoid,
but are "pos" and 'cache_nr" size_t or ssize_t?  I thought they are
plain boring unsigned, so shouldn't we use the plain boring "%u"
without casting?

The same comment applies to other uses of uintmax_t cast in this
patch.

>  void fill_fsmonitor_bitmap(struct index_state *istate)
>  {
> -	unsigned int i;
> +	unsigned int i, skipped = 0;
>  	istate->fsmonitor_dirty = ewah_new();
> -	for (i = 0; i < istate->cache_nr; i++)
> -		if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
> -			ewah_set(istate->fsmonitor_dirty, i);
> +	for (i = 0; i < istate->cache_nr; i++) {
> +		if (istate->cache[i]->ce_flags & CE_REMOVE)
> +			skipped++;
> +		else if (!(istate->cache[i]->ce_flags & CE_FSMONITOR_VALID))
> +			ewah_set(istate->fsmonitor_dirty, i - skipped);
> +	}
>  }

Matches the explanation in the proposed log message pretty well.
Good job.

> @@ -354,4 +354,16 @@ test_expect_success 'discard_index() also discards fsmonitor info' '
>  	test_cmp expect actual
>  '
>  
> +# Use test files that start with 'z' so that the entries being added
> +# and removed appear at the end of the index.

In other words, future developers are warned against adding entries
to and leaving them in the index that sort later than z100 in new
tests they add before this point.  Is the above wording clear enough
to tell them that, I wonder?

> +test_expect_success 'status succeeds after staging/unstaging ' '
> +	test_commit initial &&
> +	removed=$(test_seq 1 100 | sed "s/^/z/") &&

Thanks.
