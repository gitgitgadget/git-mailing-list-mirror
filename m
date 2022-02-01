Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABECC433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbiBAUNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:13:42 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbiBAUNk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:13:40 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D95C104155;
        Tue,  1 Feb 2022 15:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCicaKrvauezrl4urDe1lQSzR6zbtmQewPNDj4
        q88Lo=; b=tDwOTyNp0NtzhpdARQ4HD+EKPR4d3OX5oV3vtn6I7XBnl3fCInwu6F
        TnXNqfOK0EEvYtJJsbae+Mpo9TaufRDqEqlayBqB0/GZyaY8FU2uopZxyWJQnojT
        SjWo8GjOnt++5/hU2VpenNG1J84168lLoaAGDjrUX8vD2HEtst0As=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 61F0E104154;
        Tue,  1 Feb 2022 15:13:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1208104153;
        Tue,  1 Feb 2022 15:13:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH 0/6] [RFC] partial-clone: add ability to refetch with
 expanded filter
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 12:13:38 -0800
In-Reply-To: <pull.1138.git.1643730593.gitgitgadget@gmail.com> (Robert Coup
        via GitGitGadget's message of "Tue, 01 Feb 2022 15:49:47 +0000")
Message-ID: <xmqqk0eecpl9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 720A2EA2-839B-11EC-A56A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

> If a filter is changed on a partial clone repository, for example from
> blob:none to blob:limit=1m, there is currently no straightforward way to
> bulk-refetch the objects that match the new filter for existing local
> commits. This is because the client will report commits as "have" during
> negotiation and any dependent objects won't be included in the transferred
> pack.

It sounds like a useful thing to have such a "refetch things"
option.

A lazy/partial clone is narrower than the full tree in the width
dimension, while a shallow clone is shallower than the full history
in the time dimension.  The latter already has the "--deepen"
support to say "the commits listed in my shallow boundary list may
claim that I already have these, but I actually don't have them;
please stop lying to the other side and refetch what I should have
fetched earlier".  I understand that this works in the other
dimension to "--widen" things?

Makes me wonder how well these two features work together (or if
they are mutually exclusive, that is fine as well as a starting
point).

If you update the filter specification to make it narrower (e.g. you
start from blob:limit=1m down to blob:limit=512k), would we transfer
nothing (which would be ideal), or would we end up refetching
everything that are smaller than 512k?

> This patch series proposes adding a --refilter option to fetch & fetch-pack
> to enable doing a full fetch with a different filter, as if the local has no
> commits in common with the remote. It builds upon cbe566a071
> ("negotiator/noop: add noop fetch negotiator", 2020-08-18).

I guess the answer to the last question is ...

> To note:
>
>  1. This will produce duplicated objects between the existing and newly
>     fetched packs, but gc will clean them up.

... it is not smart enough to stell them to exclude what we _ought_
to have by telling them what the _old_ filter spec was.  That's OK
for a starting point, I guess.  Hopefully, at the end of this
operation, we should garbage collect the duplicated objects by
default (with an option to turn it off)?

>  2. This series doesn't check that there's a new filter in any way, whether
>     configured via config or passed via --filter=. Personally I think that's
>     fine.

In other words, a repository that used to be a partial clone can
become a full clone by using the option _and_ not giving any filter.
I think that is an intuitive enough behaviour and a natural
consequence to the extreme of what the feature is.  Compared to
making a full "git clone", fetching from the old local (and narrow)
repository into it and then discarding the old one, it would not
have any performance or storage advantage, but it probably is more
convenient.

>  3. If a user fetches with --refilter applying a more restrictive filter
>     than previously (eg: blob:limit=1m then blob:limit=1k) the eventual
>     state is a no-op, since any referenced object already in the local
>     repository is never removed. Potentially this could be improved in
>     future by more advanced gc, possibly along the lines discussed at [2].

OK.  That matches my reaction to 1. above.
