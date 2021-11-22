Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC5C4332F
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 22:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhKVW0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 17:26:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50318 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbhKVWZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 17:25:58 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5161F5C62;
        Mon, 22 Nov 2021 17:22:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Otct0HcdoNWLtLpAXdUnFozs1p/Dx3S9b2ZuaY
        8GzpE=; b=BMsYxVAdUtJLxKwJL5oDbD5wXQhpSr1p0NCs70c5d7ZUUk/zjVgp4S
        wgGP8abVu8IdL9uWItFlEj0WkJzxBvxZHVj7SAVK2GT3l2HdQyQuxnSqgfAi3jw7
        3XS5im54ixn+Gc4H/y7RqcF/nYFnADk4nmopbr9ri1r7BTw/eVhE0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ABCCBF5C61;
        Mon, 22 Nov 2021 17:22:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D567F5C60;
        Mon, 22 Nov 2021 17:22:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/4] t1400: use test-helper ref-store to inspect reflog
 contents
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
Date:   Mon, 22 Nov 2021 14:22:48 -0800
In-Reply-To: <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 22 Nov 2021
        14:20:55 +0000")
Message-ID: <xmqqlf1fde4n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA44085A-4BE2-11EC-862A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> This avoids inspecting the file system, which only works with the files ref
> backend.

Nice.

Between always leaving HT after the timezone and mimicking the
files-backend storage more closely by using HT as a separator
only when there is actually a message, I have no strong preference,
but as a "test-helper", being uniform would be more useful than
being less ugly, so I think I am OK with this change (and the fact
that test-helper unconditonally puts HT in hits output).



>  Z=$ZERO_OID
> +TAB='	'
>  
>  m=refs/heads/main
>  n_dir=refs/heads/gu
> @@ -318,11 +319,12 @@ test_expect_success 'symref empty directory removal' '
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
> +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
>  EOF
>  test_expect_success "verifying $m's log (logged by touch)" '
> -	test_when_finished "rm -rf .git/$m .git/logs expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&
> +	test_cmp actual expect
>  '
>  
>  test_expect_success "create $m (logged by config)" '
> @@ -347,11 +349,12 @@ test_expect_success "set $m (logged by config)" '
>  cat >expect <<EOF
>  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 +0000	Initial Creation
>  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 +0000	Switch
> -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000
> +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 +0000$TAB
>  EOF
>  test_expect_success "verifying $m's log (logged by config)" '
> -	test_when_finished "rm -f .git/$m .git/logs/$m expect" &&
> -	test_cmp expect .git/logs/$m
> +	test_when_finished "git update-ref -d $m && rm -rf .git/logs actual expect" &&
> +	test-tool ref-store main for-each-reflog-ent $m > actual &&
> +	test_cmp actual expect
>  '
>  
>  test_expect_success 'set up for querying the reflog' '
> @@ -467,7 +470,8 @@ $h_OTHER $h_FIXED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151040 +0000	co
>  $h_FIXED $h_MERGED $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117151100 +0000	commit (merge): Merged initial commit and a later commit.
>  EOF
>  test_expect_success 'git commit logged updates' '
> -	test_cmp expect .git/logs/$m
> +	test-tool ref-store main for-each-reflog-ent $m >actual &&
> +	test_cmp expect actual
>  '
>  unset h_TEST h_OTHER h_FIXED h_MERGED
