Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0616C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD89C22266
	for <git@archiver.kernel.org>; Wed, 13 May 2020 14:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SD0+s51p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgEMO7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 10:59:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56154 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMO7e (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 10:59:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35B676169D;
        Wed, 13 May 2020 10:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jc9imBSuiZR82vd3HgP56p76/nw=; b=SD0+s5
        1poR6A80s9tpB4b89FYBUhO7nmvPUE1V33Lt465gC6EpoaiLea3kXMaGV3mj2rlL
        rlpVlriAtZE6U5BtT4w+mr/52DHn0tjILKOuJ5SgWTRV58ytSgJoW2iGWdoytfUO
        1G0cWne8M+ntPFXn/rDIZ2xJmOp2q7Tyukubk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U3VRWayB6wSKueCzoA0EUylAbvgxc1nN
        P4YmntxEbaYf7chHVVsF0IyUEa0KjL40qBESzK0nyZ7TUn5TnnTm8Jir+4+bq/mQ
        CpXmDCRfvNOmJ7nMeVTSQgH8ML8r3lxm6NXRrqYoCJsPMk7dCUAN4L8ZKNq1NHvH
        eggNOAwbFfw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CD6B6169C;
        Wed, 13 May 2020 10:59:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4FA86169B;
        Wed, 13 May 2020 10:59:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] wt-status: expand, not dwim, a "detached from" ref
References: <20200513004058.34456-1-jonathantanmy@google.com>
        <xmqqftc4wg96.fsf@gitster.c.googlers.com>
Date:   Wed, 13 May 2020 07:59:28 -0700
In-Reply-To: <xmqqftc4wg96.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 12 May 2020 22:33:41 -0700")
Message-ID: <xmqq5zczx4mn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58A9CD16-952A-11EA-AA25-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK.  "Detached at <hash>" is somewhat unsatisfactory (you most
> likely have detached from refs/remotes/origin/<something>), but
> it is much better than "fatal" X-<.
>
>> One alternative is to plumb down a flag from dwim_ref() to
>> interpret_branch_mark() that indicates that (1) don't read HEAD when
>> processing, and (2) when encountering a ref of the form "<optional
>> ref>@{u}", don't die when the optional ref doesn't exist, is not a
>> branch, or does not have an upstream. (We cannot change the
>> functionality outright because other parts of Git rely on such a message
>> being printed.)
>
> Thanks for a good analysis.  That likely is a good direction for a
> longer term.  @{upstream} is "tell me the upstream of the branch
> that is currently checked out", right?  So it is reasonable to
> expect that it has no good answer in a detached HEAD state.  And
> when on a branch, that branch may not have an upstream, and we
> should prepare for such a case, too.

Well, I have to take this back.

The real cause of the problem is that we record in reflog that we
switched to @{u}, but when get_detached_from() tries to "dwim" it,
the "current branch" that is implicitly there to be applied to @{u}
is different one from what used to compute which branch to check
out, isn't it?  And it probably is not limited to @{upstream} but
other @{<stuff>} that implicitly apply to the "current branch",
e.g. @{push}.

This causes a few potential problems:

 - The "current" branch may be different from the one when such a
   reflog entry that refers to @{<stuff>} when we later yank
   @{<stuff>} out of the reflog and try to use it.  This is the
   problem the patch under discussion tries to hide, but the patch
   also breaks cases that are working fine.

 - Even if the user gave the branch name (i.e. 'next@{upstream}' in
   the example this patch would have introduced a regression) or if
   we updated get_detached_from() to correctly infer the branch that
   was current when the reflog entry in which we found @{upstream}
   was recorded, the upstream for the branch may have been
   reconfigured between the time when the reflog entry was written
   and get_detached_from() is called.  'next@{upstream}' may have
   been 'origin/next' back then but it may be a different
   remote-tracking branch now.  This issue is not solved by the
   patch---the issue is unfixable unless we log the changes to the
   branch configuration so that we can figure out what was the
   upstream of 'next' back then, which we won't do.

Assuming that is the root cause, I think the right solution likely
lies along these three lines:

 (1) record not @{<stuff>} (or <branch>@{<stuff>} for that matter),
     but the actual starting point in the reflog (e.g. in the
     example this patch would have introduced a regression,
     i.e. next@{u}, we should record 'origin/next'.  In the example
     this patch would have used degraded output to prevent dying,
     i.e. @{u}, we should also record 'origin/next')---this also
     will fix the "the branch's upstream may be different now"
     problem.

 (2) a patch like yours to use expand_ref() as a fallback, but only
     for the "@{<stuff>}" notation that depends on what the "then
     current" branch was---this is a mere band-aid, like the patch
     under discussion is, but at least it would not regress the
     cases that are "working".  "The upstream may be different now"
     problem is still there.

 (3) when we have to interpret @{<stuff>} found in the reflog, go
     back to see which branch was current, and compute @{<stuff>}
     relative to that branch---this would "fix" more cases than (2)
     would, but it won't fix "the upstream can change" problem, and
     I think the trade-off is not all that great.

I think the combination of (1) and (2) is likely to be the best way
to go.  (1) will remove the root cause, and (2) will allow us to
cope with reflog entries before (1) is applied.
