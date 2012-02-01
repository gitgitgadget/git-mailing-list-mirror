From: Jeff King <peff@peff.net>
Subject: Re: logging disjoint sets of commits in a single command
Date: Tue, 31 Jan 2012 19:53:33 -0500
Message-ID: <20120201005332.GC30969@sigill.intra.peff.net>
References: <CB4DC442.72F%bryano@fb.com>
 <1328056769.31804.217.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan O'Sullivan <bryano@fb.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <carlos@cmartin.tk>
X-From: git-owner@vger.kernel.org Wed Feb 01 01:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsOSC-0003JZ-Kq
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 01:53:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230Ab2BAAxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 19:53:36 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51323
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722Ab2BAAxf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 19:53:35 -0500
Received: (qmail 4138 invoked by uid 107); 1 Feb 2012 01:00:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jan 2012 20:00:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jan 2012 19:53:33 -0500
Content-Disposition: inline
In-Reply-To: <1328056769.31804.217.camel@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189489>

On Wed, Feb 01, 2012 at 01:39:29AM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> > Here's a sample command line against a kernel tree:
> >=20
> > git log 373af0c^..373af0c 590dfe2^..590dfe2
> >=20
> > I want git to log those two specific commits, but in fact it looks =
like
> > limit_list is marking 590dfe2 as UNINTERESTING while processing 373=
af0c,
> > and so it gets pruned.
> >=20
> > Is there some way around this, or would a patch to fix it be accept=
able?
>=20
> From my reading of the manpage (and the way most git commands work) l=
og
> accepts one range of commits. They all get bunched up together.

Right. That command is equivalent to:

  373af0c 590dfe2 --not 373af0c^ 590dfe2^

So the limiting for one range you're interested in ends up marking part
of the other as uninteresting, and that's by design. This topic came up
recently, and I think the general consensus is that it would be cool to
be able to do totally independent ranges, but that would be backwards
incompatible with the current behavior.

In the general case, you can emulate this with:

  { git log 373af0c^..373af0c
    git log 590dfe2^..590dfe2
  } | $PAGER

which is of course slightly more annoying to type. If you're just
interested in _single_ commits, though, you can just give the commits
and turn off walking:

  git log --no-walk 373af0c 590dfe2

> You might find cat-file's --batch mode interesting.
>=20
>     git rev-list 373af0c^..373af0c | git cat-file --batch
>     git rev-list 590dfe2^..590dfe2 | git cat-file --batch
>=20
> looks a lot like what you're looking for.

I think you could even drop the rev-lists in this case, since he just
wants a single commit. However, cat-file lacks the niceties of "log",
like fancy --pretty formatting and automatic diffing against parents.

-Peff
