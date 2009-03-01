From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: "warning: no common commits" triggered due to change of remote's IP address?
Date: Sun, 1 Mar 2009 22:20:56 +0100
Message-ID: <200903012221.03662.trast@student.ethz.ch>
References: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2502405.Efo9B2SQyg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 22:24:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldt9a-0003Tb-9d
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 22:24:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbZCAVV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 16:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753438AbZCAVV1
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 16:21:27 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9232 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752956AbZCAVV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 16:21:27 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:21:24 +0100
Received: from thomas.localnet ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Mar 2009 22:21:23 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-3.2-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <e38bce640903011001p2d705707o9f7145ab5ab68929@mail.gmail.com>
X-OriginalArrivalTime: 01 Mar 2009 21:21:23.0790 (UTC) FILETIME=[AC55D6E0:01C99AB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111872>

--nextPart2502405.Efo9B2SQyg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Brent Goodrick wrote:
> My expectation at this point is that, since I've changed only the IP
> address, and kept everything else the same, git should be smart enough
> to compare SHA1 values only and not download the entire remote repo
> just to do that comparison.
>=20
> But I was quite surprised to find that it was pulling down tons of data:

Git doesn't care about the details of the transport; during its
handshake, lists of the available refs are exchanged, and then used to
determine the common commits.  So I'm also rather surprised.

However, your use of + refspecs in

>   gitw fetch 88.99.100.101:git.repos/environ.git
> +refs/heads/home:refs/remotes/origin/home

makes me wonder: have you rewritten the repo hosting 'home' between
two fetches?  Using (especially, but not only) git-filter-branch can
easily render your history disjoint from the pre-filtering state.

>   warning: no common commits

Either your history is very short and really has no common commits
whatsoever, or it gave up because of the 256 revision limit during
find_common().

IIRC it walks by date, so it is enough to make 256 local commits with
a new timestamp to hit that limit.  I posted some experimental code
two months ago that would use a bisection algorithm, so that it is
harder to hit the limit and faster at detecting disjoint history, but
nobody had the time to review it.

I'll follow up with the patch if you want to try it.  The problem is
it's quite large _and_ I don't run any git servers where I could give
it a good testing.  You'll have to apply it to both sides.

(It does have the nice side-effect of saving the uploading side a bit
of work.)

>  1. Will terminating the git fetch like I did leave the satellite repo
>     in an inconsistent state? If so, is my only choice to start
>     a new repo from scratch on the satellite machine, or is there some
>     repair mechanism?

It will just leave a temporary pack file that git-gc will eventually
remove.  You can just try another fetch later.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2502405.Efo9B2SQyg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmq/D8ACgkQqUud07tmzP0ilgCgkKXVQH5sT1eUr2BWIogXb2Wc
V6MAn1QaZWVN9u0l30BqeLvt6x9I9quk
=at68
-----END PGP SIGNATURE-----

--nextPart2502405.Efo9B2SQyg--
