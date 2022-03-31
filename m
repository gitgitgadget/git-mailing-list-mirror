Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FEDC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 17:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiCaRwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbiCaRwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 13:52:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A51BD98C
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 10:50:29 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C0A6187309;
        Thu, 31 Mar 2022 13:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2g3M5eQ9bqzTtfssfiaYAO8GCeuHFPFhpJFnqO
        tbZRE=; b=jcQe6cQ8c/BWUZhxq7AhFWSB9/AmGLpLSk1RVPIaeWHsIh4k2pDggw
        uraiQ/5EFBWFHCm2rTLG/M6HnT8u+ZeuR5mNMvEtuqy/pYvdkAqdsU+/DwLrJDwB
        25DIAuxXf/mN9vKYfR9RXWuVcKpeii2vDNsN1j/XmeKoB3ZugMwsc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62C21187308;
        Thu, 31 Mar 2022 13:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C5CC0187303;
        Thu, 31 Mar 2022 13:50:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 01/14] bulk-checkin: rename 'state' variable and
 separate 'plugged' boolean
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <c7a2a7efe6d532fc7fce1352b1dfce640cc9f2f6.1648616734.git.gitgitgadget@gmail.com>
        <xmqqpmm39xhx.fsf@gitster.g>
        <CANQDOdfWTufEn0NRSAOG991JcS4x8GsCC62UCLUTEc3gD6tfGA@mail.gmail.com>
        <xmqqr16j6ve3.fsf@gitster.g>
        <CANQDOdcDY-8TZzCHx+tWZJoD0rsULnfaWRhAOox3drSgxW_+ow@mail.gmail.com>
Date:   Thu, 31 Mar 2022 10:50:24 -0700
In-Reply-To: <CANQDOdcDY-8TZzCHx+tWZJoD0rsULnfaWRhAOox3drSgxW_+ow@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 30 Mar 2022 21:17:14 -0700")
Message-ID: <xmqqy20q2eqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B964590-B11B-11EC-B069-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> Just to understand your feedback better, is it a problem to separate
> the state of each separate "thing" under ODB transactions into
> separate file-scope global(s)?  In this series I declared the fsync
> state as completely separate from the packfile state.  That's why I
> was thinking of it as more of a naming problem, since the remaining
> state aside from the plugged boolean is entirely packfile related.

Ahh, sorry, my mistake.

I somehow thought that you would be making the existing "struct
bulk_checkin_state" infrastructure to cover not just the object
store but much more, perhaps because I partly mistook the motivation
to rename the structure (thinking again about it, since "checkin" is
the act of adding new objects to the object database from outside
sources (either from the working tree using "git add" command, or
from other sources using unpack-objects), the original name was
already fine to signal that it was about the object database, and
the need to rename it sounded like we were going to do much more
than the object database behind my head).

> My argument in favor of having separate file-scoped variables for each
> 'pluggable thing' would be that future implementations can evolve
> separately without authors first having to disentangle a single
> struct.

That is fine.  Would the trigger to "plug" and "unplug" also be
independent?  As you said elsewhere, the part to harden refs can
piggyback on the existing ref-transaction infrastructure.  I do not
know offhand what things other than loose objects that want "plug"
and "unplug" semantics, but if there are, are we going to have type
specific begin- and end-transaction?

Thanks.
