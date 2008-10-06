From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 3/6] Add a method to get refs by object Id
Date: Tue, 7 Oct 2008 00:37:53 +0200
Message-ID: <200810070037.53841.robin.rosenberg@dewire.com>
References: <1223249802-9959-1-git-send-email-robin.rosenberg@dewire.com> <1223249802-9959-4-git-send-email-robin.rosenberg@dewire.com> <20081006081554.GD27516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:40:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmykc-0000NE-If
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYJFWjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 18:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753569AbYJFWjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:39:16 -0400
Received: from [83.140.172.130] ([83.140.172.130]:20439 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbYJFWjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 18:39:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 116CA802662;
	Tue,  7 Oct 2008 00:39:14 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPStS1EHq7fu; Tue,  7 Oct 2008 00:39:02 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id ACD9C800250;
	Tue,  7 Oct 2008 00:39:02 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20081006081554.GD27516@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97640>

m=C3=A5ndagen den 6 oktober 2008 10.15.54 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.j=
ava b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > index dfce1b8..3fc5236 100644
> > --- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > +++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
> > @@ -939,6 +940,33 @@ public String getBranch() throws IOException {
> >  	}
> > =20
> >  	/**
> > +	 * @return a map with all objects referenced by a peeled ref.
> > +	 */
> > +	public Map<AnyObjectId, List<Ref>> getAllRefsByPeeledObjectId() {
>=20
> Do we really want to promise List here?  Can we make it just
> Collection instead?
Sure. Our promise is actually slightly better, it is Set, but Java does=
n't have a suitable class for that.

>=20
> > +		Map<String, Ref> allRefs =3D getAllRefs();
> > +		HashMap<AnyObjectId, List<Ref>> ret =3D new HashMap<AnyObjectId,=
 List<Ref>>(allRefs.size());
> > +		for (Map.Entry<String,Ref> e : allRefs.entrySet()) {
> > +			Ref ref =3D e.getValue();
>=20
> I think this is cleaner:
>=20
> 	for (Ref ref : allRefs.values()) {
>=20
> as you never use the key.
Yes. I was thinking it might be less efficient, but the JDK implementat=
ion looks quite well optimized in 1.6 at least
so values() is slightly faster.

> > +			AnyObjectId target =3D ref.getPeeledObjectId();
> > +			if (target =3D=3D null)
> > +				target =3D ref.getObjectId();
> > +			List<Ref> list =3D ret.get(target);
> > +			if (list =3D=3D null) {
> > +				list =3D Collections.singletonList(ref);
> > +			} else {
> > +				if (list.size() =3D=3D 1) {
> > +					ArrayList<Ref> list2 =3D new ArrayList<Ref>(2);
> > +					list2.add(list.get(0));
> > +					list =3D list2;
> > +				}
> > +				list.add(ref);
> > +			}
> > +			ret.put(target, list);
>=20
> Hmm.  Putting the list every time is pointless.  This is may run
> faster because we (on average) only do one hash lookup per target,
> not 2:
>=20
> 	List<Ref> nl =3D Collections.singletonList(ref);
> 	List<Ref> ol =3D ret.put(target, nl);
> 	if (ol !=3D null) {
> 		if (ol.size() =3D=3D 1) {
> 			nl =3D new ArrayList<Ref>(2);
> 			nl.add(ol.get(0));
> 			nl.add(ref);
> 			ret.put(target, nl);
> 		} else {
> 			ol.add(ref)
> 			ret.put(target, ol);
> 		}
> 	}

ok, I guess one just has has to include the comment on why for the casu=
al reader.=20

-- robin
