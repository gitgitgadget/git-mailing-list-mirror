From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Wed, 13 Aug 2008 00:15:51 +0200
Message-ID: <200808130016.13948.trast@student.ethz.ch>
References: <200808080148.27384.trast@student.ethz.ch> <200808091200.21634.trast@student.ethz.ch> <7v7ialrk9a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart38083914.WXyhTt8BAg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT2B0-0001t2-DN
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 00:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbYHLWQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 18:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbYHLWQJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 18:16:09 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:17782 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbYHLWQI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 18:16:08 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 00:16:06 +0200
Received: from [192.168.0.4] ([84.75.158.234]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 13 Aug 2008 00:16:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7v7ialrk9a.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 12 Aug 2008 22:16:06.0050 (UTC) FILETIME=[03AF3820:01C8FCC9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92147>

--nextPart38083914.WXyhTt8BAg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Hmm, Dscho, perhaps we should take Thomas's patch as a "revert to 685ef54
> to fix breakage introduced by 813b473", and demonstrate the breakage with
> one of the new tests in his series?

Now you've lost me.

If you're saying 813b473 is at fault: it is not.  The code I'm trying
to fix came about in dfd05e38.

To see that the change in 813b473 is ok, you can simply run the
following in git.git:

  diff -u <(git rev-list --reverse --parents --topo-order HEAD -- gitk) \
    <(git rev-list --reverse --topo-order HEAD -- gitk | while read commit
      do echo $(git rev-list -1 --parents $commit -- gitk); done)

The one thing that breaks down is (04c6e9e:git-filter-branch.sh:331)

        for p in $( (cd "$workdir"/../map; ls | sed "s/^/^/") |
                git rev-list $ref --boundary --stdin |
                sed -n "s/^-//p")

> I also _suspect_ that if you use --simplify-merges, the optimization
> made by 813b473 would still be usable even with path limiter.

It is always usable, if we are careful enough to use the same limiting
arguments in all rev-lists involved.

> By the way, I am not sure if using --simplify-merges unconditionally is
> necessarily a good thing to do.

I think filter-branch would need a generic mechanism to pass arguments
that affect commit selection.  Passing '-- -- file' or '-- ^commit' to
filter-branch --subdirectory-filter will probably break a few things,
so it either needs to recognize those arguments itself or have a
mechanism to specify them, if we want to support it.  This also goes
for the simplification mode.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart38083914.WXyhTt8BAg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiiC60ACgkQqUud07tmzP32cACfdKL/RlKKKp14K63+F5b+nO8Y
P3cAn3B2Ea52qXIwjma99JknHgT5+sRj
=zrmn
-----END PGP SIGNATURE-----

--nextPart38083914.WXyhTt8BAg--
