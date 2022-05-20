Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04AC433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347787AbiETRXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiETRXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:23:30 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428151862B9
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:23:30 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BA03121812;
        Fri, 20 May 2022 13:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RDqekz4FCxC6
        rAJhAOLJnxQrWRZgnJoo2mqN1pg6Elg=; b=JEiUEDwLUf5LiouocI4s19tCd1um
        JL6ShF4QpYKy1T918rfjfEYYoq26C8ZTTW6dlBfT8ljEIslYeujdFyAfhuelLXwC
        f6c15MbkrL4oJ+iYDeXjV8KItdoQ0RE9cBSjscXk+KFfOLrjD6FsVi9UTGojlQuV
        M1KfunHCOxKVUXM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9145E121810;
        Fri, 20 May 2022 13:23:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.111.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED45012180F;
        Fri, 20 May 2022 13:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Daniel Li <dan@danielyli.com>, git@vger.kernel.org
Subject: Re: the state of diff_free() and release_revisions()
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
        <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
        <c36896a1-6247-123b-4fa3-b7eb24af1897@web.de>
        <20220430163232.ytvwru4fnylow2jk@carlos-mbp.lan>
        <6af1aed1-ab13-ee0e-e979-d2f826ec776a@web.de>
        <220520.86pmk81a9z.gmgdl@evledraar.gmail.com>
Date:   Fri, 20 May 2022 10:23:25 -0700
In-Reply-To: <220520.86pmk81a9z.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 20 May 2022 17:23:01 +0200")
Message-ID: <xmqqczg8jeya.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F56E066-D861-11EC-9174-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> AFAICT the current status in this area is that with 2cc712324d5 (Merge
> branch 'rs/fast-export-pathspec-fix', 2022-05-04) and 5048b20d1c2 (Merg=
e
> branch 'rs/format-patch-pathspec-fix', 2022-05-04) merged the known bug=
s
> related to this have been fixed, along with 3da993f2e63 (Merge branch
> 'jc/diff-tree-stdin-fix', 2022-04-28).

There is another possible known breakage around "diff -I --cc"
reported, no?

https://lore.kernel.org/git/a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de/

> Not coincidentally around the same time my ab/plug-leak-in-revisions go=
t
> un-marked for "next" from [1] to [2], and I'm looking for a path forwar=
d
> for this whole thing...

I think this was not because it had known bugs but only because we
wanted to avoid distractions and too much churns in the tree.

I think it is a good time to reactivate it; Phillip Wood took a
serious look at the latest round, if I am reading [*] correctly.

* https://lore.kernel.org/git/2cc2d026-1496-1ed9-838b-6fdf8cfba285@gmail.=
com/

Thanks.

