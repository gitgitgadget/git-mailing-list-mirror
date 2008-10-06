From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 4/6] Add tags to the graphical history display.
Date: Mon, 6 Oct 2008 23:58:44 +0200
Message-ID: <200810062358.44954.robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-5-git-send-email-robin.rosenberg@dewire.com> <20081006080834.GC27516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmy8o-0005CF-MY
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYJFWAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbYJFWAL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:00:11 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20181 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754314AbYJFWAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 18:00:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D8741802662;
	Tue,  7 Oct 2008 00:00:07 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTAeuRwAiqax; Mon,  6 Oct 2008 23:59:54 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 07B36800250;
	Mon,  6 Oct 2008 23:59:53 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20081006080834.GC27516@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97635>

m=C3=A5ndagen den 6 oktober 2008 10.08.34 skrev Shawn O. Pearce:
> FYI, my comments don't fully cover this patch yet.
>=20
> > -	protected PlotCommit(final AnyObjectId id) {
> > +	protected PlotCommit(final AnyObjectId id, final Ref[] tags) {
> >  		super(id);
> > +		this.refs =3D tags;
>=20
> this.refs isn't final.  There is no reason to be adding it to the
> constructor and having this ripple effect all the way up into the
> RevWalk class.
Eh, it doesn't, ecept I added a methos to RevWalk than can return tags,
which it doesn't unless the information is attached.

> Maybe PlotWalk should override next() and only set PlotCommit.refs on
> things returned from super.next()?  This way we only do tag lookup
> on commits that the filtering rules have said should be shown in
> to the application, but the refs should still be inserted prior to
> the application seeing the RevCommit.

I missed something here I think. Thanks. Maybe I thought... doesn't mat=
ter.
I'll rewrite the changes in and related to this completely.

> > @@ -54,6 +66,7 @@
> >  	public PlotWalk(final Repository repo) {
> >  		super(repo);
> >  		super.sort(RevSort.TOPO, true);
> > +		reverseRefMap =3D repo.getAllRefsByPeeledObjectId();
>=20
> I wonder if this shouldn't be done as part of the StartGenerator
> (or something like it but specialized for PlotWalk).  I only say
> that because a reused PlotWalk may want to make sure its ref map
> is current with the repository its about to walk against.
noted.

> You are inside of a PlotWalk, which extends RevWalk, which has very
> aggressive caching of RevCommit and RevTag data instances, and very
> fast parsers.  Much faster than the legacy Commit and Tag classes.
Maybe we should rid us of them completely and make new commit from
these classes of possible more lightweight ones. The old classes were
straightforward but are on overtime now.

> I think we should use the RevCommit and RevTag classes to handle
> sorting here.  RevCommit already has the committer time cached
> and stored in an int.  RevCommit probably should learn to do the
> same for its "tagger" field.  The tiny extra bloat (1 word) that
> adds to a RevTag instance is worth it when we consider implementing
> something like this and/or git-describe where sorting tags by their
> dates is useful.

As you noted earlier we usually have at most one ref per commit to sort=
=2E
Not much to optimize for speed here with current repos. For a one-eleme=
nt=20
list the compare routine wil not even be invoked.

>=20
> > +			tags =3D list.toArray(new Ref[list.size()]);
>=20
> I wonder if using a Ref[] here even makes sense given that the data
> is stored in a List<Ref>.  I use RevCommit[] inside of RevCommit
> generally because the number of entries in the array is 1 or 2 and
> the array is smaller than say an ArrayList.
>=20
> In hindsight those RevCommit[] probably should be a List<RevCommit>
> with different list implementations based on the number of parents
> needed:
>=20
> 	0 parents:  Collections.emptyList()
> 	1 parent:   Collections.singletonList()
> 	2 parents:  some especialized AbstractList subclass
> 	3 parents:  ArrayList
>=20
> I think it would actually use less memory per instance, which is
> a huge bonus, but we'd pay a downcasting penalty on each access.
> HotSpot is supposed to be really good at removing the downcast
> penalty from say java.util.List, but I don't if it can beat a typed
> array access.
I guess measuring is the right way. For these small arrays, my bet
is that List is way faster because we do not need any bounds checking.
Hotspot is reasonably good at optimizing those away, but that won't
help for much small arrays.

> Sorry I got off on a bit of a tangent here.  I'm just trying to
> point out that the primary reason I've usd an array before is
> probably moot here since the data is already in a List.
Could it be that arrays are often better then lists.

> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.=
java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> > index d7e4c58..41d57c6 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
> > @@ -53,6 +53,7 @@
>=20
> IMHO this class shouldn't need to be modified.
>=20
> > @@ -541,7 +542,7 @@ public RevTree lookupTree(final AnyObjectId id)=
 {
> >  	public RevCommit lookupCommit(final AnyObjectId id) {
> >  		RevCommit c =3D (RevCommit) objects.get(id);
> >  		if (c =3D=3D null) {
> > -			c =3D createCommit(id);
> > +			c =3D createCommit(id, getTags(id));
>=20
> This code is performance critical to commit parsing.  Trying to
> lookup tags for every commit we evaluate, especially ones that we
> will never show in the UI (because they are uninteresting) but that
> we still need to parse in order to derive the merge base is just
> a huge waste of time.
>=20
> Same applies for the lookupAny and parseAny methods.
>=20
Ack.

-- robin
