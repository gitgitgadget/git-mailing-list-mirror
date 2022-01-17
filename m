Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CAAC433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 23:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiAQXMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 18:12:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiAQXMO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jan 2022 18:12:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 383701786FF;
        Mon, 17 Jan 2022 18:12:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DU1YLdXBnfYuvAMiOgvYBQsHQ0vL2cVhqLsCA2
        0mNI4=; b=AhSuuSKHNal3pJ6LkEcdVgolqoFC6q2AdxtB33vjD/KrBhpEdIIyq4
        BAUj1YJukrxQJd90Qaw871sLSHRFjMEqSu8Cn1bZRW6Wick3dbKYZWEYgJb0ujpJ
        EZcjdYN8ZtMHrOeyLp79LJQjaQhNZcS/xXtWPQ1nV/yxDOBXpbbyg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30F201786FE;
        Mon, 17 Jan 2022 18:12:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F3661786FD;
        Mon, 17 Jan 2022 18:12:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John A. Leuenhagen" <john@zlima12.com>
Cc:     git@vger.kernel.org
Subject: Re: Behavior of core.sharedRepository on non-bare Repositories
References: <20220117223912.fwsydwpkwfbcdlcq@Zulu-1>
        <xmqqo84at131.fsf@gitster.g>
Date:   Mon, 17 Jan 2022 15:12:10 -0800
In-Reply-To: <xmqqo84at131.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        17 Jan 2022 15:05:38 -0800")
Message-ID: <xmqqk0eyt0s5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E69BDF52-77EA-11EC-AFBC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But allowing write access to the same repository from multiple
> working trees were considered worth supporting.  More importantly,
> the repository data access by git is not uncontrolled---there are
> protections with lockfiles to avoid overwriting others' changes.

IOW, the expected set-up is for a repository (bare or non-bare) is
marked as shared, owned by the group, and each user who wants to
work locally on that project sharing the repository would belong to
the group.  Each user has a worktree added to the repository (via
"git worktree add") and it is OK (and may even be encouraged) to
have their umask stricter than 022 to prevent other users in the
same group from mucking with the worktree files.  Since Git sets
the permission bits of these shared repository files to allow access
by group members, looser than what umask(1) gives as needed, users
can share the repository contents without giving too loose an access
to the worktree files.
