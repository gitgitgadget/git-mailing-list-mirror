Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034D2C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 23:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiBXXhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbiBXXhc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 18:37:32 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE19B0D0D
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 15:37:01 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A98F176A07;
        Thu, 24 Feb 2022 18:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YIh6xrTS9wj82S+yGF3hatPybvIBuZPv+MVsFk
        Y9ehA=; b=lxQ//l+8I6tuPEYX99SzAFi+zeS+M5ZsvaD7rKmC3mRynXn2jqqNdL
        s2mxwNVoiewgjuamDV0npYtxHqixpdzU+ZQ2gxvsn+OioZpzH1buQhU9hstl8m2Q
        Gbw+uvveawojcK0NFGra1tcTTntFelzhyD/WH2UOCYL+AcmygZEc0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78706176A06;
        Thu, 24 Feb 2022 18:37:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D394176A01;
        Thu, 24 Feb 2022 18:36:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 04/15] merge-tree: implement real merges
References: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
        <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <02c29f920d0d5fde6d85f7b86a69be92e3f0f34d.1643787281.git.gitgitgadget@gmail.com>
        <xmqqy22tx8t1.fsf@gitster.g>
        <CABPp-BGpD6g5QH3=4X_dCuSX0Bs0utHn5hyuU4_UiwNhU0h8sg@mail.gmail.com>
        <xmqqh79hvsgn.fsf@gitster.g>
        <CABPp-BEaemkGGm0cSofP0gau7YN-y6HFoi0yJbHA8+iGjxsYSA@mail.gmail.com>
        <xmqqee3wt5g3.fsf@gitster.g>
        <CABPp-BE+DaBkis0r7pqs-kaChCvFhCEsyDg=gs3=QjWOPERaXQ@mail.gmail.com>
        <xmqqczjduz2h.fsf@gitster.g>
        <CABPp-BEsYTz35XpXy_j09J9-ke4UoCTED4z3L1sq0vYHuvuKPQ@mail.gmail.com>
        <xmqqee3skp3x.fsf@gitster.g>
Date:   Thu, 24 Feb 2022 15:36:55 -0800
In-Reply-To: <xmqqee3skp3x.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        24 Feb 2022 12:04:50 -0800")
Message-ID: <xmqqh78nj0q0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7646AF4-95CA-11EC-BD63-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> It is more like
> ...

Actually, I misspoke.  It is a bit different.

In my mind, the building block hierarchy would have been

 (1) Take three tree objects A, B, and O, and do the three-way
     merge.  No history relation is assumed among them.

 (2) Take two tree objects A and B, with one or more commit objects
     Os; use (2) recursively to reduce Os into a single O and then
     apply (1) on A, B and O.

 (3) Take two commit objects A and B.  Compute Os out of A and B and
     use (2) once to merge A and B.

I think the basic primitive that should be exposed to an external
world (read: plumbing) this year, after all years of experience with
merge-recursive, should be (2), not (1).  

If you have (2), then (3) is trivially possible (it is just a single
call to get_merge_base()).  "git merge-tree A B" without having to
spell out bases is so convenent and you do not have to write
"git merge-tree A B $(git merge-base --all A B)", so I am OK for it
to exist, but it is not essential.

If you have (2) and exposed (2) as the primitive plumbing,
cherry-pick and revert would be a narrow special case of passing
only one O to the machinery.

And coming from the above point of view, exposing (3) as the
primitive plumbing to scripters and system builders, and later
having to _add_ support to allow (2), felt backwards.  It should be
trivial for us to make (2) available before we can even offer (3),
but what is happening to this new plumbing command goes in the
opposite order.

It may be, as you said, the problem the underlying ort API has that
somehow makes it harder to expose (2), in which case, yes, I think
that is what bugs me.



