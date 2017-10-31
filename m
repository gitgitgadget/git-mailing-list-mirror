Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538ED202A0
	for <e@80x24.org>; Tue, 31 Oct 2017 06:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbdJaG5O (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 02:57:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751172AbdJaG5N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 02:57:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 258E2A9DBA;
        Tue, 31 Oct 2017 02:57:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wo+FiA3YCz9SP0FBZ7vkC4sX7YQ=; b=xOrZYl
        4zuBFhojwglsyyYbkwU5k+Cz5WnI7uVx4X5o/1VOhYMeLeNVAKMB3oJi1aur4KdY
        2BxCWmbw9GjSh2ufrt77RgcnlH9QMTkwISMXPgGkF9ve9+Bv1T915xmHpzvRh31c
        ANO7ZpRCOA1NK0+xzF9DFyvaJmGqbPZK2iKDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vZXXa8EFTwrumiJVVvsnAyXpK7c5coEu
        pQukrAoVG38n8qBon+ZoiG1ITBYU2cF96HNgpzfWZzx2zQvP9ZXC87logkuLMw30
        e6+qVA6YX3xyFAnfINuLAJ1fNXnRfXHDYud4UcafPS7qYZ5kYyDWZxTAy3oeJyTe
        dIIMzjrTYeo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D070A9DB9;
        Tue, 31 Oct 2017 02:57:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D0D6A9DB8;
        Tue, 31 Oct 2017 02:57:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, me@ikke.info, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 2/7] revision.h: introduce blob/tree walking in order of the commits
References: <20171028004419.10139-1-sbeller@google.com>
        <20171031003351.22341-1-sbeller@google.com>
        <20171031003351.22341-3-sbeller@google.com>
Date:   Tue, 31 Oct 2017 15:57:11 +0900
In-Reply-To: <20171031003351.22341-3-sbeller@google.com> (Stefan Beller's
        message of "Mon, 30 Oct 2017 17:33:46 -0700")
Message-ID: <xmqqa807ztx4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8B4C6D0-BE08-11E7-8D49-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/list-objects.c b/list-objects.c
> index bf46f80dff..5e114c9a8a 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -237,6 +237,8 @@ void traverse_commit_list(struct rev_info *revs,
>  		if (commit->tree)
>  			add_pending_tree(revs, commit->tree);
>  		show_commit(commit, data);
> +		if (revs->tree_blobs_in_commit_order)
> +			traverse_trees_and_blobs(revs, &base_path, show_object, data);
>  	}
>  	traverse_trees_and_blobs(revs, &base_path, show_object, data);

This one is interesting.  While we walk the ancestry chain, we may
add the tree for each commit that we discover to the "pending.  We
used to sweep the pending array at the end after we run out of the
commits, but now we do the sweeping as we process each commit.

Would this make the last call to traverse_trees_and_blobs() always a
no-op?  I am not suggesting to add a new conditional in front of it;
I am just asking for curiosity's sake.

> diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
> new file mode 100755
> index 0000000000..67ebe815d2
> --- /dev/null
> +++ b/t/t6100-rev-list-in-order.sh
> @@ -0,0 +1,44 @@
> +#!/bin/sh
> +
> +test_description='miscellaneous rev-list tests'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'setup' '
> +	for x in one two three four
> +	do
> +		echo $x >$x &&
> +		git add $x &&
> +		git commit -m "add file $x"
> +	done &&
> +	for x in four three
> +	do
> +		git rm $x
> +		git commit -m "remove $x"
> +	done &&

There is break in &&-chain in the second loop, but in any case, for
loops and &&-chains do not mix very well unless done carefully.
Imagine what happens if "git commit" in the first loop failed when
x is two; it won't stop and keep going to create three and four and
nobody would noice any error.

> +	git rev-list --in-commit-order --objects HEAD >actual.raw &&
> +	cut -c 1-40 > actual < actual.raw &&
> +
> +	>expect &&
> +	git rev-parse HEAD^{commit}       >>expect &&
> +	git rev-parse HEAD^{tree}         >>expect &&
> +...
> +	git rev-parse HEAD~5^{tree}       >>expect &&

Ooooh, ugly ;-).  I wish we had --stdin interface or something.
Short of that, I'd probably write this more like...

		git rev-parse >expect \
			A B C D \
			E F

Even though we do not have --stdin for rev-parse, you can still do:

	git cat-file --batch-check='%(objectname)' >expect <<-\EOF &&
	HEAD^{commit}
	HEAD^{tree}
	HEAD:one
	HEAD:two
	...
	EOF

> +	test_cmp expect actual
> +'
> +
> +test_done
