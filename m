Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45345C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 20:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiD0UHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiD0UHC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 16:07:02 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B53F4338B
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 13:03:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7B3D19401D;
        Wed, 27 Apr 2022 16:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vUGWjBxRo7jv
        mCQSle0vboCg2gPe68Sw/jjv//aysk4=; b=bQLbNkIKzpgC5XABz6mLV73vlkuX
        Wu/JBH3gYwdrneJXJz8x4onFIZX8VZCJOXv+02qP6TOM5TIrjR3RIJm539oiE7/m
        ZVSb3HIve7DWsmmVnoeJ1LFgxTYxFASOBrW5eY0OMOYjyixCAjjTuieNZs8RhrHQ
        2G0XRc1/uxNo2XI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DFACE19401B;
        Wed, 27 Apr 2022 16:03:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 39D3319401A;
        Wed, 27 Apr 2022 16:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhau?= =?utf-8?Q?er?= 
        <mha1993@live.de>
Subject: Re: [PATCH] 2.36 gitk/diff-tree --stdin regression fix
References: <xmqqh76j3i3r.fsf@gitster.g> <xmqqbkwpvyyc.fsf@gitster.g>
        <83a76d46-5069-d6c7-b8b3-f3a063637abb@gmail.com>
        <6ac7e164-c4ba-0ffc-a8a4-4cede1d4e7ae@gmail.com>
        <xmqqo80nsw5h.fsf@gitster.g> <xmqq7d7bsu2n.fsf@gitster.g>
        <561a73aa-7e94-5a09-0c9c-08e8b6ce7188@web.de>
        <a1dcac11-98ac-9fcd-8375-4fd1be9ace78@web.de>
Date:   Wed, 27 Apr 2022 13:03:41 -0700
In-Reply-To: <a1dcac11-98ac-9fcd-8375-4fd1be9ace78@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 27 Apr 2022 20:06:39 +0200")
Message-ID: <xmqqv8uul2ea.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 23940894-C665-11EC-B291-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> +	if (prev_options_with_pathspec =3D=3D options && !options->pathspec.=
nr)
>> +		BUG("reused struct diff_options, potentially lost pathspec");
>> +	if (options->pathspec.nr)
>> +		prev_options_with_pathspec =3D options;
>
> This can report a false positive if a diffopt is reused with different
> pathspecs, and one of them is empty (match all).  Which could be counte=
red
> by using a fresh diffopt every time (e.g. pushing it into a loop).

The only use case to reset pathspec of a diffopt during iteration I
can think of is the hacky[*] version of "git log --follow" where the
pathspec is swapped when a rename of a single path being followed is
detected.

    Side note: hacky because the way it swaps a single pathspec upon
    seeing one rename means it does not work in a mergy-branchy
    history where one branch renames and there are still commits
    that need to be explored on the other branch that had the path
    under its original name.
