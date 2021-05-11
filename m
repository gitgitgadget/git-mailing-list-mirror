Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A791C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 09:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60636162A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 09:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhEKJbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 05:31:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63222 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhEKJbh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 05:31:37 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B086C1682;
        Tue, 11 May 2021 05:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h+T0fS+lHx1jV7zE/kRmwQITh1GNV8ngs1FFRn
        qSTfY=; b=cBEPAndbRoEjJbYsqNJHcEnCi9Df4ZvYbd7Sn0B2opFZ7iKSi8eR8T
        bTgkTmoM8r+koM1/w5auAIbFHAEMB+rLpA1t8JcD4Fg+gofYWNPTIc46ixtg5D0+
        DQwCmLG8YLoTWB0Nluk74sreg9QseM+gywAcdjd1vPLCj/6qtrcGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F69DC1680;
        Tue, 11 May 2021 05:30:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B29C1C167F;
        Tue, 11 May 2021 05:30:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] [GSOC] ref-filter: fix read invalid union member bug
References: <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com>
        <pull.949.v4.git.1620658904283.gitgitgadget@gmail.com>
        <xmqqcztyovf7.fsf@gitster.g>
        <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com>
Date:   Tue, 11 May 2021 18:30:29 +0900
In-Reply-To: <CAOLTT8QR4Ga41ADKhgB4=C7VgGbJEe5G5HSbcjRb51H2yQVRPA@mail.gmail.com>
        (ZheNing Hu's message of "Tue, 11 May 2021 14:28:32 +0800")
Message-ID: <xmqqlf8lmxca.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86B11410-B23B-11EB-9546-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> We are just in the process of using `populate_value()`, if the atom we
> specify meets the following conditions, then the condition of
> atom->u.remote_ref.push!=0 will be established.
>
> 1. The atom that triggers the bug , its "if" condition order must after
> "if (atom->u.remote_ref.push)", such as %(refname) or %(worktreepath),
> they can be executed correctly because their order is before "push".
>
> 2. The member size in used_atom.u corresponding to the atom must
> larger than 17 bytes, because the offset of "u.remote_ref.push" in
> "u.remote_ref" is 17, the satisfied atoms are only "%(color)" and
>  "%(contents)", their corresponding members are u.color and u.contents.
>
> 3. We happen to be able to fill in the 17th position of these structures,
>  which makes atom->u.remote_ref.push not equal to 0 established.
>
> So this kind of bug is not related to %(push), an atom that satisfies
> the above conditions will make `if (atom->u.remote_ref.push)` be true.
> then execute the program logic related to `%(push)`.
>
> Now, we only have `%(color)` can trigger it "sometime",
> It is unpredictable to fill in the 17th byte of used_atom.u.color,
> so we cannot track all the atoms related to this bug.
>
> git for-each-ref --format="%(color:#aa22ac)%(refname)"
> git for-each-ref --format="%(color:#aa22ad)%(refname)"
>
> will trigger the bug.
>
> git for-each-ref --format="%(color:#aa22ae)%(refname)"
> git for-each-ref --format="%(color:#aa22af)%(refname)"
>
> will not trigger the bug.
>
> In other words, we cannot use a perfect test set to cover all broken.
> So now `%(color:#aa22ac)` is enough for explain the problem of this bug.

Well, the thing is,

    $ git checkout 49f38e2d ;# (The fifteenth batch, 2021-05-10)
    $ git am -s mbox
    $ git show --stat --oneline
    39509d100a (HEAD) ref-filter: fix read invalid union member bug
     ref-filter.c                   |  2 +-
     t/t6302-for-each-ref-filter.sh | 18 ++++++++++++++++++
     2 files changed, 19 insertions(+), 1 deletion(-)
    $ git show ref-filter.c | git apply -R ;# revert only the fix
    $ make -j32 && make -C t T=t6302-*.sh

does not seem to break anything.  Perhaps there is something more
than the "17th byte" thing (like structure padding that may vary
depending on the compiler and architecture)?
