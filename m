From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Wed, 13 Feb 2008 08:39:59 +0100
Message-ID: <20080213073959.GA27158@auto.tuwien.ac.at>
References: <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080212190411.GA23837@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121507310.2732@xanadu.home> <20080212213858.GA29151@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121645121.2732@xanadu.home> <20080213062015.GF24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 08:40:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCET-0002nD-E3
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 08:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249AbYBMHkD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 02:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbYBMHkD
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 02:40:03 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40983 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbYBMHkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 02:40:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5852A680BED8;
	Wed, 13 Feb 2008 08:39:59 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VCOuLcuqbGJn; Wed, 13 Feb 2008 08:39:59 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2928668018E6; Wed, 13 Feb 2008 08:39:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080213062015.GF24004@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73747>

On Wed, Feb 13, 2008 at 01:20:15AM -0500, Shawn O. Pearce wrote:
>   tree.c:
>=20
>     This is inside track_tree_refs and its a file mode we do
>     not recognize.  We spit out a warning, but try to lookup
>     the unknown object anyway, even though we're looking at what
>     should be a bogus tree.  This occurs only in parse_tree_buffer,
>     only if track_objects_refs is on, and only if we see a tree
>     that is actually not understood by this version of Git.  Hmm,
>     shouldn't happen unless the tree itself is corrupt.
>=20
>     This code looked fishy enough to me to dig up the blame history
>     for it:
>=20
>       commit e2ac7cb5fbcf1407003aa07cdcd14141527ea2e3
>       Author: Sam Vilain <sam.vilain@catalyst.net.nz>
>       Date: Wed Jun  6 06:25:17 2007
>=20
>       Don't assume tree entries that are not dirs are blobs
>=20
>       When scanning the trees in track_tree_refs() there is a "lazy" =
test
>       that assumes that entries are either directories or files.  Don=
't do
>       that.
>=20
>     Sounds like it was around the time of S_ISGITLINK being
>     introduced.  Looking at this code again I have to wonder, why
>     the hell are we looking up and tracking an object inside of a
>     tree when we don't understand the mode?
>=20
>     Lets say a new form of S_ISGITLINK gets introduced in the future.
>     By this I mean the mode says "hey, this SHA-1 isn't really in my
>     object pool".  We're going to cram a dummy object into the refs
>     table for this tree.  Why?  We don't do this for S_ISGITLINK.
>=20
>     Lets say its a new object type (not tree/tag/commit/blob) but
>     it is in our storage pool.  If this Git doesn't know the mode,
>     it sure as heck won't know what the hell the loose object header
>     (or pack header!) says about that object.
>=20
>     One of the key places where you might expect tracking an unknown
>     (but referenced by a tree) SHA-1 type would be in reachability,
>     rev-list --objects, packfile generation.  But the process_tree()
>     function in reachable.c doesn't have Sam's change above, so it
>     will assume anything new looking is a blob.
>    =20
>     Oh, and what a rabbit hole I just fell down.  The only caller
>     that seems to set "track_object_refs =3D 1" (and thus get into th=
is
>     odd lookup_unknown_object() call) is fsck.  Everyone else sets
>     it to 0, including its default declaration.
>=20
>     So we've got this nice baggage, and differing implementation,
>     so fsck can be happy how?  We've also got a whole lot of apps
>     setting "track_object_refs =3D 0", which is what it defaults to,
>     unless you managed to run fsck first.  Hmmph.
>=20
>     Is it just me or is track_object_refs perhaps outlived its
>     usefulness?

See the patch at the start of this topic. I'm working on replacing
track-object-refs.

It is missing some frees and I copied the lookup_unknown_object call
(This should be replaced with an error message in my patch, as the the
verification of the tree content would reject such an invalid mode).

mfg Martin K=F6gler
