Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475822021E
	for <e@80x24.org>; Sun, 13 Nov 2016 02:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbcKMCo0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 21:44:26 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:47020 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932310AbcKMCoZ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Nov 2016 21:44:25 -0500
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 88FF8392076;
        Sat, 12 Nov 2016 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=Q11ExCI6s6pgjL0T5Ss0Osg1biU=; b=gVMeDlqSJC
        WGOBisgRITiW3LnsmgQ2YB6kBYBfsvYPLOXkYrAykqNw64Iu63AhhC5IIA2fgZHq
        jy0ojyKXayiziiqsaXtTXVVs/58ZHuAv4BaPn2WTvYfPiA59cFdl4/qiWKT1b8ru
        NGqSI/A5l3kZp+L2+5sS1b3sdlYEnYXZI=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 063FF392075;
        Sat, 12 Nov 2016 18:44:21 -0800 (PST)
Message-ID: <1479005056.3471.40.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>, Jon Loeliger <jdl@jdl.com>
Cc:     git@vger.kernel.org
Date:   Sat, 12 Nov 2016 21:44:16 -0500
In-Reply-To: <xmqqpomiuu8q.fsf@gitster.mtv.corp.google.com>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
         <1477692961.2904.36.camel@mattmccutchen.net>
         <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
         <E1c0XaZ-0007Ab-QI@mylo.jdl.com>
         <xmqqpomiuu8q.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-10-30 at 01:16 -0700, Junio C Hamano wrote:
> Jon Loeliger <jdl@jdl.com> writes:
>=20
> >=20
> > Is there an existing protocol provision, or an extension to
> > the protocol that would allow a distrustful client to say to
> > the server, "Really, you have Y2?=C2=A0=C2=A0Prove it."
>=20
> There is not, but I do not think it would be an effective solution.
>=20
> The issue is not the lack of protocol support, but how to determine
> that the other side needs such a proof for Y2 but not for other
> commits.=C2=A0=C2=A0How does your side know what makes Y2 special and w=
hy does
> yout side think they should not have Y2?
>=20
> Once you know how to determine Y2 is special, that knowledge can be
> used to abort the "push" before even starting.=C2=A0=C2=A0When you are =
pushing
> back the 'master' and that 'master' reaches Y2, which must be kept
> secret, you shouldn't be pushing that 'master' to them, whether they
> claim to have Y2 or not.

FWIW, I can imagine a protocol that would prove possession for all
objects, which would completely fix the problem. =C2=A0Each object would
have a "private" hash computed recursively over the object graph, just
like the ordinary object hash, but with a different seed. =C2=A0The objec=
t
database would be extended to cache the private hash of every object.
=C2=A0Then, during a fetch or push, when the two sides identify a matchin=
g
object, the side that would otherwise have had to send the object sends
the private hash. =C2=A0Support for storing multiple hashes per object mi=
ght
also be useful in some way for the migration to a stronger hash
function than SHA-1.

The next best solution, which doesn't require a protocol change but
requires a little user intervention, is to have a configuration option
per remote for a set of refs whose reachable objects are known to be
safe to send to the server. =C2=A0This set presumably includes the remote=
's
own remote-tracking refs. =C2=A0During fetch and push, the client looks f=
or
matches only among these "safe" objects, effectively emulating a
repository containing only the safe objects. =C2=A0A fetch may update the
remote-tracking refs to point to unsafe objects that were already in
the local repository, effectively making them safe, but only after the
server sends the content of these objects (and the client validates the
hashes!).

Unfortunately, I'm not signing up to implement either solution. :(

Matt
