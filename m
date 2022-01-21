Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997AC433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 21:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiAUV6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 16:58:14 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58559 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiAUV6O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 16:58:14 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93D0315B5E3;
        Fri, 21 Jan 2022 16:58:13 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=T1izo1S3m/UyS
        8IC7/+hyOhbiyIFywjjDced/mMxsMc=; b=hawydpEUJFIC3+6XSvyDLl/sPxHT/
        7CC5jTxSybeJa3mR/HfhN/3ra+9C4ybEF7/nLWE5Cb/2gJz/qJzlRwIkGBcFxLVp
        L99HXnrAC8oEWn7vPeczbw2kiFuaoswUhUfRy7H/f20gYp4bb12SKmL/OpLkVokY
        AMFn6HpB79eoYQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CF8415B5E1;
        Fri, 21 Jan 2022 16:58:13 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B9BD15B5E0;
        Fri, 21 Jan 2022 16:58:09 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 21 Jan 2022 16:58:06 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Petr =?utf-8?B?xaBwbMOtY2hhbA==?= <psplicha@redhat.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] checkout: fix BUG() case in 9081a421a6
Message-ID: <YessbkNZlxLOTzBE@pobox.com>
References: <YemTGQZ97vAPUPY0@pobox.com>
 <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
 <xmqqee52ghwg.fsf@gitster.g>
 <220121.86iludl4d9.gmgdl@evledraar.gmail.com>
 <CABXw6YMztos7UYJn0LxKiWvZ_oy55mu+k__jABdXwAW0H3J0cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABXw6YMztos7UYJn0LxKiWvZ_oy55mu+k__jABdXwAW0H3J0cA@mail.gmail.com>
X-Pobox-Relay-ID: 3903EEF2-7B05-11EC-9CAD-CBA7845BAAA9-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petr =C5=A0pl=C3=ADchal wrote:
> Thanks for explaining in detail what's wrong about the approach.

Yes, thank you =C3=86var and Junio for providing context and the
thoughtful planning on how to fix this in both the short and
long term.

> We didn't know about the "HEAD must point at a local branch" rule
> and copying the ref seemed to be the easiest way to create a local
> branch pointing always to the latest content of the remote default
> branch. I described the use case here:
>=20
>     https://bugzilla.redhat.com/show_bug.cgi?id=3D2042920#c2
>=20
> Basically we just need to checkout and reset --hard to the default
> remote branch after entering a git repository while HEAD can be
> pointing anywhere. Could you suggest some more straightforward way
> to achieve this from a script? Thanks.

I'm nearly positive that I don't know the best way, but
here's _a_ way to do it.  It assumes the default remote name
is origin, which seems less than ideal.

(Hopefully this isn't egregiously wrong.  But if it is, I'm
happy to serve as an example of how _not_ to do it for
others.)

    git clone https://github.com/psss/fmf /tmp/fmf
    cd /tmp/fmf
    git switch -c custom-branch
    : work work work
    defbranch=3D$(git symbolic-ref --short refs/remotes/origin/HEAD)
    git switch -f ${defbranch#*/}
    git reset --hard @{u}

Odds are there's a better way to do this or to arrange
things in a way that lets you solve an easier problem.

--=20
Todd
