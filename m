Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C158F2047F
	for <e@80x24.org>; Wed, 26 Jul 2017 20:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbdGZUbE (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 16:31:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51065 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751022AbdGZUbD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 16:31:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BBA6914C4;
        Wed, 26 Jul 2017 16:30:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CnOzRmatEXIy9ZGXpV8ArYkKKrM=; b=KRRO+5
        JQ1E1fKWmjakYyMOXFK6Ft8refnZzSqLLbNg6GWvu2HwQ1OvT6DBitK8GCvdTbEY
        5Sg5dCfxYf1cEj6Lv4Y8HoQJFiW5LyW0yaPL4y4jbwY1x2EhbWtny98KBtCnRX4E
        9Wy02VN7elDoCxYHTYFi5yng1V8mxEN1MCeG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HgzMxMAmMzu7Nr+KQXWa8dB0sga3BuEE
        hWK9oLfVv2MjrBe0pd5Cc/zXxz7PysiAD/R28CPX/k1M1ozEiKYOYf8IIWTxtatz
        ZpexbHZJpkzcZ3Bg7CQlixg/hiQQf9gQBv+GRrGgIXdb6VqYgM8LKflOm95QHWTN
        A2j+btOjn00=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03672914C3;
        Wed, 26 Jul 2017 16:30:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 69EAC914C1;
        Wed, 26 Jul 2017 16:30:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] submodule: correct error message for missing commits.
References: <20170726200832.28522-1-sbeller@google.com>
Date:   Wed, 26 Jul 2017 13:30:54 -0700
In-Reply-To: <20170726200832.28522-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 26 Jul 2017 13:08:32 -0700")
Message-ID: <xmqqh8xzq6td.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53531B92-7241-11E7-BEAE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> When a submodule diff should be displayed we currently just add the
> submodule objects to the main object store and then e.g. walk the
> revision graph and create a summary for that submodule.
>
> It is possible that we are missing the submodule either completely or
> partially, which we currently differentiate with different error messages
> depending on whether (1) the whole submodule object store is missing or
> (2) just the needed for this particular diff. (1) is reported as
> "not initialized", and (2) is reported as "commits not present".
>
> If a submodule is deinit'ed its repository data is still around inside
> the superproject, such that the diff can still be produced. In that way
> the error message (1) is misleading as we can have a diff despite the
> submodule being not initialized.

This is confusing...  

So are you saying that if we do "submodule init A && submodule
update A" followed by "submodule deinit A", we _could_ show the
difference for submodule A between two commits in the superproject,
because we already have the necessary data for the submodule, but we
_choose_ not to show it because the user told us explicitly that the
submodule is not interesting?

That sounds like a very sensible and user-centric behaviour to me,
and "not initialized" sounds like the right message to give in such
a case (as opposed to "commits not present"---even the user told us
they are not interesting, we may have them, so "not present" is not
just incorrect but irrelevant because that is not the reason why we
are not showing).

Or are you saying that even the user told us that the submodule is
not interesting, if we had "init" it earlier even once, we show the
difference and with a wrong label?  Showing the difference sounds
like a bug that is more severe than using a wrong label to me.

Puzzled.

>
> Downgrade the error message (1) to be the same as (2) and just say
> the commits are not present, as that is the true reason why the diff
> cannot be shown.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> I came across this error message in the series for the
> object store modularisation[1], when I was trying to replace
> 'add_submodule_odb' by a custom loaded object store from a
> submodule repo object, which got me thinking on the error
> message and the true cause for it.  
>
> While this could go in separately, I may carry it in that
> series, as there we'd come up with more error messages
> ("could not create submodule object store" as well as the
> "commits not present", maybe even "submodule not lookup failed")
>
> Thanks,
> Stefan
>
> [1] https://public-inbox.org/git/20170706202739.6056-1-sbeller@google.com/
>   
>
>  submodule.c                               | 2 +-
>  t/t4059-diff-submodule-not-initialized.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6531c5d609..280c246477 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -567,7 +567,7 @@ static void show_submodule_header(FILE *f, const char *path,
>  
>  	if (add_submodule_odb(path)) {
>  		if (!message)
> -			message = "(not initialized)";
> +			message = "(commits not present)";
>  		goto output_header;
>  	}
>  
> diff --git a/t/t4059-diff-submodule-not-initialized.sh b/t/t4059-diff-submodule-not-initialized.sh
> index cd70fd5192..49bca7b48d 100755
> --- a/t/t4059-diff-submodule-not-initialized.sh
> +++ b/t/t4059-diff-submodule-not-initialized.sh
> @@ -95,7 +95,7 @@ test_expect_success 'submodule not initialized in new clone' '
>  	git clone . sm3 &&
>  	git -C sm3 diff-tree -p --no-commit-id --submodule=log HEAD >actual &&
>  	cat >expected <<-EOF &&
> -	Submodule sm1 $smhead1...$smhead2 (not initialized)
> +	Submodule sm1 $smhead1...$smhead2 (commits not present)
>  	EOF
>  	test_cmp expected actual
>  '
