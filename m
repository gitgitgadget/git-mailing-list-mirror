Return-Path: <SRS0=BqTQ=5V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07953C2BA15
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FAB2072A
	for <git@archiver.kernel.org>; Sun,  5 Apr 2020 20:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PPgUqgzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgDEU2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:28:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55690 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbgDEU2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 16:28:16 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CD8A5D6B1;
        Sun,  5 Apr 2020 16:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HMJiDBwgi7hqb12TN77wLNX/T/s=; b=PPgUqg
        zGCTZJTGN4ssM9FhsYZjPzXVRYdMqjFNq2Vzjw3WJThos9QqjAKBIrtnqscoFOxU
        4n39MR2tchtA8hUHPeMQips3rfZQpcWpWNIb/fIPWtBfZF/kKTyrR0yhiY7ZgGCO
        mK7bR8/L1IZny4R693+mHFGRwc/xq84ls13Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U5XrSHj/hPkXv84QxUSJ8vbAKXTvKUz0
        GzFfKwNH0Ca8ommouahKC8kiIA73zL3OjEwpVTt6hr6p/SzMNLjzgYyyYHynYvgk
        UrESMXkXUNtm0oJUX/cyU/H5u+5ecJY0yKM/GmU/KaePi0Nscne5+UUyvgRPiStj
        EG0TIx6xubU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7465B5D6B0;
        Sun,  5 Apr 2020 16:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C95625D6AE;
        Sun,  5 Apr 2020 16:28:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        stolee@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 03/15] run-job: implement fetch job
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
        <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
Date:   Sun, 05 Apr 2020 13:28:13 -0700
In-Reply-To: <77b1da5d3063a2404cd750adfe3bb8be9b6c497d.1585946894.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 03 Apr 2020
        20:48:02 +0000")
Message-ID: <xmqqeet1y8wy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F9799A90-777B-11EA-B69C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> 1. One downside of the refs/hidden pattern is that 'git log' will
>    decorate commits with twice as many refs if they appear at a
>    remote ref (<remote>/<ref> _and_ refs/hidden/<remote>/<ref>). Is
>    there an easy way to exclude a refspace from decorations?

I do not think there is, but it makes sense to teach the decoration
machinery to either use only certain refs hierarchies or use all
hierarchies except for certain ones; if we want to make sure we
won't break existing workflows, we should by defautlt use all the
refs we currently use and nothing else, but over time we probably
would want to migrate the default to cover only the local and
remote-tracking branches and tags (and at that point, refs/hidden
would be outside the decoration source).

By the way, I have a moderately strong opinion against the use of
"refs/hidden" for the purpose of "prefetch in advance, without
disrupting refs/remotes".  There may be more than one reason why
some refs want to be "hidden", and depending on the purose, the
exact refs that one workflow (e.g. "decorate") wants to hide may be
the ones that want to be exposed.

If we rename it to "refs/prefetch/", would it make the purpose of
the hierarchy clearer without squatting on a vague (because it does
not tell why it is hidden) name "hidden" that other people might
want to use to hide their stuff for different reasons?

> Should
>    we make refs/hidden/* a "special" refspace that is excluded from
>    decorations?

See above.
