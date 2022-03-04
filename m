Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116C3C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbiCDCNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiCDCNe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:13:34 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268623B29C
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:12:44 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22D471092E6;
        Thu,  3 Mar 2022 21:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fHRpPt++y0GHcwNqNpLl1wx5xXwIhjhbp9syBi
        ulddU=; b=QR1qgN/o1ho/TiR9ZT7dvqEEXAyAI3yQT2aD7yAyCXlyh6A0gKYrWn
        /ItOEVm2668jk1g2f+7NyadOULoPQvlO/zu6p7qC2W/Dw57qtde7Vx2CwP5WyDL4
        UMIDEgi1W9uIzaIE0quC865iRwxVDXCN1rTHaYwB/C8EQxSSarfLU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 197D71092E5;
        Thu,  3 Mar 2022 21:12:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54D421092E4;
        Thu,  3 Mar 2022 21:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 02/10] t5526: stop asserting on stderr literally
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-3-chooglen@google.com>
Date:   Thu, 03 Mar 2022 18:12:41 -0800
In-Reply-To: <20220304005757.70107-3-chooglen@google.com> (Glen Choo's message
        of "Thu, 3 Mar 2022 16:57:49 -0800")
Message-ID: <xmqq8rtq5uue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92CBDB36-9B60-11EC-A407-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> In the previous commit message, we noted that not all of the "git fetch"
> stderr is relevant to the tests. Most of the test setup lines are
> dedicated to these details of the stderr:
>
> 1. which repos (super/sub/deep) are involved in the fetch
> 2. the head of the remote-tracking branch before the fetch (i.e. $head1)
> 3. the head of the remote-tracking branch after the fetch (i.e. $head2)
>
> 1. and 3. are relevant because they tell us that the expected commit is
> fetched by the expected repo, but 2. is completely irrelevant.
>
> Stop asserting on $head1 by replacing it with a dummy value in the
> actual and expected output. Do this by introducing test
> helpers (check_*()) that make it easier to construct the expected
> output, and use sed to munge the actual output.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  t/t5526-fetch-submodules.sh | 119 +++++++++++++++++-------------------
>  1 file changed, 57 insertions(+), 62 deletions(-)
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index dff7a4b90b..6b24d37b2b 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -10,6 +10,32 @@ export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
>  
>  pwd=$(pwd)
>  
> +check_sub () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.sub <<-EOF

Style.

	cat >"$pwd/expect.err.sub" <<-EOF

Here, $pwd most likely has an $IFS letter in it (because we
deliberately use "trash directory.xxxx" as the place to run our
tests in) but a redirection target does not go through $IFS word
splitting, so such a quoting is not technically necessary, but
some versions of bash are known to throw a warning if we don't,
and an extra quoting does not hurt.

> +check_deep () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.deep <<-EOF

Likewise.

> +	Fetching submodule submodule/subdir/deepsubmodule
> +	From $pwd/deepsubmodule
> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
> +	EOF
> +}
> +
> +check_super () {
> +	NEW_HEAD=$1 &&
> +	cat >$pwd/expect.err.super <<-EOF

Likewise.

> +	From $pwd/.
> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
> +	EOF
> +}
