Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E1FC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8734E64F60
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhBBV47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:56:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65430 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBBV4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:56:55 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96F0B961F6;
        Tue,  2 Feb 2021 16:56:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xFxaBCT0WAShxQPGuWZdso9XII8=; b=PVfgY/
        XuPJ0seFZb9hGyhDPyQvuDW4wRm5/MiW8n+TaYvD3ozDcs+qwFh5zO30QWqyVBEw
        45ZuDh3kVMCUJ1nkkOlUvQGsJhEA0w4rC9XNeljoJbSgfOnGaqsEG4TNoIl0hdGN
        WT1rooXRBYiWqt3z5HKQ002iyJs8SlrNnFx1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WtJEXh8XJdRfZgju9NWdlE6lH65XjFr2
        thZk7WeN9ofM/zeLpT7iBEAzqRoxn9jpcdWQfGeXOM20cyd1PUht9GLAleFrSS4Q
        GhiGe7BXmlaKI4/fTdn5cn0frmlfbeLtS5RL4iP5gPWyYLmtZh8KwDAk9TEqOqnT
        9wPkdWS8vGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FE0F961F5;
        Tue,  2 Feb 2021 16:56:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 255CD961F3;
        Tue,  2 Feb 2021 16:56:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/9] stash show: teach --include-tracked and
 --only-untracked
References: <cover.1612258145.git.liu.denton@gmail.com>
        <c2375d1fc6c5fe7a36d2f868b172e83749d67b45.1612258145.git.liu.denton@gmail.com>
Date:   Tue, 02 Feb 2021 13:56:12 -0800
In-Reply-To: <c2375d1fc6c5fe7a36d2f868b172e83749d67b45.1612258145.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 2 Feb 2021 01:33:25 -0800")
Message-ID: <xmqq5z3af81v.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 775D6626-65A1-11EB-ABC0-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Stash entries can be made with untracked files via
> `git stash push --include-untracked`. However, because the untracked
> files are stored in the third parent of the stash entry and not the
> stash entry itself, running `git stash show` does not include the
> untracked files as part of the diff.
>
> Teach stash the --include-tracked option, which also displays the

Is that "tracked" or "untracked"?

> untracked files in a stash entry from the third parent (if it exists).
> Do this by just concatenating the diff of the third parent against an
> empty tree. One limitation of this is that it would be possible to
> manually craft a stash entry which would present duplicate entries in
> the diff by duplicating a file in the stash and in the third parent.

In other words, a broken "stash" that cannot have be taken with
"stash save -u" may show nonsense?  I wouldn't be so worried about
it, as long as we won't crash in "git stash show".

But a larger downside is that you will have to see all diffs from
the tracked paths from A to Z before you start seeing untracked
paths from A to Z, which is not what people would expect how
"include" behave---it is more like "append as afterthought".  If we
cannot do a good job showing both in a sensible way, I'd rather not
to see us introduce such an incomplete "--include-untracked" option
until we can do so.

The "only-untracked" one does not have such problem, so it is
probably a good feature to add at this moment, though.

This is not in the scope of this topic, but I wonder if it people
want to have the "--only-untracked" option on the "stash apply"
command.
