From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] submodule merge support
Date: Mon, 7 May 2007 18:37:58 +0200
Message-ID: <20070507163758.GJ30511@admingilde.org>
References: <20070506190224.GG30511@admingilde.org> <20070506220745.GA2439@steel.home> <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org> <20070507090346.GI30511@admingilde.org> <463EFFC6.12A1B0A1@eudaptics.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon May 07 18:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hl6Du-0003GU-B4
	for gcvg-git@gmane.org; Mon, 07 May 2007 18:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965764AbXEGQiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 May 2007 12:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965765AbXEGQiA
	(ORCPT <rfc822;git-outgoing>); Mon, 7 May 2007 12:38:00 -0400
Received: from mail.admingilde.org ([213.95.32.147]:37791 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965764AbXEGQh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2007 12:37:59 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hl6Dm-0004Py-AP; Mon, 07 May 2007 18:37:58 +0200
Content-Disposition: inline
In-Reply-To: <463EFFC6.12A1B0A1@eudaptics.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46469>


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 07, 2007 at 12:30:30PM +0200, Johannes Sixt wrote:
> Martin Waitz wrote:
> > On Sun, May 06, 2007 at 03:18:53PM -0700, Linus Torvalds wrote:
> > > On Mon, 7 May 2007, Alex Riesen wrote:
> > > > How about making all existing strategies just ignore submodules, and
> > > > move recursive merge in the merge driver (git-merge.sh)?
> > >
> > > Yes, I think that's the right thing to do.
> > >
> > > I think it's the right thing for another reason: in a true "recursive"
> > > merge, the submodules shouldn't be recursively merged anyway. *THEIR*
> > > merge will have its own history, and doing it based on some random hi=
story
> > > of the superproject is actually wrong anyway!
> >=20
> > Of course the submodule has to get its own history, it's not possible
> > to do otherwise.  But you have to trigger the submodule merge when you
> > find a submodule-level conflict in the supermodule merge, just as
> > you trigger file-level three-way merges, too.
>=20
> I think you missed Linus's point: If the supermodule's merge leads to a
> conflict in the submodule links, it is not appropriate to merge the
> submodule.

why?

We do file-level merging, too.
A submodule is not that different, besides being much more complex ;-)
We should try to automatically merge the content if possible and leave
conflict markers if not.

> Say you are merging commits A and B in the supermodule, and A uses v1.0
> of the submodule and B uses v2.0 of submodule, then you can't just merge
> v1.0 and v2.0 - instead, you have to make a decision whether the
> supermodule's merge result is going to use v1.0 or v2.0 or even
> something different like v2.1. An automatic merge cannot make this
> decision for you (unless there was no conflict in the first place).

So when should we try to merge and when should we leave conflict
markers?

Let's look at submodule commits O, A, B which are the commits that are
used by the (supermodule-) merge base, our supermodule version and their
supermodule version.

The trivial cases are:

 O,A -..- B        O,B -..- A

Then there is the fast-forward case:

 O -..- A -..- B      O -..- B -..- A

All of those do not require to create any new submodule commit, just use
the one on the right side of the chain.  I think they are not
controversial.

Now to the more complex parts:

          /-..- A
 O -..- X
          \-..- B

and

   /-..- A
 X
   \-..- O -..- B

Here we don't have any existing submodule commit that can be used.
In the second case an automatic merge cannot be done -- one supermodule
branch choose to rewind the submodule (e.g. by switching to another
branch in the submodule) and there really is no way to automatically
detect what should be done.
But when the submodule got branched after the supermodule merge-base
then an automatic submodule merge can be tried.
And it really makes sense to do so:
If you rely on submodule for your project, you will have people
submitting features which touch several submodules.  They can simply
create a new supermodule version incorporating all their changes and
send it to their supermodule-upstream.  After review,
supermodule-upstream wants all the new submodule versions merged into
her tree and it would be wrong to refuse to do that automatically.

The above behaviour is exactly what is implemented in the patch.
(OK, I could write a more elaborate commit message... ;-)

--=20
Martin Waitz

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFGP1Xmj/Eaxd/oD7IRAuqHAJQMfvOhUbSQeuUUjhgIdZSxER4QAJ0bkGFP
B56x5imFstTJlOafmOHykQ==
=31Wd
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
