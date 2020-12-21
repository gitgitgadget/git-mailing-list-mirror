Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB5C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35828229CA
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLUVJU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:09:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63399 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLUVJU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:09:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1D0E108933;
        Mon, 21 Dec 2020 16:08:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kryJazaDhZdIObN+Jcf4dAqrgQo=; b=h6HsbM
        r/TM5sI6FnTDzMSGpI9Ar98B5j+Txk13pR/IW/U0J2aXp2VWiLPnCpNKNlxdXZcm
        mt/uTjDqeuUrUyTFLZ3jj+5YN0kig4qlDXyA5NFe7g0416Qlw6BPywKowYjHORG+
        k/Kknw/Wn37/0tFGYvQHBT9pLt5LQMIASi+Og=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dRclnLlslJgywgVQQoFbeB+pN/ndOU64
        36xHiMEWC097rOX8Sqhrgh0dhTHYHeZMaxTgxztn4tP5LqSDpBRb5VV+8eupq1/0
        f+VZj7PHYkYrdJHh5s2g8+lnmBfFQqsQ/SZaxQjZlLhdzqnlzAPid+OllGeweWom
        4g/2Xsu2bvs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99362108932;
        Mon, 21 Dec 2020 16:08:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD8BB108930;
        Mon, 21 Dec 2020 16:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] test: bisect-porcelain: fix location of files
References: <20201218151406.1193792-1-felipe.contreras@gmail.com>
Date:   Mon, 21 Dec 2020 13:08:32 -0800
In-Reply-To: <20201218151406.1193792-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Fri, 18 Dec 2020 09:14:06 -0600")
Message-ID: <xmqqk0talve7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF5BF1D4-43D0-11EB-9B15-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Commit ba7eafe146 (t6030: explicitly test for bisection cleanup,
> 2017-09-29) introduced checks for files in the $GIT_DIR directory, but
> that variable is not always defined, and in this test file it's not.

It is somewhat surprising that nobody caught it for 3 years, but
perhaps nobody cared very deeply (and it must have helped that the
feature it purports to test is not broken).

Will queue.

>
> Therefore these checks always passed regardless of the presence of these
> files (unless the user has some /BISECT_LOG file, for some reason).
>
> Let's check the files in the correct location.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  t/t6030-bisect-porcelain.sh | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)



>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 34099160ed..6d5440d704 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -926,14 +926,14 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
>  	git bisect bad $HASH4 &&
>  	git bisect reset &&
>  	test -z "$(git for-each-ref "refs/bisect/*")" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_EXPECTED_REV" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_LOG" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_RUN" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_TERMS" &&
> -	test_path_is_missing "$GIT_DIR/head-name" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_HEAD" &&
> -	test_path_is_missing "$GIT_DIR/BISECT_START"
> +	test_path_is_missing ".git/BISECT_EXPECTED_REV" &&
> +	test_path_is_missing ".git/BISECT_ANCESTORS_OK" &&
> +	test_path_is_missing ".git/BISECT_LOG" &&
> +	test_path_is_missing ".git/BISECT_RUN" &&
> +	test_path_is_missing ".git/BISECT_TERMS" &&
> +	test_path_is_missing ".git/head-name" &&
> +	test_path_is_missing ".git/BISECT_HEAD" &&
> +	test_path_is_missing ".git/BISECT_START"
>  '
>  
>  test_done
