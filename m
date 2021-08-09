Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC554C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9057161051
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 19:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbhHITQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 15:16:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52106 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbhHITQs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 15:16:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FF6A15F5CB;
        Mon,  9 Aug 2021 15:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yRdgbHVPWeWrnWCOjpPkZpNKf7EuRqxka6gMZ7
        bU+2g=; b=brxh9t0Jkzr8Tsi8NspaCCo6HGLmxj0ctnDMfEXLIHQI7UwpJD97m5
        KYhjMQOjswmzJAlrl67zRgAusF+/8N0GUG2xcEz6xDdxDRZpllXDQZfpBhyBkUZs
        f9CUC+cYKeDcQ10JxNHYhOIMsPm/arL2hKlx/ZVvTS/Eg9or9v/ck=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8858515F5CA;
        Mon,  9 Aug 2021 15:16:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D10DC15F5C7;
        Mon,  9 Aug 2021 15:16:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
References: <20210730135845.633234-1-kim@eagain.st>
        <20210731203415.618641-1-kim@eagain.st>
        <20210804203829.661565-1-kim@eagain.st>
        <20210804205951.668140-1-kim@eagain.st>
        <20210809175530.75326-1-kim@eagain.st>
        <20210809175530.75326-2-kim@eagain.st>
Date:   Mon, 09 Aug 2021 12:16:22 -0700
In-Reply-To: <20210809175530.75326-2-kim@eagain.st> (Kim Altintop's message of
        "Mon, 09 Aug 2021 17:56:45 +0000")
Message-ID: <xmqq8s1afmyh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49F4AA08-F946-11EB-9B88-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kim Altintop <kim@eagain.st> writes:

> Assembling a "raw" fetch command to be fed directly to "test-tool serve-v2"
> is extracted into a test helper.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kim Altintop <kim@eagain.st>
> ---
>  t/t5703-upload-pack-ref-in-want.sh | 107 ++++++++++++++++++++---------
>  1 file changed, 74 insertions(+), 33 deletions(-)
>
> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index e9e471621d..cd4744b016 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -40,6 +40,54 @@ write_command () {
>  	fi
>  }
>
> +# Write a complete fetch command to stdout, suitable for use with `test-tool
> +# pkt-line`. "want-ref", "want", and "have" values can be given in this order,
> +# with sections separated by "--".
> +#
> +# Examples:
> +#
> +# write_fetch_command refs/heads/main
> +#
> +# write_fetch_command \
> +#	refs/heads/main \
> +#	-- \
> +#	-- \
> +#	$(git rev-parse x)
> +#
> +# write_fetch_command \
> +#	--
> +#	$(git rev-parse a) \
> +#	--
> +#	$(git rev-parse b)

Have a blank line here (or a line with "#" and nothing else) and it
would become easier to read.

> +write_fetch_command () {
> +	write_command fetch &&
> +	echo "0001" &&
> +	echo "no-progress" || return

The "while :" in this helper function are indented with 4 spaces,
not a single tab.

> +    while :
> +	do
> +		case $# in 0) break ;; esac &&
> +		case "$1" in --) shift; break ;; esac &&
> +		echo "want-ref $1" &&
> +		shift || return
> +	done &&
> +    while :
> +	do
> +		case $# in 0) break ;; esac &&
> +		case "$1" in --) shift; break ;; esac &&
> +		echo "want $1" &&
> +		shift || return
> +	done &&
> +    while :
> +	do
> +		case $# in 0) break ;; esac &&
> +		case "$1" in --) shift; break ;; esac &&
> +		echo "have $1" &&
> +		shift || return
> +	done &&
> +	echo "done" &&
> +	echo "0000"
> +}

The error checking of the helper function seems to be reasonable,
but ...

>  # c(o/foo) d(o/bar)
>  #        \ /
>  #         b   e(baz)  f(main)
> @@ -97,15 +145,13 @@ test_expect_success 'basic want-ref' '
>  	EOF
>  	git rev-parse f >expected_commits &&
>
>  	test-tool pkt-line pack >in <<-EOF &&
> +	$(write_fetch_command \
> +		refs/heads/main \
> +		-- \
> +		-- \
> +		$(git rev-parse a) \
> +	)
>  	EOF
>  	test-tool serve-v2 --stateless-rpc >out <in &&

... the code that uses the helper needs rewriting to make use of
it.  A failure in $(write_fetch_command) here will not cause the
caller to stop here.  If we had any "git" command used in the
helper, I would recommand restructuring the caller to do something
like:

    write_fetch_command >pkt-src \
	refs/heads/main \
	-- \
	-- \
	$(git rev-parse a) &&
    test-tool pkt-line pack <pkt-src >in &&
    test-tool serve-v2 --stateless-rpc >out <in &&

but it probably may not be necessary (we only use "echo" there, and
it probably is not worth worrying about 'echo' failing).

The call to $(git rev-parse a) might fail when rev-parse gets
broken, and I think the rewritten version would catch such a
breakage while the one inside $(write_fetch_command) in the here-doc
would not be.

