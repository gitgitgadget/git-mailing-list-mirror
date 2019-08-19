Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 730661F461
	for <e@80x24.org>; Mon, 19 Aug 2019 21:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHSVzw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 17:55:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58652 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfHSVzw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 17:55:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BE5671FBC;
        Mon, 19 Aug 2019 17:55:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WOxukyOjnR1LVR28sWz/swe+QBs=; b=RUL0mp
        ZrPbNzfCcHVIwjd+/qBTWPmufjQPsdnpGJ5C8M4ilwukKth2aGxpeffbv4/f3QZ1
        VJZqjw2P2O4cBmSjux/vWapVrKJm7LwVC1TzMDUw3Rq4e/2BvYMCwcQ/UPIyeO+b
        I59jH/dngBluMGZqwgyUIzH1fKKCAUJi7XiWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RxtjSSEqeKGIm+K5oo4Q8v9/r20vaFi8
        x4YZ+Dw7chbrhonWBcq6nfHzAwzwvZR3Ft3OF0pHrrLinVv+xHiic+uo04W5QqEn
        G2o2WeMzBuse+d6/YBUojNE5k6mn3QnlzNH88tCNOIPUoiGQNOk/kMH3GmWJVjs3
        bpjMdeX2JsY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54F5F71FBA;
        Mon, 19 Aug 2019 17:55:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7FF9471FB8;
        Mon, 19 Aug 2019 17:55:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 1/2] t3420: never change upstream branch
References: <20190818095349.3218-1-ben@wijen.net>
        <20190818095349.3218-2-ben@wijen.net>
Date:   Mon, 19 Aug 2019 14:55:42 -0700
In-Reply-To: <20190818095349.3218-2-ben@wijen.net> (Ben Wijen's message of
        "Sun, 18 Aug 2019 11:53:48 +0200")
Message-ID: <xmqqr25gx1k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 182046F2-C2CC-11E9-889E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Wijen <ben@wijen.net> writes:

> When using `git rebase --autostash <upstream> <branch>` and
> the workarea is dirty, the active branch is incorrectly reset
> to the rebase <upstream> branch.
>
> This test will check for such behavior.
>
> Signed-off-by: Ben Wijen <ben@wijen.net>
> ---
>  t/t3420-rebase-autostash.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index b8f4d03467..867e4e0b17 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -306,4 +306,13 @@ test_expect_success 'branch is left alone when possible' '
>  	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
>  '
>  
> +test_expect_success 'never change upstream branch' '
> +	test_when_finished "git reset --hard && git branch -D upstream" &&
> +	git checkout -b upstream unrelated-onto-branch &&
> +	echo changed >file0 &&
> +	git add file0 &&
> +	git rebase --autostash upstream feature-branch &&
> +	test $(git rev-parse upstream) = $(git rev-parse unrelated-onto-branch)
> +'
> +
>  test_done

If you are going to make these into two separate commits (which I do
not necessarily recommend), introduce it as "test_expect_failure" in
step 1/2 and flip it to "test_expect_success" in step 2/2, when the
breakage is corrected.

This breakage may have happened somewhere between v2.19 and v2.20,
if my hunch is correct.  If it is easy to identify the exact point
of breakage, it may make sense to note it in the log message of 2/2
as well.  My guess is 176f5d96 ("built-in rebase --autostash: leave
the current branch alone if possible", 2018-11-07) is the plausible
candidate (iow, I suspect that the "do not detach" optimization was
made a bit too aggressively by that commit), but don't quote me on
it as this was purely done by "git log --grep -p" and not compiling
or running any tests ;-)

Thanks.


