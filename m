Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6229C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 23:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiAGXIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 18:08:54 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58261 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiAGXIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 18:08:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 406B0FA49F;
        Fri,  7 Jan 2022 18:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=B85V5R2rfBk9
        GGiS2DoPO8+0iJQRVuwB9FzQ8xunYv8=; b=dYwXHtnfSy8nxeWs3bBHAUKF57bm
        KdB2P8uJQx5Ifkw5dncg1sYJkiiLD1arUjh1HuFg0+5xq9UlrqAWuHnpUAei9TyU
        Wfxa5nDDZTBwlbIEWwI/DVYOBdAr//By88IIKZUZ+WOV35q0IzezWhU8/EpbqMbV
        Z/oieTyyTVXJKlU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3860EFA49E;
        Fri,  7 Jan 2022 18:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D88EFA49D;
        Fri,  7 Jan 2022 18:08:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 01/17] hook: add 'run' subcommand
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
        <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
        <patch-v6-01.17-ba6fd47482e-20211222T035755Z-avarab@gmail.com>
        <Ydi2XEvZywEyImfC@google.com>
Date:   Fri, 07 Jan 2022 15:08:51 -0800
In-Reply-To: <Ydi2XEvZywEyImfC@google.com> (Emily Shaffer's message of "Fri, 7
        Jan 2022 13:53:32 -0800")
Message-ID: <xmqqfspz5ekc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C7DC7EFC-700E-11EC-B893-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> On Wed, Dec 22, 2021 at 04:59:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> diff --git a/hook.h b/hook.h
>> +struct run_hooks_opt
>> +{
>> +	/* Environment vars to be set for each hook */
>> +	struct strvec env;
>> +
>> +	/* Args to be passed to each hook */
>> +	struct strvec args;
>> +
>> +	/* Emit an error if the hook is missing */
>> +	unsigned int error_if_missing:1;
>
> I wonder if it's premature to include error_if_missing, if we will
> always set it to 1 until way down in patch 11.
>
> But I do not care all that much - at this point, I'll be honest, I'd
> just like to see the series merged.
>
>> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
>> new file mode 100755
>> +test_expect_success 'git hook run: nonexistent hook' '
>> +	cat >stderr.expect <<-\EOF &&
>> +	error: cannot find a hook named test-hook
>> +	EOF
>> +	test_expect_code 1 git hook run test-hook 2>stderr.actual &&
>> +	test_cmp stderr.expect stderr.actual
>> +'
>
> It's a little unclear to me what "nonexistent" means - does it mean tha=
t
> it's a hook unknown to Git (e.g. not in hook-list.h)? Does it mean that
> the hook path doesn't exist? Does it mean the hook path is not
> executable?

I think I saw the same puzzlement from another reviewer.  It needs
to be clarified if the documentation patch does not do a good job.

> It might be nice to at least leave a comment on this test case and poin=
t
> out that it relies on nobody having created a test-hook script in an
> earlier test. Or to clean up that path just in case, at the beginning o=
f
> this one.

Yup, I agree that the latter is a good practice.

