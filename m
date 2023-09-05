Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED1EC83F3E
	for <git@archiver.kernel.org>; Tue,  5 Sep 2023 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbjIEWSV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWSU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2023 18:18:20 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15B1F4
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 15:18:16 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 18A921B9FB3;
        Tue,  5 Sep 2023 18:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=P8U/gKw47SYu
        iXGsC02PuXqod8gB2m3514YN6XpiCjg=; b=PC3lfIdFKqXlKrA6HUiKhsv1Mlrd
        uuRQWSfYCRS79r5WoqBX3tv/KScKfIk3vGlD5w/3t4W5hGleiX/vlknjRIz/uU44
        92eEoOuovjzGZxHefDkqxajCFzGeX+cO+LhjOGa1X73lHlOSAOgMvdbhddt6/Hqd
        SXQYUJRb1AKfjaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 119851B9FB2;
        Tue,  5 Sep 2023 18:18:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 789651B9FB1;
        Tue,  5 Sep 2023 18:18:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: Plumbing for mapping from a remote tracking ref to the remote ref?
In-Reply-To: <CAPMMpojUrfSmpgWVh3TTn_uamPCcyHRQf2R3APSpEjsqujNXvA@mail.gmail.com>
        (Tao Klerks's message of "Sun, 3 Sep 2023 09:16:00 +0200")
References: <CAPMMpogUxq59zj+=7UDiURYbydAwvymOqhEWaheT9fkU8HaP4Q@mail.gmail.com>
        <xmqqilp1znn1.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2206182358350.349@tvgsbejvaqbjf.bet>
        <xmqqczf5lgk3.fsf@gitster.g>
        <CAPMMpojUrfSmpgWVh3TTn_uamPCcyHRQf2R3APSpEjsqujNXvA@mail.gmail.com>
Date:   Tue, 05 Sep 2023 15:18:14 -0700
Message-ID: <xmqqpm2wqn6h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1BE8AFBC-4C3A-11EE-8387-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> On Sun, Jun 19, 2022 at 1:04=E2=80=AFAM Junio C Hamano <gitster@pobox.c=
om> wrote:
>>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> >>      $ git refmap refs/remotes/somepath/{branch-A,branch-B}
>> >>      origin refs/heads/branch-A
>> >>      origin refs/heads/branch-B
>> >>
>> >> IOW, you give name(s) of remote-tracking branches and then you get
>> >> the remote and their ref for these?
>> >
>> > Modulo introducing a new top-level command (a subcommand of `git rem=
ote`
>> > would make much more sense and make the feature eminently more
>> > discoverable), and modulo allowing patterns in the ref to match, I a=
gree.
>>
>> "git remote" is primarily about "I have this remote---tell me more
>> about it", but this query goes in the other direction, and that is
>> why I threw a non-existing command to solicit alternatives that are
>> potentially better than "git remote".
>
> Thank you for the responses here, and my apologies for not following
> up (much) earlier.
> ...
> Would something like the following be mutually agreeable?
>
>        $ git remote origin map-ref
> refs/remotes/my-favorite-remotes/origin/someref
>       refs/heads/someref

With strainge line wrapping, I cannot quite tell what is the input
and what is the output, but if you meant that the part up to the
long-ish refname in the refs/remotes is the command line, and map-ref
is the new subcommand name in the "git remote" command, i.e.

    $ git remote map-ref origin refs/remotes/my-favorite-remotes/origin/s=
omeref

is the input, to which the output=20

    refs/heads/someref

is given, I am not sure what its value is.  First of all, the user
is giving a ref in a hierarchy that is usually used for the remote
whose name is "my-favorite-remotes".  What made this user _know_
that the remote reference belongs to "origin"?  Isn't that part of
what the user may want to _find_ _out_, instead of required to give
as input?

So, no, I do not think it is agreeable at least not from this end,
but I may be misunderstanding what you meant to present as your
design.

I would understand if it were more like

    $ git remote refmap refs/remotes/somepath/{branch-A,branch-B}
    origin:refs/heads/branch-A refs/remotes/somepath/branch-A
    origin:refs/heads/branch-B refs/remotes/somepath/branch-B

that is,

 (1) the new subcommand (refmap) takes one or more refs from the
     command line; they typically are in the refs/remotes hiearchy
     and each asks which remote's which ref needs to be fetched to
     update the ref.  Note that the user does *not* need to know
     which remote the refs will be updated from.

 (2) the subcommand goes through the "remote.*.fetch" configuration
     items (and its older equivalents in .git/remotes, whose support
     should come free if you used remote.c API properly) to find
     what ref from what remote is fetched to update the refs given
     from the command line.

 (3) the output is "<remote>:<ref-at-remote> <our-remote-tracking-branch>=
"
     one line at a time.

Note that this format allows the "two remotes can both update the
same remote tracking branches we have" arrangement.

