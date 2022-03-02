Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF70C433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiCBUzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBUzx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:55:53 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A417CA0C7
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:55:10 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D387117AB70;
        Wed,  2 Mar 2022 15:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g3qjo97VnjY3
        rRDzWA8065XXAtXpPFjh2IP4pEO9G90=; b=CCTDvnfPLXRbJuXRV2wP4vaaa/TL
        LYfSR0KRqYUoMZaMDs0TXmGo8z5eLxbQaNhZuA2lf46kfrc2mEQOiMsKKjNZwMIp
        PNzsOH75G4RUB8b8MsXgbwFD974vXcZ4NYl3SDgoF5QMthZsbDKJU7xAeGPYG+tc
        wSdvms4GD9b+siA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBAAE17AB6F;
        Wed,  2 Mar 2022 15:55:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B59217AB6E;
        Wed,  2 Mar 2022 15:55:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/10] hook tests: turn exit code assertions into a loop
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-01.10-706460d10b9-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 12:55:03 -0800
In-Reply-To: <patch-01.10-706460d10b9-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:20
        +0100")
Message-ID: <xmqqlexsjcrc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 09FB438C-9A6B-11EC-94B1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Amend a test added in 96e7225b310 (hook: add 'run' subcommand,
> 2021-12-22) to use a for-loop instead of a copy/pasting the same test
> for the four exit codes we test.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  t/t1800-hook.sh | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> ...
> +for code in 1 2 128 129
> +do
> +	test_expect_success "git hook run: exit code $code is passed along" '
> +		write_script .git/hooks/test-hook <<-EOF &&
> +		exit $code
> +		EOF
> +
> +		test_expect_code $code git hook run test-hook
> +	'
> +done

Looks good.  Each being separate test_expect_success means we do not
have to worry about breaking out of the loop upon a failure, which
is much cleaner than I would have thought ;-)

It also illustrates a good use of unquoted here document.
