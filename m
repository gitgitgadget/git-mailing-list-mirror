Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CA5C433FE
	for <git@archiver.kernel.org>; Wed, 11 May 2022 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbiEKT17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 15:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbiEKT16 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 15:27:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A16A3EF07
        for <git@vger.kernel.org>; Wed, 11 May 2022 12:27:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A6C481915C8;
        Wed, 11 May 2022 15:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yAlf9W+TAo9S
        B/SgPo/J8/bsHXnpMSll9m9UMyVoHNE=; b=BkWXSMsED7shOEx0spdiAYS+DzVF
        sThQdzkFb0HOINPPISCLpiKOsFzmkLMNlkl1m1hf5uOrpqhjW4e1zCf2JR+IEsIs
        ZwLrBPPt9/irqhHTCnY2Uyw645ai1ZJrSFjJdBOjsHXr5qPImSZDMVhp/vkJkL43
        48ekgYOUH6eUQw4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9EB1D1915C7;
        Wed, 11 May 2022 15:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 45E211915C6;
        Wed, 11 May 2022 15:27:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     rsbecker@nexbridge.com,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        'Taylor Blau' <me@ttaylorr.com>,
        'Derrick Stolee' <stolee@gmail.com>,
        'Elijah Newren' <newren@gmail.com>,
        'Johannes Schindelin' <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/7] archive: optionally add "virtual" files
References: <pull.1128.v3.git.1651677919.gitgitgadget@gmail.com>
        <pull.1128.v4.git.1652210824.gitgitgadget@gmail.com>
        <45662cf582ab7c8b1c32f55c9a34f4d73a28b71d.1652210824.git.gitgitgadget@gmail.com>
        <xmqqtu9x6ovh.fsf@gitster.g>
        <03d701d864ba$46d15c10$d4741430$@nexbridge.com>
        <xmqq8rr955zf.fsf@gitster.g>
        <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de>
Date:   Wed, 11 May 2022 12:27:51 -0700
In-Reply-To: <3cf6e4f8-9151-6d68-21ca-b94d6a7557e6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 11 May 2022 18:14:12 +0200")
Message-ID: <xmqqzgjnkgy0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 734B873A-D160-11EC-AFB1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 11.05.22 um 01:21 schrieb Junio C Hamano:
>> <rsbecker@nexbridge.com> writes:
>>
>>>> If we did "--add-virtual-file=3D<path>:0644:<contents>" instead from=
 day one, it
>>>> certainly adds a few more lines of logic to this patch, and the call=
ing "scalar
>>>> diagnose" may have to pass a few more bytes, but I suspect that such=
 a change
>>>> would help the project in the longer run.
>
>> I did say "scalar diagnose" may not care.  But a patch to "git
>> archive" will affect other people, and among them there would be
>> people who say "gee, now I can add a handful of files from the
>> command line with their contents, without actually having them in
>> throw-away untracked files, when running 'git archive'.  That's
>> handy!", try it out and get disappointed by their inability to
>> create executable files that way.
>
> Which might motivate them to contribute a patch to add that feature.
> Give them a chance! :)

Yes, but there is no way to reuse the same option in a backward
compatible way to later add the mode information, and that is why we
want to be careful before a half-feature squats on an option.

> FWIW, I'd already be satisfied by a convincing outline of a way towards
> a complete solution to accept the partial feature, just to be sure we
> don't paint ourselves into a corner.

Exactly.  As you say, an extra and separate option can be used.  I
do not know if that is a workaround because we didn't design the
first option to take an additional option, or a welcome feature.

> Regarding file modes: We only effectively support the executable bit,
> so an additional option --add-virtual-executable-file=3D<path>:<content=
s>
> would suffice.

While I do not think we want to support more than one "is it
executable or not?" bit, I am not so sure about what the current
code does, though, for these "not from a tree, but added as extra
files" entries.

If you add an extra file from an on-disk untracked file, the
add_file_cb() callback picks up the full st.st_mode for the file,
and write_archive_entries() in its loop over args->extra_files pass
the full info->stat.st_mode down to write_entry(), which is used by
archive-tar.c::write_tar_entry() to obtain mode bits pretty much
as-is.  For tracked paths, we probably are normalizing the blobs
between 0644 and 0755 way before the values are passed as "mode"
parameter to the write_entry() functions, but for these extra files,
there is no such massaging.

So, I am OK with --add-virtual-executable=3D<path>:<contents> (but the
point still stands that the way the code in the patch squats in the
codepath makes it necessary to first refator it before it can
happen) as a separate option.  We may want to massage the mode bit
we grab from these extra files, if we were to go that route, though.

Thanks.

