From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Wed, 13 Feb 2008 09:11:29 +0100
Message-ID: <20080213081128.GA27730@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 09:12:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCit-000308-Ui
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 09:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872AbYBMILc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 03:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756751AbYBMILc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 03:11:32 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:37314 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592AbYBMILb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 03:11:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 302EF680B581;
	Wed, 13 Feb 2008 09:11:29 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cQDOwLypH26f; Wed, 13 Feb 2008 09:11:29 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 0E3C668018E6; Wed, 13 Feb 2008 09:11:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080213074209.GG24004@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73751>

On Wed, Feb 13, 2008 at 02:42:09AM -0500, Shawn O. Pearce wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > I think this is a good idea to always have some sanity checks on an=
y=20
> > incoming objects so to make sure they're well formed and valid befo=
re=20
> > giving them a SHA1 value, and bail out as soon as any error is foun=
d. =20
>=20
> When we get the raw data for an object so we can compute its SHA-1
> and/or write its loose object to disk we should first verify its
> content is sane, then do the SHA-1/store loose.
>=20
[...]
> > As to making sure those objects are well connected... well this is =
a=20
> > technically different issue entirely, and I wonder if a special mod=
e to=20
> > fsck might not be a better solution.
>=20
> Nah, just do what quickfetch does in builtin-fetch.c, but run it
> in receive-pack, between unpack() and execute_commands():
>=20
> 	rev-list --quiet --objects $new... --not --all
>=20
> If it aborts, reachability testing failed and the push is rejected
> without updating any refs.  Yes your repository now has objects
> that are missing things, but none of those are considered to be
> reachable, so this isn't a big deal.  They will get cleaned up on
> the next `gc --prune`, whenever that is.

This would mean, that we must make git-rev-list and git-pack-objects
not segfault on incorrect links between objects.

> In this configuration (--quiet) rev-list tries to be pretty low
> on its memory usage, it doesn't save buffers, etc.  Further since
> everything that is already considered reachable is not interesting,
> we are only doing a walk over the objects that we just received,
> not our entire ODB.  Its also after index-pack exited, so we just
> freed up a good chunk of memory.
>=20
> Rememeber we are talking about receive-pack here.  The cost on
> the to perform the rev-list is lower than the cost will be to pack
> these objects for distribution back to just one client.  Since this
> is a server of some sorts (otherwise why did you push here?), odds
> are its going to be doing a lot of packing requests for clients to
> receive these newly uploaded objects by the native git protocol.
> This new rev-list is nothing compared to that already existing load.
> And if your OS is any good the just created .idx and .pack is still
> in OS buffer cache, so there shouldn't be any additional disk IO.
>=20
> Yes, we could make this optional in receive-pack, but really I don't
> see a reason to.  Just run it.  The client shouldn't be giving us
> unreachable crap.

Looks sane to me.

mfg Martin K=F6gler
