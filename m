From: martin f krafft <madduck@madduck.net>
Subject: Re: Storing additional information in commit headers
Date: Tue, 2 Aug 2011 10:28:10 +0200
Message-ID: <20110802082810.GC29887@fishbowl.rw.madduck.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
 <20110802035056.GB17494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
To: Jeff King <peff@peff.net>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Aug 02 10:28:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoAL4-0006wp-RK
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 10:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556Ab1HBI2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 04:28:30 -0400
Received: from seamus.madduck.net ([213.203.238.82]:52852 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1HBI20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 04:28:26 -0400
Received: from fishbowl.rw.madduck.net (244-228.79-83.cust.bluewin.ch [83.79.228.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id CB1DA407D3B;
	Tue,  2 Aug 2011 10:28:11 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 81B601FEB9; Tue,  2 Aug 2011 10:28:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110802035056.GB17494@sigill.intra.peff.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178449>


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Jeff King <peff@peff.net> [2011.08.02.0550 +0200]:
> >   2. It is immutable. Ideally, I would like to store extra
> >      information for a ref in ref/heads/*, but there seems to be no
> >      way of doing this. Hence, I need to store it in commits and
> >      backtrack for it. Or so I think, at least=E2=80=A6
>=20
> Wait, so you want metadata on a _ref_, not on a commit? That is a very
> different thing, I think. We usually accomplish that with data in
> .git/config. Or if you need to push data between repos, or if it's too
> big to easily fit in the config, then put it in a blob and keep a
> parallel ref structure (e.g., refs/topgit/bases/refs/heads/master).
>=20
> Or maybe I'm just misunderstanding.

You nailed it perfectly well. Thank you for taking the time again to
reply to me.

TopGit does what you suggest (a parallel ref structure), but there
are three problems with this, which I am trying to address:

  1. you need to ensure that these refs are pushed and fetched,
     which requires set up and possible migration issues when things
     change, and can cause big problems for contributors who just so
     happened to forget.

  2. the additional refs confuse people a lot =E2=80=94 and I can attest to
     that because I have also at times found myself overwhelmed by
     them when staring at gitk.

  3. once a ref updates, we need to keep a pointer to the previous
     location, since one of the goals is the ability to be able to
     return to a point in history (e.g. for security updates to
     a stable package, or backports). Additional refs enhance the
     aforementioned two problems.

Therefore I thought it would be sensible to store these data in
commit. When the data change, there will always be a new commit to
store these data, and we do *not* want to update the data in
previous commits. Finding the data then becomes backtracking the
branch history until a commit is found containing them.

> >   In addition to the standard tree and parent pointers, there could
> >   be *-ref and x-*-ref headers, which take a single ref argument,
> >   presumably to a blob containing more data.
>
> I'm not sure how well-defined that is, though. What does the ref
> mean? What does it point to, and what is the meaning with respect
> to the original commit? Or are you suggesting that "*" would be
> "topgit-base" here, and that git core would understand only that
> any header matching the pattern "x-*-ref" should be followed with
> respect to reachability/pruning. Only the owner of the "*" part
> (topgit in this case) would be able to make sense of the meaning
> of the ref.

Exactly the latter. Sorry for my unannounced use of wildcards in
this context.

> If that is the case, that does make sense to me. It's basically an
> immutable version of a note.
>
> However, implementing such a thing would mean you have an awkward
> transition period where some versions of git think the referenced
> object is relevant, and others do not. That's something we can
> overcome, but it's going to require code in git, and possibly
> a dormant introduction period.

Indeed. This could be adressed by letting a tool like TopGit require
a minimum version of Git. For a while, this will burden developers,
but ensure that it works. Over time, this will cease to be
a problem.

> I suspect you would give git people more warm fuzzies about
> implementing this by showing a system that is built on git-notes
> and saying "this works really well, except that the external note
> storage is not a good reason because { it's mutable, it's not
> efficient, whatever other reason you find}". And then we know that
> the system is proven to work, and that migrating the note-like
> structure into the object is sensible.
>
> But I get the impression you're one step back from that now. So it makes
> sense to me to at least prototype it via git-notes, which will give you
> the same semantic storage (a mapping of commits to some blobs, with
> reachability handled automatically).

I appreciate how you are developing your reasoning, and the advice
you give.

Indeed, I am already prototyping using git-notes, and I designed the
datastore to be extensible, so that I can use other ways to find the
data.

Using pseudo-headers is another (temporary) way to prove the concept
works, but I am afraid that it will become standard too quickly
(because it's so easy), essentially preventing progress into x-*-ref
domain, or forcing us to carry compatibility with us forever.

What do you think about using the idea of orphan parent commits
(OPC) for now? These are conceptually closest to the x-*-ref
pointers, do not require extra setup, pollute history only a little
bit (IMHO), and slot in with Git and fsck/gc alright.

Here's the idea again, graphically:

  o--o--o--=E2=97=8F
       /
      #

while at HEAD, I would backtrack history until I found HEAD^, which
has a parent with a well-defined commit message and holding the data
I am looking for.

Later, when x-*-ref is mainline, instead of parent pointers, it can
be used in place.

When there is a merge and the TopGit data need updating, a new
OPC is slotted into place, on the merge commit. In
the following graph, the user then decided also at a later point to
update e.g. the TopGit patch description (.topmsg), which is also
stored in this OPC:

       o--o-o
      /      \      maint       master
  o--o--o--o--+--o--O--o--o--o--=E2=97=8F
       /     /           /
      #     #           #

To keep things simple, every OPC copies the unchanged data from the
previous one as well (compression will reduce the overhead).

Later, I can use the maint branch just in the same way I could use
master when it was at that age.

> > > Otherwise, the usual recommendation is to use a pseudo-header
> > > within the body of the commit message (i.e., "Topgit-Base: ..." at
> > > the end of the commit message). The upside is that it's easy to
> > > create, manipulate, and examine using existing git tools. The
> > > downside is that it is something that the user is more likely to
> > > see in "git log" or when editing a rebased commit message.
> >=20
> > =E2=80=A6 to see *and to accidentally mess up*. And while that may even=
 be
> > unlikely, it does expose information that really ought to be hidden.
>=20
> I'm not quite sure what the information is, so I can't really judge. Do
> you have a concrete example?
>=20
> I got the impression earlier you were wanting to store a human-readable
> text string.  That makes a pseudo-header a reasonable choice. But if you
> are going to reference some blob (which it seems from what you wrote
> above), and you are interested in proper reachability analysis, then no,
> it probably isn't a good idea.

I am not yet sure what information needs storing. Right now, I am
keeping five fields:

  Depend-Refs         A list of the most recent branch points from
                      dependency branchs, so that a tool can tell
                      when the dependent branch needs an update
                      (commits following those refs that are not
                      reachable by the branch head).
  Base-Ref            The ref to the most recent merge of all
                      dependencies, used to create diffs.
  Patch-Branch        boolean to suggest whether this branch is
                      designed to develop a single patch for
                      submission or use in a quilt series.
  Patch-Message       Patch description (think git-send-email).
  Integration-Branch  boolean to suggest whether instead this branch
                      is a branch designed to collect features.

At the moment, I do now know which of those are necessary, and which
I am missing.

The flexibility of being able to store as much as I want, in
whatever format I want, without having to fear overloading the
commit message or burdening the user, is what makes me want to use
refs to blobs.

> I think extensibility is welcome. It's just that most discussions
> so far have ended up realizing that a new header would just be
> cruft. Maybe yours is different. I'm still not 100% sure
> I understand what you want to accomplish, but the idea of an
> x-*-ref header is a reasonable thing for git to have.

I think there are two questions:

  1. would x-*-ref be a suitable idea for Git core?

     I think the answer is yes, as (I think) it's well-defined and
     I cannot see any problems with it, really.

  2. can we prevent abuse?

     No, never. But just like you cannot abuse X-* headers in the
     RFC822 format due to their design, x-*-ref abuse would only
     affect those who chose it.

Thank you,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the question of whether computers can think
 is like the question of whether submarines can swim."
                                                 -- edsgar w. dijkstra
=20
spamtraps: madduck.bogus@madduck.net

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJON7UXwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xMFB
EACb1zQSOhBYVblpV39DP6NDPfgxpT0ZUJ4tTR5JucbZy0tJm8yxLybeAQwwXkeR
77edTuJfePOvoku5bB37YRGOZ102ADvqy9VAaaj4F746fmb8VQ04ktM7CNwjuCME
FbGnUm5E7WCDIMy0hWdCSsGseCl7KydiJULlmE6/oJhbNuaekuVsEZySQ8qGx2zy
MydHh/O4RPwyjJuAZtFbel0rFrZbDlmBinkKiHWdIhahVK0RPBIkOa2+bha6czCZ
Rh8/fTZuZT/or9vyrZUPbcg6w1uLbwDRHxd1nvfb13KkPB/UoN30vGwotQ2PrR7W
hLJasToyiXHfrksfVvCKhXodrCS5f7wLOkxjrIrPpVNE2H2tL1aD9j0kCvMwkFPJ
PpYq2qSldc0dm/uUGEhtb7ixPBB5HfOMlr+LCmZ2VeeAtuOimFJ4YkAyozOg6jev
1FF5Fz55HMubwR3zHIuCTbL9m6DMucfGMNjRpxnRzinTeoVUe17lqXvLeO5PfS/b
8SS6fwCn8OoI1c38bxt6tHortzWghutVmr9rK2bC6uFclXpilyaVow3O9IL6o0rF
5X8ENCx/MiyhxfkDChiesg83jpcj8lIKlW3bM3p+8UQrQ0JA9BRSVXxZptJgYIHP
MZk8QOU84TQJwnYfnkhbcdGSGH4Fc7P1VfbZNlvsccuFVw==
=D6ia
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
