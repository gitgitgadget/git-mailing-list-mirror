Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417A5C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343489AbiCJTQG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 14:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343490AbiCJTQE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 14:16:04 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C411592B8
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 11:15:03 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BF58182299;
        Thu, 10 Mar 2022 14:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wSUiUTbtbiJ/DVrkrxN9+C97Qfh8k9hAN/PmOa
        c4l3Q=; b=kTmKbpbOzLZunYmcvWYWuZqJuMg7wXrrN/UqWmKGK+y/fFQHERbE8s
        4tR3ZV/OaQYX8o7X+/ePfKfu6RQvTc8TDDaEYPIkaEFjtpqr2fLuOSZ7aQ+PgpoT
        DFuhjRIoR6qO/uxbQfdJT7rKZ4qgwVVcAhy2JuG9BUvIhLbQhE/BY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 54AF5182297;
        Thu, 10 Mar 2022 14:15:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9942A182294;
        Thu, 10 Mar 2022 14:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/6] Importing and exporting stashes to refs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
Date:   Thu, 10 Mar 2022 11:14:59 -0800
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:30 +0000")
Message-ID: <xmqq35jpei18.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61C5981A-A0A6-11EC-8F34-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> ...  The commits used in a stash export are nearly
> identical to those used in the stashes, with one notable change: the
> first parent of a stash is a pointer to the previous stash, or an empty
> commit if there is no previous stash.  All of the other parents used in
> the stash commit are present following it in their normal order.
> ...
> We intentionally attempt to exactly round-trip commits between stashes,
> although we don't do so for the exported data due to the base commit not
> having identical timestamps.  Preserving the commits exactly lets us
> more efficiently test our code and it also permits users to more easily
> determine if they have the same data.

Hmph, out of reflog entries stash@{0}, stash@{1}, stash@{3}, if we
create a chain of commits A, B, C such that

	A^2 = B, A^1 = stash@{0}
	B^2 = C, B^1 = stash@{1}
	         C^1 = stash@{2}

then the original stash entry commits can be recreated identically,
and after you export the stash as "A", you can "import" from it
without creating any new commit to represent the stash entries, no?

When we create A, if we use a predictable commit log message and
the same author/committer ident as A^1 (i.e. stash@{0}), and do it
the same for B and C, then no matter who exports the stash and at
which time, we'd get an identical result, I would presume.

> The tooling here is intentionally plumbing.  It's designed to be simple
> and functional and get the basic job done.  If we want additional
> features, we can add them in the future, but this should be a simple,
> basic feature set that can support additional uses.

Sounds sensible.
