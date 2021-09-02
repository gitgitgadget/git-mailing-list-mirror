Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916F1C433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FA460724
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347656AbhIBWGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:06:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64291 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhIBWGr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:06:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 962C3EF95E;
        Thu,  2 Sep 2021 18:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0Z2x8lNaJ2mze8Rhs8o4VW9SZT5h7tZF3SZQp3
        1GgZc=; b=BpZv9IG03V2sXopVDngD/fR2tqeFL1bDxoMsG5RVoF0rGrsOKBbJbU
        VlSXUfzxLrc1kRgW4Gv5z3mbkN5I8h6vzjRefol+Zqd1GGeGOK7qF0RiMyQ4BJ7m
        RFTgdfSAqjDek+cSOsEKL+y4wSj2Hg61BYBA7pp/SxKWHqW1zInyY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E608EF95D;
        Thu,  2 Sep 2021 18:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1689CEF95C;
        Thu,  2 Sep 2021 18:05:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/6] t6030-bisect-porcelain: add test for bisect
 visualize
References: <20210902090421.93113-1-mirucam@gmail.com>
        <20210902090421.93113-3-mirucam@gmail.com>
Date:   Thu, 02 Sep 2021 15:05:46 -0700
In-Reply-To: <20210902090421.93113-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Thu, 2 Sep 2021 11:04:17 +0200")
Message-ID: <xmqqpmtqiqf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED08FA86-0C39-11EC-B816-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> Add a test to control breakages in bisect visualize command.
>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  t/t6030-bisect-porcelain.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index e61b8143fd..f13eeac9ce 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -973,4 +973,11 @@ test_expect_success 'bisect run fails with exit code equals or greater than 128'
>  	test_must_fail git bisect run ./test_script.sh >> my_bisect_log.txt
>  '
>  
> +test_expect_success 'bisect visualize with a filename with dash and space' '
> +	echo "My test line" >> -hello\ 2 &&

The same style guide for redirection applies here.

Also, it makes sense to quote such an unusual filename for human
readers, i.e.

	echo "My test line" >"./-hello 2" &&

> +	git add -- -hello\ 2 &&
> +	git commit --quiet -m "Add test line" -- -hello\ 2 &&

Likewise.  

Especially since this is not a test for "git add" or "git commit",
instead of writing "-hello 2", "./-hello 2" may help human readers
better.

> +	git bisect visualize -p -- -hello\ 2 > my_bisect_log.txt

This one, if it is meant to test the pathspec parsing of the command
being tested (i.e. "git bisect"), is probably better to be left
without "./" prefix, i.e. "-hello 2".

The same comment applies to the redirection into my_bisect_log.txt
file.  It is better not to redirect this at all.

This is the first use of "git bisect visualize" in our tests.  How
are we making sure that we won't open gitk and leave it hanging and
doing silly things like that?

    ... goes and looks ...

Ah, OK.  "git bisect --help" makes it clear that giving an option
like "-p" tells us to run "git log", so we are OK.

THanks.




> +'
> +
>  test_done
