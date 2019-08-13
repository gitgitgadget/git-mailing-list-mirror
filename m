Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 291531F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfHMWiD (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:38:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51595 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfHMWiD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 18:38:03 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29A38743B4;
        Tue, 13 Aug 2019 18:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2tBYDINs90Pz9Jz/b3nZBCetv6E=; b=b7Ig2a
        l8olHQW8CPzSS3ez6zaL1mtoUSKG+0HH1qvCge7nsdfilILYrcNnmVelt1rDB2mo
        BQ9kjiXiaohO90E2MINWzJ4TJ6vAuaAqWWm/5F10V4A0j/JjwiTcJyCrQsVLfSKW
        FBPcnDuoU41U5MdzQZYbJNmID6G4kFN/afQ6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VwvBPiONZgDtJyZz5w/YF08ryG/Zb9cN
        B4jw4ZRJnxK+6QKrGqaDNF7Z/4aBUa82CQqTIUhpvltEeOfx7DwGp47I5l1r6aY/
        YcDLuV6uJjyrernlUNfYvknB9IhFvas4Oj5vuFqa/dNXjeqBTmoUKa4Z8yYoRayH
        wBbuiowkJQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 22B06743B0;
        Tue, 13 Aug 2019 18:38:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F02A743AD;
        Tue, 13 Aug 2019 18:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] apply: reload .gitattributes after patching it
References: <20190809100217.427178-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-1-sandals@crustytoothpaste.net>
        <20190813024307.705016-3-sandals@crustytoothpaste.net>
Date:   Tue, 13 Aug 2019 15:37:56 -0700
In-Reply-To: <20190813024307.705016-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 13 Aug 2019 02:43:07 +0000")
Message-ID: <xmqq36i47ku3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFE8F5D0-BE1A-11E9-8A0E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +test_expect_success 'rebase --am and .gitattributes' '
> +	test_create_repo attributes &&
> +	(
> +		cd attributes &&
> +		test_commit init &&
> +		test_config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
> +		test_config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&

These eventually invokes test-when-finished for cleaning things up,
that cannot be called inside a subshell.  The "attributes" test
repository is a throw-away reopsitory, so we should be able to just
use "git config" to set the variables locally in it, no?

> +		test_commit second &&
> +		git checkout -b test HEAD^ &&
> +
> +		echo "*.txt filter=test" >.gitattributes &&
> +		git add .gitattributes &&
> +		test_commit third &&
> +
> +		echo "This text is smudged." >a.txt &&
> +		git add a.txt &&
> +		test_commit fourth &&
> +		git rebase master &&
> +		grep "smudged" a.txt
> +	)
> +'
> +
>  test_expect_success 'rebase--merge.sh and --show-current-patch' '
>  	test_create_repo conflict-merge &&
>  	(
