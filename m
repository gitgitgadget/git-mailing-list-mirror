From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 4/6] Add tags to the graphical history display.
Date: Mon, 6 Oct 2008 15:14:21 -0700
Message-ID: <20081006221421.GA13687@spearce.org>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com> <20081006080834.GC27516@spearce.org> <200810062358.44954.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmyMY-0001QG-Lb
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYJFWOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 18:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbYJFWOW
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:14:22 -0400
Received: from george.spearce.org ([209.20.77.23]:41627 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbYJFWOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 18:14:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16BE53835F; Mon,  6 Oct 2008 22:14:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200810062358.44954.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97637>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> m=C3=A5ndagen den 6 oktober 2008 10.08.34 skrev Shawn O. Pearce:
> > Maybe PlotWalk should override next() [...]
>=20
> I missed something here I think. Thanks. Maybe I thought... doesn't m=
atter.
> I'll rewrite the changes in and related to this completely.

OK, looking forward to the changes.
=20
> > > @@ -54,6 +66,7 @@
> > >  	public PlotWalk(final Repository repo) {
> > >  		super(repo);
> > >  		super.sort(RevSort.TOPO, true);
> > > +		reverseRefMap =3D repo.getAllRefsByPeeledObjectId();
> >=20
> > I wonder if this shouldn't be done as part of the StartGenerator
> > (or something like it but specialized for PlotWalk).  I only say
> > that because a reused PlotWalk may want to make sure its ref map
> > is current with the repository its about to walk against.
>
> noted.

Be careful.  StartGenerator is package access only and I think
PlotWalk is in a different package.

IMHO binding into the StartGenerator (by subclassing it and replacing
it) feels like the right thing to me, but it means making a bunch
of changes to RevWalk and StartGenerator to make that type public
and allow PlotWalk to inject a different subclass of StartGenerator
for itself.

The StartGenerator trick is very useful though; it allows the RevWalk
to perform init activity only on the first invocation of next()
and then removes the init code entirely from the call path.  It is a
virtual dispatch, but I figured its a virtual dispatch anyway due to
the way the other generators are chained together based the filters
so we at least avoid a "if (first) {...}" test on every call to next.
=20
> > You are inside of a PlotWalk, which extends RevWalk, which has very
> > aggressive caching of RevCommit and RevTag data instances, and very
> > fast parsers.  Much faster than the legacy Commit and Tag classes.
>
> Maybe we should rid us of them completely and make new commit from
> these classes of possible more lightweight ones. The old classes were
> straightforward but are on overtime now.

I'm trying to go in that direction.  However there are three reasons
why we aren't ready yet:

- Commits can only be made by the old-style Commit class.
- Tags can only be made by the old-style Tag class.
- Trees can only be made by the old-style Tree class.

I have some experimental code in my merge branch to solve the last
one by teaching DirCache how to write out the index and update the
cache trees with the ObjectIds of the newly created trees, but I
have not had a chance to clean the patches up with test cases and
docs to submit to the git ML yet.

So I'm actively working on fixing the last item.

Oh, and of course existing callers have to be converted.  But I am
trying to avoid introducing new callers.
=20
> As you noted earlier we usually have at most one ref per commit to so=
rt.
> Not much to optimize for speed here with current repos. For a one-ele=
ment=20
> list the compare routine wil not even be invoked.

Oh, good point.
=20
> > In hindsight those RevCommit[] probably should be a List<RevCommit>
> > with different list implementations based on the number of parents
> > needed:
> >=20
> > 	0 parents:  Collections.emptyList()
> > 	1 parent:   Collections.singletonList()
> > 	2 parents:  some especialized AbstractList subclass
> > 	3 parents:  ArrayList
>
> I guess measuring is the right way. For these small arrays, my bet
> is that List is way faster because we do not need any bounds checking=
=2E
> Hotspot is reasonably good at optimizing those away, but that won't
> help for much small arrays.

Yup.  Its something to explore.  But I lack the time right now so
I'm going going to be making any changes and measuring it anytime
soon.  ;-)

Maybe someone who wants to get involved can look at this.  Or any
other number of issues we still have open.

But without measurements to back up the code either way I won't be
making changes to what we have right now.
=20
--=20
Shawn.
