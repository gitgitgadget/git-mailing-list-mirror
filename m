From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libxdiff and patience diff
Date: Tue, 04 Nov 2008 09:30:42 +0100
Message-ID: <20081104083042.GB3788@artemis.corp>
References: <20081104004001.GB29458@artemis.corp> <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="KFztAG8eRSV9hGtP";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: davidel@xmailserver.org, Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 04 09:32:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxHKS-0006Nw-9M
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 09:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbYKDIap (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 03:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYKDIap
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 03:30:45 -0500
Received: from pan.madism.org ([88.191.52.104]:34213 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753767AbYKDIap (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 03:30:45 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D069B3BEA8;
	Tue,  4 Nov 2008 09:30:43 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3CC09110A3F; Tue,  4 Nov 2008 09:30:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100055>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 05:39:48AM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 4 Nov 2008, Pierre Habouzit wrote:
>=20
> > I've been working tonight, trying to make libxdiff support the patience=
=20
> > diff algorithm, but I've totally failed, because I _thought_ I=20
> > understood what xdl_split was doing, but it appears I don't.
>=20
> I thought about it, too, at the GitTogether, although I want to finish my=
=20
> jGit diff first.
>=20
> The main idea I had about patience diff is that you can reuse a lot of=20
> functions in libxdiff.
>=20
> But the requirement of taking just unique lines/hashes into account, and=
=20
> _after_ splitting up, _again_ determine uniqueness _just_ in the=20
> between-hunk part made me think that it may be wiser to have a separate=
=20
> function for the patience diff stuff.
>=20
> Basically, you would start to have libxdiff split the lines and hash them=
=20
> as normal, but then determine the unique hashes (I'd start with the=20
> smaller text, just to have a better chance to end up with unique hashes).
>=20
> Once they are determined, you can search for those exact lines (hash=20
> first) in the post-document.

Actually my current implementation just puts all the hashes into an
array, sorts them by hash (which is O(n log(n)) with the position from
left or right file it's in, ordered by increasing right position. (and
the struct is filled with the left pos to -1 if the right pos is set,
and vice versa).

The I scan the array to find patterns of two consecutive hashes exactly,
and collapse it into the proper {left pos, right pos} tuple if it was
indeed a unique line in both files.

This results into an array I sort again by right pos then, and we can
work on that for the stack sorting, and I do it, and then I have my LCS.


This is the complete brute-force algorithm which requires a temporary
array of the size of the number of lines on the left + the right, and a
temporary array for the stacks which _may_ end up being as large as the
smallest number of lines between the left or right file in the worst
case I'd say (roughly).

Then I just remember a list of split points, and I recurse in all the
sub splits again. It has a fixed point which may or may not need
libxdiff recursion in it.

This code is actually written, naive and unoptimized but it doesn't work
probably because I didn't plug that in the proper place :)

> Once that is done, you'd have to find the longest common subsequence,=20
> which you could do using the existing infrastructure, but that would=20
> require more work (as we already know the lines are unique).

Patience diff gives you the algorithm to do that, it's pretty simple,
and is more efficient than the current infrastructure (in time, I don't
know for space though).

> After that, you would have to recurse to the same algorithm _between_=20
> known chunks.  Eventually, that would have to resort to classical libxdif=
f=20
> (if there are no, or not enough, unique lines).

Yeah, that's the point, the problem is, I believe more and more that I
should prepare the LCS from patience diff in xprepare.c, but I grok
absolutely nothing at what the chastore_t and similar stuff is. I
understand it's about hashing, but the exact stuff it does eludes me. In
fact when I look at the records I have in xdiffi.c I had the impression
they were already somehow collapsed, which makes it a too late point to
apply the patience diff ...

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkQCDIACgkQvGr7W6Hudhy7egCeN4ITwmCmgGEoWnL4As0N/df0
od0An2spHz+SMhzozteA6llJrX7h7cf5
=n9Tf
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
