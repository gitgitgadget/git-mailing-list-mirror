Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54299C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 05:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243009AbiCKFfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 00:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiCKFfE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 00:35:04 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214BE1A12B8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 21:34:01 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB8FB186F42;
        Fri, 11 Mar 2022 00:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RTc3hMrZgZ6P6lZsMhWGIvPUILdj0CFxQBxxKx
        AZVOo=; b=Gziv/zooHgg38+1yXDg4rcyfkVuHZ8Nt2Idvq6rKAWOIBknIMZfv/b
        SedZNq2rfMxzMODYo+QFvqM2SaGxHo84FhebJDHEVQRGnCQ9jjcMbWxm2rgfX41m
        B75ykdFSCbtinLahYN1+/rFvvG++3XAXDWk08AcL/vg0Z/bPNwJeM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C41CA186F41;
        Fri, 11 Mar 2022 00:34:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4F133186F3F;
        Fri, 11 Mar 2022 00:33:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] rebase: set REF_HEAD_DETACH in checkout_up_to_date()
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 21:33:57 -0800
In-Reply-To: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Fri, 11 Mar 2022 05:05:44 +0000")
Message-ID: <xmqqczitaw8q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9877E30-A0FC-11EC-B84A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 71b1735e1dd..0b92e78976c 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -437,4 +437,25 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>  	)
>  '
>  
> +test_expect_success 'rebase with oids' '
> +	git init main-wt &&
> +	(
> +		cd main-wt &&
> +		>file &&
> +		git add file &&
> +		git commit -m initial &&
> +		git checkout -b side &&
> +		echo >>file &&
> +		git commit -a -m side &&
> +		git checkout main &&

The above is sufficient set-up.

> +		git tag hold &&
> +		git checkout -B main hold &&

These two are unnecessary.  It was there in my bisect "runme" script
only because I originally used an out-of-line repository that is
prepared beforehand, so that "move main back to hold and rerun the
rebase" can be done regardless of the bug in the previous version
checked during "bisect run".

> +		git rev-parse main >pre &&
> +		git rebase $(git rev-parse main) $(git rev-parse side) &&
> +		git rev-parse main >post &&
> +		test "$(git rev-parse side)" = "$(cat .git/HEAD)" &&

You may want to prepare for segfaulting "git rev-parse"  in the
above three lines.

Never "cat .git/HEAD".  use "git rev-parse".

> +		test_cmp pre post
> +	)
> +'
> +
>  test_done
>
> base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
