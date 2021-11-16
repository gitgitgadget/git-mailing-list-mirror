Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA577C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE88F63212
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 06:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhKPGMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 01:12:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52543 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhKPGMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 01:12:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99C2B15B93D;
        Tue, 16 Nov 2021 01:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sLm2/lCulxdrT4T0XDdxCSvTdv8dnKmMMnIIjpr+00I=; b=d1xJ
        /KYpUIz6lCzXaJoyLtvQt34RtFtB/J7BuIHgUYZw1l611DwIgBYIYI8uHsn8YkCd
        KRerwQhEZNhiIUKrYKV8pudwB6AmtVzxlzZvxf7vZC+CvfxUO5hndP3CmQDSi6LO
        TbNwp+HiLt96QDI5NIlFRrPy25oHls7HYfQlmkk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 841E015B93C;
        Tue, 16 Nov 2021 01:09:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D8B7E15B93B;
        Tue, 16 Nov 2021 01:09:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] test-lib: introduce required prereq for test runs
References: <20211115160750.1208940-1-fs@gigacodes.de>
        <20211115160750.1208940-3-fs@gigacodes.de>
Date:   Mon, 15 Nov 2021 22:09:08 -0800
Message-ID: <xmqqpmr0bpiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B69D8EE0-46A3-11EC-989D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> In certain environments or for specific test scenarios we might expect a
> specific prerequisite check to be succeed. Therefore we would like to

"to be succeed" -> "to succeed"?

> trigger an error when running our tests if this is not the case.
>
> To remedy this we add the environment variable GIT_TEST_REQUIRE_PREREQ
> which can be set to a comma separated list of prereqs. If one of these
> prereq tests fail then the whole test run will abort.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/README                |  6 ++++++
>  t/test-lib-functions.sh | 11 +++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/t/README b/t/README
> index 29f72354bf..18ce75976e 100644
> --- a/t/README
> +++ b/t/README
> @@ -466,6 +466,12 @@ explicitly providing repositories when accessing submodule objects is
>  complete or needs to be abandoned for whatever reason (in which case the
>  migrated codepaths still retain their performance benefits).
>  
> +GIT_TEST_REQUIRE_PREREQ=<list> allows specifying a comma speparated list of
> +prereqs that are required to succeed. If a prereq in this list is triggered by
> +a test and then fails then the whole test run will abort. This can help to make
> +sure the expected tests are executed and not silently skipped when their
> +dependency breaks or is simply not present in a new environment.
> +
>  Naming Tests
>  ------------
>  
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index eef2262a36..2c8abf3420 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -680,6 +680,17 @@ test_have_prereq () {
>  			# Keep a list of missing prerequisites; restore
>  			# the negative marker if necessary.
>  			prerequisite=${negative_prereq:+!}$prerequisite
> +
> +			# Abort if this prereq was marked as required
> +			if test -n $GIT_TEST_REQUIRE_PREREQ
> +			then
> +				case ",$GIT_TEST_REQUIRE_PREREQ," in
> +				*,$prerequisite,*)
> +					error "required prereq $prerequisite failed"
> +					;;
> +				esac
> +			fi
> +
>  			if test -z "$missing_prereq"
>  			then
>  				missing_prereq=$prerequisite
