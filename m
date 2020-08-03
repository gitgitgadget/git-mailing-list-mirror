Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57322C433EA
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEA822CA1
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 21:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MZHkCJyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgHCVCW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:02:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57626 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgHCVCW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 17:02:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DB587F5A83;
        Mon,  3 Aug 2020 17:02:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkoJPrDpXMmrcz0yEAUU3SOlXYY=; b=MZHkCJ
        yWdHc7l2PY8jOirdBb9rBFBPiU+L1FGehM1svae6LGTB5CM7aj64isTa9eR4PAfu
        eFxTFqK5BpUGBtypZQOjHo7rNsYAjvMKxXYK21A8dPzzawoA9Bho9aeGKIdlOgxp
        q/njkpVEIE9/Z5/dJLfVyhE/sYLeurgunld0Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eQV9K8i0B3T4vuVzZNtUlsfAzdeb+/rG
        POkiyceT0oWuriKmdNKbwwJuQ47W3uDryt2tYwMJYkcJZFohvtM6WGJ+zj0+7+Ms
        nMAUpqpzWWIKHuilvF0RqWrnqGX4HXqtelDtbhAWht6yToj+OzsCB1oaR25ybXt2
        QCeZIqeAv5s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3CD1F5A82;
        Mon,  3 Aug 2020 17:02:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1B9CDF5A81;
        Mon,  3 Aug 2020 17:02:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: Renaming the "master" branch without breaking existing clones
References: <ec960483f5008e9948271c678d51876920ab62c9.camel@mattmccutchen.net>
        <20200803160051.GA50799@syl.lan>
        <20200803194006.GA2715275@coredump.intra.peff.net>
        <20200803204503.GB2715275@coredump.intra.peff.net>
Date:   Mon, 03 Aug 2020 14:02:14 -0700
In-Reply-To: <20200803204503.GB2715275@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 3 Aug 2020 16:45:03 -0400")
Message-ID: <xmqq1rknv3xl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C5878C2-D5CC-11EA-8227-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Something like this script could be run on the clients:
>
>   remote=origin
>   git ls-remote --symref $remote |
>   grep ^ref: |
>   while read junk to from; do
>     if test "$from" = HEAD; then
>       old=$(git symbolic-ref refs/remotes/$remote/HEAD)
>       echo "Upstream switched their HEAD:"
>       echo "  old: $old"
>       echo "  new: $to"
>       echo "Update to match?"
>       read r </dev/tty
>       if test "$r" = yes; then
>         git symbolic-ref refs/remotes/$remote/HEAD $to
>       fi
>     else
>       # do we even have the old branch?
>       git rev-parse --verify $from >/dev/null 2>&1 || continue
>       echo "Upstream is redirecting a branch:"
>       echo "     branch: $from"
>       echo "  points to: $to"
>       echo "And you have a local $from; should we rename it?"
>       read r </dev/tty
>       if test "$r" = yes; then
>         git branch -m ${from#refs/heads/} ${to#refs/heads/}
>       fi
>     fi
>   done
>
> There are probably some rough edges that could be smoothed (only looking
> in refs/heads/ and using branch names instead of fully qualified refs,
> handling the case that $to already exists more gracefully, better
> prompting). But something like that might be useful for projects that
> are transitioning.
>
> Note that it only works with protocol v2, though, because we don't
> report non-HEAD symrefs in v0.

Renaming local branches themselves is probably the least interesting
part.  You could even do _without_ renaming your local branches at
all and keep working without any problem.  But you need to be able
to adjust to the renaming upstream does, so if your 'topic' branch
builds on top of 'refs/remotes/origin/master' and your upstream
renames it to 'refs/remotes/origin/stuff' you'd need to reconfigure
'topic' branch to also build on and/or integrate with 'stuff'
instead of 'master'.

