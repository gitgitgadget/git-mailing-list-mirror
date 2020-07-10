Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342DAC433E2
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B5F20725
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 16:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V58670iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGJQnT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:43:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55087 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJQnT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 12:43:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 437747C69B;
        Fri, 10 Jul 2020 12:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=243JUizjDTv6OkQ13yj4AoFaaMM=; b=V58670
        iyxKFk7T1IwO4Tafk5Um4BWlAYmSv2ZJ0xPzCmmaZ5syB2a/Kzu1n9Ia9G+3+gBE
        YlKHk6fdWkr2ch5oZhH7n8YyIZuf3zJvh0SFV8f4Wt3Van/iYsrMlnvAOoBA4NmG
        an9xDvQ7xy181zkkdZenSZKdtFvZaf2Oj8kbo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f7g6GNR8z83jKBgfWVwzSg7imFRzjY3T
        O1ACQzgfSUIqshSqSTSLqe3qQU3zJjI57gbi+qVPsW4OXcixBh/bcnSDq4jdFBBZ
        L33W0RfEY2aRAyRdQD3ypwQttSWJpRI4ofOVf2WC7eVXmD4rSu6HOe9VbkeamhXf
        6R/irNy/TBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4D07C69A;
        Fri, 10 Jul 2020 12:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB3C47C699;
        Fri, 10 Jul 2020 12:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Zach Riggle <zachriggle@gmail.com>, git@vger.kernel.org
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
        <20200707215951.GB2300296@coredump.intra.peff.net>
        <CAMP9c5mpJ9_HvEBTiEQj=vocTdH6N9uXkpLKiE8+hFbAt9p5Ow@mail.gmail.com>
        <20200708201353.GA2354599@coredump.intra.peff.net>
        <xmqqfta11zu0.fsf@gitster.c.googlers.com>
        <20200709231030.GD664420@coredump.intra.peff.net>
Date:   Fri, 10 Jul 2020 09:43:15 -0700
In-Reply-To: <20200709231030.GD664420@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 9 Jul 2020 19:10:30 -0400")
Message-ID: <xmqq5zavuxr0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74388F0C-C2CC-11EA-B9C1-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For a tree-to-tree or index-to-tree comparison, both sides will have an
> oid and can use the textconv cache. Even for an index case where we
> might choose to use a stat-fresh working tree file as an optimization,
> we'll still consult the textconv cache before loading those contents.

OK, that "we'll still consult" part does sound like sort-of
"clever", but after thinking about the whole sentence twice,
I realize the actual cleverness lies in the reuse of stat-fresh
working tree file, not the use of textconv cache ;-)  The cache
is just doing its normal thing: if we know the oid, look up the
cached one.

> But for diffing a file in the working tree, we'll never have an oid and
> will always run the textconv command).

OK.  In such a case, we need to run the clean filter on the working
tree contents, and then finally we need to run the textconv on the
result.  We could internally hash the result of applying the clean
filter to see if we have the blob in the object database and use it
as the look-up key in the textconv cache, but we are talking about
the working tree files, which by definition is more fluid than what
is in the index, which is likely more fluid than what is already
committed, so the chance of finding a hit may be slim.

We could still see if the oid in the index is correct with the stat
check, but by definition, diff-files won't compare between a cache
entry and a working tree file if the path is stat-clean, so that
does not help all that much.  I wonder if diff-index comparing a
tree and the working tree (i.e. without "--cached") can be improved,
though.

> So "git diff" against the index,
> for example, would run _one_ textconv (using the cached value for the
> index, and running one for the working tree version). And we know that
> isn't that interesting for optimizing, since by definition the file is
> stat-dirty in that case (or else we'd skip the content-level comparison
> entirely).

Yup, we reached the same conclusion here ;-)

> So you'd have to compute the sha1 of the working tree file
> from scratch. Plus the lifetime of a working tree file's entry in the
> textconv cache is probably smaller, since it hasn't even been committed
> yet.

Yes again.

> I don't think I ever noticed because the primary thing I was trying to
> speed up with the textconv cache is "git log -p", etc, which always has
> an oid to work with.

Absolutely.

> But "grep" is a totally different story. It is frequently looking at all
> of the stat-fresh working tree files.

Yeah.  Grepping in the working tree files could be optimized with
the same technique that would be used to optimize diff-index without
"--cached".  When we look at the working tree file, we consult the
index and possibly learn its object name if the path is stat-clean,
probably if and only if textconv is in use.

"git grep" would divert to the "grep in a blob object" codepath from
there, and "git diff-index" would make clever use of oid_valid bit
in diff_filespec when running textconv (we might need a separate
bit, though; I haven't thought it through).

Or something like that.

