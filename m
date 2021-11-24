Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C00C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 20:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244409AbhKXUyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 15:54:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56369 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243805AbhKXUyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 15:54:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5F02E167148;
        Wed, 24 Nov 2021 15:51:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YGvuItyIZ9rmMsfv+m/c5//pDmX5lnuDGM5t8d
        XCqjc=; b=wa/Txep0qsR+1fGqi/m/s4HJT8GJDsHAtHt3Oesyh9nmm/A5MR9LNm
        N9tguMTOiTWgrkg9suaAnYHHhM+wNYrWbq7u18Q2tZb+oYuNm/ToWqSNqkUt7ggs
        bG4SQbP4+JkuPQ+RQ+z5HeIXeRQiUFDG33RKL2dzD7UZ22vThTpNs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 576AD167147;
        Wed, 24 Nov 2021 15:51:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B67F8167142;
        Wed, 24 Nov 2021 15:51:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, phillip.wood123@gmail.com,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com> <xmqqa6hvbxob.fsf@gitster.g>
        <CAPUEspgDafXHHPvzNijTsPsna76yE8W=JH-78LX3jyaieSmp0A@mail.gmail.com>
        <xmqqtug293ml.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2111241428190.63@tvgsbejvaqbjf.bet>
        <xmqqwnkx1h5y.fsf@gitster.g>
        <CAPUEspjBf1MrN_hhNYndJ3MExikZ=rODbHiLNHNfpz1SUKd3RA@mail.gmail.com>
Date:   Wed, 24 Nov 2021 12:51:00 -0800
In-Reply-To: <CAPUEspjBf1MrN_hhNYndJ3MExikZ=rODbHiLNHNfpz1SUKd3RA@mail.gmail.com>
        (Carlo Arenas's message of "Wed, 24 Nov 2021 12:04:21 -0800")
Message-ID: <xmqqy25dz39n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3BD8E864-4D68-11EC-9DEA-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Arenas <carenas@gmail.com> writes:

> On Wed, Nov 24, 2021 at 11:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Why 'vi' and 'vim' are so special?  Is this an attempt to paper over
>> a bug in 'vim' on the caller side?
>
> not sure if the bug is on vi/vim, cygwin's pty or the new conPTY that
> Windows Terminal uses; but in Git for Windows, using an MSYS vim (that
> uses cygwin's pty) within Windows Terminal (and other terminals that
> use conPTY most likely) leads to this terminal output corruption, that
> bash "fixes" when it gets the control back, but that git does not
> (unless something like what I am proposing is done), and that is
> specially disruptive when doing several commits in a series (ex: an
> interactive rebase).
>
> you could say it is an attempt to paper over that bug, but IMHO it is
> also a way for git to protect itself from a "rogue" editor, as it is
> now just trusting that the editor wouldn't mess with its terminal
> settings after being invoked and it returns control to git.

Surely, bash keeps using the same TTY and it may be in its interest
to "protect" it.  We on the other hand would exit when we are done
and no need for the TTY.  In other words, bash may "own" TTY and it
may want to take a good care of it.  We don't.

I would have to say that your argument is a bit of stretch ;-).
