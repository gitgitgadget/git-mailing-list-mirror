Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EA0C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 17:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiHDRMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 13:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiHDRMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 13:12:46 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5037929CA6
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 10:12:44 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F0471AE0B5;
        Thu,  4 Aug 2022 13:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VG1SibFN3iau
        VwozKEmnXavQ0IRHcrmnVG4iger6W18=; b=US51C17OWazNaORIpOV14+YBwY1A
        QSHe+v7QfySE6DIEIZFuFlRCwBu97vfxxRysohB0nos4juDMbR8EkIEDRTlp+6l8
        FjrP8sgRcmTND9iPScc1vQkUSTSvjhvR8yU7eCvM6HFFZ2ihXx/huiH7BrXhfnxQ
        2HLUm8RDTn6PGkg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 85D291AE0B4;
        Thu,  4 Aug 2022 13:12:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17EDA1AE0B3;
        Thu,  4 Aug 2022 13:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 03/10] scalar-diagnose: add directory to archiver
 more gently
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
        <220804.868ro4fryg.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Aug 2022 10:12:37 -0700
In-Reply-To: <220804.868ro4fryg.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Aug 2022 08:19:53 +0200")
Message-ID: <xmqq35ec6igq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A491DB00-1418-11ED-8F11-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +	dir =3D opendir(at_root ? "." : path);
>> +	if (!dir) {
>> +		if (errno =3D=3D ENOENT) {
>
> Per [1]

"Per [1]" somehow sounds more like a reference to an authoritative
source, at least to me.  Every time you use it, I have to see what
it refers to, and after realizing that you used it as a replacement
of "I said it already in [1]" again, it leaves a funny feeling.

> I think this is incorrect or overly strict. Let's not spew
> warnings if the user "rm -rf .git/hooks" or whatever.

The above is doing the right thing even in that situation, doesn't
it?  If there is no ".git/hooks" that is fine.  We get ENOENT, give
a warning to indicate that we found an unusual situation, and return
without failing.  If we got something other than ENOENT, we fail with
error_errno(), because opendir() failed for a reason other than "No
such file or directory".

> You already have an errno, so using *_errno() will add the standard
> information about what the issue is.

Reading the code aloud, slowly, may help.  When errno says ENOENT,
we know opendir() failed because of "No such file or directory",
so "path" was missing.  So let's say 'not archiving a missing directory'"=
.

ENOENT or "No such file or directory" is an implementation detail
that does not help the end user.

The other side, i.e. when the errno is *not* ENOENT, already uses
error_errno().

So, I am puzzled.
