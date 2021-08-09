Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F403C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E4716056B
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhHIVTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:19:25 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:41467 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhHIVTY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:19:24 -0400
Date:   Mon, 09 Aug 2021 21:18:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628543910;
        bh=G3hUttAaBDTaHSlfjlzvkF4n7+U5sV9KZBBpXnFjDD4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TTv9Z6yrjfyFf/sNXcjsiBSu3f18U/t55pVsLRqGZx9b7FyM7qvrydn5c7fO+Y2lt
         gya7Uv0+BINvkOiG/8OQ9g9r267kt8++ySh+N9HLHxShiSggQFyF4WpfdmQ43k0efq
         h5SFzhJH4ty0WyMQhD/u11S/BazrvTiOEVlxhRtCEP1bJJhzSre00rYxyvHT/T1fYr
         O1rbkkoeGdBh6Q5juCuKj1i4hWQKhX9U2tFXdUo/THIpkqJObeqZH8vuuPZdcUAAEi
         yhu3uuecvpynL+i2qgNsjwAYvvLgK3eOy93IA4EpZKAkRnQB//lSbpegrlSxRqz1iy
         DoRg+y6cZgzNw==
To:     Junio C Hamano <gitster@pobox.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        bwilliams.eng@gmail.com, jrnieder@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <CDFAMOMQ0NMC.19EDQ0WOL1JZE@schmidt>
In-Reply-To: <xmqq8s1afmyh.fsf@gitster.g>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210809175530.75326-2-kim@eagain.st> <xmqq8s1afmyh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Aug 9, 2021 at 9:16 PM CEST, Junio C Hamano wrote:
> >
> > +# Write a complete fetch command to stdout, suitable for use with `tes=
t-tool
> > +# pkt-line`. "want-ref", "want", and "have" values can be given in thi=
s order,
> > +# with sections separated by "--".
> > +#
> > +# Examples:
> > +#
> > +# write_fetch_command refs/heads/main
> > +#
> > +# write_fetch_command \
> > +#=09refs/heads/main \
> > +#=09-- \
> > +#=09-- \
> > +#=09$(git rev-parse x)
> > +#
> > +# write_fetch_command \
> > +#=09--
> > +#=09$(git rev-parse a) \
> > +#=09--
> > +#=09$(git rev-parse b)
>
> Have a blank line here (or a line with "#" and nothing else) and it
> would become easier to read.

Noted.

>
> > +write_fetch_command () {
> > +=09write_command fetch &&
> > +=09echo "0001" &&
> > +=09echo "no-progress" || return
>
> The "while :" in this helper function are indented with 4 spaces,
> not a single tab.

Noted, sorry.

I can't seem to be able teach `git diff --check` to exit non-zero on whites=
pace
errors.

> >  # c(o/foo) d(o/bar)
> >  #        \ /
> >  #         b   e(baz)  f(main)
> > @@ -97,15 +145,13 @@ test_expect_success 'basic want-ref' '
> >  =09EOF
> >  =09git rev-parse f >expected_commits &&
> >
> >  =09test-tool pkt-line pack >in <<-EOF &&
> > +=09$(write_fetch_command \
> > +=09=09refs/heads/main \
> > +=09=09-- \
> > +=09=09-- \
> > +=09=09$(git rev-parse a) \
> > +=09)
> >  =09EOF
> >  =09test-tool serve-v2 --stateless-rpc >out <in &&
>
> ... the code that uses the helper needs rewriting to make use of
> it. A failure in $(write_fetch_command) here will not cause the
> caller to stop here. If we had any "git" command used in the
> helper, I would recommand restructuring the caller to do something
> like:
>
> write_fetch_command >pkt-src \
> =09refs/heads/main \
> =09-- \
> =09-- \
> =09$(git rev-parse a) &&
> test-tool pkt-line pack <pkt-src >in &&
> test-tool serve-v2 --stateless-rpc >out <in &&
>
> but it probably may not be necessary (we only use "echo" there, and
> it probably is not worth worrying about 'echo' failing).
>
> The call to $(git rev-parse a) might fail when rev-parse gets
> broken, and I think the rewritten version would catch such a
> breakage while the one inside $(write_fetch_command) in the here-doc
> would not be.

Heh, this is turning into an exercise to forget everything about bash :/

I didn't know that an error in a nested command substitution would not caus=
e the
outer one to fail. As we can't use a pipe either (as Jonathan Nieder sugges=
ts),
I think a redirection like this is indeed necessary. The only other option =
I
could think of would be assigning rev-parse to a variable, which arguably i=
s
less readable:

    have=3D$(git rew-parse a) &&
    test-tool pkt-line pack >in <<-EOF &&
    $(write_fetch_command \
=09    refs/heads/main \
=09    -- \
=09    -- \
=09    $have)
    EOF


Thanks

