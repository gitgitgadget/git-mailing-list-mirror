Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ECF1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752745AbdDREMI (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:12:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752330AbdDREMG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:12:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E27274B5E;
        Tue, 18 Apr 2017 00:12:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=efE7pfaawrtO0M1WshwyJzT+3yk=; b=cZ1QEf
        q+FyXVxHg4SqNkaiPukVB9KhkwMFTiT8W4nFSKpkdBIfvDWVvf/FrU2fWum1C2de
        rqs+uuZnIOQvdn50r2iHn0jL/K84ki1TPOQbfv29aTsYEqH5lRN4phVhBrZtHBE9
        /cc1eVzOQnDVULV1XDjYK3VycN7iiBmvuquCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PgWk/Hi82kDC3SmIVOoyF6j6JvC/pt9a
        iSluAfd02QfJltjALvPj9Npln9jQ6ukkkwG0wv437lohXLeaqxad45Pt2r4t54FT
        JNaG8MfAELIWQDM5ndjanSNYVZ8aaixCVjpJFKVS3PkvqjccQwSIZ/zmgukCV7SC
        z9HT6Skgbls=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36C7074B5D;
        Tue, 18 Apr 2017 00:12:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DA2574B5C;
        Tue, 18 Apr 2017 00:12:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 1/5] dir_iterator: add tests for dir_iterator API
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
        <1492462296-4990-2-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 21:12:03 -0700
In-Reply-To: <1492462296-4990-2-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:32 -0300")
Message-ID: <xmqqinm2fj70.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E267F96-23ED-11E7-9CDA-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> +test_expect_success 'setup' '
> +	mkdir -p dir &&
> +	mkdir -p dir/a/b/c/ &&
> +	>dir/b &&
> +	>dir/c &&
> +	mkdir -p dir/d/e/d/ &&
> +	>dir/a/b/c/d &&
> +	>dir/a/e &&
> +	>dir/d/e/d/a &&
> +
> +	mkdir -p dir2/a/b/c/ &&
> +	>dir2/a/b/c/d
> +'
> +
> +cat >expect-sorted-output <<-\EOF &&
> +[d] (a) [a] ./dir/a
> +[d] (a/b) [b] ./dir/a/b
> +[d] (a/b/c) [c] ./dir/a/b/c
> +[d] (d) [d] ./dir/d
> +[d] (d/e) [e] ./dir/d/e
> +[d] (d/e/d) [d] ./dir/d/e/d
> +[f] (a/b/c/d) [d] ./dir/a/b/c/d
> +[f] (a/e) [e] ./dir/a/e
> +[f] (b) [b] ./dir/b
> +[f] (c) [c] ./dir/c
> +[f] (d/e/d/a) [a] ./dir/d/e/d/a
> +EOF
> +
> +test_expect_success 'dir-iterator should iterate through all files' '
> +	test-dir-iterator ./dir >out &&
> +	sort <out >./actual-pre-order-sorted-output &&
> +
> +	test_cmp expect-sorted-output actual-pre-order-sorted-output
> +'

OK, if you can get multiple entries from a single directory, the
order of these entries are not known because they come in readdir()
order, and you'd need to sort the output to see if you got the same
thing.  Sort of makes sense.

> +
> +cat >expect-pre-order-output <<-\EOF &&
> +[d] (a) [a] ./dir2/a
> +[d] (a/b) [b] ./dir2/a/b
> +[d] (a/b/c) [c] ./dir2/a/b/c
> +[f] (a/b/c/d) [d] ./dir2/a/b/c/d
> +EOF
> +
> +test_expect_success 'dir-iterator should list files in the correct order' '
> +	test-dir-iterator ./dir2 >actual-pre-order-output &&
> +
> +	test_cmp expect-pre-order-output actual-pre-order-output
> +'

And this example has only one item per each recursion level, so the
order of output is predictable.  Again, makes sense.
