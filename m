Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDD9C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 16:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350070AbiCPQPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350101AbiCPQPs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 12:15:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F4AB7CF
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 09:14:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0071E11DCCF;
        Wed, 16 Mar 2022 12:14:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ANOontaN2zIMnw59aakyVBCENoRkGY6Z/Ag0OkCyfPw=; b=N+1O
        +v+Qnll/+hcCIqzWT8VOD5NmqNIbE4uj95yvnu8aeyS7r4tlBoYnomi/74etV1oo
        M1FYo3qnRIrjgnDPCnh5weibDV7qviZoMzza4+lg0W2arHcsbsQQHZhlx2SKAwb0
        jfAaFwoEdwClHFJBzBLuVnOMIhyqVvZv7iLwv2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EBFFD11DCCE;
        Wed, 16 Mar 2022 12:14:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6340811DCCD;
        Wed, 16 Mar 2022 12:14:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
        <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
        <xmqqbky6bgw0.fsf@gitster.g>
        <CANQDOdcak1nV1Pr9cmyk9dgEjHOH8Au92pUMskJipUodzskzqQ@mail.gmail.com>
Date:   Wed, 16 Mar 2022 09:14:27 -0700
Message-ID: <xmqq35jhoows.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 27B5F9F6-A544-11EC-8B2D-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> I think my new usage is congruent with the existing API, which seems
> to be about combining multiple add operations into a large transaction,
> where we can do some cleanup operations once we're finished. In the
> preexisting code, the transaction is about adding a bunch of large objects
> to a single pack file (while leaving small objects loose), and then completing
> the packfile when the adds are finished.

OK, so it was part me, and part a suboptimal presentation, I guess
;-)

Let me rephrase the idea to see if I got it right this time.

The bulk-checkin API has two interesting entry points, "plug" that
signals that we are about to repeat possibly many operations to add
new objects to the object store, and "unplug" that signals that we
are done such adding.  They are meant to serve as a hint for the
object layer to optimize its operation.

So far the only way the hint was used was that the logic that sends
an overly large object into a packfile (instead of storing it loose,
which leaves it subject to expensive repacking later) can shove more
than one such objects in the same packfile.

This series invents another use of the "plug"-"unplug" hint.  By
knowing that many loose object files are created and when the series
of object creation ended, we can avoid having to fsync each and
every one of them on certain filesystems and achieve the same
robustness.  The new "batch" option to core.fsyncmethod triggers
this mechanism.

Did I get it right, more-or-less?

Thanks.
