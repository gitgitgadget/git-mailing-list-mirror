Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B351F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 02:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfKNCHg (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 21:07:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60060 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNCHg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 21:07:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17C53A3034;
        Wed, 13 Nov 2019 21:07:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oRCzDTWKZgDSGKURan0Xz/uw1M0=; b=WccjZY
        Zaxw6ZPdK7wjTCt7Do5mmnIPMZIg1bk5c5iWJ6mCSbFBN+Zh75AiXGRpgAYFVlFy
        I0EcBSW+uPsr5+yLNneI82S52KxlvnKS2OZDGivJVxUww5ChVbCW8n/gpzew6J51
        EPRJQI4INx+7popxyvGFQ+PHTlOfNnYq4LRm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RIJJQN6EKJvZCtPgVYD6YkjO7GtJnNJg
        AlqTjvs7AstTcF6zPmTvngF5Q86E7OM0U3A8QAI3VAhYrQrmh/ShEUlouTAd5IkP
        VYGgt9gKG9m12Qpj/puMYtxVAVwnrQfzEAQdaJx1EI4UYAdz6Z5+553QfDXuGc6A
        yV8b+7h/Zb8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10AA6A3033;
        Wed, 13 Nov 2019 21:07:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 424DAA3032;
        Wed, 13 Nov 2019 21:07:27 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Grzegorz Rajchman <rayman17@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v3] stash: make sure we have a valid index before writing it
References: <CAMcnqp22tEFva4vYHYLzY83JqDHGzDbDGoUod21Dhtnvv=h_Pg@mail.gmail.com>
        <20191107184912.GA3115@cat>
        <xmqq7e4bp06l.fsf@gitster-ct.c.googlers.com>
        <20191108165929.GB3115@cat>
        <xmqqk188l0pn.fsf@gitster-ct.c.googlers.com>
        <20191111195641.GC3115@cat>
        <xmqqftitfz5u.fsf@gitster-ct.c.googlers.com>
        <20191113111539.GA3047@cat>
        <xmqq4kz7c37i.fsf@gitster-ct.c.googlers.com>
        <20191113150136.GB3047@cat>
Date:   Thu, 14 Nov 2019 11:07:24 +0900
In-Reply-To: <20191113150136.GB3047@cat> (Thomas Gummerer's message of "Wed,
        13 Nov 2019 15:01:36 +0000")
Message-ID: <xmqqmucz9pnn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 81968D30-0683-11EA-BF35-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Subject: [PATCH v3] stash: make sure we have a valid index before writing it
>
> In 'do_apply_stash()' we refresh the index in the end.  Since
> 34933d0eff ("stash: make sure to write refreshed cache", 2019-09-11),
> we also write that refreshed index when --quiet is given to 'git stash
> apply'.
>
> However if '--index' is not given to 'git stash apply', we also
> discard the index in the else clause just before.  We need to do so
> because we use an external 'git update-index --add --stdin', which
> leads to an out of date in-core index.
>
> Later we call 'refresh_and_write_cache', which now leads to writing
> the discarded index, which means we essentially write an empty index
> file.  This is obviously not correct, or the behaviour the user
> wanted.  We should not modify the users index without being asked to
> do so.
>
> Make sure to re-read the index after discarding the current in-core
> index, to avoid dealing with outdated information.  Instead we could
> also drop the 'discard_cache()' + 'read_cache()', however that would
> make it easy to fall into the same trap as 34933d0eff did, so it's
> better to avoid that.
>
> We can also drop the 'refresh_and_write_cache' completely in the quiet
> case.  Previously in legacy stash we relied on 'git status' to refresh
> the index after calling 'git read-tree' when '--index' was passed to
> 'git apply'.  However the 'reset_tree()' call that replaced 'git
> read-tree' always passes options that are equivalent to '-m', making
> the refresh of the index unnecessary.
>
> Reported-by: Grzegorz Rajchman <rayman17@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

Thanks.  This looks good and minimal ;-)

>  builtin/stash.c  | 7 +++----
>  t/t3903-stash.sh | 7 ++++++-
>  2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index ab30d1e920..372fbdb7ac 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -481,13 +481,12 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  		if (ret)
>  			return -1;
>  
> +		/* read back the result of update_index() back from the disk */
>  		discard_cache();
> +		read_cache();
>  	}
>  
> -	if (quiet) {
> -		if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> -			warning("could not refresh index");
> -	} else {
> +	if (!quiet) {
>  		struct child_process cp = CHILD_PROCESS_INIT;
>  
>  		/*
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 392954d6dd..9de1c3616a 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -232,8 +232,11 @@ test_expect_success 'save -q is quiet' '
>  	test_must_be_empty output.out
>  '
>  
> -test_expect_success 'pop -q is quiet' '
> +test_expect_success 'pop -q works and is quiet' '
>  	git stash pop -q >output.out 2>&1 &&
> +	echo bar >expect &&
> +	git show :file >actual &&
> +	test_cmp expect actual &&
>  	test_must_be_empty output.out
>  '
>  
> @@ -242,6 +245,8 @@ test_expect_success 'pop -q --index works and is quiet' '
>  	git add file &&
>  	git stash save --quiet &&
>  	git stash pop -q --index >output.out 2>&1 &&
> +	git diff-files file2 >file2.diff &&
> +	test_must_be_empty file2.diff &&
>  	test foo = "$(git show :file)" &&
>  	test_must_be_empty output.out
>  '
