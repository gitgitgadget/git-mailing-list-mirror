Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C81C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiFXQDi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiFXQDh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 12:03:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A5653A53
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 09:03:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 920551AFD2F;
        Fri, 24 Jun 2022 12:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cC57z9pe3rhrOmfzYQnCWILjzTFaBGYXVDJDLk
        OENFc=; b=AanWhIm8/e4Ye8WSxmhAUo1ssJmcRRhRPeeo456C2tbFFPSbLhcQWm
        rmxpnjNOQ5HbWwt+R9ESC/w86aqbESzsXwuEkedKR/ZMTPI2GjP9WK0ihD9k4XH1
        p4kq/LkNVzIL5Dillb6eQ5lE+8j9u6k5zGgifmmxq4GKu/ZklOfYM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7603C1AFD2E;
        Fri, 24 Jun 2022 12:03:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0BE3B1AFD2D;
        Fri, 24 Jun 2022 12:03:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <hanxin.hx@bytedance.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [PATCH v2 1/2] test-lib.sh: add limited processes to test-lib
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
        <cover.1656044659.git.hanxin.hx@bytedance.com>
        <442a4c351dea603e226bae89eddc2b3496d93262.1656044659.git.hanxin.hx@bytedance.com>
Date:   Fri, 24 Jun 2022 09:03:28 -0700
In-Reply-To: <442a4c351dea603e226bae89eddc2b3496d93262.1656044659.git.hanxin.hx@bytedance.com>
        (Han Xin's message of "Fri, 24 Jun 2022 13:27:56 +0800")
Message-ID: <xmqqfsjuvyjz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 309B90D0-F3D7-11EC-99AB-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han Xin <hanxin.hx@bytedance.com> writes:

> We will use the lazy prerequisite ULIMIT_PROCESSES in a follow-up
> commit.
>
> With run_with_limited_processses() we can limit forking subprocesses and
> fail reliably in some test cases.
>
> Signed-off-by: Han Xin <hanxin.hx@bytedance.com>
> ---
>  t/test-lib.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8ba5ca1534..f920e3b0ae 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1816,6 +1816,15 @@ test_lazy_prereq ULIMIT_FILE_DESCRIPTORS '
>  	run_with_limited_open_files true
>  '
>  
> +run_with_limited_processses () {
> +	(ulimit -u 512 && "$@")

The "-u" presumably is a way to say that the current user can have
only 512 processes at once that is supported by bash and ksh?  dash
seems to use "-p" for this but "-p" of course means something
completely different to other shells (and is read-only), which is a
mess X-<.

I suspect that it is OK to make it practically bash-only, but then ...

> +}
> +
> +test_lazy_prereq ULIMIT_PROCESSES '
> +	test_have_prereq !HPPA,!MINGW,!CYGWIN &&
> +	run_with_limited_processses true

... as this lazy-prereq makes a trial run that would fail when the
system does not allow "ulimit -u 512", do we need the platform
specific prereq check?  I am wondering if the second line alone is
sufficient.

Also, 512 is not a number I would exactly call "limit forking".
Does it have to be so high, I wonder.  Of course it cannot be so low
like 3 or 8 or even 32, as per-user limitation counts your window
manager and shells running in other windows.

What you ideally want is an option that lets you limit the number of
processes the shell that issued the ulimit call can spawn
simultaneously, but I didn't find it in "man bash/dash/ksh".

> +'
> +
>  build_option () {
>  	git version --build-options |
>  	sed -ne "s/^$1: //p"
