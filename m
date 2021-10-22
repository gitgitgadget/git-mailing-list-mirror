Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F7AC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF41E6044F
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhJVVTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:19:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53610 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVTj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:19:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC9EDF6D0E;
        Fri, 22 Oct 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RdjYyMC6NxV7zF+Kw6oO4i1kPPVmF2rj82R6mf
        Z2SNU=; b=xuRM/1ThRbpylhkdXTtqg+Q+y+6vjV4mfK4ZbqA1Am0FQfwNCC0qBG
        CxPqyTkfnb2e1S2RUEFVSpLZ7VCzg37gE1yKbrJMl9pbDaJCaw4DBc9sqrm8pDW9
        nmEDdt2zL1c+/Zk59Iqr6SRYCMIOC1pEqy4GBReRWfWL36xXtHIfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3FD2F6D0C;
        Fri, 22 Oct 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 28A73F6D0B;
        Fri, 22 Oct 2021 17:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kalyan Sriram" <kalyan@coderkalyan.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
        <xmqqbl3ihu6l.fsf@gitster.g>
        <016801d7c74b$64bb9a90$2e32cfb0$@nexbridge.com>
        <0101017ca921a6a0-96383fe2-4d73-47cb-83f7-4152b2c6ed7e-000000@us-west-2.amazonses.com>
Date:   Fri, 22 Oct 2021 14:17:18 -0700
In-Reply-To: <0101017ca921a6a0-96383fe2-4d73-47cb-83f7-4152b2c6ed7e-000000@us-west-2.amazonses.com>
        (Kalyan Sriram's message of "Fri, 22 Oct 2021 17:52:07 +0000")
Message-ID: <xmqqlf2kep41.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71070494-337D-11EC-BBBD-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kalyan Sriram" <kalyan@coderkalyan.com> writes:

>> The really unhappy place is when a user deletes the upstream submodule
>> repo itself after not seeing it in main any longer during
>> some cleanup adventure, then someone else tries to check out an older
>> commit that references the submodule.
>
> IMO this seems like a pretty unlikely situation to be in, which doesn't
> warrant *not* adding this feature. I get the idea, but how commonly do
> people checkout old commits and play around with them?

You MUST be able to go back to old versions.  Otherwise, why are we
working on a version control system?  You may find that in the old
days in v1.0 something used to work and in today's code it does not.
You would want to bisect and need to be able to go back to v1.0 that
still had the submodule you recently removed.  And you check where
in the history since v1.0 the actual breakage happend---it is called
"bisection" and people do that all the time.  IOW, it is VERY common.

And that is why I said "submodule rm" should *not* just "rm -fr
submodule-dir/", but ensure that submodule-dir/.git is absorbed (in
.git/modules/submodule-dir, most likely) before doing so, and then
the entry for the submodule should be removed from .gitmodules, but
I deliberatly did not mention anything about .git/config.  The entry
should in general _stay_ there, because having an entry for a
submodule in .git/config means you are interested in it (e.g. your
build may require having it, for a commit in the superproject that
still had the submodule there).  When you are on a commit in the
superproject after the submodule was removed, you may not have
anything from the submodule materialized in the working tree, but
when you go back in the history, you do still need to be able to
materialize it.

> In any case, this
> seems to be the project maintainer's problem, not git's.

You are correct.  The remote side removing some repository and
making it unavailable is just as bad as the site going down.  

On your side, you would want to be able to continue working even
when that happens, and not simply removing submodule-dir/.git
together with submodule-dir/ before making sure the submodule is
absorbed makes sure you'd have a local copy of the submodule
repository available just like you have local copy of the
superproject repository available.
