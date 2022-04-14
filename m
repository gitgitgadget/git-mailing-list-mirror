Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6B7C433EF
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiDNFIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiDNFIf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:08:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFEF24BC0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:06:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C18B019F2C0;
        Thu, 14 Apr 2022 01:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XLMrc6cE8Qv54aPspeR4bVQhbCBtPgRuEBxR6W
        spycs=; b=jqyqwUAbpEJXSFHcU2CiCLxnKpJX/MuhGFs0QVv99UrSs5DZ52EGMX
        avtBuqDc5BtKhCZ3J4EKsf/5/FYkO+sL7bXVbgkaMjoKwjmiCRYPwC1dpXZbLzag
        YVmIt/HQdxgzUSitZyTp+QIMoPVkZBxFiC2uDk8iQTl2pbSMm0sy0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BAE3719F2BF;
        Thu, 14 Apr 2022 01:06:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3716719F2BD;
        Thu, 14 Apr 2022 01:06:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] Makefile: add a prerequisite to the coverage-report
 target
References: <20220414022513.31465-1-gitter.spiros@gmail.com>
Date:   Wed, 13 Apr 2022 22:06:05 -0700
In-Reply-To: <20220414022513.31465-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Thu, 14 Apr 2022 02:25:13 +0000")
Message-ID: <xmqqsfqg2r0i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97859836-BBB0-11EC-9CB4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Directly invoking make coverage-report as a target results in an error because
> its prerequisites are missing,
>
> This patch adds the compile-test prerequisite, which is run only once each time
> the compile-report target is invoked. In practice, the developer may decide to
> review the coverage-report results without necessarily rerunning for this
> coverage-test, if it has already been run.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
> This is the third revision of the patch. Compared to the second:
>
> - deleted the Makefile coverage-test.file variable, replaced directly by the
>   coverage-test.made file
> - added in coverage-compile as last command the touch of coverage-test.made, so
>   that even if coverage-test is run first, invoking indirectly it by the first coverage-report does not
>   call coverage-test and so the test suite gain.
>
>  Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f8bccfab5e..d6ae228c74 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3407,6 +3407,7 @@ coverage-clean-results:
>  	$(RM) coverage-untested-functions
>  	$(RM) -r cover_db/
>  	$(RM) -r cover_db_html/
> +	$(RM) coverage-test.made
>  
>  coverage-clean: coverage-clean-results
>  	$(RM) $(addsuffix *.gcno,$(object_dirs))
> @@ -3421,13 +3422,18 @@ coverage-compile:
>  coverage-test: coverage-clean-results coverage-compile
>  	$(MAKE) CFLAGS="$(COVERAGE_CFLAGS)" LDFLAGS="$(COVERAGE_LDFLAGS)" \
>  		DEFAULT_TEST_TARGET=test -j1 test
> +	touch coverage-test.made
> +
> +coverage-test.made:
> +	@make coverage-test

s/@make/$(MAKE)/, I think.

> +	touch coverage-test.made

Other than that, looking good.

Thanks.
