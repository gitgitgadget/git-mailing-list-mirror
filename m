Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164ACC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbhLVAeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:34:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55662 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLVAeC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:34:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2044159C3D;
        Tue, 21 Dec 2021 19:34:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6UzQHQGjHCafDbAuu84J4lr0yqX2rM1eUZ5D0/
        GYRys=; b=tXi/kPlmvMlylRqjcpD0wrrg+kG9SRi2jJgTXlaXnZjm9QekLLfMId
        6edalegWuhr0oYFT9rrDy5vF1zfjxzwdX058KC7gGuOU4uZFOIHGkDcynVt6GNj/
        ZQNJy6fPldDDhzO3NnWEygBTN9ZsUAEFmbpJpgnNws4YlpKgcFmTk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9BFB159C3B;
        Tue, 21 Dec 2021 19:34:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 210BA159C39;
        Tue, 21 Dec 2021 19:33:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 0/9] Add a new --remerge-diff capability to show & log
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 16:33:56 -0800
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Tue, 21 Dec 2021 18:05:39 +0000")
Message-ID: <xmqqee65mqa3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9F2D8C8-62BE-11EC-A56C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  Documentation/diff-options.txt |  8 ++++
>  apply.c                        |  5 ++-
>  builtin/checkout.c             | 12 ++++--
>  builtin/log.c                  | 16 ++++++++
>  diff-merges.c                  | 12 ++++++
>  diff.c                         | 34 ++++++++++++++++-
>  diff.h                         |  1 +
>  ll-merge.c                     | 40 ++++++++++---------
>  ll-merge.h                     |  9 ++++-
>  log-tree.c                     | 70 ++++++++++++++++++++++++++++++++++
>  merge-blobs.c                  |  5 ++-
>  merge-ort.c                    | 49 +++++++++++++++++++++---
>  merge-ort.h                    | 10 +++++
>  merge-recursive.c              |  8 +++-
>  merge-recursive.h              |  1 +
>  notes-merge.c                  |  5 ++-
>  rerere.c                       | 10 +++--
>  revision.h                     |  6 ++-
>  t/t6404-recursive-merge.sh     |  9 ++++-
>  t/t6406-merge-attr.sh          |  9 ++++-
>  tmp-objdir.c                   |  5 +++
>  tmp-objdir.h                   |  6 +++
>  22 files changed, 288 insertions(+), 42 deletions(-)

It is somewhat disappointing that there is no test or documentation
update that show how a typical remerge-diff output should look like.
I was specifically interested in finding out how the "conflict hint
messages from merge backend in the diff header" output would look.

I left some messages here and there on the patches I read carefully,
and they looked mostly good.  I only skimmed 7 and 8 and did not
find anything glaringly wrong, but that wouldn't count as a review.

Thanks.
