Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5803FC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 21:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF2120754
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 21:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a21wgDdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756671AbgJWV2M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 17:28:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53391 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756654AbgJWV2L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 17:28:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 787BCF3585;
        Fri, 23 Oct 2020 17:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vokYZcp0Q0Eb6wIKwPVCo/uRVek=; b=a21wgD
        dNpXTqQwemzA7TIw65masFEdO/3pKIkX2xP3FELUSrlnFtXwuT6rZ5qloELk8mfv
        OfY0l2E8GSXwMz1eycK1RvQXoEUaPcbRPuEqDuKzolEo0CuhXHjJZ/vl7v4DIpi5
        QNSN3o8oIWcxACIeqLW+fuu3YDM38Ykf5DBi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KQttFu9qNWvYdnfbyraWnFkhzy4eNqYf
        T6FBx1zqQfBv3cC267lK/r84cA3Ms4ZsfuHS+RONpNxopFncs1Z7dswlxxg3NT9n
        NQJxNKJQYSHY3lPjfu34jDwzlmSNHbnKsd/PxD0lGDb3frKrrXiH2C3tINpnd2Qu
        jNKfvO3AHZs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7123DF3584;
        Fri, 23 Oct 2020 17:28:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93DF3F3583;
        Fri, 23 Oct 2020 17:28:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sangeeta Jain <sangunb09@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH v4] diff: do not show submodule with
 untracked files as "-dirty"
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
        <20201023111827.40188-1-sangunb09@gmail.com>
Date:   Fri, 23 Oct 2020 14:28:01 -0700
In-Reply-To: <20201023111827.40188-1-sangunb09@gmail.com> (Sangeeta Jain's
        message of "Fri, 23 Oct 2020 16:48:27 +0530")
Message-ID: <xmqqmu0cfx9a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A22E77BC-1576-11EB-A1DA-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sangeeta Jain <sangunb09@gmail.com> writes:

> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> ...
> +test_expect_success 'git diff HEAD with dirty submodule (untracked) (none ignored)' '
> +	git config diff.ignoreSubmodules none &&
> +	git diff HEAD >actual &&
> +	sed -e "1,/^@@/d" actual >actual.body &&
> +	expect_from_to >expect.body $subtip $subprev-dirty &&
> +	test_cmp expect.body actual.body &&
> +	git config --unset diff.ignoreSubmodules
> +'

If any step concatenated by && in the above sequence fails, the test
repository will have diff.ignoreSubmodules set to none (without
getting it reset, since &&-chain prevents the last "config --unset"
step from running).  Unless the test is run under the --immediate
option, that would affect the environment in which subsequent tests
are run.

Instead, our test usually do this:

	test_expect_success 'test title' '
                test_config diff.ignoresubmodules none &&
                git diff HEAD >actual &&
                ...
                test_cmp expect.body actual.body
	'

"test_config" sets up a trigger, which will _always_ fire, whether
the test fails at any intermediate steps or runs to the end and
succeeds, to remove the configuration it just added.  It is a
short-hand for writing

	test_when_finished test_unconfig diff.ignoresubmodules &&
	git config diff.ignoresubmodules none

i.e. to use test_when_finished to set up the trigger.

> -	git diff HEAD >actual &&
> +	git diff --ignore-submodules=none HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual.body &&
>  	git diff --ignore-submodules=all HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
> -	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	git diff HEAD >actual3 &&

This line can be left as-is, no?

> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f852136585..bb368b685d 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
>  
>  test_expect_success 'submodule contains untracked content' '
>  	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
>  	cat >expected <<-EOF &&
>  	Submodule sm1 contains untracked content
>  	EOF
> @@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
>  '
>  
>  test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&

Likewise.
