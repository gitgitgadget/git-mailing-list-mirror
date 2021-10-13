Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E341AC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0C8160EDF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239014AbhJMUN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:13:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62995 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbhJMUN7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:13:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F99414E3BB;
        Wed, 13 Oct 2021 16:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vjUEE+39EjHWsF6XR02NHvx4Ru2oGRRRciUJ5t
        9X5gE=; b=TXUn9xwS+wd5VKrdRU5Triv0jMo365m1r8y3uAyj4c3XUpDE4GF2z7
        UwnEwtzPpMx+AbCtjpwp7XLxrFgXV6iDTiLrIo5Sop6evLXzOsufWzZukJ91/5QJ
        jKSCtqppjPAx5AVjmTx19NyzmqT6nmGEjLonsPvDlV+9JPOx/8di4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 487BE14E3BA;
        Wed, 13 Oct 2021 16:11:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A6E3F14E3B9;
        Wed, 13 Oct 2021 16:11:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] remote: replace static variables with struct
 remote_state
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
Date:   Wed, 13 Oct 2021 13:11:51 -0700
In-Reply-To: <20211013193127.76537-1-chooglen@google.com> (Glen Choo's message
        of "Wed, 13 Oct 2021 12:31:24 -0700")
Message-ID: <xmqqtuhkfzw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE5880E6-2C61-11EC-95E1-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> While this concern is valid, I decided to keep this interface for a few
> reasons:
>
> 1. The correct way of calling the function is 'obvious'.
> 2. It is relatively easy to get the contained object (struct branch/remote)
>    and its containing struct repository/remote_state (e.g. we don't pass
>    struct branch or remote through long call chains). For "struct
>    branch", callers usually get the branch from the repo and use it
>    immediately. For "struct remote", we don't use container objects
>    outside of static functions. If you are interested in seeing all of
>    the call sites, you can see a sample commit in [3].
> 3. The separation between container/contained objects allows us to
>    reason better about what the correct interface is. e.g. we might be
>    tempted to include a backpointer from struct branch to struct
>    remote_state so that we can pass around struct branch and be
>    confident that struct branch has all of the information it needs.

I am not following.  None of the above reasons argue for forcing the
functions that take contained object to also take its container.

>    However, I believe that some questions *shouldn't* be answered by
>    just struct branch. The prime example in this series is
>    branch_get_push() - it conceptually answers 'What is the pushremote
>    of this branch', but the behavior we want is closer to 'If
>    configured, give me the pushremote for the branch. Otherwise, give me
>    the default pushremote of the repo.'. This is arguably a relevant
>    detail that should be exposed to callers.

It is a good example why such a function can just take an instance
of branch, and the caller,

 (1) who does care about the fallback, can be assured that the logic
     falls back to the correct repository; and

 (2) who does not care about the fallback and sees it a mere
     implementation detail of "I am on this branch; give me the
     remote to push to", do not have to know what, other than the
     branch object, needs to be passed.

if we explicitly record a branch object which repository it was
taken from.

There may be some other (real) reason where the resistance comes
from, that you may not be telling us, though.  But in what was
described in the message I am responding to, I didn't see much
convincing reason to argue _for_ keeping the contained objects
ignorant of the container and forcing callers to pass both to
functions that use both the container and contained to compute
something.

Thanks.
