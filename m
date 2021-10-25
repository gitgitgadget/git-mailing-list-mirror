Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53859C433FE
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C07960EBC
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJYUgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:36:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55806 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbhJYUgR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 16:36:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A05CE16BAE1;
        Mon, 25 Oct 2021 16:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qgeNxXSI1Yc0w/qH/9XCGrhSrt/kSof0yEbmwD
        s69c8=; b=I6V2h9+8pkibk0apzuTbD/GH1ncYJe38P54ssNaRh03qk3xrQE/Qmp
        +966/+YMZnopHcuyvmxyOc5cIGxtn6Ka4xe6jr+Owvsgp240LcaqHW0AYDHf43Zw
        2ogQyllmMti2jllH+T8OTgyZtsA76iZKudmbC820UEfpzcBHZwcfM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9922116BAE0;
        Mon, 25 Oct 2021 16:33:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0062016BADF;
        Mon, 25 Oct 2021 16:33:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <20211013193127.76537-1-chooglen@google.com>
        <20211019224339.61881-1-chooglen@google.com>
        <20211019224339.61881-3-chooglen@google.com>
        <xmqqzgr3o4yw.fsf@gitster.g> <xmqqtuhbo2tn.fsf@gitster.g>
        <kl6l35opasd1.fsf@chooglen-macbookpro.roam.corp.google.com>
        <kl6lzgqwaocl.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 25 Oct 2021 13:33:50 -0700
In-Reply-To: <kl6lzgqwaocl.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 25 Oct 2021 12:36:26 -0700")
Message-ID: <xmqqzgqwzvwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDAD51B4-35D2-11EC-B6C3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>> The caller is remote_get_1(); this funciton was called with
>>> "current_branch", which can be NULL until you have a repository and
>>> you've called read_config(), but otherwise shouldn't be.
>
> One possible culprit is working with detached HEAD, are you pushing with
> detached HEAD?
>
> "current_branch" is allowed to be NULL when HEAD does not point to a
> branch.

Good point.  It is a good justification to make the remote_state
available to the function, as branch==NULL that signals "there is no
current branch in the repository" cannot be dereferenced to get to
either the repository or the remote_state, yet the function needs
access to remote_state even when branch==NULL.

What "branch" is pushremote_for_branch() meant to take?  Is there a
caller that asks a hypothetical "I know this is not a branch that is
the current branch in the repository, but to which remote would we
push if this branch _were_ the current one?" (and passes NULL to
mean "there is a checked out branch, but what happens if our HEAD
were detached?") question?  Even if there isn't currently, do we
want to add such callers in the future?

If the answer is yes, then the function need to take both branch and
remote_state as two separate parameters.  If the answer is no (i.e.
we never ask hypothetical questions, we just ask what we should do
in the current, real, state), then the function can just take the
remote_state and remote_state->branch being NULL would be used as a
signal that the HEAD is detached.  I suspect it is the former, as
this information is used in string-name-to-object translation for
"topic@{push}" in object-name.c::interpret_branch_mark() function.

> However, if you are not using detached HEAD, the problem might be
> elsewhere..

I just checked.  The repository the push is run in is bare and its
HEAD is detached, pointing at a commit directly.
