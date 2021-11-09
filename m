Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944F2C433FE
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F08561165
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhKIArZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 19:47:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57307 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhKIArZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 19:47:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 878A3F0808;
        Mon,  8 Nov 2021 19:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oO2womNyBLTLEyKnCUzT78DNxCHpO9SptCtAEJ
        zVt60=; b=Cu3Jyao1R028+rsdc2eHlvkATux/xuajsxgX8Rc8vL/p6KUtIdPmF/
        JJzxusUMVTQYiTC5trVUHiEkm5g5mH/XzCCvdRJ5LHGcNst2bzsB53E6KK+vuanx
        OttNCFGNf81Mrx2oZhvuGHHIoUJr6RIOtEngjMSIkKsTBntJDyvzo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DAD2F0807;
        Mon,  8 Nov 2021 19:44:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7C1AF0806;
        Mon,  8 Nov 2021 19:44:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Kaseorg <andersk@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v3 2/2] receive-pack: Protect current branch for bare
 repository worktree
References: <alpine.DEB.2.21.999.2111081515380.100671@scrubbing-bubbles.mit.edu>
        <xmqqzgqe448a.fsf@gitster.g>
Date:   Mon, 08 Nov 2021 16:44:37 -0800
In-Reply-To: <xmqqzgqe448a.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        08 Nov 2021 15:28:21 -0800")
Message-ID: <xmqqpmra40p6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3823DCCA-40F6-11EC-A8A1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -1456,11 +1456,11 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
>>  		work_tree = worktree->path;
>>  	else if (git_work_tree_cfg)
>>  		work_tree = git_work_tree_cfg;
>
> Not a fault of this patch at all, but I am not sure if this existing
> bit of code is correct.  Everything else in this function works by
> assuming that the worktree that comes from the caller was checked
> with find_shared_symref("HEAD", name) to ensure that, if not NULL,
> it has the branch checked out and updating to the new commit given
> as the other parameter makes sense.
>
> But this "fall back to configured worktree" is taken when the gave
> us NULL worktree or worktree without the .path member (i.e. no
> checkout), and it must have come from a NULL return from the call to
> find_shared_symref().  IOW, the function said "no worktree
> associated with the repository checks out that branch being
> updated."  I doubt it is a bug to update the working tree of the
> repository with the commit pushed to some branch that is *not* HEAD,
> only because core.worktree was set to point at an explicit location.

Not "I doubt", but I suspect it is a bug.  Sorry.

But in practice, especially with the new code structure, we'd never
flip do_update_worktree on unless find_shared_symref() says that the
ref we are updating in the function is what is checked out, which
means worktree is always non-NULL when we call update_worktree().

So, unless there is some situation where worktree->path is NULL for
a worktree with a checkout, the "else if" above is a dead code, I
think.

Similarly, I suspect that is_bare_repository() call the patch moved
into the if/else if/ chain is even reachable with the updated
caller.  find_shared_symref() is always called, and unless it gives
a non-NULL worktree, do_update_worktree never becomes true.

Anyway, enough bug finding in the existing code.  I think the
update-instead was Dscho's invention and when the codepath was
updated to be worktree ready, Dscho helped Hariom to do so, so
I'll CC Dscho to see if he has input.

Thanks.
