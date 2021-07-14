Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EC4C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 05:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E711061369
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 05:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhGNFUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 01:20:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52340 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhGNFUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 01:20:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68095CA509;
        Wed, 14 Jul 2021 01:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sO+xfYqkhIABL7aM6NhHcTBL+RsbgbFv9LhClGVc5HY=; b=tBnj
        RacAkOtHWb1HDYZOkIjSDMi0jciu9bXdHGQThvu965p1XgQfeT2JjoYUdoNGTou0
        6kpELxwjAXE2mAdVFpFUehHnxOI5eTgAbQSRHghBNWuw3mAswNtPs5bTVV6p6YSp
        KcyjoiI3VfO5oeI5bGS6htnFwlY1Ltum2n0t98c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F4CCCA508;
        Wed, 14 Jul 2021 01:17:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D158ECA507;
        Wed, 14 Jul 2021 01:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] diff: correct warning message when renameLimit
 exceeded
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
        <44a5d5efaa637d01ec3266b34f31d46acce5ef24.1625964399.git.gitgitgadget@gmail.com>
        <9707b299-3846-6388-36ba-e8d93a28e2ac@gmail.com>
        <CABPp-BHF3Os7fOeaF_EQOo+Bs7f1DXbYr26WmAQrPjv63nq1Pg@mail.gmail.com>
        <xmqqzgupzppb.fsf@gitster.g>
        <CABPp-BHdAZYPf0QPOTiekU914u6pNxUSRQEmdN0xOLGv5hdkzA@mail.gmail.com>
        <xmqqim1dzomt.fsf@gitster.g>
        <CABPp-BFrLd+h0rzkY5nijVLzXh7bUK5t7Go=EY9jZksCeKqQLg@mail.gmail.com>
Date:   Tue, 13 Jul 2021 22:17:16 -0700
Message-ID: <xmqq7dhtzd7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1784182-E462-11EB-A374-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Am I mixing up negatives/positives (as I'm prone to do), or would it
> be more correct to say the new algorithm risks suboptimal positives
> rather than that it risks false negatives?

I'm prone to mixing them up, too, but I think they are the sides of
the same coin.  Imagine there is a path X on the source side, and
two paths Y and Z on the destination side.  With exhaustive match,
Z might be a better match (content-wise) to X than Y is to X.

For the path X on the source that is matched with a suboptimal
counterpart Y on the destination side, we may call the situation a
false-positive because with a more exhaustive search we might have
been able to find Z that is a better match.  For the path Z on the
destination side that was culled too early with heuristics and
failed to be matched with the source path X that got matched with a
suboptimal destination path Y, it is a loss for Z---it wasn't chosen
when it should have been (i.e. a false negative, as Z saw no
counterparts).

In any case, during the word search for "inexact", "more precise",
"more expensive", I do not think negatives and positives will play a
big role anyway, so...
