From: Jeff King <peff@peff.net>
Subject: Re: The config include mechanism doesn't allow for overwriting
Date: Tue, 23 Oct 2012 20:51:30 -0400
Message-ID: <20121024005130.GA19638@sigill.intra.peff.net>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
 <CAEBDL5V0Ffyp306rVo-USCBy_AXXMHXN1yrWmkF1BhzFaq60nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 02:51:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQpCE-0006UB-BQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 02:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933705Ab2JXAvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 20:51:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51805 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933407Ab2JXAve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 20:51:34 -0400
Received: (qmail 24309 invoked by uid 107); 24 Oct 2012 00:52:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 20:52:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 20:51:30 -0400
Content-Disposition: inline
In-Reply-To: <CAEBDL5V0Ffyp306rVo-USCBy_AXXMHXN1yrWmkF1BhzFaq60nA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208277>

On Tue, Oct 23, 2012 at 08:46:47PM -0400, John Szakmeister wrote:

> On Tue, Oct 23, 2012 at 10:13 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
> <avarab@gmail.com> wrote:
> [snip]
> > And git config --get foo.bar will give you:
> >
> >     $ git config -f /tmp/test --get foo.bar
> >     one
> >     error: More than one value for the key foo.bar: two
> >     error: More than one value for the key foo.bar: three
> >
> > I think that it would be better if the config mechanism just silent=
ly
> > overwrote keys that clobbered earlier keys like your patch does.
> >
> > But in addition can we simplify things for the consumers of
> > "git-{config,var} -l" by only printing:
> >
> >     foo.bar=3Dthree
> >
> > Or are there too many variables like "include.path" that can
> > legitimately appear more than once.
>=20
> I frequently use pushurl in my remotes to push my master branch both
> to the original repo and my forked version.  I find it very helpful i=
n
> my workflow, and would hate to lose that.  That said, I do like the
> idea of having a config file and the ability to override some of the
> variables.

No, that won't go anywhere. We really do have two classes of variables:
things that are expected to be single values, and things that are
expected to be lists.

=46rom the perspective of the config code, we don't know or care which =
is
which, and just feed all entries sequentially to a C callback. In
practice, the callbacks do one of two things:

  1. Append the values into a list.

  2. Overwrite, and end up with the final value seen.

The trouble is that git-config has to print the values in a reasonable
way, so it asks the caller to give a hint about which it wants (--get
versus --get-all). But in the single-value case did not behave like the
C callbacks, which is what my series fixes.

Using "git config -l" is more like asking the config machinery to just
feed us everything, which is what the C callbacks see. Which is more
flexible, but way less convenient for the caller. But it doesn't need t=
o
be fixed, since the caller has all the information to implement whateve=
r
semantics they like.

-Peff
