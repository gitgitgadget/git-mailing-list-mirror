Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F1C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 17:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239686AbiDOR17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbiDOR15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 13:27:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572B15A39
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 10:25:28 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE4A811A66A;
        Fri, 15 Apr 2022 13:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZQgfNGiYu13+
        nW3VtASIW0oyTquGsyNNUIizI+rACE4=; b=kBhJCaKcs4FG7z64O8gm4mqSO69/
        qCjQ/Uh/qotxEZ0pTiyiRGONHsilqODdZ1k2ecwJ0F4OqmlmDB1ovWPm62jwC0UD
        4HnLxcKQ5J37rP98bg0zUJcdM3LYgaOp8Hwnz5LgKWfdiGSetNTHeINl8wJoyDef
        FwlzFfqPMlHrnX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5D3A11A668;
        Fri, 15 Apr 2022 13:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2BF3911A667;
        Fri, 15 Apr 2022 13:25:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Pathological performance with git remote rename and many
 tracking refs
References: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
        <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
        <YljFnJk55WYLKd6Y@camp.crustytoothpaste.net>
        <220415.868rs6cyal.gmgdl@evledraar.gmail.com>
Date:   Fri, 15 Apr 2022 10:25:26 -0700
In-Reply-To: <220415.868rs6cyal.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 15 Apr 2022 14:26:16 +0200")
Message-ID: <xmqqfsmedzsp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0A87D8B8-BCE1-11EC-AFFB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I actually wonder if this wouldn't be that hard, because if we have any
> reflogs we could simply "replay" them by turning (again, I'm a bit rust=
y
> on the exact lock dance);
>
>     lock(refs/remotes/origin/master);
>     lock(refs/remotes/def/master);
>     create(refs/remotes/def/master, refs/remotes/origin/master^{});

Why deref?  Trying to be prepared for seeing a symbolic ref, or
something?

>     delete(refs/remotes/origin/master);
>     unlock(refs/remotes/origin/master);
>     unlock(refs/remotes/def/master);
>
> Into instead doing:
>
>     lock(refs/remotes/origin/master);
>     lock(refs/remotes/def/master);
>     for from, to, msg ref_update(refs/remotes/origin/master):
>         update(refs/remotes/def/master, from, to, msg);
>     delete(refs/remotes/origin/master);
>     unlock(refs/remotes/origin/master);
>     unlock(refs/remotes/def/master);

Would this (or the above, for that matter) work well when renaming 'foo'
to 'foo/bar' (or the other way around), I wonder?

Anyway.

Is the reasoning behind "replay each and every reflog entry" because
you are trying to avoid depending on the implementation detail (i.e.
"R=3D.git/logs/refs/remotes; mv $R/origin/master $R/def/master" works
only with the files backend)?  Unless we are willing to add a new
ref backend method to help this natively, it would be a workable but
an ultra-slow way to do so, as it would involve open, write, fsync,
and close for each reflog entry.

    ... goes and looks ...

Hmph, I am utterly confused.  refs/files-backend.c eventually
dispatches to files_copy_or_rename_ref() when rename_ref method in
ref_storage_be is used on the files backend, and the function
already renames the reflog file without having to copy entry by
entry.  We cannot just open a transaction, run many rename_refs and
close it?

