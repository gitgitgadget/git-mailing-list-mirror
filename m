From: Jeff King <peff@peff.net>
Subject: Re: Is anyone working on a next-gen Git protocol?
Date: Sun, 7 Oct 2012 18:08:33 -0400
Message-ID: <20121007220833.GD1743@sigill.intra.peff.net>
References: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, spearce@spearce.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKz1j-0007JB-14
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 00:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab2JGWIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2012 18:08:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44016 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2JGWIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 18:08:35 -0400
Received: (qmail 18570 invoked by uid 107); 7 Oct 2012 22:09:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 07 Oct 2012 18:09:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Oct 2012 18:08:33 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX6b+3P8M+z+X13k9Pq3tvVUfs_k1=foQVreX8K801=efQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207203>

On Sun, Oct 07, 2012 at 09:57:56PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Has anyone started working on a next-gen Git protocol as a result of
> this discussion? If not I thought I'd give it a shot if/when I have
> time.

I haven't, and don't really plan on it soon (I have a few smaller thing=
s
I'm working on, then I'd like to look into the EWAH bitmap stuff from
Shawn next).

> The current protocol is basically (S =3D Server, C =3D Client)
>=20
>  S: Spew out first ref
>  S: Advertisement of capabilities
>  S: Dump of all our refs
>  C/S: Declare wanted refs, negotiate with server
>  S: Send pack to client, if needed

In the "C" portion there, there is also "client acknowledges a
subset of capabilities shown by server" while it is declaring wanted
refs.

> And I thought I'd basically turn it into:
>=20
>  C: Connect to server, declare what protocol we understand
>  C: Advertisement of capabilities
>  S: Advertisement of capabilities

The capability negotiation right now is that the server offers and the
client accepts. Are you swapping that so that the client offers and the
server accepts? Or are you thinking that they would be sent
simultaneously here? That could drop one round-trip (it's probably not
that important for git-over-tcp, but smart-http cares a lot about round
trips). But it also introduces a complexity with future additions (one
side may not know how to present its capabilities until understanding
what the other side can do).

>  C/S: Negotiate what we want

Refs we want, or capabilities we want?

>  C/S: Same as v1, without the advertisement of capabilities, and mayb=
e
> don't dump refs at all
>=20
> Basically future-proofing it by having the client say what it support=
s
> to begin with along with what it can handle (like in HTTP).

I feel like this "maybe..." bit needs more fleshed out before designing
the first part. I like the idea of future-proofing first and then addin=
g
new features second, but what does the "don't advertise all refs"
protocol look like? Presumably the client is going to say "I'm
interested in refs/heads/* and refs/tags/*" or something. Does that com=
e
with the capabilities? Or is it a new protocol phase?

I think we need to know what the second half of the two-step process
will look like to be sure the first half will accommodate it (and the
answer may be as simple as saying "they're not sending capabilities,
they're sending arbitrary key/value items, with the knowledge that the
other side may not understand particular keys, and we have to be
prepared to handle both cases).

> Then in the negotiation phase the client & server would go back &
> forth about what they want & how they want it. I'd planned to
> implement something like:
>=20
>     C: want_refs refs/heads/*
>     S: OK to that
>     C: want_refs refs/tags/*
>     S: OK to that
>=20
> Or:
>=20
>     C: want_refs refs/heads/master
>     S: OK to that
>     C: want_refs refs/tags/v*
>     S: OK to that

That seems simple. But how will it work over smart-http? Are we adding =
a
round-trip to do want_refs negotiation?

-Peff
