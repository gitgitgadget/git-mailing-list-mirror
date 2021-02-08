Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DFC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338E864E8C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBHXf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:35:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53877 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBHXfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:35:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1AC84A8B89;
        Mon,  8 Feb 2021 18:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WH/SgjEfKJhr6i5c+y2WTTIBJIE=; b=wotv5p
        8eqRX2KtSFA6GWgBmGvR13cNqbh7U9JUR1NlhlFYJy6ZaM8QQJ2EKP0p+U6udK+m
        AogUrCZC24g3iMDDQcRLnwPuo/LRZTsqRldHwAvcHHiBRIdW0K1SYKamutKisTua
        w8AlZ0wXv+4fTdO5DYXA0+oJRH1G4iPuYQG6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=t+aJaVd67z2fQ+TgcpAgx/ck+05WpZgl
        Ghc3AhnkfWl9iYr3Pt/mE8msIbTPksLiZCXkhd6XH+HTB+vkFcWDyzsi3CaMc+o0
        2eTBpdpa8M+DgUhiANz4FStXNfSjNEB4J/gK5ynLyQ4N139qsjoWwYX6Hh4p0Kru
        knCZql6Z3Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FD65A8B85;
        Mon,  8 Feb 2021 18:34:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 802F4A8B84;
        Mon,  8 Feb 2021 18:34:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        ZheNing Hu <adlternative@gmail.com>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH v2] git-difftool-helper.sh: learn a new way go back to
 last save point
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
        <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
        <CAJDDKr4AyxuS-MQ+62XGnK4UvJ+cFDdnMwOK1GSn-oiFrWoxyw@mail.gmail.com>
Date:   Mon, 08 Feb 2021 15:34:41 -0800
In-Reply-To: <CAJDDKr4AyxuS-MQ+62XGnK4UvJ+cFDdnMwOK1GSn-oiFrWoxyw@mail.gmail.com>
        (David Aguilar's message of "Mon, 8 Feb 2021 14:15:28 -0800")
Message-ID: <xmqq4kim3zhq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 381B7E8E-6A66-11EB-BC52-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

> What if instead of global state, maybe the user could specify a path
> that difftool could skip forward to?   For example, we could teach
> difftool to resume by telling it where we last left off:
>
>    git difftool --resume-from=foo/bar099.txt
>
> Then we don't need the global counter state file?

Does it have to be the second and subsequent invocation to pass the
new "resume-from" option?  As we do not have "global" state, I would
presume that we do not even know if it is the first invocation, so
perhaps a better name would be "--start-from=$pathname"?

> Finally, I'm going to plug what I believe to be the right tool for the
> job here.  Have you tried git cola?[1]  Difftool is tightly
> integrated, and the UI is such that you can trivially choose any of
> the modified/staged files and difftool them by using the Ctrl-d
> hotkey.
>
> https://github.com/git-cola/git-cola/
>
> Cola is purpose-built for driving difftool, and for interactive
> staging, so not mentioning it in the context of wanting a better UI
> for difftool would be a disservice to difftool users.

;-)
