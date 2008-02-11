From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Mon, 11 Feb 2008 20:56:23 +0100
Message-ID: <20080211195623.GA21878@auto.tuwien.ac.at>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:57:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOelw-0004Gf-Ru
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbYBKT40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Feb 2008 14:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756606AbYBKT40
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:56:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40981 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756523AbYBKT4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:56:25 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 7A980680BF62;
	Mon, 11 Feb 2008 20:56:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j2-+Z7R+rJFS; Mon, 11 Feb 2008 20:56:23 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 56757680BED8; Mon, 11 Feb 2008 20:56:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802101929310.2732@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73576>

On Sun, Feb 10, 2008 at 07:33:34PM -0500, Nicolas Pitre wrote:
> On Sun, 10 Feb 2008, Junio C Hamano wrote:
>=20
> > mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
> >=20
> > > This patch adds a cache to keep the object data in memory. The de=
lta
> > > resolving code must also search in the cache.
> >=20
> > I have to wonder what the memory pressure in real-life usage
> > will be like.

> FWIW, I don't like this idea.
>
> I'm struggling to find ways to improve performances of=20
> pack-objects/index-pack with those large repositories that are becomi=
ng=20
> more common (i.e. GCC, OOO, Mozilla, etc.)  Anything that increase=20
> memory usage isn't very welcome IMHO.

Maybe I have missed something, but all repack problems reported on the
git mailing list happen durring the deltifing phase. The problematic
files are mostly bigger blobs. I'm aware of these problems, so my
patch does not keep any blobs in memory.

As we are talking about memory, let's ignore unpack-objects, which is
used for small packs. Lets compare the memory usage of index-pack to
pack-objects:

If it is disabled (no --strict passed), only a (unused) pointer for
each object in the received pack file is additionally allocated.

On i386, struct object_entry is 84 bytes in pack-objects, but only 52
in index-pack. Both programs keep a struct object_entry for each
object during the runtime in memory. So in this case, index-pack uses
less memory than pack-objects

If the --strict option is passed, more memory is used:

* Again, we add one pointer to struct object_entry. object_entry is
  still smaller.(52<84 bytes).

* index-pack allocates a struct blob/tree/commit/tag for each object in=
 the pack.

  pack-objects also allocates only struct object in the best case
  (reading from pack file), otherwise a struct
  blob/tree/commit/tag. This objects are kept during the runtime of
  pack-objects in memory.

  So depending of the parameters of pack-objects, index-pack uses
  additionally up to 24 bytes per object, but struct object_entry is 32
  bytes smaller.

* index-pack allocates a struct blob/tree/commit/tag for each link to a=
 object outside the pack.

  I don't know the code of pack-objects enough to say something to
  this point.

* index-pack keeps the data for each tag/tree/commit in the pack in mem=
ory

  In the next version, I don't need to keep the tag/commit data in
  memory. Tree data could be reconstructed from the written pack,
  but I'm not sure, if the additional code (resolving deltas again),
  would justify the additional memory usage.

So my conclusion is, that the memory usage of index-pack with --strict
should not be too worse compared to pack-objects.

Please remember, that --strict is used for pushing data.

mfg Martin K=F6gler
