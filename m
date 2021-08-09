Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C43C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C114B60F25
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 21:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbhHIV5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 17:57:50 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:55047 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbhHIV5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 17:57:49 -0400
Date:   Mon, 09 Aug 2021 21:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eagain.st;
        s=protonmail; t=1628546215;
        bh=KcYCz7at6yTZhfXO6zmSRxT3DAi33D76CdVGWvvVJJs=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=QqJyCHSj6ATots1dLXSGAaCEbkcpiP1MtEa9X0cK0ZFm29MX5gULHO/3AThe6S1kV
         7/0HdOuTlBmqnrexNnuRo976NZJCCrHWqaAi6xJAClmop75d+fP1TLa2zZzxM+/ZBf
         +t5AFYD5BiY72ykUi3G4/KpG9QfPXN/q4QG3oZMjNsWO02sgszQjTeG2iIpryI/Gsm
         hZL7OM85jTn1+3/n/abXyRGz2yo2dJRHbtNXNgO5VGu1+TL0ssY5kRmhGaNxqc0xnB
         9KYgTBJ95WwEQ4IxmkxYIWByPY9X+IHM6xgTz50GSQNxLfkV2eNW14NQF4UT8pYDNS
         vLBpDHBWPpv2Q==
To:     Jonathan Nieder <jrnieder@gmail.com>
From:   Kim Altintop <kim@eagain.st>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        bwilliams.eng@gmail.com
Reply-To: Kim Altintop <kim@eagain.st>
Subject: Re: [PATCH 1/3] t5730: introduce fetch command helper
Message-ID: <CDFBG4S23B1M.141X9FIPP7YHS@schmidt>
In-Reply-To: <YRGEwFauT5QjMSNO@google.com>
References: <20210730135845.633234-1-kim@eagain.st> <20210731203415.618641-1-kim@eagain.st> <20210804203829.661565-1-kim@eagain.st> <20210804205951.668140-1-kim@eagain.st> <20210809175530.75326-1-kim@eagain.st> <20210809175530.75326-2-kim@eagain.st> <YRGEwFauT5QjMSNO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for chiming in!

On Mon Aug 9, 2021 at 9:40 PM CEST, Jonathan Nieder wrote:
> Hm, for comparison let me see what this looks like without the helper:
> after some prior step
>
>=09 object_format=3D$(test_oid algo) && # probably just once in a setup st=
ep
>=09 x=3D$(git rev-parse x) &&
>
> we can write
>
>=09 cat <<-EOF &&
>=09 command=3Dfetch
>=09 object-format=3D$object_format
>=09 0001
>=09 no-progress
>=09 want-ref refs/heads/main
>=09 have $x
>=09 done
>=09 0000
>=09 EOF
>
> I find that a little _easier_ to read than a write_fetch_command call,
> because I don't have to chase the definition and x is labeled as a
> 'have'.
>
> Is there some additional motivation for this helper?

It was suggested in earlier review rounds. I think it does improve readabil=
ity
as quite some lines need to be repeated everywhere a fetch command is assem=
bled.
I agree though that not having some sort of "named arguments" is a bit
detrimental.

>
> >  =09test-tool serve-v2 --stateless-rpc >out <in &&
> > @@ -121,16 +167,14 @@ test_expect_success 'multiple want-ref lines' '
> >  =09EOF
> >  =09git rev-parse c d >expected_commits &&
> >
> > -=09oid=3D$(git rev-parse b) &&
> >  =09test-tool pkt-line pack >in <<-EOF &&
> > -=09$(write_command fetch)
> > -=090001
> > -=09no-progress
> > -=09want-ref refs/heads/o/foo
> > -=09want-ref refs/heads/o/bar
> > -=09have $oid
> > -=09done
> > -=090000
> > +=09$(write_fetch_command \
> > +=09=09refs/heads/o/foo \
> > +=09=09refs/heads/o/bar \
> > +=09=09-- \
> > +=09=09-- \
> > +=09=09$(git rev-parse b) \
> > +=09)
> >  =09EOF
>
> Here the entirety of the input to "test-tool pkt-line pack" is the
> entirety of the output from write_fetch_command, which would suggest
> either
>
> a. making write_fetch_command pipe its output to "test-tool pkt-line
> pack", or
>
> b. using a pipe instead of a command substitution, like
> "write_fetch_command ... | test-tool pkt-line pack >in"
>
> (although as mentioned above, I think it's simpler to inline the
> write_fetch_command and even the write_command as well).

Yes, although I believe a pipe cannot be used as we don't have bash's `set =
-o
pipefail` (ie. the exit status will always be the status of the last comman=
d in
the pipe, even if an earlier one failed).

Perhaps an alternative would be:

=09write_fetch_command () {
=09=09write_command fetch &&
=09=09echo "0001" &&
=09=09echo "no-progress" &&
=09=09cat /dev/stdin &&
=09=09echo "done" &&
=09=09echo "0000"
 =09}


Which would then be called like so:

=09write_fetch_command >pkt_cmd <<-EOF &&
=09want-ref refs/heads/main
=09have $(git rev-parse a)
=09EOF
=09test-tool pkt-line pack <pkt_cmd >in &&
=09test-tool serve-v2 --stateless-rpc >out <in &&


I'm not sure how portable that is, though. Maybe using `while read -r` inst=
ead
of `cat /dev/stdin`?

