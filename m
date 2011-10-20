From: Jeff King <peff@peff.net>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Thu, 20 Oct 2011 03:13:56 -0400
Message-ID: <20111020071356.GA14945@sigill.intra.peff.net>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
 <7vr5289mlu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 09:14:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGmpU-0003xc-SR
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 09:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab1JTHN7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 03:13:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36076
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751999Ab1JTHN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 03:13:58 -0400
Received: (qmail 8000 invoked by uid 107); 20 Oct 2011 07:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Oct 2011 03:14:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Oct 2011 03:13:56 -0400
Content-Disposition: inline
In-Reply-To: <7vr5289mlu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184011>

On Wed, Oct 19, 2011 at 11:57:17PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > Agreed. Having hidden cruft makes birthday collision attacks easier=
 (or
> > it will, if sha1 ever gets broken to that point).  Unfortunately, t=
here
> > is a _ton_ of code which assumes that commit messages are
> > NUL-terminated, as they always have been since e871b64 (2005-05-25)=
=2E
>=20
> I think that commit is irrelevant, as long as read_sha1_file() return=
s the
> contents as <ptr,len> pair, which has been the case forever. It's jus=
t the
> matter of propagating the length back up the callchain.

It's not that the commit is bad or the source of problems. My point is
that the assumption that commit messages are NUL-terminated has been
there for a really long time, so there are lots of spots in the code
that sloppily run string functions on them. Every one of those needs to
be found and fixed (e.g., I remember seeing this in
for-each-ref.c:find_subpos recently).

It's not impossible, of course, or even really that hard. It's just a
giant pain, and I wonder if the effort is worth it.

> A na=C3=AFve implementation to add "len" member to struct commit woul=
d increase
> the size of the in-core commit object by sizeof(unsigned long), which=
 we
> may want to avoid. Traversals that care nothing but the topology of t=
he
> history would have to waste that memory and these things tend to add =
up
> (8-byte ulong * 250k commits =3D 2MB).
>=20
> Perhaps change the type of "buf" member in struct commit to a pointer=
 to a
> <ptr,len> pair, or something? Or perhaps a few megabytes wasted betwe=
en
> friends we do not care much about?

I think you'd have to convert the struct (even if not every piece of
code is converted to use it) and profile.

-Peff
