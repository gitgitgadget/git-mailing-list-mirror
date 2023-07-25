Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326C9EB64DD
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 23:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjGYXPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 19:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGYXPe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 19:15:34 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB74DB
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 16:15:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C67553357E;
        Tue, 25 Jul 2023 19:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3qzeCC/kx7ueJbtIq7UUnK+KTWZRiTXEYfuldC
        BBQrs=; b=HmK8n7qJp/oJ7My4PXPlOU7yLytvawMDV0EX/eBCXp6rx1w1NrCBrR
        WWV2hDuIzGvZaobzwr5lvNCU4x1ciWOvDA4/oYBMwqLLvFMaut5TOlbyYmghwmky
        XR9rIy+cLboiwweaJftSKcxHMfOtb3AUHHW/2zPQtciE7in2EJh+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF2FD3357C;
        Tue, 25 Jul 2023 19:15:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A81E93357B;
        Tue, 25 Jul 2023 19:15:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <emmir@google.com>,
        git@vger.kernel.org
Subject: Re: includeIf not matching during `git rebase`
References: <CABb0KFF1vqMLa5DLYd_c9sQeZbhkhQ=Q0bE7W41nmMFmNWB4tg@mail.gmail.com>
        <CAJoAoZnuLxyQ7ufUTrK4mBJ_4sQoyPCqJD9eeS8XfquWue1xQA@mail.gmail.com>
Date:   Tue, 25 Jul 2023 16:15:26 -0700
In-Reply-To: <CAJoAoZnuLxyQ7ufUTrK4mBJ_4sQoyPCqJD9eeS8XfquWue1xQA@mail.gmail.com>
        (Emily Shaffer's message of "Tue, 25 Jul 2023 13:28:08 -0700")
Message-ID: <xmqqila7h9bl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244E5CDE-2B41-11EE-B068-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> emilyshaffer@podkayne:~/git [libification-style|REBASE 3/4]$ git
> branch | head -n1
> * (no branch, rebasing libification-style)
>
> It looks like to log that error, we're using a cached branch name (and
> pick that up from wt_status_get_state and eventually
> wt_status_check_rebase, which checks
> .git/rebase-(merge|apply)/head-name).
>
> However, when we check the current branch for includeif.onbranch
> (config.c:include_by_branch()) we're using resolve_ref_unsafe("HEAD"),
> which doesn't check the current rebase state the way that the
> wt_status_* stuff does.
>
> Does that mean that the config machinery should also be using
> wt_status to determine which branch to use?

Not really.  The low-level config machinery shouldn't rely on a
piece of information from so high a layer (making call to
wt_status.c or spawning "git status" is an absolute no-no).

But "we are not exactly on branch X, but doing work on behalf of
branch X" is a common situation during rebase and possibly bisect,
and I agree that it is a good future direction to introduce a
reliable low-level primitive to notice that condition.

I however am hesitant to fully support such an idea, because I
suspect that there may be cases such as "we are technically on
branch Y, but actually doing work on behalf of branch X" or worse
yet "we are on branch Z, but actually doing work on behalf of both
branches X and Y", where there are more than one plausible branch,
which is different from what HEAD points at, that
include_by_branch() could use.

Thanks.
