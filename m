Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 20:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJLUs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJLUsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 16:48:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154A564FF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 13:48:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA4951508AF;
        Wed, 12 Oct 2022 16:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v4lsavgLmvDoZBC6mTOP1DoOPriDnUtsip8iGW
        1ZE6o=; b=uEkmhwTLLI19DRPp+SWckLMykL0tMpkn/0rii9qbXwlsE207c1i7Yr
        sdELAUqnoM2+ITjcajDl8QL7KTCVKPRw/Ulq1Oc8nFfkzkhsE4G8UL3J+cDgIjJk
        kLu8tj0gvfUJywCAQ0WJr6ZilLIfFK4iaWCiBFPDkBa9X02pI+rJQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1FB41508AE;
        Wed, 12 Oct 2022 16:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5149B1508AD;
        Wed, 12 Oct 2022 16:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] config: respect includes in protected config
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
        <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 13:48:13 -0700
In-Reply-To: <0ff5b5741a519c63e65ef57d7d0b3148c38c1a52.1665603814.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Wed, 12 Oct 2022 19:43:34
        +0000")
Message-ID: <xmqqv8ookbua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3112C274-4A6F-11ED-9C3A-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

Not commenting on the code yet as I am in the middle of today's
integration run, but as I notice a bad pattern being followed, let
me comment before it spreads too widely.

The "add failing test first and then fix the code with flipping the
test to success" is very much unwelcome.  For whoever gets curious
enough (me included when accepting posted patch), it is easy to
revert only the part of the commit outside t/ tentatively to see how
the original code breaks.  Keeping the fix and protection of the fix
together will avoid mistakes.  The post context of the hunk that
changes test_expect_failure to test_expect_success does not cover
the test script, thereby hiding the body of the test that changes
behaviour while reviewing the patch text, which is another downside.

> diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
> index 720d6cdd60b..dc3496897ab 100755
> --- a/t/t0033-safe-directory.sh
> +++ b/t/t0033-safe-directory.sh
> @@ -71,7 +71,7 @@ test_expect_success 'safe.directory=*, but is reset' '
>  	expect_rejected_dir
>  '
>  
> -test_expect_failure 'safe.directory in included file' '
> +test_expect_success 'safe.directory in included file' '
>  	cat >gitconfig-include <<-EOF &&
>  	[safe]
>  		directory = "$(pwd)"
> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> index aa6a6a8c3fd..fa33839704b 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -51,7 +51,7 @@ test_expect_success 'safe.bareRepository on the command line' '
>  		-c safe.bareRepository=all
>  '
>  
> -test_expect_failure 'safe.bareRepository in included file' '
> +test_expect_success 'safe.bareRepository in included file' '
>  	cat >gitconfig-include <<-EOF &&
>  	[safe]
>  		bareRepository = explicit
