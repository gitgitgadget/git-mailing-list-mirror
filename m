Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F007C83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 22:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjIBWYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 18:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjIBWYR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 18:24:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3240CCE0
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 15:24:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DA6CD1AF769;
        Sat,  2 Sep 2023 18:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=sANT7syUJ9EAPJ1lqfI/AYqIofkSgaX8A5SjPl
        ASHOQ=; b=Xe2lsTTatKxMeCUkx3rXcan6D1eo2a0LGAbV1OXDnJ6OWunKZlx/Po
        LDjmC1n3coB/He+SbAJsPj8lTrd+BffC7DtD0XpIOaeTE37W3L+7qPe/kWyo+IOB
        D7oJxSzI41WE0QMtmQx2tRahGWQDNRpTkjyjk5zKhK6+NmX/NAk9E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D20C61AF768;
        Sat,  2 Sep 2023 18:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 482971AF767;
        Sat,  2 Sep 2023 18:24:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] sequencer: beautify subject of reverts of reverts
In-Reply-To: <20230902072035.652549-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Sat, 2 Sep 2023 09:20:35 +0200")
References: <xmqqsf89e8wz.fsf@gitster.g>
        <20230902072035.652549-1-oswald.buddenhagen@gmx.de>
Date:   Sat, 02 Sep 2023 15:24:09 -0700
Message-ID: <xmqqsf7wkyd2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 702587C4-49DF-11EE-8982-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> ---
> v4:
> - factor out verification of subject as per taylor's patch, with minor
>   modifications.

The change seems to make the test quite straight-forward to read.

Let's mark the topic for 'next'.

Thanks.

> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index e2ef619323..4158590322 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -176,6 +176,29 @@ test_expect_success 'advice from failed revert' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_subject () {
> +	echo "$1" >expect &&
> +	git log -1 --pretty=%s >actual &&
> +	test_cmp expect actual
> +}
> +
> +test_expect_success 'titles of fresh reverts' '
> +	test_commit --no-tag A file1 &&
> +	test_commit --no-tag B file1 &&
> +	git revert --no-edit HEAD &&
> +	test_expect_subject "Revert \"B\"" &&
> +	git revert --no-edit HEAD &&
> +	test_expect_subject "Reapply \"B\"" &&
> +	git revert --no-edit HEAD &&
> +	test_expect_subject "Revert \"Reapply \"B\"\""
> +'
> +
> +test_expect_success 'title of legacy double revert' '
> +	test_commit --no-tag "Revert \"Revert \"B\"\"" file1 &&
> +	git revert --no-edit HEAD &&
> +	test_expect_subject "Revert \"Revert \"Revert \"B\"\"\""
> +'
> +
>  test_expect_success 'identification of reverted commit (default)' '
>  	test_commit to-ident &&
>  	test_when_finished "git reset --hard to-ident" &&
