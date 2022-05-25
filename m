Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F129C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245325AbiEYUzN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiEYUzM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 16:55:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAB0B41F9
        for <git@vger.kernel.org>; Wed, 25 May 2022 13:55:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79CB013013D;
        Wed, 25 May 2022 16:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=5FPDK064pxTgnPVMburFzywlI
        g5pNFK/gpqMrlrF5Bw=; b=VNrmWnrbfTqpEaSurK2tQeC1E+z5p1ltnEKlk6zqg
        ha8IdVLfXtSRTbfzetKp9rcTZ0x+unp68ltIzFG1vg7z0YVo9rPcwwmuOwtPmXFi
        x6+DQuewhVty5+PtP4ONra2eAdlZ8A/6QYEtc2qCb6wPaB4km9Qza9FgIyta3dM8
        Zw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37CB313013A;
        Wed, 25 May 2022 16:55:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8512130132;
        Wed, 25 May 2022 16:55:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 1/5] usage.c: add a non-fatal bug() function to go with
 BUG()
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com>
        <patch-1.5-faa1c708a79-20220521T170939Z-avarab@gmail.com>
Date:   Wed, 25 May 2022 13:55:05 -0700
Message-ID: <xmqqpmk15o46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5258424-DC6C-11EC-82E8-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Any caller to bug() should follow up such calls with BUG_if_bug(),
> which will BUG() out (i.e. abort()) if there were any preceding calls
> to bug(). As the tests and documentation here show we'll catch missing
> BUG_if_bug() invocations in our exit() wrapper.

...

> +- `bug` (lower-case, not `BUG`) is supposed to be used like `BUG` but
> +  prints a "BUG" message instead of calling `abort()`. We then expect
> +  `BUG_if_bug()` to be called to `abort()` if there were any calls to
> +  `bug()`. If there weren't any a call to `BUG_if_bug()` is a NOOP.

OK.  So the expected pattern would be a series of calls to bug(),
each guarded by its own condition, concluded by a call to BUG_if_bug()

	if (condition1)
		bug(...);
	if (condition2)
		bug(...);
	...
	BUG_if_bug();

and when none of the guard conditions fired, BUG_if_bug() will
become a no-op.

> +/* usage.c: if bug() is called we should have a BUG_if_bug() afterward=
s */
> +extern int bug_called_must_BUG;

I am not sure about the name, but in essense, each call to bug()
ensures that this becomes true, so BUG_if_bug() can use it to see
if it should abort(), right?

>  __attribute__((format (printf, 3, 4))) NORETURN
>  void BUG_fl(const char *file, int line, const char *fmt, ...);
>  #define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
> +__attribute__((format (printf, 3, 4)))
> +void bug_fl(const char *file, int line, const char *fmt, ...);
> +#define bug(...) bug_fl(__FILE__, __LINE__, __VA_ARGS__)
> +#define BUG_if_bug() do { \
> +	if (bug_called_must_BUG) { \
> +		bug_called_must_BUG =3D 0; \
> +		BUG_fl(__FILE__, __LINE__, "see bug() output above"); \
> +	} \
> +} while (0)

I have a feeling that "see bug() output above" should come from the
caller of BUG_if_bug().  These bug() calls that are grouped together
must have a shared overall theme, which may want to be stated in
that final message.

Other than these two small points, this does not look too bad ;-)

Thanks.
