Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E13EB20899
	for <e@80x24.org>; Wed,  2 Aug 2017 19:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbdHBTun (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 15:50:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61965 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752116AbdHBTum (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 15:50:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D550B92DB3;
        Wed,  2 Aug 2017 15:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C7PiEYe9sRfsVtk9/pKEQH+sJhw=; b=fAnlMH
        4Ap5iOFv3PgCx/lrSjVC0MNjYu13aSP2OuER9qI35jK7zmqpvVkhGn5psBJRXWaR
        hOl01TPk7lEGzEdEKtHthAVdkV6AA8Osp13H5v/rooTaXdR93b7YulKZQlu0qGGS
        I6OXbDeZHN3qjIzS7lhGAZCJtkyqAMW9hmjSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xk+Fslxz/CLq/sgulX1La1HZbhuMNbcN
        EdXcoPHR0uekPzxj9ruuQCFSXaGhN0Ra5y4hBF386SZmRGvJ/ZogC+lvKMdp4LGN
        w0eVocZ9aPlHeGkBgPypy0LSgn3R+rP6JJ29vTi/Aibh+MTi3NirJNZ3i01uqJ9D
        OLcMlW7fY1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC5C092DB0;
        Wed,  2 Aug 2017 15:50:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4747792DAF;
        Wed,  2 Aug 2017 15:50:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Subject: Re: reftable [v4]: new ref storage format
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
Date:   Wed, 02 Aug 2017 12:50:39 -0700
In-Reply-To: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
        (Shawn Pearce's message of "Sun, 30 Jul 2017 20:51:24 -0700")
Message-ID: <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCADA9E6-77BB-11E7-8B0C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> ### Layout
>
> The `$GIT_DIR/refs` path is a file when reftable is configured, not a
> directory.  This prevents loose references from being stored.
>
> A collection of reftable files are stored in the `$GIT_DIR/reftable/`
> directory:
>
>     00000001_UF4paF
>     00000002_bUVgy4
>
> where reftable files are named by a unique name such as produced by
> the function:
>
>     mktemp "${update_index}_XXXXXX"
>
> The stack ordering file is `$GIT_DIR/refs` and lists the current
> files, one per line, in order, from oldest (base) to newest (most
> recent):
>
>     $ cat .git/refs
>     00000001_UF4paF
>     00000002_bUVgy4
>
> Readers must read `$GIT_DIR/refs` to determine which files are
> relevant right now, and search through the stack in reverse order
> (last reftable is examined first).
>
> Reftable files not listed in `refs` may be new (and about to be added
> to the stack by the active writer), or ancient and ready to be pruned.

I like the general idea, what the file format can represent and how
it does so, but I am a bit uneasy about how well this "stacked" part
would work for desktop clients.  The structure presented here is for
optimizing the "we want to learn about many (or all) refs" access
pattern, which probably matters a lot on the server implementations,
but I do not feel comfortable without knowing how much it penalizes
"I want the current value of this single ref" access pattern.

With the traditional "packed-refs plus loose" layout, no matter how
many times a handful of selected busy refs are updated during the
day, you'd need to open at most two files to find out the current
value of a single ref (admittedly, the accessing of the second file,
after we realize that there is no loose one, would be very costly).
If you make a few commits on a topic branch A, then build a 100
commit series on top of another topic branch B, finding the current
value of A is still one open and read of refs/heads/A.

With the reftable format, we'd need to open and read all 100
incremental transactions that touch branch B before realizing that
none of them talk about A, and read the next transaction file to
find the current value of A.  To keep this number low, we'd need
quite a frequent compaction.

We can just declare that reftable format is not for desktop clients
but for server implementations where frequent compaction would not
be an annoyance to the users, but I'd wish we do not have to.



