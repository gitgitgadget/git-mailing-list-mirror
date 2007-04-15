From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Correct dir.c to compile on Solaris 9
Date: Sun, 15 Apr 2007 23:54:53 +0200
Organization: Dewire
Message-ID: <200704152354.55097.robin.rosenberg.lists@dewire.com>
References: <20070415043328.GA17285@spearce.org> <Pine.LNX.4.64.0704151824240.18846@racer.site> <200704152303.12435.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 23:51:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdCdH-0003Rw-I1
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 23:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbXDOVvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Apr 2007 17:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbXDOVvf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 17:51:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13776 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753985AbXDOVvf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2007 17:51:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5935680286E;
	Sun, 15 Apr 2007 23:45:48 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03039-02; Sun, 15 Apr 2007 23:45:48 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id E540D802657;
	Sun, 15 Apr 2007 23:45:47 +0200 (CEST)
User-Agent: KMail/1.9.4
In-Reply-To: <200704152303.12435.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44532>

s=F6ndag 15 april 2007 23:03 skrev Josef Weidendorfer:
> On Sunday 15 April 2007, Johannes Schindelin wrote:
> > On Sun, 15 Apr 2007, Shawn O. Pearce wrote:
> > >  static int simple_length(const char *match)
> > >  {
> > > -	const char special[256] =3D {
> > > -		[0] =3D 1, ['?'] =3D 1,
> > > -		['\\'] =3D 1, ['*'] =3D 1,
> > > -		['['] =3D 1
> > > -	};
> > >  	int len =3D -1;
> > > =20
> > >  	for (;;) {
> > >  		unsigned char c =3D *match++;
> > >  		len++;
> > > -		if (special[c])
> > > +		switch (c) {
> > > +		case 0: case '?':
> > > +		case '\\': case '*':
> > > +		case '[':
> > >  			return len;
> > > +		}
> > >  	}
> > >  }
> >=20
> > You are replacing a table-based check with a switch based, which mi=
ght be=20
> > substantially slower (depends on how often cmp_name() is called).
>=20
> Or faster. When the table gives a cache miss and has to be
> loaded from main memory, I am quite sure that 5 compares in a row are
> faster than the cache miss.
It is five compares time the length of the path being examined. The cac=
he miss
only occurs once per invocation even inthe worst case.  Judging from wh=
ere
the code is invoked, cache misses should be rare which means the table =
is much
faster.=20

As for the table being a micro-optimization, that still holds true=20

>=20
> Actually, with the switch, the compiler is free to implement it with =
a
> table (and gcc usually does this, probably even using a substantially
> smaller table). The table-based check in contrast looks
It usually uses binary search. For gcc to create a lookup table you'll =
need
a large number of case's.
> like some kind of micro-optimization which makes the code IMHO more
> difficult to read, and which only would be justified with meassured
> improvements.

The table lookup *is* faster (meastured), but that doesn't make a big d=
ifference
on the total CPU used. The muliple-case-per line thing (both versions, =
however makes is hard
to read. =20

-- robin

diff --git a/dir.c b/dir.c
index 7426fde..0780f23 100644
--- a/dir.c
+++ b/dir.c
@@ -423,12 +423,22 @@ static int cmp_name(const void *p1, const void *p=
2)
  */
 static int simple_length(const char *match)
 {
-       const char special[256] =3D {
-               [0] =3D 1, ['?'] =3D 1,
-               ['\\'] =3D 1, ['*'] =3D 1,
-               ['['] =3D 1
-       };
        int len =3D -1;
+       static const char special[256] =3D {
+               1,0,0,0,0,0,0,0, /* nul */
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,0,
+               0,0,1,0,0,0,0,0, /* * */
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,1, /* ? */
+
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,0,
+               0,0,0,0,0,0,0,0,
+               0,0,0,1,1,0,0,0  /* [ \ */
+       };

        for (;;) {
                unsigned char c =3D *match++;
