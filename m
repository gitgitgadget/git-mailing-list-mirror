Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51EDC433EF
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 16:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87FB6103D
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 16:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRQL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 12:11:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50255 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhJRQLV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 12:11:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EE7B145404;
        Mon, 18 Oct 2021 12:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4xxQFl/su/8UPpI/2HqpbEP+fLcWeqQjeLhPxB
        UUpJI=; b=PZIp+vTwDOrcy/doAwVYTd0lHXqHXYkZ+TBGVp+DSha6GycDFOAOQK
        VoYPz5vlgwBDpcHArwJojN22OPR1ZiML1ds1s7lXuR8HCCkQ/j2gDDf5KTzVWssu
        pGEa9RF4CSKiBzwCqkbCfuSJkrBNcnvDZ28LPRut8xyUc2Df7KGKg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 18444145403;
        Mon, 18 Oct 2021 12:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 72CFA145400;
        Mon, 18 Oct 2021 12:09:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
        <xmqqh7di3qfu.fsf@gitster.g>
        <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
        <xmqq5ytw19ck.fsf@gitster.g>
        <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
        <xmqqczo3yvz3.fsf@gitster.g>
        <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com>
Date:   Mon, 18 Oct 2021 09:09:05 -0700
In-Reply-To: <b51500f2-854a-3006-810a-fb7fb8d8dcfb@gmail.com> (Derrick
        Stolee's message of "Mon, 18 Oct 2021 09:25:18 -0400")
Message-ID: <xmqqilxuxqla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8455548-302D-11EC-9C40-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I think the 'else if' should be removed, which would match my
> expectations.
> ...
> convert_to_sparse() has several checks that prevent the conversion
> from happening, such as having a split index. In particular, it will
> skip the conversion if the_repository->settings.sparse_index is false.
> Thus, calling it unconditionally in the write code is correct.

Heh ;-) It was exactly the fact that convert_to_sparse() has many
checks inside that confused me into thinking that the new "else" may
turn into a no-op and the behaviour of the new code matches your
description.  It is confusing, and it being one way street does not
help readers, either.

Which in turn led me into worrying that our unconditional calls to
convert_to_sparse(), which are not accompanied by corresponding
calls to ensure_full_index() on the write code paths, were
problematic.  With the patch under discussion, in a repository that
does not want to see a sparse index, if we did not have "otherwise,
do sparsify the in-core index", lack of ensure_full_index() may not
be a problem, because we are guaranteeing that the in-core index is
fully expanded by the time the control reaches the write code path.

But if we by default shrunk the in-core index upon reading
(i.e. with the "else" clause), its correctness becomes muddy.
Convert_to_sparse() may not turn a non-sparse in-core index into
sparse with these checks, but it would not expand a sparse in-core
index before writing out.

Which in turn led me to suggest, instead of unconditional calls to
convert_to_sparse(), make unconditional calls to a helper function
that fixes the sparseness.  I knew convert_to_sparse() refrains from
touching the in-core index when the repository does not want a
sparse index, but I also am reasonably sure that it lacks support to
expanding the sparse index into full, so it cannot be the "fix to
the correct sparseness" function.

If our promise to a repository that does not want a sparse index is
that the read code path ensures that the in-core index is fully
expanded, and that nobody (including convert_to_sparse()) places a
sparse entry in the in-core index, then the promise would not be
broken, but I still wonder if the whole code is human-reader
friendly.  It wasn't to me ;-)

> Perhaps a rename to something like "convert_to_sparse_if_able()" would
> make sense? But it might be best to leave that one lie.

"-if-able" does not make much sense to me, but "-as-needed" may.  By
not calling it "fix-sparseness", but saying "convert-to-sparse", we
are making it clear that it is a one-way street that may make it
sparse but never removes sparseness.

I do not know if that is the guarantee we want to keep giving the
callers (not saying that I have a hunch that it would be better to
allow us to optionally expand to full in that function---I genuinely
do not know), or we may want to call it a neutral "fix sparseness"
to keep the door open for a future where we may expand an already
sparse in-core index into full based on the setting.

Thanks.
