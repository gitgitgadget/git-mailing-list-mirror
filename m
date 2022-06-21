Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E96C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354592AbiFUWep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354483AbiFUWed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:34:33 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CF12AA9
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:34:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA4C0136C56;
        Tue, 21 Jun 2022 18:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kMwi4ovImLC0
        sn6675IH7VfFQpo0egaxQKPMRMA9MX0=; b=K+8ahuZJ9yrPUV0CrUISlk/pMuFl
        q/vvfVHRIAeonwMXIQqkSm96Dcitrjx0Zrh0kxtZSjBJ5xpeXuhz7RGGpPwSpX/z
        gzD5vpyljsoQxIlomdehEWZDN06MsOv9bDYEwbrkjBWW7ECVP9PZdTqttxu5hgY2
        WueI1Sb4omcFrFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D101C136C55;
        Tue, 21 Jun 2022 18:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47BFF136C53;
        Tue, 21 Jun 2022 18:34:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] config tests: fix harmless but broken "rm -r" cleanup
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
        <patch-3.3-f787b19f8c2-20220621T221928Z-avarab@gmail.com>
Date:   Tue, 21 Jun 2022 15:34:29 -0700
In-Reply-To: <patch-3.3-f787b19f8c2-20220621T221928Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 22 Jun
 2022 00:21:40 +0200")
Message-ID: <xmqq4k0dfxxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50C3ADC4-F1B2-11EC-A989-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  test_expect_success 'override global and system config' '
> -	test_when_finished rm -f "$HOME"/.config/git &&
> +	test_when_finished "rm -rf \"$HOME\"/.config/git" &&

As this string is evaled, isn't it safer to defer dereferencing the
environment variable at the runtime by quoting the dollar-sign, too?

I.e.

	test_when_finished rm -rf \"\$HOME\"/.config/git &&

or something?
