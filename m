Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E897C433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 22:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiAPWNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 17:13:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63096 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiAPWNt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 17:13:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A00B11D105;
        Sun, 16 Jan 2022 17:13:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ApxmGA5EEAAhT8GZgPfXmw3ngHoKLJ1ZvawXJF
        Juing=; b=EQ8c7ZVO/lyqS6iIYqlACcWL7uVA9l2M5jfqFuALW5Y1ob9LgnBRhr
        SXthv0WIeSVLctmnwAJcS/GDeE7fkgR6K2ga73a2ybjIZpopPpM2E/7Gc0vigbL/
        xXE9YjgNfIxr2yQmm8pP0sftD+2a9CW6rz0SounldBnLyPYLtdTAw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0184D11D104;
        Sun, 16 Jan 2022 17:13:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5390311D103;
        Sun, 16 Jan 2022 17:13:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
        <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
        <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
        <20220115095725.GA1738@szeder.dev>
        <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
Date:   Sun, 16 Jan 2022 14:13:47 -0800
In-Reply-To: <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
        (Elijah Newren's message of "Sat, 15 Jan 2022 17:03:24 -0800")
Message-ID: <xmqqv8yjz5us.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 94108C28-7719-11EC-8DF0-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> ...  If our
> guide is merely what the command swallows, then we should forgo
> completion for these subcommands, because it's not possible to
> enumerate all possible completions.

I am not sure if I follow.  I do not think it makes sense to aim for
enumerating EVERYTHING the command would accept.  But I do not know
that is the same as "merely what the command swallows".

> I don't think that's a useful guide or starting point, so we
> instead need to discuss what are reasonable completions.

I do not think it is a good idea to refrain from suggesting anything
that has a possibility of being wring, either, though.  If a path
that is not a directory (either because it is a file in the current
checkout, or because it is a directory only in a different branch)
is given, it might not make sense in the cone-mode for the current
checkout, but it may well make sense when a different branch is
checked out.  Or you may not even in the cone-mode, and in which
case, as SZEDER suggested, a single filename may perfectly make
sense.  A user who said READM<TAB> and does not see it completed to
README.md would be quite confused.

Are we limiting ourselves to directories only when we know we are in
the cone-mode and showing both directories and files otherwise?

I think the guiding principle ought to be that we show completion
that

 - is cheap enough to compute in interactive use (e.g. we should
   refrain from looking for directories in all possible branches,
   but instead just look at the working tree and possibly in the
   index),

 - is simple enough to explain to the users to understand what the
   rules are, and

 - gives useful enough candidates.

"We only look for directories (without going recursive) in the
working tree" does satisfy the first two, but I am not sure it is
more useful than "We show files and directories (without going
recursive) in the working tree", which also satisfies the first
two.

Of course, if the completion limits to directories only in a
repository in the cone-mode, I would not worry about the exclusion
of non-directories will confuse users.
