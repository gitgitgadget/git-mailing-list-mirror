Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284EDC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 06:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiANGBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 01:01:11 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56748 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiANGBL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 01:01:11 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C180217A8B3;
        Fri, 14 Jan 2022 01:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uz3Sx/14ATOekVsb7cMxx6FHPTQPlp3/KWKpLb
        E/b00=; b=wfvtI7tD7h6ZTlfQqIhwCMwVfTyaEAZWU3v7FQVo6nno2JFN0KmZyL
        hhc//ylqFBfGYGvf0/F+8XWnVZh9U1Y83KeYdkEH5Z8jLW91/F8AEnK+elVt45+m
        cQqGLH3T4j9V44S0QVbM+CsYok8JuDi2eliVLCvLkfXP2O47eEzWI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA48F17A8B2;
        Fri, 14 Jan 2022 01:01:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 33A2217A8B0;
        Fri, 14 Jan 2022 01:01:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: unset trace2 parent envvars
References: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
Date:   Thu, 13 Jan 2022 22:01:07 -0800
In-Reply-To: <82e51a52e20fbe13a5a898a0a2f6dbe1188e3fa3.1642116539.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 13 Jan 2022 19:33:36 -0800")
Message-ID: <xmqq35lqetzw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DE2CDEE-74FF-11EC-B83F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> This behavior breaks certain tests that examine trace2 output when the
> tests run as a child of another git process, such as in `git rebase -x
> "make test"`.

Well explained.  The paragraph makes it clear how easy to trigger
and get bitten by this problem.

> While we could fix this by unsetting the relevant variables in the
> affected tests (currently t0210, t0211, t0212, and t6421), this would
> leave other tests vulnerable to similar breakage if new test cases are
> added which inspect trace2 output. So fix this in general by unsetting
> GIT_TRACE2_PARENT_NAME and GIT_TRACE2_PARENT_SID in test-lib.sh.

This probably makes sense, but I wonder how it interacts with a user
who runs "cd t && GIT_TRACE2=blah ./t0987-test-this.sh" to trace the
entire test script, though.

> Reported-by: Emily Shaffer <emilyshaffer@google.com>
> Helped-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 0f7a137c7d..e4716b0b86 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -449,6 +449,8 @@ unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
>  unset XDG_CACHE_HOME
>  unset XDG_CONFIG_HOME
>  unset GITPERLLIB
> +unset GIT_TRACE2_PARENT_NAME
> +unset GIT_TRACE2_PARENT_SID

Hmph.  Have you noticed the more generic "We want to unset almost
everything that begins with GIT_, other than those selected few that
are designed to be used to affect the tests" above the part you
touched?

I am wondering if we should tweak the list there, instead of special
casing these two and these two only. There is a pattern that allows
anything that match "^GIT_(other|TRACE|things)", and I suspect that
the pattern is way too loose (i.e. it allows any garbage to follow,
and by allowing "TRACE", it also catches "TRACE2" because the former
is a prefix of the latter), which is a problem.
