Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E900AC433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 00:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiAVAFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 19:05:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54729 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiAVAFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 19:05:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CE1D1863AA;
        Fri, 21 Jan 2022 19:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7MmLJ54uQm+wUra51oY/4KqaoYa1omZz1MBdAc
        GwL2E=; b=tfIYymFL3YnbWTUxBpJjltu2xxE+Mshn9TRDsgG0aZvjcNRr1sfmB6
        QmsnjVSQ4fkWiZ8v3d0Bw+Iwqn8RMUI7r7ea+bjpAIo3UOlvbZc+1PXxsRRV7Zh8
        seFslsZJzGb53o/iXGiOJjwz0xVOopK8x7gZFNClibSZw/BlEdxQo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 65B1A1863A9;
        Fri, 21 Jan 2022 19:05:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A1FB21863A8;
        Fri, 21 Jan 2022 19:05:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/2] merge: fix memory leaks in cmd_merge()
References: <pull.1200.git.git.1642664835.gitgitgadget@gmail.com>
        <c6522d6449f9323edbbd9329b2859368492aabd3.1642664835.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Jan 2022 16:05:18 -0800
In-Reply-To: <c6522d6449f9323edbbd9329b2859368492aabd3.1642664835.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 20 Jan 2022
        07:47:15 +0000")
Message-ID: <xmqqczkkeitd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC76E0A4-7B16-11EC-8E29-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  done:
> +	if (!automerge_was_ok) {
> +		free_commit_list(common);
> +		free_commit_list(remoteheads);
> +	}

I wondered what happens upon a successful automerge.

We call finish_automerge() and come here, and I do see a call to
free_commit_list(common) in finish_automerge(), but the way
remoteheads is used looked a bit iffy.

In finish_automerge(), we use a temporary variable parents to point
remoteheads at it, and conditionally prepend the current HEAD at the
beginning of the parents list.  This is passed to commit_tree(),
which does pop_commit() to consume all commits on the list.

So after commit_tree() returns, all commit_list instances on
remoteheads list, and possibly the one finish_automerge() prepended
for the current HEAD, are all consumed, and there is no need to
call, and it would be wrong to call, free_commit_list(), at this
point.

So, I agree that this conditional freeing is correct.  It was just
it was a bit hard to see.

Thanks.


