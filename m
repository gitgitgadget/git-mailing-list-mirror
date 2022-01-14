Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C45C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiANTPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:15:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60841 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbiANTPA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:15:00 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D45C2166E2D;
        Fri, 14 Jan 2022 14:14:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bhLIQJEfV4It
        JRqdk8NBV210FtmVc/LFit4P8jjMSwI=; b=l//a9j3r1zMbDNVUYFssjnUCuVPw
        kDOlc5LSHg3IYcxScP4HLswLxihQP7UPBuOKj9um84tgord7c2WDHIhlN4eY33CX
        +fjJFTFKtP9q4IUvudqU8NIyQ+eQfJtY0DBvJs0gaVPebIbn/VC0pjDMY3m5ygIS
        KbW84v0zSikNemk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC838166E2C;
        Fri, 14 Jan 2022 14:14:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37B26166E2A;
        Fri, 14 Jan 2022 14:14:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
References: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
        <220114.86wnj2se41.gmgdl@evledraar.gmail.com>
Date:   Fri, 14 Jan 2022 11:14:56 -0800
In-Reply-To: <220114.86wnj2se41.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 14 Jan 2022 13:11:57 +0100")
Message-ID: <xmqqzgnyb03z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 42FD9508-756E-11EC-8550-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> From what I understand of GGG I think you updated only the summary on
> the PR but not the commit itself, the latter is what would go into
> git.git. Here the commit should be updated so we get this message.

Ah, I have long learned to ignore the blurb after the three-dash
line when a patch comes via GGG (because the PR text is often
useless and most often people seem to use text identical to the
commit log message).  I didn't realize that the proposed commit log
message was useless in this particular patch.  I was wondering why
you were talking about an extra blank line after the title there ;-)

> The part after the "---" is usually just used in this project for ad-ho=
c
> list-only comment.

True.  "What I'm not sure about is ..." however does belong to the
list-only comment, though.  If it is not=20

> The difference between these two APIs is thaht oidset is hash-backed,
> and you'd insert into it and we de-duplicate any duplicate OIDs on-the-=
fly.
>=20
> The oid_array is just an realloc()'d "struct object_id *oid". On
> insertion you can insert duplicates, but it has the ability to track
> "I've sorted these", and "let's iterate over this sorted, and de-dup an=
y
> duplicates".
>
> We have the two APIs for a reason, but I don't know in any of these
> cases whether this change is safe.
>
> Does e.g. index-pack.c always receive de-duplicated OIDs and we were
> wasting CPU cycles using an oidset?
>
> Do some of these like pack-objects.c receive de-duplicated OIDs from
> e.g. "git repack" *now*, but we just lack test coverage to see that
> they're happy to get duplicate OIDs on stdin (e.g. manually from a
> user), and this would introduce a bug?

Also, if oid_array is used to produce a de-duplicated list of object
names in the current code, it is very likely that oid_array is
sorted (perhaps the objects are fed in sorted order), and the
callers depend on the order of the objects they find in the array.
Throwing sorted list of object names at oidset and then iterating
over what is in the oidset would likely to destroy the original
ordering.  I do not offhand know if the callers are broken by such a
change (either correctness-wise or performance-wise).

> But most importantly is it worth it? What's the rationale for the
> change? Less CPU/memory use? Getting e.g. "hyperfine" or "/usr/bin/time
> -v" output for those (if so) would be valuable.

Thanks.
