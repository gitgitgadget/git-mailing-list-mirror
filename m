Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBCCC433F5
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89CF60F94
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhJIRwT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 13:52:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62056 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhJIRwT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 13:52:19 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90FC2EA492;
        Sat,  9 Oct 2021 13:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DV/ajZW7UuwF
        hm1QxQYfCRBCfevosamYMaZxV3aZR68=; b=ZbDgWBArdiaTzdurTQoSpHlOp8KQ
        Mdp5MFc95CGxUGNaJRB8Rjr0zUwzenxkgxhDmxQ7cSDOlnjD6y2jhFfcaWVVC47b
        QL8shDL2/lwZx9yFZhJuSelWFsM2KpivfkZQbqBuH6Dkg0xwpCb2KfzjDB8ALHfB
        Zq2LhJKvxJ/frlI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8955EEA490;
        Sat,  9 Oct 2021 13:50:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EC0ABEA48F;
        Sat,  9 Oct 2021 13:50:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: "git reflog expire" blindly trusting timestamps in reflogs
References: <b25ac1cc-8e77-17e6-602a-b289c1e1cfeb@web.de>
        <30df5e39-3f2a-00d8-541b-347c43f36b38@gmail.com>
        <581663a7-9b16-e464-ada7-368f20c99ff1@web.de>
        <xmqqsfxersvy.fsf@gitster.g>
        <ba3e16f7-bf9c-c5f3-4c0d-8288db6f44c7@web.de>
        <87wnmmkzaa.fsf@evledraar.gmail.com>
Date:   Sat, 09 Oct 2021 10:50:19 -0700
In-Reply-To: <87wnmmkzaa.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 09 Oct 2021 16:57:20 +0200")
Message-ID: <xmqqa6jif5pg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5F3CABB4-2929-11EC-92BF-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I.e. shouldn't reflog expiry at least have the invariant that nothing
> should expire in a given file if the tip commit is old enough to be
> expired, *AND* the mtime of the file is more recent than the expiry
> epoch, because such a scenario points to either git's own test suite
> (and we should just fake up the time there), or that we're about to
> corrupt some user's repository because they're either doing similar
> import work, or their clock was screwy?

A reflog whose entries (and possibly the containing file) have
inconsistent timestamps might need some care when pruning.  If the
time @{1} has is older than @{2}, there may be something fishy going
on.  Expiring @{1}, keep @{2}, and expire @{3} in such a case where
@{2} is exceptionally new but all others are older than expiry limit
is one possibility, but "entries out of order detected---do you want
to keep the one that is sandwiched between much older ones [y/N]?"
might be worth asking.  In any case, a reflog with such unordered
entries may not answer time-based @{1.week.ago} question correctly.

I do not think, at least by default, we should care about file's
mtime to the same degree, because it can easily be modified by
accident and because the timestamps on entries and mtime can come
from different time sources, and the local clock may be faster than
the fileserver's clock, resulting in the tip entry having a more
recent timestamp than the file's mtime.
