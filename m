Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3515DC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 08:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359316AbhKZIHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:07:38 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55371 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245061AbhKZIFh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 03:05:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3B67F2B7F;
        Fri, 26 Nov 2021 03:02:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VGNYcLpdX6bj/e78jnJQ2gsneZ13BQ91jBVqo+
        Xvi8Y=; b=LoU3HWjYVN+WuTG0Fc8OQieg3X8l+u5p5ZqdCcUdr9TbruPPYoyN14
        Dv2LgQSCvphY2H3cpng3HPpkQZd50R/43QlioMO8VMF8x387xfH3B1xYfr2mMq3+
        RMyANgNNYDz/P8a0e5jDSL6KJGetP8B/aAyrabaL9OAFfTqFdj3UE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9F03F2B7E;
        Fri, 26 Nov 2021 03:02:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4EFB6F2B7D;
        Fri, 26 Nov 2021 03:02:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/5] test-ref-store: tweaks to for-each-reflog-ent
 format
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <62f5cb8a8243f9e5c2af5c148ed586a2504c8cee.1637855872.git.gitgitgadget@gmail.com>
Date:   Fri, 26 Nov 2021 00:02:22 -0800
In-Reply-To: <62f5cb8a8243f9e5c2af5c148ed586a2504c8cee.1637855872.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 25 Nov 2021
        15:57:51 +0000")
Message-ID: <xmqqsfvj73ap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2FF35552-4E8F-11EC-8A2B-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	printf("%s %s %s %" PRItime " %d %s", oid_to_hex(old_oid),
> -	       oid_to_hex(new_oid), committer, timestamp, tz, msg);
> +	printf("%s %s %s %" PRItime " %+05d%s%s", oid_to_hex(old_oid),
> +	       oid_to_hex(new_oid), committer, timestamp, tz,
> +	       *msg == '\n' ? "" : "\t", msg);

So, we used to show the timezone as an integer casually, but now we
make sure we use the +/- prefix, with 0 filled 4 digits, that is
consistent with how we record the tz in different places (like the
low-level object header, or the user-visible header lines in commit
and tag objects).

>  	return 0;
>  }
>  
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 0d4f73acaa8..0d46a488032 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -321,8 +321,9 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
>  $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
>  EOF
>  test_expect_success "verifying $m's log (logged by touch)" '
> -	test_when_finished "rm -rf .git/$m .git/logs expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&

micronit: lose SP between redirection '>' and its target 'actual'.

> +	test_cmp actual expect

And the +0000 will be checked by comparing with "expect" file.  Nice.

>  '
>  
>  test_expect_success "create $m (logged by config)" '
> @@ -350,8 +351,9 @@ $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
>  $B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
>  EOF
>  test_expect_success "verifying $m's log (logged by config)" '
> -	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&

Ditto.

> +	test_cmp actual expect
>  '
>  
>  test_expect_success 'set up for querying the reflog' '
> @@ -467,7 +469,8 @@ $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	co
>  $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
>  EOF
>  test_expect_success 'git commit logged updates' '
> -	test_cmp expect .git/logs/$m
> +	test-tool ref-store main for-each-reflog-ent $m >actual &&

This one is good.

> +	test_cmp expect actual
>  '
>  unset h_TEST h_OTHER h_FIXED h_MERGED

Thanks.
