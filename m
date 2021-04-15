Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5C9C433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA681610CB
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhDOVln (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:41:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52878 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhDOVlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:41:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D1F0135D76;
        Thu, 15 Apr 2021 17:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NYzXZY7XmxR3
        gqnH0HRp4OkBo+M=; b=BLPi51dvXJmaTt8y8j4VFKLxlVWYZ2RxDHKFqAJdYzAT
        4+9x/eQBs1ScAOStWMBgJ61KbquDWNPJNAwK6w+lIl2m2WV6IO6gg256JVF32VLk
        MKQiNPBoAeWD/HfdvRODjXMB22pvOlq2YHfDv4cJVAgCApP2qgHsRI97wyX6Roc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iXRyhj
        u4fkKRlbD+UpKPrbrylh2ioJcRAYcnNemUgT29wT9KQbCYsM+faRD9jvKRA21bJ8
        sTMZVcSZZ6Yjj95VYTAI72kN6VVOPvxGYwEtDb44k3gRQA6kCmcvsb7XzMAbniEw
        9Tk43awaeJHIxbYaOl2z7RIGgXBtnsUd+BNmE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 16351135D75;
        Thu, 15 Apr 2021 17:41:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56EE4135D71;
        Thu, 15 Apr 2021 17:41:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: Future structure of submodules and .git/, .git/modules/*
 organization
References: <20210408233936.533342-1-emilyshaffer@google.com>
        <87v98p17im.fsf@evledraar.gmail.com>
Date:   Thu, 15 Apr 2021 14:41:11 -0700
In-Reply-To: <87v98p17im.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 14 Apr 2021 12:32:17 +0200")
Message-ID: <xmqq8s5jp6o8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4CC93636-9E33-11EB-B395-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I very much wish that we could eventually make the use of submodules
> totally transparent, i.e. (taking the example of git.git):
>
>  * You clone, and we just get objects from
>    https://github.com/cr-marcstevens/sha1collisiondetection.git too
>
>  * The fact that we have:
>
>    160000 commit 855827c583bc30645ba427885caa40c5b81764d2  sha1collisio=
ndetection
> ...

I am afraid that the story is not that simple (I wish it were).

There are at last two opposing ways submodules are to be used.  The
original motivation was to borrow an external project as part of
your project, and the way we use SHA1DC is fairly close to it (but
not quite).  In the context of such a usage

	git commit -m "message" --recurse-submodules

would often not be an appropriate operation.  A message that is
suitable in the context of the entire project would not be in the
context of the project that is bound to your project as a submodule,
and for your changes to be reusable by the folks who own the borrowed
project to make sense, your change should be defensible on its own,
"it helps this project that happens to use you as a submodule" by
itself is not all that convincing.

The other way submodule often gets used is to artificially split a
logically single project into many subdirectories and make them into
separate repositories, the top-level project binding them as
submodules.  An submodule in such an arrangement may not even make
sense as a standalone project---this pattern was only brought into
usage because without the more recent inventions like lazy/partial
clones and sparse checkouts, large projects did not fit within a
single repository.

With such an arrangement, of course it makes perfect sense for
things like

	git commit -m "message" --recurse-submodules
	git grep --recurse-submodules

to work as if you are working inside a single repository, by
definition.  You are splitting a logically single project into
multiple submodules as a workaround, and then still wanting to
treat them as a single project, after all.

Supporting those who want to use "collection of submodules as if it
were a single monolithic project" well is a worthy goal, but I do
not think it is healthy to assume that is the only use and forget
about use cases that would benefit from a clear boundary at
submodules (e.g. not sharing commit log message, a change at the
toplevel project may consist of multiple changes at the submoudle
level, etc.).

Thanks.

