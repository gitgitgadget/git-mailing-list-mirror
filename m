From: Keith Packard <keithp@keithp.com>
Subject: Re: observations on parsecvs testing
Date: Thu, 15 Jun 2006 15:03:26 -0700
Message-ID: <1150409006.30681.132.camel@neko.keithp.com>
References: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PlVbTIwL/bWdSRqQ7HAT"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 00:04:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqzwP-0003ty-3a
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 00:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWFOWDu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 18:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWFOWDu
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 18:03:50 -0400
Received: from home.keithp.com ([63.227.221.253]:58894 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750700AbWFOWDt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 18:03:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id AE06F13001F;
	Thu, 15 Jun 2006 15:03:48 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 30295-06-2; Thu, 15 Jun 2006 15:03:48 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 595AD13001E; Thu, 15 Jun 2006 15:03:48 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EF42614001;
	Thu, 15 Jun 2006 15:03:47 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 6E59754337; Thu, 15 Jun 2006 15:03:27 -0700 (PDT)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606151529350.16002@localhost.localdomain>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21916>


--=-PlVbTIwL/bWdSRqQ7HAT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-15 at 16:37 -0400, Nicolas Pitre wrote:
> My machine is a P4 @ 3GHz with 1GB ram.
>=20
> Feeding parsecvs with the Mozilla repository, it first ran for 175=20
> minutes with about 98% CPU spent in user space reading the 100458 ,v=20
> files and writing 700000+ blob objects.  Memory usage grew to 1789MB=20
> total while the resident memory saturated around 700MB.  This part was=20
> fine even with 1GB of ram since unused memory was gently pushed to swap. =
=20
> Only problem is that spawned git-pack-object instances started failing=20
> with memory allocation by that time, which is unffortunate but not=20
> fatal.

Right, the ,v -> blob conversion process uses around 160 bytes per
revision as best I can count (one rev_commit, one rev_file and=20
a 41-byte sha1 string); 700000 revisions would therefore use 1.1GB just
for the revision objects. It should be possible to reduce the size of
this data structure fairly significantly; converting the sha1 value to
binary and compressing the CVS revision number to minimal length.
Switching from the general git/cvs structure to this cvs-specific
structure is 'on the list' of things I'd like to do.

> But then things started to go bad after all ,v files were parsed.  The=20
> parsecvs dropped to 3% CPU while the rest of the time was spent waiting=20
> after swap IO and therefore no substantial progress was made at that=20
> point.

Yeah, after this point, parsecvs is merging the computed revision
historys of the individual files into a global history. This means it's
walking across the whole set of files to compute each git commit. For
each branch, it computes the set of files visible at the head of that
branch and then sorts the last revision of the visible files to discover
the last change set along that branch, constructing a commit for each
logical changeset backwards from the present into the past. As it's
constructing commits from the present backwards, it must go all the way
to the past before it can emit any commits to the repository. So, it has
to save them somewhere; right now, it's saving them in memory. What it
could do is construct tree objects for each commit, saving only the sha1
that results and dump the rest of the data. That should save plenty of
memory, but would require a radical restructuring of the code (which is
desparately needed, btw). With this change, parsecvs should actually
*shrink* over time, instead of grow.

> So the Mozilla clearly requires 2GB of ram to realistically be converted=20
> to GIT using parsecvs, unless its second phase is reworked to avoid=20
> totally random access in memory in order to improve swap behavior, or=20
> its in-memory data set is shrinked at least by half.

Changing the data structures used in the first phase will shrink them
significantly; replacing the second state data structures with sha1 tree
hash values and disposing of the first phase objects incrementally
should elicit a shrinking memory pattern rather than growing. It might
well be easier at this point to just take the basic CVS parser and start
afresh though; the code is a horror show of incremental refinements.

> Also rcs2git() is very inefficient especially with files having many=20
> revisions as it reconstructs the delta chain on every call.  For example=20
> mozilla/configure,v has at least 1690 revisions, and actually converting=20
> it into GIT blobs goes at a rate of 2.4 objects per second _only_ on my=20
> machine.  Can't objects be created as the delta list is walked/applied=20
> instead?  That would significantly reduce the initial convertion time.

Yes, I wanted to do this, but also wanted to ensure that the constructed
versions exactly matched the native rcs output. Starting with 'real' rcs
code seemed likely to ensure the latter. This "should" be easy to fix...

--=20
keith.packard@intel.com

--=-PlVbTIwL/bWdSRqQ7HAT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkdkuQp8BWwlsTdMRAsQfAJ4up1nr2kHdvmjbflOJuwpV6RYOngCgs5EQ
YUbuvDCVZqF9wxx+lAgxb0Q=
=qNI4
-----END PGP SIGNATURE-----

--=-PlVbTIwL/bWdSRqQ7HAT--
