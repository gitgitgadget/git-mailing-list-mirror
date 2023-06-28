Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C50EB64D7
	for <git@archiver.kernel.org>; Wed, 28 Jun 2023 21:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjF1Va2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjF1VaY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2023 17:30:24 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691731FDC
        for <git@vger.kernel.org>; Wed, 28 Jun 2023 14:30:23 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B6B019240F;
        Wed, 28 Jun 2023 17:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IKL8dQkNTsCMmT3DmkGIt6ksMGgra5iKUGqkw9
        Slrhg=; b=I9Mka5RnnZwW5Qbgbj1H9/VbtbdyEPAgPPErNwOMYneCXiGJp+NfsT
        7Ug6RDbO4MA2HCd7zsTb6PgrBnpwCqAaNB6FQWHoc80J4gP5th4dDQabHZr1n3fN
        bE3sXiuvf5zyMXRMa9as92uwqbtpG8EB4C6mOtws6YuUrtojtas40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 031EB19240E;
        Wed, 28 Jun 2023 17:30:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 64F5F19240D;
        Wed, 28 Jun 2023 17:30:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Eli Schwartz <eschwartz@archlinux.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] t4205: correctly test %(describe:abbrev=...)
References: <20230628181753.10384-1-five231003@gmail.com>
Date:   Wed, 28 Jun 2023 14:30:18 -0700
In-Reply-To: <20230628181753.10384-1-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Wed, 28 Jun 2023 23:46:59 +0530")
Message-ID: <xmqqv8f7b7h1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB20C208-15FA-11EE-84F1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> The pretty format %(describe:abbrev=<number>) tells describe to use only
> <number> characters of the oid to generate the human-readable format of
> the commit-ish.

Is that *only* correct?  I thought it was "at least <number> hexdigits"
to allow for future growth of the project.

> This is not apparent in the test for %(describe:abbrev=...) because we
> directly tag HEAD and use that, in which case the human-readable format
> is just the tag name. So, create a new commit and use that instead.

Nice.  How was this found, I have to wonder, and more importantly,
how would we have written this test in the first place to avoid
testing "the wrong thing", to learn from this experience?

>  test_expect_success '%(describe:abbrev=...) vs git describe --abbrev=...' '
> -	test_when_finished "git tag -d tagname" &&
> -	git tag -a -m tagged tagname &&
> +	test_commit --no-tag file &&
>  	git describe --abbrev=15 >expect &&
>  	git log -1 --format="%(describe:abbrev=15)" >actual &&
>  	test_cmp expect actual

The current test checks that the output in the case where the number
of commits since the tag is 0, and "describe --abbrev=15" and "log
--format='%(describe:abbrev=15)'" give exactly the same result.
Which is a good thing to test.

But we *also* want to test a more typical case where there are
commits between HEAD and the tag that is used to describe it.  

And we *also* want to make sure that the hexadecimal object name
suffix used in the description is at least 15 hexdigits long, if not
more.

The updated test drops test #1 (which is questionable), adds test #2
(which is good), and still omits test #3 (which is not so good).  

So, perhaps

    test_when_finished "git tag -d tagname" &&
-   git tag -a -m tagged tagname &&
    test_commit --no-tag file &&
    git describe --abbrev=15 >expect &&
    git log -1 --format="%(describe:abbrev=15)" >actual &&
    test_cmp expect actual &&
+   sed -e "s/^.*-g\([0-9a-f]*\)$/\1/" <actual >hexpart &&
+   test 16 -le $(wc -c <hexpart) &&
+
+   git tag -a -m tagged tagname &&
+   git describe --abbrev=15 >expect &&
+   git log -1 --format="%(describe:abbrev=15)" >actual &&
+   test_cmp expect actual &&
+   test tagname = $(cat actual)

or something along the line?  First we test with a commit that is
not tagged at all to have some commits between the tag and HEAD with
the original comparison (this is for #2), then we make sure the
length of the hexpart (new---this is for #3), and then we add the
tag to see the "exact" case also works (this is for #1).

Thanks.
