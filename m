From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Sat, 12 Mar 2011 21:52:58 -0500
Message-ID: <20110313025258.GA10452@sigill.intra.peff.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net>
 <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de>
 <20110310222443.GC15828@sigill.intra.peff.net>
 <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Miseler <alexander@miseler.de>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Eric Montellese <emontellese@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 03:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PybQn-00030Y-Ut
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 03:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374Ab1CMCxE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Mar 2011 21:53:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52442
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756196Ab1CMCxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2011 21:53:01 -0500
Received: (qmail 29353 invoked by uid 107); 13 Mar 2011 02:53:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 12 Mar 2011 21:53:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Mar 2011 21:52:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168956>

On Sat, Mar 12, 2011 at 08:53:53PM -0500, Eric Montellese wrote:

> The best solution, it seems, has two parts:
>=20
> 1. Clean up the way in which git considers, diffs, and stores binarie=
s
> to cut down on the overhead of dealing with these files.

This is the easier half, I think.

>   1.1 Perhaps a "binaries" directory, or structure of directories, wi=
thin .git

I'd rather not do something so drastic. We already have ways of marking
files as binary and un-diffable within the tree. So you can already do
pretty well with marking them with gitattributes. I think we can do
better by making them the binaryness auto-detection less expensive
(right now we pull in the whole blob to check the first 1K or so for
NULs or other patterns; this is fine in the common text case, where
we'll want the whole blob in a minute anyway, but for large files it's
obviously wasteful). There may also be code-paths for binary files wher=
e
we accidentally load them (I just fixed one last week where we
unnecessarily loaded them in the diffstat code path). Somebody will nee=
d
to do some experimenting to shake out those code paths.

=46or packing, we have core.bigFileThreshold to turn off delta compress=
ion
for large files, but according to the documentation, it is only honored
for fast-import. I think we would want something similar to say "for
some subset of files (indicated either by name or by minimum size),
don't bother with zlib-compression either, and always keep them loose".

Those are the two major ones, I think. There are probably a handful of
other cases (like git-add, which really should be able to have a fixed
memory size). Again, the first step is figuring out where all of the
problems are (and I'm happy to just fix them one by one as they come up=
,
but I am also thinking of this in terms of a GSoC project).

>   1.2 Perhaps configurable options for when and how to try a binary
> diff? =C2=A0(allow user to decide if storage or speed is more importa=
nt)

We can already do that with gitattributes. But it would be nice to have
it be fast in the binary auto-detection case.

> 2. Once (1) is accomplished, add an option to avoid copying binaries
> from all but the tip when doing a "git clone."

This is much harder. :)

>   2.1 The default behavior would be to copy everything, as users
> currently expect.
>   2.2 Core code would have hooks to allow a script to use a central
> location for the binary storage. (ssh, http, gmail-fs, whatever)

I think we would need a protocol extension for the fetching client to
say "please don't bother sending me anything larger than N bytes; I wil=
l
get it via alternate storage". Although there are situations more
complicated than that. Your alternate storage might have up to commit X=
,
and you don't want large objects in X or its ancestors. But you _do_
want large objects in descendants of X, since you have no other way to
get them.

So you need some way of saying which sets of large objects you need and
which you don't. One implementation is that you could fetch from
alternate storage (which would then need to be not just large-blob
storage, but actually have a full repo), and then afterwards fetch from
the remote (which would then send you all binaries, because by
definition anything you are fetching is not something the alternate
storage has). That feels a bit hack-ish. Doing something more clever
would require a pretty major protocol extension, though.

I haven't been paying attention to any sparse clone proposals. I know i=
t
has come up but I don't know how mature the idea is. But this is
potentially related.

-Peff
