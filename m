Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D310C433EF
	for <git@archiver.kernel.org>; Thu, 12 May 2022 15:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355001AbiELPjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiELPjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 11:39:42 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0120E25C2A8
        for <git@vger.kernel.org>; Thu, 12 May 2022 08:39:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 94F7119D684;
        Thu, 12 May 2022 11:39:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YDFCLLgQfEGHUfOrv6yfzBz40AZdaVT9J2YpOC
        ClXX8=; b=KqoZp6yDUfOaoB0Ko/+Rh3h6NdHBHm1BpJ83Q4cVlB0+fm27pWSD8y
        5S47sm6nrntUoSDdrBR82SGyIKcGoaS5IWdB+ff7vfP0L5ixP2slJPKAAK5upgis
        8acFZ+q/aFk6SJnjuG9Vl9aacf6HZ7jdZTIPoK41V9VA/3C2s3M0c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D66219D683;
        Thu, 12 May 2022 11:39:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2BB1719D682;
        Thu, 12 May 2022 11:39:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, vascomalmeida@sapo.pt
Subject: Re: Question about pre-merge and git merge octopus strategy
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
        <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
        <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
        <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com>
        <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
        <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
        <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
Date:   Thu, 12 May 2022 08:39:34 -0700
In-Reply-To: <CABPp-BHmNBMypVDrE=gPMXoHT9uH-u4HJG1dAuY0tjSGrK0yPg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 12 May 2022 08:04:41 -0700")
Message-ID: <xmqqk0aqhia1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA30D2E6-D209-11EC-A281-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>     Merge with strategy octopus failed.
>
> Also, if we check `git status`:
>
>     $ git status
>     On branch main
>     Unmerged paths:
>       (use "git restore --staged <file>..." to unstage)
>       (use "git add <file>..." to mark resolution)
>     both modified:   base
>
>     no changes added to commit (use "git add" and/or "git commit -a")
>
> And in git-merge-octopus.sh we see:
>
>     case "$OCTOPUS_FAILURE" in
>     1)
>     # We allow only last one to have a hand-resolvable
>     # conflicts.  Last round failed and we still had
>     # a head to merge.
>     gettextln "Automated merge did not work."
>     gettextln "Should not be doing an octopus."
>     exit 2
>     esac
>
> and in builtin/merge.c, we see:
>
>     /*
>      * The backend exits with 1 when conflicts are
>      * left to be resolved, with 2 when it does not
>      * handle the given merge at all.
>      */
>
> Which means git-merge-octopus.sh is claiming it can't handle this type
> of merge, and some other merge strategy should be tried, and
> implicitly that it didn't leave any conflicts to be resolved because
> it can't handle this merge.

Correct.  Near the beginning of the loop you found the above
comment, there is this code:

	if (use_strategies_nr == 1 ||
	    /*
	     * Stash away the local changes so that we can try more than one.
	     */
	    save_state(&stash))
		oidclr(&stash);

	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
		int ret, cnt;
		if (i) {
			printf(_("Rewinding the tree to pristine...\n"));
			restore_state(&head_commit->object.oid, &stash);
		}

but that save-then-restore triggers ONLY when there are multiple
strategies to try.  Unfortunately, octopus has no friends to fall
back on, so we do not do the save-restore dance on the calling side.

> But it clearly decides to leave the
> modifications it made to the index and working tree around, which just
> seems wrong to me.

If merge-recursive or merge-resolve is asked to merge a single
commit to the current branch without any other strategies to use as
a fallback, they leave the working tree and index into a state where
the end-user can conclude the conflict resolution and commit the
result.  In spirit, we are in the same situation, aren't we?

The user, if they want to proceed against octopus's opinion, would
resolve the current conflict, read-tree -m the next one, ..., to
conclude and commit the result. 

So I am not sure if it is a good idea to unconditionally "reset --merge"
in this situation.

> +# If octopus is inapplicable, make sure we undo any changes we made first
> +cannot_octopus() {
> +       git reset --merge
> +       exit 2
> +}
