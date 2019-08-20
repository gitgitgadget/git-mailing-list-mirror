Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79DF1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 20:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbfHTU6b (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 16:58:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59558 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbfHTU6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 16:58:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C8F3887F4C;
        Tue, 20 Aug 2019 16:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mtLFPl5gTj6dWkG7QkF9wM4WOzU=; b=bG0Phv
        mDJyceeE08wwrhfLNmBDDrIovYkS5m+HcSeCHqEjeXeY1UEE5N+rUN7uQu9CxnBI
        nLzjI0g1T1Ommf1+IavMqSPrZWc2mDZJcgM43PuUVj7AWZ7MznuzjQMrYkWj0irg
        D3Xkl5y2/vXjymAkLSw22ZNS5E5e9D0WPQAsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ChVJpXm5ZnawjgDsI/k+tze+f5u7Idc6
        6d6388046P7UH9IP3MvqAFHJjEeemPJ39A2aLIt2cuaHmqKBY+JqyNizj37wwbl3
        KBPlzC3TQIwFa4mjaDHGSh/X6L/5cW7DxVKdXCoZ7ogTAbraDo3CVT+vZlGcIle5
        IeYjurmURXw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0BD087F4B;
        Tue, 20 Aug 2019 16:58:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EDF5787F4A;
        Tue, 20 Aug 2019 16:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/1] rebase.c: make sure current branch isn't moved when autostashing
References: <20190818095349.3218-3-ben@wijen.net>
        <20190820201237.10205-1-ben@wijen.net>
        <20190820201237.10205-2-ben@wijen.net>
Date:   Tue, 20 Aug 2019 13:58:23 -0700
In-Reply-To: <20190820201237.10205-2-ben@wijen.net> (Ben Wijen's message of
        "Tue, 20 Aug 2019 22:12:37 +0200")
Message-ID: <xmqqlfvntuz4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41010770-C38D-11E9-ADC9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Wijen <ben@wijen.net> writes:

> Consider the following scenario:
>     git checkout not-the-master
>     work work work
>     git rebase --autostash upstream master
>
> Here 'rebase --autostash <upstream> <branch>' incorrectly moves the
> upstream branch to master.
>
> The expected behavior: (58794775:/git-rebase.sh:526)
>     AUTOSTASH=$(git stash create autostash)
>     git reset --hard
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH
>
> The actual behavior: (6defce2b:/builtin/rebase.c:1062)
>     AUTOSTASH=$(git stash create autostash)
>     git reset --hard master
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH

In the scenario at the top, the branch that is checked out while you
are working is "not-the-master" branch, and you run the rebase
command.  If we follow the "actual behaviour" in our head, after
stashing away the local change, the tip of the current branch
(i.e. not-the-master) is reset to the same commit as the tip of
'master'.

But earlier, you said, "incorrectlly moves the upstream branch".

It looks like either one of the use of branches in the "scenario",
or the problem statement, is incorrect.

The reason why "HEAD is..." comments are all gone (as shown in the
test) is not explained well in the proposed commit log message,
either.  I think the change is correct (i.e. we were moving HEAD
incorrectly, and the messages were given incorrectly, and we are
fixing this behaviour hence there is no longer any need to say we
are moving the HEAD anymore), but there should be some mention of
the change, I would think.

Thanks.

>  create_expected_failure_am () {
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	First, rewinding head to replay your work on top of it...
>  	Applying: second commit
>  	Applying: third commit
> @@ -70,7 +67,6 @@ create_expected_failure_am () {
>  create_expected_failure_interactive () {
>  	cat >expected <<-EOF
>  	$(grep "^Created autostash: [0-9a-f][0-9a-f]*\$" actual)
> -	HEAD is now at $(git rev-parse --short feature-branch) third commit
>  	Applying autostash resulted in conflicts.
>  	Your changes are safe in the stash.
>  	You can run "git stash pop" or "git stash drop" at any time.
> @@ -306,4 +302,13 @@ test_expect_success 'branch is left alone when possible' '
>  	test unchanged-branch = "$(git rev-parse --abbrev-ref HEAD)"
>  '
>  
> +test_expect_success 'never change upstream branch' '
> +	test_when_finished "git reset --hard && git branch -D upstream" &&
> +	git checkout -b upstream unrelated-onto-branch &&
> +	echo changed >file0 &&
> +	git add file0 &&
> +	git rebase --autostash upstream feature-branch &&
> +	test_cmp_rev upstream unrelated-onto-branch
> +'
> +
>  test_done
