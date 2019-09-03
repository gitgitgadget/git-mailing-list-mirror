Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA1C1F461
	for <e@80x24.org>; Tue,  3 Sep 2019 21:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfICVIT (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 17:08:19 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65058 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfICVIT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 17:08:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66A046FA22;
        Tue,  3 Sep 2019 17:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y51Zs5xjls/cSv8CB7CAE6lRBsc=; b=Cl+2vc
        +jk9LkuWWKz0SNU0ddbx1ODHShOtkvqPqfJ/OBmNuQHnHAxy3ASeY014qjf2kmwc
        UEzZpSM66ITtflnj8H5c2MsxAklKfsBi0otquK0ccIB3wVFsK8Sn6CCaohizVQVn
        7LgPQXugRqvr1NNP5Gdzc5PGQOB4KU7A4SMYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qhoA3v7jg3HRugocAvdW+zIAJ5bLPChS
        T6TEdGqW+VDDuf7P5BNMAqpws8bNYpzds7iPsyK2PlTJG2QfyDToCCpzbmwzsA/H
        JtcSlpX3wIvVTf5++gHyMIgRzM2bjKWRq4CqDCqfZWOvh9Zb69Bb4kYb7YEa70JT
        9PXQdEZv+9Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DE5A6FA21;
        Tue,  3 Sep 2019 17:08:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 924026FA1F;
        Tue,  3 Sep 2019 17:08:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/4] t6006: simplify and optimize empty message test
References: <20190828002210.8862-1-newren@gmail.com>
        <20190903185524.13467-1-newren@gmail.com>
        <20190903185524.13467-2-newren@gmail.com>
Date:   Tue, 03 Sep 2019 14:08:09 -0700
In-Reply-To: <20190903185524.13467-2-newren@gmail.com> (Elijah Newren's
        message of "Tue, 3 Sep 2019 11:55:21 -0700")
Message-ID: <xmqq1rwxt7eu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFD8F404-CE8E-11E9-ADEE-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Test t6006.71 ("oneline with empty message") was creating two commits
> with simple commit messages, and then running filter-branch to rewrite
> the commit messages to be empty.  This test was written this way because
> the --allow-empty-message option to git commit did not exist at the
> time.  Simplify this test and avoid the need to invoke filter-branch by
> just using --allow-empty-message when creating the commit.

The result of filter-branch seems to have one empty line as the body
(i.e. "echo X; git cat-file commit A; echo Y" will show two blank
lines between the committer line and Y), while "--allow-empty-message"
does not leave any body (i.e. the same will give you only one blank
line there).

Was this test verifying the right thing in the first place, I have
to wonder.

IOW,

	git commit --allow-empty --cleanup=verbatim -m "$LF" &&

would be more faithful conversion of the original (and hopefully
just as performant).

> Despite only being one piece of the 71st test and there being 73 tests
> overall, this small change to just this one test speeds up the overall
> execution time of t6006 (as measured by the best of 3 runs of `time
> ./t6006-rev-list-format.sh`) by about 11% on Linux, 13% on Mac, and
> about 15% on Windows.

Quite an improvement ;-)

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6006-rev-list-format.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index da113d975b..d30e41c9f7 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -501,9 +501,8 @@ test_expect_success 'reflog identity' '
>  '
>  
>  test_expect_success 'oneline with empty message' '
> -	git commit -m "dummy" --allow-empty &&
> -	git commit -m "dummy" --allow-empty &&
> -	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
> +	git commit --allow-empty --allow-empty-message &&
> +	git commit --allow-empty --allow-empty-message &&
>  	git rev-list --oneline HEAD >test.txt &&
>  	test_line_count = 5 test.txt &&
>  	git rev-list --oneline --graph HEAD >testg.txt &&
