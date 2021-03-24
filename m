Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86307C433E0
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4782761A1E
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 22:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhCXWEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 18:04:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62384 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhCXWEU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 18:04:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DBC07C46F4;
        Wed, 24 Mar 2021 18:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fOrfJANXuETkFpWv0JP/Ds2Ehb8=; b=RJL9Vz
        6KUkv6SNqTcb00DA6gT2CmTQ2f+KSzQ5xN4S7yzr5woKFvo0thnx7LBW7xEYenVL
        aQCdpdeFXHRGBCZU3mt9NE7K16N6NcsTR39iWqMvmmoOIwFFw3bGbb21MwBJ3VsR
        PUzgmWuy9bulbLE4s1FNUqOixzFr7l2qjkFq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OBNOUprCFBSmRnbjSqz6N/qGv00YnWNV
        HgrDlyg6Qxs3MmDf5zN9McAbaniAT8xlszxmZopr2qyzFHLidmVh9BwipeE+cUrB
        KQOzcyQeFbI6hihzluEbUt5n5T3FjXeU5KvZccGKD0wIUm9e+1YQrrnoMLwir+ha
        dgdZnlIRZnM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3260C46F3;
        Wed, 24 Mar 2021 18:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5F492C46F2;
        Wed, 24 Mar 2021 18:04:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 0/7] Optimization batch 11: avoid repeatedly detecting
 same renames
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
Date:   Wed, 24 Mar 2021 15:04:16 -0700
In-Reply-To: <pull.859.git.1616621553.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Wed, 24 Mar 2021 21:32:26 +0000")
Message-ID: <xmqqv99gw6n3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0A5B7A6-8CEC-11EB-8C7E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> === Basic Optimization idea ===
>
> This series avoids repeatedly detecting the same renames in a sequence of
> merges such as a rebase or cherry-pick of several commits. When there are
> many renames between the old base and the new base, traditionally all those
> renames are re-detected for every commit that is transplanted. This
> optimization avoids redoing that work.

Unless this section is easily understandable, the readers have no
incentive to read on, but the above is a bit too hand wavy.

> This one adds a fourth (remember-renames), with some interesting properties:
>
>  * unlike basename-guided rename detection, there are no behavioral changes
>    (there is no heuristic involved)[2].
>
>  * like skip-because-irrelevant, this optimization does not apply to all git
>    commands using the rename machinery. In fact, this one is even more
>    restrictive since it is ONLY useful for rebases and cherry-picks (not
>    even merges), and only for second and later commits in a linear series.

So, is it correct to understand that one case this would help is
this scenario?

 ---o---o---o---X---o---o---o---O ours
     \
      A---B---C topic

where there is a side branch A--B--C that touched some files, while
on our side, there is a commit X that is unknown to the side branch
that renamed these files.  Now we want to transplant the side topic
to the tip of our history, replaying the changes A--B--C made to
these files under their original name to the corresponding files
that have been renamed.

And each step in this "rebase" is a 3-way merge of commits A, B and
C onto HEAD, using the parent of the commit being cherrk-picked as a
virtual common ancestor.  Which means

 - To transplant A (i.e. the first step), we'd compare the diff of
   A^..O (i.e. what our side did, including the renames done at X)
   and diff of A^..A (i.e. what the first commit did in the range),
   and the former does quite a lot of rename detection.

 - After transplanting B (i.e. the second step), then we'd compare
   the diff of A^..A' (where A' is A cherry-picked on O, i.e. the
   result of the previous step).  If we are lucky, O..A' did not
   rename anything so the renames done in A^..O (i.e. what we
   detected during the first step) and A^..A' (i.e. what we should
   be computing for this second step) should be quite similar.

   If we assume that the "quite similar" is good enough, then we can
   blindly reuse the record of "<path in A^> correspnds to <path in
   O>" as if it were "<path in A^> corresponds to <path in A'>".

 - Do the same for C, pretending that renames discovered between A^
   and O is identical to the renames between A^ and B' (i.e. the
   result of cherry-picking A--B on top of O).

