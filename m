Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6532DC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 20:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbiF3Upb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiF3Upa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 16:45:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A444A18
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 13:45:29 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 568B11A8CA8;
        Thu, 30 Jun 2022 16:45:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=iuL4vfmMfj48
        Pfn7ViexRPbn6CcJzUFlVCr2o8T5EyQ=; b=EksrTut52HhOTLrWUx2cnes/IASO
        mIUWcpLP5X4/T5HMBQdYII00FjK/ufFTySsw8gAXHRPqJyemRtha7IMI8kcJqYVu
        s6FiwZmK2df7hqROeOtjX40vXwZzRaKYbgB83yzXDqGCXbS7VgqIdE3gfEG9KvvT
        ml8DV5Ya1GvwShA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F8A01A8CA7;
        Thu, 30 Jun 2022 16:45:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E03621A8CA6;
        Thu, 30 Jun 2022 16:45:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2] trace2: don't include "fsync" events in all trace2 logs
References: <patch-1.1-df87e515efd-20220623T154943Z-avarab@gmail.com>
        <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
Date:   Thu, 30 Jun 2022 13:45:21 -0700
In-Reply-To: <patch-v2-1.1-a1fc37de947-20220630T084607Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 30 Jun
 2022 10:56:47
        +0200")
Message-ID: <xmqqczepev8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FF0C05E-F8B5-11EC-A95A-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> As we're needing to indent the trace2_data_intmax() lines let's
> introduce helper variables to ensure that our resulting lines (which
> were already too) don't exceed the recommendations of the

too -> too something

> +    elsif ($event eq 'data_json') {
> +	# NEEDSWORK: Ignore due to
> +	# compat/win32/trace2_win32_process_info.c, which should log a
> +	# "cmd_ancestry" event instead.
> +    }

This does read better.

>  void trace_git_fsync_stats(void)
>  {
> -	trace2_data_intmax("fsync", the_repository, "fsync/writeout-only", co=
unt_fsync_writeout_only);
> -	trace2_data_intmax("fsync", the_repository, "fsync/hardware-flush", c=
ount_fsync_hardware_flush);
> +	const struct repository *r =3D the_repository;
> +	const intmax_t cfwo =3D count_fsync_writeout_only;
> +	const intmax_t cfhf =3D count_fsync_hardware_flush;
> +
> +	if (cfwo)
> +		trace2_data_intmax("fsync", r, "fsync/writeout-only", cfwo);
> +	if (cfhf)
> +		trace2_data_intmax("fsync", r, "fsync/hardware-flush", cfhf);

I would have wrapped the lines instead of introducing these extra
variables; the key observation is that it would make a much easier
pattern to follow for a future developer who needs to add the third
kind of "fsync" on top of the existing wo and hf.

But we can address that when somebody actually adds the third one,
so let's take the patch as-is.

Thanks.
