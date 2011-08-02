From: Jeff King <peff@peff.net>
Subject: Re: Storing additional information in commit headers
Date: Mon, 1 Aug 2011 21:50:56 -0600
Message-ID: <20110802035056.GB17494@sigill.intra.peff.net>
References: <20110801182015.GA3100@fishbowl.rw.madduck.net>
 <20110801201301.GA17111@sigill.intra.peff.net>
 <20110801211104.GC15401@fishbowl.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>, Clemens Buchacher <drizzd@aon.at>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 05:51:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo60Y-0005xx-Am
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 05:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313Ab1HBDvB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 23:51:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab1HBDvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 23:51:00 -0400
Received: (qmail 25740 invoked by uid 107); 2 Aug 2011 03:51:32 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 01 Aug 2011 23:51:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2011 21:50:56 -0600
Content-Disposition: inline
In-Reply-To: <20110801211104.GC15401@fishbowl.rw.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178437>

On Mon, Aug 01, 2011 at 11:11:04PM +0200, martin f krafft wrote:

> >   1. Does git actually care about your data? E.g., would it want to=
 use
> >      it for reachability analysis in git-fsck?
> >=20
> >   2. Is it an immutable property of a commit, or can it be changed =
after
> >      the fact?
>=20
> Excellent points, and I have answers to both:
>=20
>   1. Ideally, I would like to point to another blob containing
>      information. Right now, in order to prevent gc from pruning
>      it, that would have to be a commit pointed to with a parent
>      pointer, which is just not right (it's not a parent) and causes
>      the commit to show up in the history (which it should not, as
>      it's an implementation detail).

In that case, notes sound like a nice solution, as that is exactly what
they do. Yes, they are mutable, but that might not be that big a deal.

>   2. It is immutable. Ideally, I would like to store extra
>      information for a ref in ref/heads/*, but there seems to be no
>      way of doing this. Hence, I need to store it in commits and
>      backtrack for it. Or so I think, at least=E2=80=A6

Wait, so you want metadata on a _ref_, not on a commit? That is a very
different thing, I think. We usually accomplish that with data in
=2Egit/config. Or if you need to push data between repos, or if it's to=
o
big to easily fit in the config, then put it in a blob and keep a
parallel ref structure (e.g., refs/topgit/bases/refs/heads/master).

Or maybe I'm just misunderstanding.

> > Otherwise, if (1) is yes, then a commit header makes sense. But
> > then, it should also be something that git is taught about, and
> > your commit header should not be some topgit-specific thing, but
> > a header showing the generalized form.
>=20
> I agree entirely and would be all too excited to see this happening.
> I already had ideas too:
>=20
>   In addition to the standard tree and parent pointers, there could
>   be *-ref and x-*-ref headers, which take a single ref argument,
>   presumably to a blob containing more data.

I'm not sure how well-defined that is, though. What does the ref mean?
What does it point to, and what is the meaning with respect to the
original commit? Or are you suggesting that "*" would be "topgit-base"
here, and that git core would understand only that any header matching
the pattern "x-*-ref" should be followed with respect to
reachability/pruning. Only the owner of the "*" part (topgit in this
case) would be able to make sense of the meaning of the ref.

If that is the case, that does make sense to me. It's basically an
immutable version of a note.

However, implementing such a thing would mean you have an awkward
transition period where some versions of git think the referenced objec=
t
is relevant, and others do not. That's something we can overcome, but
it's going to require code in git, and possibly a dormant introduction
period.

I suspect you would give git people more warm fuzzies about implementin=
g
this by showing a system that is built on git-notes and saying "this
works really well, except that the external note storage is not a good
reason because { it's mutable, it's not efficient, whatever other reaso=
n
you find}". And then we know that the system is proven to work, and tha=
t
migrating the note-like structure into the object is sensible.

But I get the impression you're one step back from that now. So it make=
s
sense to me to at least prototype it via git-notes, which will give you
the same semantic storage (a mapping of commits to some blobs, with
reachability handled automatically).

> > Otherwise, the usual recommendation is to use a pseudo-header
> > within the body of the commit message (i.e., "Topgit-Base: ..." at
> > the end of the commit message). The upside is that it's easy to
> > create, manipulate, and examine using existing git tools. The
> > downside is that it is something that the user is more likely to
> > see in "git log" or when editing a rebased commit message.
>=20
> =E2=80=A6 to see *and to accidentally mess up*. And while that may ev=
en be
> unlikely, it does expose information that really ought to be hidden.

I'm not quite sure what the information is, so I can't really judge. Do
you have a concrete example?

I got the impression earlier you were wanting to store a human-readable
text string.  That makes a pseudo-header a reasonable choice. But if yo=
u
are going to reference some blob (which it seems from what you wrote
above), and you are interested in proper reachability analysis, then no=
,
it probably isn't a good idea.

> I can see how it's arguable too why one would want to give git
> commit objects the ability to reference arbitrary blobs containing
> additional information. I suppose the answer to this question is
> related to the answer to the question of whether Git is
> a contained/complete tool as-is, or also serves as
> a "framework"/"toolkit" for advanced/creative use.
>=20
> The availability of the porcelain commands seems to suggest that
> extensible/flexible additional features should be welcome! ;)

I think extensibility is welcome. It's just that most discussions so fa=
r
have ended up realizing that a new header would just be cruft. Maybe
yours is different. I'm still not 100% sure I understand what you want
to accomplish, but the idea of an x-*-ref header is a reasonable thing
for git to have.

-Peff
