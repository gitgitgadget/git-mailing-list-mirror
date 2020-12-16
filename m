Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F5C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBB32342C
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgLPSuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:50:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56345 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbgLPSut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:50:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77D88A570D;
        Wed, 16 Dec 2020 13:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RGTR7nva6YD/ukmzQiC8LByGbBI=; b=RV4AN3
        XOml/mUWnI8Dy9O3iQDgGLbAJer2znzWLDtBksVYVPXwc8lQJkX2fXuod2Apz9qc
        HurDRj8EihUQ1U7XntIywoen10YKOTlIpiiWXH+E05YtQfbfCsIADy70ifEvfBZg
        I8UxE5qYgR0hIRnqDbt2zl5avzxDxV4gdBZh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=umUFWViPQbcBJUWOkKXQg2obvVeAmjSP
        HXwTdSOmKZCvVtqPU1l6kkiaQL+BhDAYVCXF3VuZWDJ0+vm0feuWCpU7Dh+I3spQ
        qaR+z8urmAjCRR+Zi64HtwsAO1Ab1+GLg3c168xSadg/cCIvspqywHglMUBQrbFo
        PLgMBxLMXDw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6901EA570B;
        Wed, 16 Dec 2020 13:50:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C65BFA570A;
        Wed, 16 Dec 2020 13:50:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout: send commit provenance during prefetch
References: <20201215200207.1083655-1-jonathantanmy@google.com>
Date:   Wed, 16 Dec 2020 10:50:06 -0800
In-Reply-To: <20201215200207.1083655-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 15 Dec 2020 12:02:07 -0800")
Message-ID: <xmqqa6ud4mch.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83E4802A-3FCF-11EB-B8A5-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Therefore, teach the partial clone fetching mechanism to support a
> "provenance" argument, and plumb the commit provenance from checkout to
> the partial clone fetching mechanism.
>
> In the future, other commands can be similarly upgraded. Other possible
> future improvements include better diagnostic messages when a prefetch
> fails.

I am not sure "provenance" is a good word to describe the concept,
but it feels a bit too limiting that you can give only a single
commit, especially when ...

>  builtin/checkout.c       |  4 ++++
>  builtin/index-pack.c     |  2 +-
>  builtin/pack-objects.c   |  2 +-
>  diff.c                   |  2 +-
>  diffcore-rename.c        |  2 +-
>  promisor-remote.c        | 12 +++++++++---
>  promisor-remote.h        |  3 ++-
>  sha1-file.c              |  2 +-
>  t/t5616-partial-clone.sh |  7 +++++--
>  unpack-trees.c           |  3 ++-
>  unpack-trees.h           |  7 +++++++
>  11 files changed, 34 insertions(+), 12 deletions(-)

... I see that "diff" already needs lazy blob fetching and we know
diff often is between two commits (think: "git log -p").

> This essentially splits reachability-of-blob, which almost certainly
> requires loading a bitmap, into 2 parts: reachability-of-commit (which,
> from my limited experience, can be more quickly done using a regular
> object walk) and reachability-of-blob-from-commit (which, at worst,
> requires fewer bitmaps to be loaded). I don't have timings for how it
> works in practice, though.

What does the bitmap you have on the serving side typically tell
you?  For some selected commits (not all commits) you'd have a
bitmap that says "from this commit, these objects can be reached",
or is it "from this commit, these commits can be reached"?

Thanks.
