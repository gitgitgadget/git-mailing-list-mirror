Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B6EC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 21:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbiCBVXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 16:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245233AbiCBVXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 16:23:46 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C6433AF
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 13:23:02 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2BC711B8B4;
        Wed,  2 Mar 2022 16:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xnw389m8vFwc
        5kLc9rt7C/1Mi/ZPOpf5Y3qJNqmL3Xc=; b=ZbKiHHnx7rlIJMG0YimAo3SxP9Dw
        NU3hevZXPZR3peRRPojo8Zxix2GxAe/dJXeit7US8YpiJe+krhqoe8ng8OtkaaXR
        s16E8DkQDdYMSvjmVADQD8udbzKF9OgwJ8hoanM71kxxb0Kgff0pwsQTG3pJPROP
        QFUR1/Wklyu1X6E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E85BA11B8B2;
        Wed,  2 Mar 2022 16:23:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9F1BC11B8B1;
        Wed,  2 Mar 2022 16:23:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/10] bugreport tests: tighten up "git bugreport -s
 hooks" test
References: <cover-00.10-00000000000-20220302T131859Z-avarab@gmail.com>
        <patch-04.10-1da2efc9886-20220302T131859Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 13:22:59 -0800
In-Reply-To: <patch-04.10-1da2efc9886-20220302T131859Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 14:22:23
        +0100")
Message-ID: <xmqqzgm8hwwc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F01AF968-9A6E-11EC-B915-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +	write_script .git/hooks/applypatch-msg <<-\EOF &&
> +	true
> +	EOF
> +	write_script .git/hooks/unknown-hook <<-\EOF &&
> +	true
> +	EOF
>  	git bugreport -s hooks &&
> +
>  	grep applypatch-msg git-bugreport-hooks.txt &&
> -	! grep prepare-commit-msg git-bugreport-hooks.txt
> +	! grep unknown-hook git-bugreport-hooks.txt &&
> +	! grep -F .sample git-bugreport-hooks.txt
>  '

The above is not wrong per-se, but because we control which hooks
are and are not visible to "git bugreport" we run in this test, I
wonder if we should do

	git bugreport -s tmp &&
	sed -ne '/^\[Enabled Hooks\]$/,/^$/p' git-bugreport-tmp.txt |
	sort >actual &&
	sort >expect <<-\EOF &&
	[Enabled Hooks]
	applypatch-msg
	EOF
	test_cmp expect actual

instead.  It is not like checking the "git help -a" output for list
of commands, which may grow or shrink as the system evolves.

