Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B304C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 19:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349211AbiFCTZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbiFCTZf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 15:25:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA557554B1
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 12:25:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D13F912F395;
        Fri,  3 Jun 2022 15:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oFDYasUb3vx2
        LvNcmyhMsIANg4Vbq2ds18sDqlXh3yA=; b=Siq5w7a7J4C9iA8nWFuE+0UO1HAz
        RSNfDZyvOHBF6BAy7k0GeyNHNj0flwe3pyKIASW6Aeea5ix0RcB5rBbK47ldfogA
        AMa/zFbG+P2X5dSRhp6LZOxsQWmezlCfcr8dd3onAEy+JYX2l7RJQSyeARqPIsml
        ha14bW03sKiaoHs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6F1B12F394;
        Fri,  3 Jun 2022 15:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D5B512F392;
        Fri,  3 Jun 2022 15:25:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>, John Cai <johncai86@gmail.com>
Subject: Re: [RFC PATCH 1/3] test-tool: don't fake up BUG() exits as code 99
References: <RFC-cover-0.3-00000000000-20220525T234908Z-avarab@gmail.com>
        <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
Date:   Fri, 03 Jun 2022 12:25:32 -0700
In-Reply-To: <RFC-patch-1.3-78431bdc8f0-20220525T234908Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 May
 2022 02:30:42
        +0200")
Message-ID: <xmqqv8theehf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFE33E04-E372-11EC-A616-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the BUG() function invoked be "test-tool" to be the "real" one,
> instead of one that avoids producing core files. In
> a86303cb5d5 (test-tool: help verifying BUG() code paths, 2018-05-02)
> to test the (then recently added) BUG() function we faked up the
> abort() in favor of an exit with code 99.
>
> However, in doing so we've been fooling ourselves when it comes to
> what trace2 events we log. The events tested for in
> 0a9dde4a04c (usage: trace2 BUG() invocations, 2021-02-05) are not the
> real ones, but those that we emit only from the "test-tool".

I can fully agree with the above reasoning, i.e. let's test what we
do use in production, instead of something nobody uses for real, if
we were adding a test for BUG() in vacuum, but why did we have to
"fake" it in the first place?

> Let's just stop faking it, and call abort(). As a86303cb5d5 notes this
> will produce core files on some OS's, but as the default behavior for
> that is to dump them in the current directory they'll be placed in the
> trash directory that we'll shortly me "rm -rf"-ing.

Are we sure that the reason no longer applies?  How do we know?  We
would want to explain that to future developers in the proposed log
message, I would think.

> +	elif test_match_signal 6 $exit_code && list_contains "$_test_ok" siga=
brt
> +	then
> +		return 0
>  	elif test_match_signal 13 $exit_code && list_contains "$_test_ok" sig=
pipe

Not a new problem, but these numberings are probably not very
portable.  I am willing to take this as-is and let people on
minority platforms complain ;-)
