Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E42B71F461
	for <e@80x24.org>; Wed,  3 Jul 2019 00:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfGCAfb (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 20:35:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65479 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGCAfb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 20:35:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F4B514BEB3;
        Tue,  2 Jul 2019 17:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pkPyXq5mqaz4YWvPItoPsvc/+Lo=; b=jKLegD
        Yq9fHqzMrf6wSgtpfWsbCx1Zz00FsS4492tmuoxcxqLqIbfhRyCfVFk4hIK3NBgH
        5t3MHB7jcfzj1ifl5ZD5eSfLtHPGkzuesvbOEA5LMhwLRpPx3fns5g0TVqGIqUrL
        5eT/t6c0xPLSe3RYYPwux5PVq4xuas/0Eofhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qqtuASmhdnnaoofxN129PCRpQhvgFHGH
        1Qln3uGou1KX0IILH0Kf7StVFp9qPX7X5ZG5h29idyslruPuJGsZnpn43Iw0G/Uj
        DC0s1xH5NK6/ypKSgOwOyh020ZDj+MI20ycbaQZmYa4Ec4P8PGXjCRPbpKDYAmbt
        0T3PvmpGZZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1884114BEB1;
        Tue,  2 Jul 2019 17:37:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7B86F14BEAF;
        Tue,  2 Jul 2019 17:37:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper: enforce atomic in push_refs_with_push
References: <20190702005340.66615-1-emilyshaffer@google.com>
Date:   Tue, 02 Jul 2019 14:37:42 -0700
In-Reply-To: <20190702005340.66615-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 1 Jul 2019 17:53:40 -0700")
Message-ID: <xmqqa7dw2k49.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF5E7FC-9D11-11E9-88AD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Teach transport-helper how to notice if skipping a ref during push would
> violate atomicity on the client side. We notice that a ref would be
> rejected, and choose not to send it, but don't notice that if the client
> has asked for --atomic we are violating atomicity if all the other
> pushes we are sending would succeed. Asking the server end to uphold
> atomicity wouldn't work here as the server doesn't have any idea that we
> tried to update a ref that's broken.
>
> The added test-case is a succinct way to reproduce this issue that fails
> today. The same steps work fine when we aren't using a transport-helper
> to get to the upstream, i.e. when we've added a local repository as a
> remote:
>
>   git remote add ~/upstream upstream
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  t/t5541-http-push-smart.sh | 58 ++++++++++++++++++++++++++++++++++++++
>  transport-helper.c         |  6 ++++
>  transport.c                | 15 +++++++++-
>  3 files changed, 78 insertions(+), 1 deletion(-)
>
> diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
> index 8ef8763e06..b57f6d480f 100755
> --- a/t/t5541-http-push-smart.sh
> +++ b/t/t5541-http-push-smart.sh
> @@ -177,6 +177,64 @@ test_expect_success 'push (chunked)' '
>  	 test $HEAD = $(git rev-parse --verify HEAD))
>  '
>  
> +test_expect_success 'push --atomic also prevents branch creation' '
> +	# Make up/master
> +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> +	git init --bare "$d" &&
> +	git --git-dir="$d" config http.receivepack true &&
> +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> +	test_commit atomic1 &&
> +	test_commit atomic2 &&
> +	git push "$up" master &&
> +	# Make master incompatible with up/master
> +	git reset --hard HEAD^ &&
> +	# Add a new branch
> +	git branch atomic &&
> +	# --atomic should roll back creation of up/atomic
> +	test_must_fail git push --atomic "$up" master atomic &&
> +	git ls-remote "$up" >up-remotes &&
> +	test_must_fail grep atomic up-remotes

Don't use test_must_fail on non-git things.  We are not in the
business of catching segfaulting system programs.

> +'
> +
> +test_expect_success 'push --atomic shows all failed refs' '
> +	# Make up/master, up/allrefs
> +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-failed-refs.git &&
> +	git init --bare "$d" &&
> +	git --git-dir="$d" config http.receivepack true &&
> +	up="$HTTPD_URL"/smart/atomic-failed-refs.git &&
> +	test_commit allrefs1 &&
> +	test_commit allrefs2 &&
> +	git branch allrefs &&
> +	git push "$up" master allrefs &&
> +	# Make master and allrefs incompatible with up/master, up/allrefs
> +	git checkout allrefs &&
> +	git reset --hard HEAD^ &&
> +	git checkout master &&
> +	git reset --hard HEAD^ &&
> +	# --atomic should complain about both master and allrefs
> +	test_must_fail git push --atomic "$up" master allrefs >&output &&

Don't rely on ">&output", which is an unnecessary bash-ism here.  It
breaks test run under shells like dash.

	>output 2>&1

should be OK.

> +	grep master output &&
> +	grep allrefs output
> +'
> +
> +test_expect_success 'push --atomic indicates collateral failures' '
> +	# Make up/master, up/collateral
> +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-collateral.git &&
> +	git init --bare "$d" &&
> +	git --git-dir="$d" config http.receivepack true &&
> +	up="$HTTPD_URL"/smart/atomic-collateral.git &&
> +	test_commit collateral1 &&
> +	test_commit collateral2 &&
> +	git branch collateral &&
> +	git push "$up" master collateral &&
> +	# Make master incompatible with up/master
> +	git reset --hard HEAD^ &&
> +	# --atomic should mention collateral was OK but failed anyway
> +	test_must_fail git push --atomic "$up" master collateral >&output &&

Ditto.

> +	grep "master -> master" output &&
> +	grep "collateral -> collateral" output
> +'
> +

