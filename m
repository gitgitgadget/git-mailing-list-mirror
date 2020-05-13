Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C864FC2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844952054F
	for <git@archiver.kernel.org>; Wed, 13 May 2020 05:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o6GSKFs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgEMFdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 01:33:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62962 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgEMFdq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 01:33:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E89F5DD43;
        Wed, 13 May 2020 01:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zR9saVTEj3dUiS4wR5QyFFiopbs=; b=o6GSKF
        s01rX+3W9MVRZFy2seT5z+OUpy6M5bzy1XmlidWp2t2vHWpoA5wU2+6FyeE4ILNT
        CgTDjFd82AB8SYb53z0lIBYNuxyCPifYXRM8NWkZepuN+AtQM506ndMfhzWrwH5y
        nXVZSu+XE1ZsCZNA7RWx9CzTkp3LES0kQBThM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mVpwUD1jR+6cDS5ytHvxlKQfJStN755F
        77bIuvSW6EmHz1ANUd7sekUcjq2MbN3QXNYcYnXf+3yizT/gsVHfMrcqb4jKisBn
        5GI+KgJpNDeUfQ1EXPlT0poHEiaLrr65A4xV7OcHkTAVTC/nIQ0E7BHOO0wTRMAo
        mdyV0v9xDJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53BE65DD42;
        Wed, 13 May 2020 01:33:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDD585DD41;
        Wed, 13 May 2020 01:33:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] wt-status: expand, not dwim, a "detached from" ref
References: <20200513004058.34456-1-jonathantanmy@google.com>
Date:   Tue, 12 May 2020 22:33:41 -0700
In-Reply-To: <20200513004058.34456-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 12 May 2020 17:40:58 -0700")
Message-ID: <xmqqftc4wg96.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4E237F58-94DB-11EA-B07B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When a user checks out the upstream branch of HEAD and then runs "git
> branch", like this:
>
>   git checkout @{u}
>   git branch
>
> an error message is printed:
>
>   fatal: HEAD does not point to a branch

I had to spend unreasonable amount of time reproducing this.

    $ git branch --show-current
    master
    $ git checkout -b -t naster master
    $ git branch --show-current
    naster
    $ git checkout @{u}
    $ git branch --show-current
    master
    $ git branch
    * master
      naster

What was missing was that the current branch must be forked from a
remote-tracking branch; with a fork from a local branch, the last
step, i.e. "git branch", works just fine.

> (This error message when running "git branch" persists even after
> checking out other things - it only stops after checking out a branch.)

Correct.  And it is also worth pointing out that this is not "git
branch"; the users would see it primarily as a problem with "git
status", which would die the same way.

> This is because "git branch" attempts to DWIM "@{u}" when determining
> the "HEAD detached" message, but that doesn't work because HEAD no
> longer points to a branch.
>
> Therefore, when calculating the status of a worktree, only expand such a
> string, not DWIM it. Such strings would not match a ref, and "git
> branch" would report "HEAD detached at <hash>" instead.

OK.  "Detached at <hash>" is somewhat unsatisfactory (you most
likely have detached from refs/remotes/origin/<something>), but
it is much better than "fatal" X-<.

> One alternative is to plumb down a flag from dwim_ref() to
> interpret_branch_mark() that indicates that (1) don't read HEAD when
> processing, and (2) when encountering a ref of the form "<optional
> ref>@{u}", don't die when the optional ref doesn't exist, is not a
> branch, or does not have an upstream. (We cannot change the
> functionality outright because other parts of Git rely on such a message
> being printed.)

Thanks for a good analysis.  That likely is a good direction for a
longer term.  @{upstream} is "tell me the upstream of the branch
that is currently checked out", right?  So it is reasonable to
expect that it has no good answer in a detached HEAD state.  And
when on a branch, that branch may not have an upstream, and we
should prepare for such a case, too.

> diff --git a/wt-status.c b/wt-status.c
> index 98dfa6f73f..f84ebc3e2c 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1562,7 +1562,7 @@ static void wt_status_get_detached_from(struct repository *r,
>  		return;
>  	}
>  
> -	if (dwim_ref(cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
> +	if (expand_ref(the_repository, cb.buf.buf, cb.buf.len, &oid, &ref) == 1 &&
>  	    /* sha1 is a commit? match without further lookup */
>  	    (oideq(&cb.noid, &oid) ||
>  	     /* perhaps sha1 is a tag, try to dereference to a commit */

Hmph, I just did this:

    $ git branch -b -t next origin/next
    $ git checkout next@{upstream}
    $ git status

It used to say "HEAD detached at origin/next" without this change,
but now it says "HEAD detached at 046d49d455", which smells like a
regression.
