Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC24C433F5
	for <git@archiver.kernel.org>; Mon, 10 Oct 2022 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJJXZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJJXZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 19:25:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362381FCCD
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 16:25:26 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 663D415F214;
        Mon, 10 Oct 2022 19:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mYb10NS4j8xrVUasrpAFTPnGp259XKE0Dv/2K7
        bOfyU=; b=VsDRCYqR1TZpC63MJBwdMQ/pJB8OTs5wYSc5clnLkJEa2AQqg5MgbQ
        XUM9JTE0ONL9Y3SNWstI2Vwu1f1l4XUmbJ2vHkT1r0rFDxiRNC65uXQ0zcYMeEI5
        Y4aWh4UrIJp0whBHg67IkjYeJHR8BBtoViWoftrSE9ulr4+Gc0Vqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F4D515F213;
        Mon, 10 Oct 2022 19:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C086415F212;
        Mon, 10 Oct 2022 19:25:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH] ci: add address and undefined sanitizer tasks
References: <xmqq8rlo62ih.fsf@gitster.g>
Date:   Mon, 10 Oct 2022 16:25:23 -0700
In-Reply-To: <xmqq8rlo62ih.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        09 Oct 2022 15:44:22 -0700")
Message-ID: <xmqqtu4bz2fw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D13CCB2E-48F2-11ED-A2EF-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  * I've been running my local post-integration-pre-pushout tests of
>    'seen' with these two sanitizer tests, which has saved me from a
>    few potential embarrassments early.  As it takes a lot extra time
>    to run these locally, I am aiming to burden contributors who run
>    their due diligence "before sending the patch" checks using the
>    GitHub Actions CI ;-).
>
>    The way the patch adds jobs to CI just imitates how -leaks one is
>    defined.
>
>  .github/workflows/main.yml | 6 ++++++
>  ci/lib.sh                  | 3 +++
>  2 files changed, 9 insertions(+)

One downside is that the usual CI cycle for a branch that takes a
bit shorter than 40 minutes seems to take between 50 to 60 minutes
(the primary culprit seems to be the address sanitizer).

Arguably, that 10 or 20 minutes are time saved from human
developers' time, so it might not be too bad, but I'll keep
it out of 'next' for now.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 831f4df56c..2f80da7cfb 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -251,6 +251,12 @@ jobs:
>            - jobname: linux-leaks
>              cc: gcc
>              pool: ubuntu-latest
> +          - jobname: linux-address
> +            cc: gcc
> +            pool: ubuntu-latest
> +          - jobname: linux-undefined
> +            cc: gcc
> +            pool: ubuntu-latest
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 1b0cc2b57d..678edd5abb 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -278,6 +278,9 @@ linux-leaks)
>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>  	export GIT_TEST_SANITIZE_LEAK_LOG=true
>  	;;
> +linux-address | linux-undefined)
> +	export SANITIZE=${jobname#linux-}
> +	;;
>  esac
>  
>  MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
