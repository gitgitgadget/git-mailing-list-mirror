From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Mon, 13 Jun 2011 18:27:34 -0400
Message-ID: <20110613222734.GD21390@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <BANLkTinfVNxYX3kj4DBm1ra=8Ar5ca9UvQ@mail.gmail.com>
 <BANLkTi=PnYmJVXe8tuqdb9UiYnethf1GSw@mail.gmail.com>
 <4DF0EC32.40001@gmail.com>
 <BANLkTimk06eibz99AO_0BwzoL6FWb5pR8A@mail.gmail.com>
 <20110609162604.GC25885@sigill.intra.peff.net>
 <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git <git@vger.kernel.org>
To: NAKAMURA Takumi <geek4civic@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWFbg-0006FK-EC
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 00:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661Ab1FMW1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jun 2011 18:27:35 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab1FMW1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 18:27:35 -0400
Received: (qmail 17863 invoked by uid 107); 13 Jun 2011 22:27:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 18:27:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 18:27:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimEGjBMrbQpkZfWYPTZ93syiKFHdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175735>

On Fri, Jun 10, 2011 at 12:59:47PM +0900, NAKAMURA Takumi wrote:

> 2011/6/10 Stephen Bash <bash@genarts.com>:
> > I've seen two different workflows develop:
> > =C2=A01) Hacking on some code in Git the programmer finds something=
 wrong. =C2=A0Using Git tools he can pickaxe/bisect/etc. and find that =
the problem traces back to a commit imported from Subversion.
> > =C2=A02) The programmer finds something wrong, asks coworker, cowor=
ker says "see bug XYZ", bug XYZ says "Fixed in r20356".
> >
> > I agree notes is the right answer for (1), but for (2) you really w=
ant a cross reference table from Subversion rev number to Git commit.
>=20
> It is the point I wanted to say, thank you! I am working with svn-men=
=2E
> They often speak svn revision number. (And I have to tell them svn
> revs then)

Yeah, there is no simple way to do the bi-directional mapping in git.
If all you want are decorations on commits, notes are definitely the wa=
y
to go. They are optimized for lookup in of commit -> data. But if you
want data -> commit, the only mapping we have is refs, and they are not
well optimized for the many-refs use case.

Packed-refs are better than loose refs, but I think right now we just
load them all in to an in-memory linked list. We could load them into a
more efficient in-memory data structure, or we could perhaps even mmap
the packed-refs file and binary search it in place.

But lookup is only part of the problem. There are algorithms that want
to look at all the refs (notably fetching and pushing), which are going
to be a bit slower. We don't have a way to tell those algorithms that
those refs are uninteresting for reachability analysis, because they ar=
e
just pointing to parts of the graph that are already reachable by
regular refs. Maybe there could be a part of the refs namespace that is
ignored by "--all". I dunno. That seems like a weird inconsistency.

> FYI, I have tweaked git-rev-list for commits not to sort by date with
> --quiet. It improves git-fetch (git-rev-list --not --all) performance
> when objects is well-packed.

I'm not sure that is a good solution. Even with --quiet, we will be
walking the commit graph to find merge bases to see if things are
connected. The walking code expects date-sorting; I'm not sure what
changing that assumption will do to the code.

-Peff
