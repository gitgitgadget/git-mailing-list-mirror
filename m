From: Jeff King <peff@peff.net>
Subject: Re: [Tagging Commits] feedback / discussion request
Date: Thu, 5 May 2011 16:30:16 -0400
Message-ID: <20110505203016.GD1770@sigill.intra.peff.net>
References: <BANLkTik5-Ygh0YwN=j+ibLhP6==ots_MXQ@mail.gmail.com>
 <20110504084212.GB8512@sigill.intra.peff.net>
 <BANLkTinCxzXCmmtxXSM7=+yeve2hhLSYNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Peterson <richard@rcpeterson.com>
X-From: git-owner@vger.kernel.org Thu May 05 22:30:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI5Bp-00059U-36
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 22:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab1EEUaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 16:30:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52483
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1EEUaS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 16:30:18 -0400
Received: (qmail 3083 invoked by uid 107); 5 May 2011 20:32:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 16:32:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 16:30:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinCxzXCmmtxXSM7=+yeve2hhLSYNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172907>

On Thu, May 05, 2011 at 11:39:41AM -0400, Richard Peterson wrote:

> > =C2=A03. In git notes. You can do something like:
> >
> > =C2=A0 =C2=A0 =C2=A0 (git rev-parse --verify HEAD
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "I reviewed this"
> > =C2=A0 =C2=A0 =C2=A0 ) | gpg --sign -a |
> > =C2=A0 =C2=A0 =C2=A0 git notes add -F - HEAD
> >
> > =C2=A0 =C2=A0 though you'd probably want to be a little more comple=
x, and handle
> > =C2=A0 =C2=A0 lists of signed notes for each commit. And you may wa=
nt to store
> > =C2=A0 =C2=A0 these in a separate notes ref from the default one.
>=20
> I had looked at this option, but had failed to see the usefulness of =
using
> a different ref. I was worried about cluttering things up, overloadin=
g the
> intended purpose of notes, and so forth. I wasn't really sure if note=
s were
> intended to be general purpose storage for systematic, structured dat=
a.

They are definitely intended to be general purpose storage. For one suc=
h
(ab)use, see the textconv-caching subsystem. It maps binary blobs into
their converted text counterparts. So we are keying on blobs (not
commits!), and storing arbitrarily gigantic data in the notes values.
And the nice thing is that because notes use git objects for storage, w=
e
get all the usual delta compression benefits on the result.

> My inclination was to do this outside notes, or even in a parallel
> implementation to notes, factoring out the common parts. I suppose th=
at
> looking at notes as somewhat of a free-for-all obviates this need. Is=
 this
> really what notes are for?

Yep. Definitely use notes if you are going to do the storage in git.

> > =C2=A0 =C2=A0 The advantage of notes are that they are designed for=
 lots of
> > =C2=A0 =C2=A0 per-commit storage, and can be accessed fairly effici=
ently.
>=20
> That was my other concern about notes - performance. Not sure how
> notes are stored, but I certainly trust you that they're efficient.

Each notes tree is stored as a git tree full of entries representing th=
e
commit (or other object) hashes. And each entry points to a blob which
is the note's value. And then as the notes change over time, we version
them with commit objects. So you can make notes and your coworker can
make notes, and you can merge them together.

=46or fun, you can do:

  # make a repo to play around in
  git clone /path/to/some/repo notes-test
  cd notes-test

  # make some notes. You could also use "notes add -F"
  # to add notes with arbitrary binary content.
  git notes --ref=3Dfoo add -m "this is note 1" HEAD
  git notes --ref=3Dfoo add -m "this is note 2" HEAD^

  # check them out in context
  git log --show-notes=3Dfoo -2

  # and then see how they're stored
  git checkout refs/notes/foo
  grep . *

> > Developers would have to make a note and push their notes tree firs=
t,
>=20
> You mean for hook / verification purposes? Or is there some underlyin=
g
> reason to push notes first?

Yeah, for a pre-receive hook. You need to first tell the server "here
are some signatures" by pushing the notes, and then it can verify those
signatures when trying to put commits on actual branches.

> I'll be sure to share.

Great. I look forward to seeing the result.

-Peff
