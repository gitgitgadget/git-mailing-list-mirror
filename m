Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E79DC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiBPAvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:51:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiBPAvg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:51:36 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF863E6
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:51:25 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8ECDD18D251;
        Tue, 15 Feb 2022 19:51:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AceYkjqwdHZPJdkgKXS+8TIpII7r3B7FKo7FVv
        +62qw=; b=DpQr0Kr9MzhHbBedD/L28qwma3Bg7xdx2q0AFDbzf3X9Dao5ZiHiZE
        BI7wuAG7gQCoZgH1mpjrv6MS/ETAf3br+xu9Zm2jMCA3xpqQ047jAfZqUv88ZVRk
        Dk/xM5v4gKWE9DaNBi/VZkjqYtBdA3kU1NYVA8emkmETLozwgLdMs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 86FDE18D250;
        Tue, 15 Feb 2022 19:51:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F1FE18D24D;
        Tue, 15 Feb 2022 19:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic
 commit dates
References: <20220214210136.1532574-1-jacob.e.keller@intel.com>
        <xmqqr18515jr.fsf@gitster.g>
        <CA+P7+xrN0zPWfxO1roWzR+MBHntTv8jr9OGdNcN9RPA=ebK24A@mail.gmail.com>
        <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com>
Date:   Tue, 15 Feb 2022 16:51:20 -0800
In-Reply-To: <42d2a9fe-a3f2-f841-dcd1-27a0440521b6@github.com> (Derrick
        Stolee's message of "Tue, 15 Feb 2022 09:48:38 -0500")
Message-ID: <xmqq1r03zl9z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F1066EC-8EC2-11EC-BAD8-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I initially thought that generation numbers could help. The usual way
> is to use a priority queue that explores by generation, not commit
> date. This approach was immediately stifled by these lines:
>
> 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO */
> 	prio_queue_put(&queue, start_commit);
>
> So the queue is really a stack.

Hmph, I am not sure if stifled is a word, but I agree that this one
is not solvable by "we have a priority queue that explores by commit
date, and using generation numbers instead of commit date will give
us a more stable result when clock skews are involved", because the
traversal is not the usual "we pop the newest commit seen so far to
dig into older history".

However.

> It is still possible that the cutoff could be altered to use generation
> numbers instead of commit dates, but I haven't looked closely enough to
> be sure.

In "name-rev [--tags] C", we look for a tag to use in describing the
given commit C as an ancestry path starting at the tag T (e.g. T~4,
T~2^2).  There can be multiple such tags (e.g. it is likely that a
commit that is v1.0~2 is also reachable from tag v2.0, even though
it would require more hops).  We try to and find a tag that gives
the "simplest" path.  For that purpose, it is no use to consider any
tag that is not a descendant of the given commit, because doing an
ancestry traversal starting from such a tag will never reach the
commit.  In a world where everybody's clock is in sync, if commit
was made at time X, any tag that was made before time X will not be
a descendant of the commit, so we do not add such a tag to the
candidate pool.

I think the idea of "cutoff" heuristic is exactly what generation
numbers can improve, in an imperfect world where there are imperfect
clocks.
