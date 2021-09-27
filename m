Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE6C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCEB660FC2
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 21:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbhI0VX1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:23:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59663 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhI0VX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 17:23:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 80B7614184C;
        Mon, 27 Sep 2021 17:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=swqGbSC6sI5urkziLQYDh9Fz9i66nyd64L1WOW
        G39iI=; b=rEQ4dQmvpSS8mbQMtrcQg3Fm/k1N86MmUCxKJBzWo7vyIt84pLZq0n
        mCRfNsLDPNmjojMovqpJa7jANImuXZVfH/KhTocE/bh+A9EOHo0saOUJTCjxATf+
        ElOH80MSTu87V/wiM378KQ06OCZ4kWUZxeEo4RR2stGERi7hC6Uk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 789F414184A;
        Mon, 27 Sep 2021 17:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A5D79141849;
        Mon, 27 Sep 2021 17:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Taylor <coolcatt@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug Report: git ls-files -d
References: <CAP9BFHVdg_BWZ2wvdv8t-mN3WKjW4fA+v2181WRYQGsrgmvKmA@mail.gmail.com>
Date:   Mon, 27 Sep 2021 14:21:44 -0700
In-Reply-To: <CAP9BFHVdg_BWZ2wvdv8t-mN3WKjW4fA+v2181WRYQGsrgmvKmA@mail.gmail.com>
        (Calvin Taylor's message of "Mon, 27 Sep 2021 10:36:24 -0300")
Message-ID: <xmqqtui5ogt3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAF4815E-1FD8-11EC-A890-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



    What did you expect to happen? (Expected behavior)
    git ls-files -d to show deleted files in my repository

    What happened instead? (Actual behavior)
    nothing is shown

Does not reproduce to me.

    $ git reset --hard
    $ git ls-files -s COPYING
    100644 536e55524db72bd2acf175208aef4f3dfc148d42 0	COPYING
    $ ls -1 COPYING
    COPYING
    $ git ls-files -d; echo no output
    no output
    $ rm COPYING
    $ git ls-files -d
    COPYING

Did you remove any file?  "ls-files -d" reports the working tree
files that have been removed that are still known by the index.
So, after all of the above

    $ git rm --cached COPYING
    $ git ls-files -d; echo no output
    no output

is perfectly expected.

Unlike "git ls-files" that checks the working files against what is in
the index, "git status" checks them against both the index and the
HEAD, so after all of the above, it would notice the removal
relative to HEAD:

    $ git status -uno --porcelain
    D  COPYING

HTH.
