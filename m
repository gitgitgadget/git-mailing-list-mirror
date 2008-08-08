From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Fri, 8 Aug 2008 20:37:45 +0200
Message-ID: <200808082037.49918.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <200808081614.44422.trast@student.ethz.ch> <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10089652.TsfbN2MgMP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 20:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRWrL-0005i7-PC
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 20:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753960AbYHHShl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 14:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbYHHShl
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 14:37:41 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:21842 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292AbYHHShl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 14:37:41 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 20:37:39 +0200
Received: from [192.168.0.8] ([77.56.223.244]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Aug 2008 20:37:39 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-OriginalArrivalTime: 08 Aug 2008 18:37:39.0738 (UTC) FILETIME=[D60FB7A0:01C8F985]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91705>

--nextPart10089652.TsfbN2MgMP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Johannes Schindelin wrote:
> On Fri, 8 Aug 2008, Thomas Rast wrote:
>=20
> > I think a more careful use of rev-list -1 is actually a correct and eas=
y=20
> > way to figure out an ancestor.
>=20
> I have not looked at your patch closely, or at your explanation, but I am=
=20
> really certain that every attempt to replace the --boundary with a -1 mus=
t=20
> fail.
>=20
> Let me show you why I think that.  Just look at this history:
>=20
> A - B - C
>   /
> D
>=20
> Where all commits except B touch the inside directory.  Two options:

'rev-list' "solves" this problem for us.  At the point where we are
rewriting the branch pointers, commits have already been rewritten to
whatever 'git rev-list --parents -- $subdir' told us to make them.  I
think there are only two cases for its output:

(a) Both A and D bring the same subdirectory contents.  'rev-list
    --parents -- $subdir' drops one side of the merge during pruning.
    It does not look past the merge to see whether the contents were
    arrived at via different changesets.  Thus the history becomes

      A' -- C'

      D'

    and even that only if D was reachable by a different ref,
    otherwise D' is simply dropped.

(b) A and D bring different $subdir contents.  Then the merge is
    interesting and remains.  History is now

      A' -- B' -- C'
           /
      D' -/

Neither of those cases is a problem for the -1 strategy.  A branch
'topic' pointing to B will be rewritten to (a) A' and (b) B'.

IOW, either the merge remains and there is no problem, or the side
branches vanish too and there is no problem.  rev-list never "forward
simplifies" merges; it merely tries to prune away commits on the
incoming side of the merge until all its parents are interesting.

Either that, or I missed something obvious.  I think I'll have to come
up with a better commit message...

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart10089652.TsfbN2MgMP
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkickn0ACgkQqUud07tmzP3JxgCcCbxtHdVKG3p8StRIa7tYdsta
stAAn2U1GN+YyhBGVcpxOT5QPWn5g1on
=L5np
-----END PGP SIGNATURE-----

--nextPart10089652.TsfbN2MgMP--
