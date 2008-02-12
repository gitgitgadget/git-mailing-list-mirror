From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Tue, 12 Feb 2008 22:38:58 +0100
Message-ID: <20080212213858.GA29151@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080212190411.GA23837@auto.tuwien.ac.at> <alpine.LFD.1.00.0802121507310.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP2qv-0001qz-IN
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 22:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbYBLVjI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 16:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbYBLVjH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 16:39:07 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:54213 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYBLVjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 16:39:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 94CD7680BEB9;
	Tue, 12 Feb 2008 22:38:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eukx9eTmZi4g; Tue, 12 Feb 2008 22:38:58 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 6F27968018E6; Tue, 12 Feb 2008 22:38:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802121507310.2732@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73696>

On Tue, Feb 12, 2008 at 03:22:17PM -0500, Nicolas Pitre wrote:
> On Tue, 12 Feb 2008, Martin Koegler wrote:
> > We will need some additional memory for struct blob/tree/tag/commit
> > even for this check.
>=20
> Why so?
>=20
> Each received object is stored in memory when received, so why can't =
you=20
> simply validate it in place?  No need to keep trace of them afterward=
=2E

=46reeing the data is not my problem.

Many validations are in parse_XXX_buffer, which are also used by
fsck. This returns a struct commit/tree/tag/blob.

I have not found any code in git to free them.=20

Same for pack-objects, e.g. add_objects_in_unpacked_packs allocates
many struct object via lookup_unknown_object. As far as I understand
the code, they are never freed, even if they are not needed later.

> > > As to making sure those objects are well connected... well this i=
s a=20
> > > technically different issue entirely, and I wonder if a special m=
ode to=20
> > > fsck might not be a better solution.  For example, fsck could be =
made to=20
> > > validate object connectivity, starting from the new ref(s), and s=
topping=20
> > > object walking as soon as a reference to an object not included i=
n the=20
> > > newly received pack is encountered.  This could be run from some =
hook to=20
> > > decide whether or not to update the new refs, and to delete the p=
ack=20
> > > otherwise.
> >=20
> > Do you really think, that this will need less memory? fsck loads fi=
rst
> > all objects and then verifies their connections.
>=20
> Not all objects otherwise I wouldn't even be able to run it.

It only loads all objects, it checks (eg. no objects from the pack file
by default). After loading a object, it frees the content of object,
but keeps the parsed information in memory for the connectivity check.

> My point is that you can have fsck load only objects contained in the=
=20
> received pack (you can use the pack index to load them) and assume=20
> connectivity is good whenever an object in the pack reference an=20
> existing object outside of the pack.  At least this doesn't need to=20
> happen in parallel with pack indexing.

So you propose the following:
1) run index-pack (write pack file + index in repository)
2) fsck pack file
3) update refs

This looks to be very prone to race conditions, if multiple
pushes run concurrently.

To be on the safe side, the checks must be finished, before a pack/obje=
ct
becomes part of the repository. We must check the reachability before=20
index-pack writes the index.

In my opinion, separating the code for the reachability check from
index-pack would complicate things. It would not safe memory, as the
memory would be used by two processes instead of one.

You don't want to increase the resource usage of index-pack. If
--strict is not passed, I implemented this.=20

=46or --strict, it is not avoidable, that index-pack will use more
memory and cpu time.

mfg Martin K=F6gler
