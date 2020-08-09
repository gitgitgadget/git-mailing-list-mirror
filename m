Return-Path: <SRS0=dguO=BT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96168C433DF
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673A0206B5
	for <git@archiver.kernel.org>; Sun,  9 Aug 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiEgTY/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHITMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:12:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59747 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHITMn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Aug 2020 15:12:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E2C56DF5E2;
        Sun,  9 Aug 2020 15:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zh/vxNarnNLQY7kCLtrQVcgVzUc=; b=uiEgTY
        /Q+GE84LMwuU2os1IfHDCQFAjRTdjolc7dsUwshl7qMOpo/YqsDbws1//dJMFg/U
        2UuJVXdSt6z6jzCPp492fq+ga5UKP9y+SlDhxDDNlQtFA4NvqXYMgagDtW9M0RlY
        o8qkvBq9mlqSlN7eWpryv7U879J3IjCSgG0+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4dlpYZD71msoa8+BA+7zr7GudrGTvyM
        LvqqEbiZJ0QSxSwCtKML3m6lotlB796ZPvYJB9dRDA8yqlhO/yYC9kwVMAQPdCY4
        DpH0+tfwrPQnCbZc/oqwsf0iN0kur0fJIob9wQ/pViAumCUFOYUNYh7Z8vNvhPK3
        i++9la1pUew=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DB1E4DF5E1;
        Sun,  9 Aug 2020 15:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3794EDF5DF;
        Sun,  9 Aug 2020 15:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: Re: [PATCH v2] test_cmp: diagnose incorrect arguments
References: <20200809060810.31370-1-sunshine@sunshineco.com>
        <20200809174209.15466-1-sunshine@sunshineco.com>
Date:   Sun, 09 Aug 2020 12:12:37 -0700
In-Reply-To: <20200809174209.15466-1-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 9 Aug 2020 13:42:09 -0400")
Message-ID: <xmqq7du7eiqi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AB1122A-DA74-11EA-8FAF-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Under normal circumstances, if a test author misspells a filename passed
> to test_cmp(), the error is quickly discovered when the test fails
> unexpectedly due to test_cmp() being unable to find the file. However,
> if the test is expected to fail, as with test_expect_failure(), a
> misspelled filename as argument to test_cmp() will go unnoticed since
> the test will indeed fail, but for the wrong reason. Make it easier for
> test authors to discover such problems early by sanity-checking the
> arguments to test_cmp(). To avoid penalizing all clients of test_cmp()
> in the general case, only check for missing files if the comparison
> fails.
>
> While at it, make test_cmp_bin() sanity-check its arguments, as well.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

The motivation makes quite a lot of sense.

I suspect that it is a bug to use "-", i.e. "read from the standard
input", for "$2", because

 (1) if it is used for the expected output, we got the comparison in
     the wrong direction;

 (2) if it is used for the actual output, we have a command whose
     output we are interested in on the upstream side of a pipe to
     discard its exit status.

but I'll let it pass.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index b791933ffd..a12d6a3fc9 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -952,7 +952,13 @@ test_expect_code () {
>  # - not all diff versions understand "-u"
>  
>  test_cmp() {
> -	eval "$GIT_TEST_CMP" '"$@"'
> +	test $# -eq 2 || BUG "test_cmp requires two arguments"
> +	if ! eval "$GIT_TEST_CMP" '"$@"'
> +	then
> +		test "x$1" = x- || test -e "$1" || BUG "test_cmp '$1' missing"
> +		test "x$2" = x- || test -e "$2" || BUG "test_cmp '$2' missing"
> +		return 1
> +	fi
>  }
>  
>  # Check that the given config key has the expected value.
> @@ -981,7 +987,13 @@ test_cmp_config() {
>  # test_cmp_bin - helper to compare binary files
>  
>  test_cmp_bin() {
> -	cmp "$@"
> +	test $# -eq 2 || BUG "test_cmp_bin requires two arguments"
> +	if ! cmp "$@"
> +	then
> +		test "x$1" = x- || test -e "$1" || BUG "test_cmp_bin '$1' missing"
> +		test "x$2" = x- || test -e "$2" || BUG "test_cmp_bin '$2' missing"
> +		return 1
> +	fi
>  }
>  
>  # Use this instead of test_cmp to compare files that contain expected and
