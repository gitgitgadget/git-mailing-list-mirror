Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4924C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B50E206F6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 05:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mN381FVJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgC3FJH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:09:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56503 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3FJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 01:09:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E9654E83F;
        Mon, 30 Mar 2020 01:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Oqxi+bDI0CIx
        LcxhAzxAzDMQwY8=; b=mN381FVJtWnLSkvI+lc+owAqC+YklfkP0ELKwStYJ7o4
        exKgjmV2Edd9CZ3j/K+HuSOe21iXi3wSKM7I6uPRch1D4lNNQiw7vxWlvrgpxlF0
        5kU3luZe2qBcWnXQWLi4gAG3/+vIB2ofDlmRDjynVSgWxL6HvEGFF8HlLm9TnZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rJhNWD
        etW2d1yDTPd6a/VfCrvyx/gpiZPvTm2wpRNlGAnbZGV0omjERwgIHtHcQV0w6sh+
        tQE+npSKLbwmfx5sv/xY4ElmZOgMAGnxeI8w0KsfcvTtEz1CB07xXbNDD0Z2/QDB
        QGvntwxRiOgxMQS3jKYu8Ync6wGww6f0PN3FQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4647D4E83E;
        Mon, 30 Mar 2020 01:09:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65B354E83D;
        Mon, 30 Mar 2020 01:09:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, congdanhqx@gmail.com, newren@gmail.com
Subject: Re: [PATCH v3] rebase --merge: optionally skip upstreamed commits
References: <20200309205523.121319-1-jonathantanmy@google.com>
        <20200330040621.13701-1-jonathantanmy@google.com>
Date:   Sun, 29 Mar 2020 22:09:02 -0700
In-Reply-To: <20200330040621.13701-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Sun, 29 Mar 2020 21:06:21 -0700")
Message-ID: <xmqqh7y6a0pd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92CEB960-7244-11EA-90A3-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When rebasing against an upstream that has had many commits since the
> original branch was created:
>
>  O -- O -- ... -- O -- O (upstream)
>   \
>    -- O (my-dev-branch)
>
> it must read the contents of every novel upstream commit, in addition t=
o
> the tip of the upstream and the merge base, because "git rebase"
> attempts to exclude commits that are duplicates of upstream ones. This
> can be a significant performance hit, especially in a partial clone,
> wherein a read of an object may end up being a fetch.
>
> Add a flag to "git rebase" to allow suppression of this feature. This
> flag only works when using the "merge" backend.
>
> This flag changes the behavior of sequencer_make_script(), called from
> do_interactive_rebase() <- run_rebase_interactive() <-
> run_specific_rebase() <- cmd_rebase(). With this flag, limit_list()
> (indirectly called from sequencer_make_script() through
> prepare_revision_walk()) will no longer call cherry_pick_list(), and
> thus PATCHSAME is no longer set. Refraining from setting PATCHSAME both
> means that the intermediate commits in upstream are no longer read (as
> shown by the test) and means that no PATCHSAME-caused skipping of
> commits is done by sequencer_make_script(), either directly or through
> make_script_with_merges().
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> This commit contains Junio's sign-off because I based it on
> jt/rebase-allow-duplicate.
>
> This does not include the fix by =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng =
Danh. If we want all
> commits to pass all tests (whether run by Busybox or not) it seems like
> we should squash that patch instead of having it as a separate commit.
> If we do squash, maybe include a "Helped-by" with =C4=90o=C3=A0n Tr=E1=BA=
=A7n C=C3=B4ng Danh's
> name.

Yup, I think =C4=90o=C3=A0n already said it is fine to squash in, so plea=
se do
that.

Thanks.
