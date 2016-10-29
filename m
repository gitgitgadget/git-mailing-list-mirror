Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBBCD2022A
	for <e@80x24.org>; Sat, 29 Oct 2016 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755282AbcJ2QIg (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Oct 2016 12:08:36 -0400
Received: from homie.mail.dreamhost.com ([208.97.132.208]:42683 "EHLO
        homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754138AbcJ2QIf (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Oct 2016 12:08:35 -0400
Received: from homiemail-a62.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTP id 34DD563406E;
        Sat, 29 Oct 2016 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=gC83fCazdD7dxRrOwuGfhj7uZWE=; b=H8LQK2zDS0
        U9fL21pEPAvM8wqlvm38WLiUkG/fTSVImp9n6iO0v69oKuMKDNHaULmd/ayOYXWY
        gNjNtebZN2h3Z6CVFP5+3/9r9qhM8tdtqvWz3mZEYOiQEBPG0U/URCW7QdYBd55F
        BLcRhsaY9i7GyyflQa/ZcgNEH6n5igZI0=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a62.g.dreamhost.com (Postfix) with ESMTPSA id B174363406C;
        Sat, 29 Oct 2016 09:08:33 -0700 (PDT)
Message-ID: <1477757311.1524.21.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Sat, 29 Oct 2016 12:08:31 -0400
In-Reply-To: <20161029133959.kpkohjkku3jgwjql@sigill.intra.peff.net>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
         <1477692961.2904.36.camel@mattmccutchen.net>
         <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
         <1477712029.2904.64.camel@mattmccutchen.net>
         <20161029133959.kpkohjkku3jgwjql@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2016-10-29 at 09:39 -0400, Jeff King wrote:
> I'm not sure I understand how connecting to a remote server to fetch is
> a big problem. The server may learn about the existence of particular
> sha1s in your repository, but cannot get their content.
>=20
> It's the subsequent push that is a problem.
>=20
> In the scenarios you've described, I'm mostly inclined to say that the
> problem is not git or the protocol itself, but rather lax refspecs.
> You mentioned earlier:
>=20
> =C2=A0 the server can just generate another ref 'xx' pointing to Y2, as=
suming
> =C2=A0 it can entice the victim to set up a corresponding local branch
> =C2=A0 refs/heads/for-server1/xx and push it back.=C2=A0=C2=A0Or if the=
 victim is for
> =C2=A0 some reason just mirroring back and forth:
>=20
> This sounds a lot like "I told git to push a bunch of things without
> checking if they were really secret, and it turned out to push some
> secret things". IOW I think the problem is not that the server may lie
> about what it has, but that the user was not careful about what they
> pushed. I dunno. I do not mind making a note in the documentation
> explaining the implications of a server lying, but the scenarios seem
> pretty contrived to me.

Let's focus on the first scenario. =C2=A0There the user is just pulling a=
nd
pushing a master branch. =C2=A0Are you saying that each time the user pul=
ls,
they need to look over all the commits they pulled before pushing them
back? =C2=A0I think that's unrealistic, for example, on a busy project wi=
th
centralized code review or if the user is publishing a project-specific=20
modified version of an upstream library. =C2=A0The natural user expectati=
on
is that anything pulled from a public repository is public.

But let's see what Junio says in the other subthread.

> A much more interesting one, IMHO, is a server whose receive-pack lies
> about which objects it has (possibly ones it found out about earlier vi=
a
> fetch), which provokes the client to generate deltas against objects th=
e
> server doesn't have (and thereby leaking information about the base
> objects).
>=20
> That is a problem no matter how careful your refspecs are. I suspect it
> would be a hard attack to pull off in practice, just because it's going
> to depend heavily on the content of the specific objects, what kinds of
> deltas you can convince the other side to generate, etc. That might
> merit a mention in the git-push documentation.

Sure, if I end up doing a patch, I'll include this.

Matt
