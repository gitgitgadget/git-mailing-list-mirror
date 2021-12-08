Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E06C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 23:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241128AbhLHXYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 18:24:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhLHXYG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 18:24:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CB6BF3FAD;
        Wed,  8 Dec 2021 18:20:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=00ljlQ4WGQhKScCA9rrXISNIdnsrFKChq/px22
        tlgW0=; b=cks3QORJAXxlxzHAdLwwjGkn2jDNFyzds1VSwYKiUDmvFIYVWSQ7bg
        04/eT9GuoXO29MmByrwyqaI4yi3bNyzPx39b+MUIrWLZlooEQyFmJtm2q91PJZiU
        +lbvK9c4VGFS0u56VfERvdC4rx8W365XL0H4VxzNazamOKK8dY+VM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23928F3FA4;
        Wed,  8 Dec 2021 18:20:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FCF8F3F9F;
        Wed,  8 Dec 2021 18:20:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 8/8] t/fmt-merge-msg: make gpg/ssh tests more specific
References: <20211130141112.78193-1-fs@gigacodes.de>
        <20211208163335.1231795-1-fs@gigacodes.de>
        <20211208163335.1231795-9-fs@gigacodes.de>
Date:   Wed, 08 Dec 2021 15:20:30 -0800
In-Reply-To: <20211208163335.1231795-9-fs@gigacodes.de> (Fabian Stelzer's
        message of "Wed, 8 Dec 2021 17:33:35 +0100")
Message-ID: <xmqqsfv2wuo1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FFEA7E4-587D-11EC-A1D0-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> All the GPG, GPGSSH and the new GPGSSH_VERIFYTIME tests are redirecing
> stdout as well as stderr to `actual` and grep for success/failure over
> the resulting flie. However, no output is printed on stderr and we do
> not need to include it in the grep. The newer SSH signing based tests
> are also missing a grep for the merged tag to make sure the merge
> message is correct.
>
> - remove unneccessary 2>&1 redirects
> - add grep for merged tag to gpgssh* tests
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/t6200-fmt-merge-msg.sh | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)

The 4 hunks at the beginning seems to be a clean-up of the existing
issue, but aren't hunks -162,7, -170,7, -178,7, 187,7 "oops, we
screwed up in [6/8], and we patch up after the fact"?  

For a new topic not yet in 'next', we'd prefer to pretend to be more
perfect humans by not deliberatly keeping mistakes made in an
earlier step, only to be corrected in a later step.

While there may not be any difference in the end-result, it would be
cleaner and less sloppy to have the 4 hunks to fix the ones before
the series as a preliminary clean-up step, and the other hunks
folded into the step that introduced the problem, no?

Thanks.

> diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
> index 2dd2423643..12a1e62bf0 100755
> --- a/t/t6200-fmt-merge-msg.sh
> +++ b/t/t6200-fmt-merge-msg.sh
> @@ -124,7 +124,7 @@ test_expect_success 'message for merging local branch' '
>  test_expect_success GPG 'message for merging local tag signed by good key' '
>  	git checkout main &&
>  	git fetch . signed-good-tag &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
>  	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>  	grep "^# gpg: Signature made" actual &&
>  	grep "^# gpg: Good signature from" actual
> @@ -133,7 +133,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
>  test_expect_success GPG 'message for merging local tag signed by unknown key' '
>  	git checkout main &&
>  	git fetch . signed-good-tag &&
> -	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
>  	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
>  	grep "^# gpg: Signature made" actual &&
>  	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
> @@ -143,7 +143,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . signed-good-ssh-tag &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
>  	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
>  	! grep "${GPGSSH_BAD_SIGNATURE}" actual
>  '
> @@ -152,7 +152,8 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . signed-untrusted-ssh-tag &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
>  	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
>  	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
>  	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
> @@ -162,7 +163,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . expired-signed &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
>  	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
>  '
>  
> @@ -170,7 +172,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . notyetvalid-signed &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
>  	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
>  '
>  
> @@ -178,7 +181,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . timeboxedvalid-signed &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
>  	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
>  	! grep "${GPGSSH_BAD_SIGNATURE}" actual
>  '
> @@ -187,7 +191,8 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
>  	test_config gpg.ssh.allowedSignersFile "${GPGSSH_ALLOWED_SIGNERS}" &&
>  	git checkout main &&
>  	git fetch . timeboxedinvalid-signed &&
> -	git fmt-merge-msg <.git/FETCH_HEAD >actual 2>&1 &&
> +	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
> +	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
>  	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
>  '
