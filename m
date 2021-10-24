Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A489BC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7766760E09
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 20:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbhJXU37 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 16:29:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50893 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhJXU36 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 16:29:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83859F0B45;
        Sun, 24 Oct 2021 16:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zjd4F8btdG0y
        3sBUb9O/DxB1brDTSwX9Q/sc4fLFjVs=; b=DuOxd0imDy+dBjX0iEqi8zt7swzI
        u2iMCTHzmmWAvIzWdu5ms35ShmjJY137Je8jV8O7StyUPH6zzL6psZWMLte+K0kY
        r/5Ri4OQheABBEC/Ie3bLrdycPs0/QQGqovlZVeKoVr+KhPkYeO4C6tS7KQD/y7T
        nSjF7WmtEb1DSbk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B35BF0B40;
        Sun, 24 Oct 2021 16:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DBB71F0B3F;
        Sun, 24 Oct 2021 16:27:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin <git@mfriebe.de>
Cc:     git@vger.kernel.org
Subject: Re: changing the experimental 'git switch'
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
        <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
        <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
        <da952e81-70f9-886b-42ff-2ec850f55fa0@mfriebe.de>
Date:   Sun, 24 Oct 2021 13:27:34 -0700
In-Reply-To: <da952e81-70f9-886b-42ff-2ec850f55fa0@mfriebe.de> (Martin's
        message of "Sun, 24 Oct 2021 08:54:12 +0200")
Message-ID: <xmqqwnm2418p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D3176494-3508-11EC-AE92-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> So one could do
> git switch=C2=A0 --settings-from <branch-with-reflog-and-conf> --create
> <new-branch>=C2=A0=C2=A0 <commit>
> git switch=C2=A0 -s <branch-with-reflog-and-conf>=C2=A0=C2=A0 -c <new-b=
ranch>=C2=A0=C2=A0 <commit>
>
> "settings-from" is just an example, there may be better names for
> it. Ideally not starting with a "c".
>
> And using a name different from "copy" may be more accurate, because
> unless it is created on the same one <commit> to which the=20
> <branch-with-reflog-and-conf> points, then its at best partially copied=
.

I like the "copy the settings from this other branch when creating
this new branch" as a concept.

One thing that I find iffy is the reflog.  Even with the current
"create a new branch NEW, pointing at the same commit, tracking the
same remote-tracking branch, having the same branch description, and
pretending to have come along the same trajectory, out of this
original branch OLD", I actually find that the copyng of reflog is
utterly questionable.  Before that operation, the new branch did not
exist, hence NEW@{4.days.ago} shouldn't say the same thing as
OLD@{4.days.ago} for the branch NEW that was created like so just a
minute ago.

If you generalize the operation to allow starting the new branch at
a different commit, it becomes even more strange to copy the reflog
of the "original" branch, which is not even the original for this
new branch.

Another thing nobody seems to have brought up is the branch
description.  We copy everything under branch.OLD.* to branch.NEW.*
and end up copying it from OLD to NEW, but I think that is also a
nonsense operation.

So, it probably makes sense to be more selective that what are
sensibly copied and what are not.  Reflog most likely does not
belong to the "sensibly copyable" set.  Tracking info most likely
does.  Among various configuration in branch.OLD.*, there may be
things like description that are not sensibly copyable.

