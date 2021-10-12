Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81134C433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CF7610C9
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbhJLUj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 16:39:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60989 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhJLUjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 16:39:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54D641015F7;
        Tue, 12 Oct 2021 16:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=eed2HTux5QiU
        vgGxL8L5NKY/Pliz4C7BeiI9AoEuXc4=; b=gykkhWi84vv6Dzz0HSQg3DDm1xCC
        hsFeBLNbfYoeh6ANzkkyVEdRVxD6F1ZtnbOIqY3P1J7jqY2vZYzGIn9nwkQNoI3U
        M0QGQc91gT6tXZELFw3fAe2bZu0OuzHghX821IJqTwxugeCU1K2hk52L92kjWXb3
        vM30fWZqqMDpxyY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C1AA1015F6;
        Tue, 12 Oct 2021 16:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A140B1015F4;
        Tue, 12 Oct 2021 16:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git.mexon@spamgourmet.com, git@vger.kernel.org
Subject: Re: [PATCH] add: don't write objects with --dry-run
References: <a2c0deed-fff3-6c1c-633f-af9dffea1e02@exon.name>
        <0131d21f-dabd-3da5-34bd-a570e990f9e0@web.de>
        <871r4qj8mw.fsf@evledraar.gmail.com>
Date:   Tue, 12 Oct 2021 13:37:21 -0700
In-Reply-To: <871r4qj8mw.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 12 Oct 2021 22:17:06 +0200")
Message-ID: <xmqqfst62d4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 33DF9C90-2B9C-11EC-9F96-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think the "git fetch --dry-run" command behaves like this too,
> i.e. doesn't update refs, but fetches and writes objects.
>
> For the patch I hacked up I think it's easy to argue that it shouldn't
> do compression etc.
>
> For this sort of thing and "fetch" I'm not so sure. Do we really know
> that there aren't people who rely on this for say the performance of
> seeing what an operation would do, and then not pay as much for the
> "real one" that updates the index/refs/etc. later? Is that subsequent
> "fetch" cheaper because of the --dry-run?

The answer to the last one is an easy "yes".  Trying to gauge the
time it would take for a real fetch with "--dry-run" is a losing
battle, I would think, as the pre-fetching would make the "real" one
cheaper, so from that point of view, I think we can ignore those who
time "--dry-run" and try to figure out anything meaningful.

This in any case is an interesting area, as the definition of
correctness of what "dry-run" does can be quite fuzzy.  As long as
it does not change the index, "git add --dry-run", even if it writes
objects or detects filesystem corruption by noticing I/O error while
compressing the data taken from the working tree files, is still
correct and the patch in question is not technically a bugfix (it is
a performance thing).  "git fetch --dry-run" would fall into the
same category, so would "git hash-object" without "-w".

All can use performance enhancement without breaking existing users,
I would think.

Thanks.
