Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B61C433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346521AbiEZRLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 13:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEZRLA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 13:11:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163794F9F4
        for <git@vger.kernel.org>; Thu, 26 May 2022 10:10:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8889C1921EF;
        Thu, 26 May 2022 13:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AJwE9UDeDnbz
        SJq3FokYLtkcY3Z7/9QfoHdWRwplS7g=; b=GwlRSFj/s3/EHNIibyQYlkUVC1ix
        Y8Gz/HJJo2pVicsRX4K3+3gyKmBo6sZXnYe5k8S0iP8ToESgCJT/Q1rJi8s110+t
        ZRkxx/vZ/OBk9Hco0r6CuSYFxmJLfQ/EqJsaV1ezxYEGqczu8jEmTjQ47rQ++G4g
        WnkwhRiBv1R33Nk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 803201921EE;
        Thu, 26 May 2022 13:10:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 999CB1921EA;
        Thu, 26 May 2022 13:10:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>, rsbecker@nexbridge.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 1/7] archive: optionally add "virtual" files
References: <pull.1128.v5.git.1652984283.gitgitgadget@gmail.com>
        <pull.1128.v6.git.1653145696.gitgitgadget@gmail.com>
        <0005cfae31d52a157d4df5ba3db9f9f5b2167ddc.1653145696.git.gitgitgadget@gmail.com>
        <xmqqfskx5ndd.fsf@gitster.g>
        <7815a07a-da2f-d348-4179-6dc5b1d5fee6@web.de>
Date:   Thu, 26 May 2022 10:10:52 -0700
In-Reply-To: <7815a07a-da2f-d348-4179-6dc5b1d5fee6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 May 2022 11:09:15 +0200")
Message-ID: <xmqqee0g1aoz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CCCA6B0C-DD16-11EC-B697-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If the prefix is applied then a prefix-less extra file can by had by
> using --prefix=3D or --no-prefix for it and --prefix=3D... for the tree=
,
> e.g.:
>
>    $ git archive --add-file=3Dextra --prefix=3Ddir/ v2.36.0
>
> puts "extra" at the root and the rest under "dir".  The order of
> arguments matters here, and the default prefix is the empty string.

This was the part of the design for the original "--add-file" that I
was moderately unhappy with.  If "--add-file" were the only feature
that used "--prefix", I wouldn't have been unhappy, but this rule:

        The value of "--prefix" most recently seen at the point of
        "--add-file" is prepended.  (By the way, it is not clearly
        documented what happens when you give multiple prefix and
        when you give prefix before or after add-file)

makes the original use of "--prefix":

	The value given to "--prefix" is prepended to each filename
	in the archive.  (IOW "git archive --prefix=3Dgit-2.36.0/
	v2.36.0" is a way to prefix each and every path in the
	tree-ish with the given prefix)

confusing.  Does

	git archive --prefix=3Dbonus-files/ --add-file=3Dextra v2.36.0

place the main part of the archive also in bonus-files/ or at the
top level?  One reasonable interpretation is "yes", if we imagine
that each invocation of --add-file will consume and reset the prefix.
Another reasonable interpretation is "no", if we imagine that the
prefix last specified will stay around and equally affect both extra
ones and main part of the archive.

Unfortunately what the implmentation does is the latter, and those
who want to put the main part of the archive at the top-level must
add "--prefix=3D''" at the end (before the tree-ish).

Because of this potential for confusion ...

> So extra files can be put anywhere even if --prefix is honored.
>
> Keeping the whole path from --add-virtual-file makes sense to me; I
> slightly prefer applying --prefix on top of that for consistency.

... I was hoping that we can releave users from having to worry
about the interaction between "prefix" and contents coming from
outside the tree-ish by ignoring the "prefix".

But either is fine by me.

Thanks.


