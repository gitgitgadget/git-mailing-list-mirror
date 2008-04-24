From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to fetch missing pack
Date: Thu, 24 Apr 2008 02:08:57 -0400
Message-ID: <20080424060857.GX29771@spearce.org>
References: <slrng019fg.nd8.joerg@alea.gnuu.de> <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de> <200804240801.13674.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: =?utf-8?B?SsO2cmc=?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:09:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoueU-0002wS-Ut
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 08:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYDXGJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 02:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbYDXGJF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 02:09:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53027 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYDXGJE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2008 02:09:04 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Joudg-0003y9-89; Thu, 24 Apr 2008 02:09:00 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67AD420FBAE; Thu, 24 Apr 2008 02:08:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200804240801.13674.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80292>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Le mercredi 23 avril 2008, J=C3=B6rg Sommer a =C3=A9crit :
> > Peter Baumann <waste.manager@gmx.de> wrote:
> > >
> > > Try using git fsck --full to check you repo. If you are missing s=
ome
> > > objects, you could just grab them from another valid repo which s=
till
> > > has them.
> >
> > How can I exctract single objects from a pack?
>=20
> Please have a look at this:
>=20
> http://git.or.cz/gitwiki/GitFaq#head-ac11406480d09e2df98588e800e41b72=
56602074

If you know the name of the objects you are missing, you can
make a temporary pack to transfer the list of objects:

	# at good repo
	#
	git pack-objects --stdout <object.list >save.pack

	# at bad repo
	#
	git index-pack --stdin <save.pack

Make object.list just one SHA-1 per line.  The resulting pack is
not likely to be highly compressed, as it will probably contain
a non-delta version of each object, but its faster to create than
calling git-cat-file for each object, and may give you a smaller
pack than just copying everything as the FAQ entry recommends.

Note that you may need to do this several times; e.g. if you are
missing a tree you won't know what blobs you are missing until
you load the tree and run fsck --full again to parse the tree and
discover the missing blobs.  This iterative copying approach is
what the FAQ avoids when it suggests you copy everything.

--=20
Shawn.
