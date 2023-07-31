Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E40C001DE
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 23:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjGaXqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 19:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjGaXqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 19:46:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42197E5D
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 16:46:02 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 793A51CB74;
        Mon, 31 Jul 2023 19:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U6gFd886VpR5
        f4BEv7H8+Hga9XwwpxbuK4MsNROX4Po=; b=LkhRua5HKoW2z2b040V0INdoon+/
        SsCpyFITZDEfATpI/9Cs0sxE8SdJ+kPQZH+AwhjHhcyzgI4BYIXpxS6tLmxrOfFz
        zx2qjeOU2kYpUHeGl8myOIqBsb7is1dRjyYE5dJnP4FPT1zF1n31iNJMvpn6oLsR
        F1ee40LTVXFrYek=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 728CA1CB73;
        Mon, 31 Jul 2023 19:46:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1A5131CB70;
        Mon, 31 Jul 2023 19:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] status: fix branch shown when not only bisecting
References: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
Date:   Mon, 31 Jul 2023 16:45:56 -0700
In-Reply-To: <48745298-f12b-8efb-4e48-90d2c22a8349@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
        message of "Sun, 30 Jul 2023 03:07:42 +0200")
Message-ID: <xmqqedkn3arv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 65CCB09C-2FFC-11EE-9675-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> In 83c750acde (wt-status.*: better advice for git status added,
> 2012-06-05), git-status received new informative messages to describe
> the ongoing work in a worktree.
>
> Multiple operations can be performed concurrently in a worktree.  For
> example, during a rebase, the user can also perform a cherry-pick.

Hmph ...

> In
> that situation, git-status only shows information about one of them,
> prioritizing which one, in order: merge, am, rebase, cherry-pick.

... I have to wonder if it is a bug that "cherry-pick" proceeds when
there is an ongoing "rebase" going on, though.  When a sequencer is
driving a cherry-pick of master..topic1 and the user gets control
back in the middle, perhaps due to a conflict, should the user be
allowed to do "cherry-pick master..topic2", splicing these commits
from the other topic in the middle of the first cherry-pick session
the user started?

