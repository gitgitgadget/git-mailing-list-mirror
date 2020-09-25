Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BC0C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A56208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 16:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rP9+FtMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIYQ5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:57:16 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62546 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgIYQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 12:57:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05BEDEBA96;
        Fri, 25 Sep 2020 12:57:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nkDh3REFN3F8SYr15NLmNYWSyyc=; b=rP9+Ft
        MuZHQvaFFjINpYm+93NcNy+QCFvS4O/tUtZoRSLhnVTcfZJQjShpJfCNs6CcqX3d
        MjXaBYxx+BBezMycO47lOka+ZbE0DyPtwuUEnjLwOXq5ZEeB77ixCBlOvbUZnLSm
        osAqhB60JCg82wrAVi1W0H9F90f3bZs8aAePA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Z2G4+xEVwkfhH2RPMuE36wOpBSD7gCkl
        wAJ2+mMpLyCTxR1QnRwHOosYegn2eLPU/AbH0O2S+bhgjB7Kgza/COuz1vXBWTOy
        H9avpOn98A3WNOHt1oMUSSQylERhcPqw6NXX2pih7la0gUrgBoOF6yCSqPuSMNCJ
        n5LzJgEbG74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD4ACEBA95;
        Fri, 25 Sep 2020 12:57:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3467BEBA94;
        Fri, 25 Sep 2020 12:57:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] parsing trailers with shortlog
References: <20200925070120.GA3669667@coredump.intra.peff.net>
Date:   Fri, 25 Sep 2020 09:57:09 -0700
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 25 Sep 2020 03:01:20 -0400")
Message-ID: <xmqqsgb5lrq2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 276F0B54-FF50-11EA-9AFC-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Somebody mentioned at the inclusion summit that it would be nice for
> mentoring/pairing relationships if we could more easily give credit to
> multiple authors of a commit. When people ask about adding multiple
> "author" headers, we usually recommend that they use a "co-authored-by"
> trailer. But you can't convince shortlog to count it for anything. :)
>
> So this series adds support for counting trailers to shortlog. You can
> do a number of fun things with it, like:
>
>     # credit reviewers
>     git shortlog -ns --group=trailer:reviewed-by
>
>     # credit authors and co-authors equally
>     git shortlog -ns --group=author \
>                      --group=trailer:co-authored-by
>
>     # see who helps whom
>     git shortlog --format="...helped %an on %as" \
>                  --group=trailer:helped-by
>
> If some of this looks familiar, it's because I sent the early patches
> years ago. But I won't even bother linking to it; I cleaned up quite a
> few rough edges since then, so it's not really worth looking at.

Fun stuff.  I like the idea.

Thanks.


>
>   [1/8]: shortlog: change "author" variables to "ident"
>   [2/8]: shortlog: refactor committer/author grouping
>   [3/8]: trailer: add interface for iterating over commit trailers
>   [4/8]: shortlog: match commit trailers with --group
>   [5/8]: shortlog: de-duplicate trailer values
>   [6/8]: shortlog: rename parse_stdin_ident()
>   [7/8]: shortlog: parse trailer idents
>   [8/8]: shortlog: allow multiple groups to be specified
>
>  Documentation/git-shortlog.txt |  29 +++++
>  builtin/log.c                  |   1 +
>  builtin/shortlog.c             | 218 +++++++++++++++++++++++++++++----
>  shortlog.h                     |   8 +-
>  t/t4201-shortlog.sh            | 141 +++++++++++++++++++++
>  trailer.c                      |  36 ++++++
>  trailer.h                      |  44 ++++++-
>  7 files changed, 447 insertions(+), 30 deletions(-)
>
> -Peff
