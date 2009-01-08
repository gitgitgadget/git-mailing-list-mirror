From: Joey Hess <joey@kitenet.net>
Subject: gitweb index performance (Re: [PATCH] gitweb: support the
	rel=vcs-* microformat)
Date: Thu, 8 Jan 2009 14:54:46 -0500
Message-ID: <20090108195446.GB18025@gnu.kitenet.net>
References: <20090107042518.GB24735@gnu.kitenet.net> <gk2794$djn$1@ger.gmane.org> <20090107155023.GA16540@gnu.kitenet.net> <cb7bb73a0901071003m77482a99wf6f3988beb5b5e78@mail.gmail.com> <20090107184515.GB31795@gnu.kitenet.net> <20090107190238.GA3909@gnu.kitenet.net> <20090107232427.GA18958@gnu.kitenet.net> <gk4bk5$9dq$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 21:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL0zI-0001HR-Cy
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 20:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525AbZAHTyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbZAHTyw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 14:54:52 -0500
Received: from wren.kitenet.net ([80.68.85.49]:49637 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755371AbZAHTyv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 14:54:51 -0500
Received: from gnu.kitenet.net (fttu-67-223-5-142.btes.tv [67.223.5.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 12CD731429F
	for <git@vger.kernel.org>; Thu,  8 Jan 2009 14:54:49 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id BB054A8D3F; Thu,  8 Jan 2009 14:54:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <gk4bk5$9dq$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8845/Thu Jan  8 11:52:13 2009 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104957>


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Giuseppe Bilotta wrote:
> > There is a small overhead in including the microformat on project list
> > and forks list pages, but getting the project descriptions for those pa=
ges
> > already incurs a similar overhead, and the ability to get every repo url
> > in one place seems worthwhile.
>=20
> I agree with this, although people with very large project lists may
> differ ... do we have timings on these?

AFAICS, when displaying the project list, gitweb reads each project's
description file, falling back to reading its config file if there is no
description file.

If performance was a problem here, the thing to do would be to add
project descriptions to the $project_list file, and use those in
preference to the description files. If a large site has done that,
they've not sent in the patch. :-)

With my patch, it will read each cloneurl file too. The best way to
optimise that for large sites seems to be to add an option that would
ignore the cloneurl files and config file and always use
@git_base_url_list.

I checked the only large site I have access to (git.debian.org) and they
use a $project_list file, but I see no other performance tuning. That's
a 2 ghz machine; it takes gitweb 28 (!) seconds to generate the nearly 1
MB index web page for 1671 repositories:

/srv/git.debian.org/http/cgi-bin/gitweb.cgi  3.04s user 9.24s system 43% cp=
u 28.515 total

Notice that most of the time is spent by child processes. For each
repository, gitweb runs git-for-each-ref to determine the time of the
last commit.

If that is removed (say if there were a way to get the info w/o
forking), performance improves nicely:

=2E/gitweb.cgi > /dev/null  1.29s user 1.08s system 69% cpu 3.389 total

Making it not read description files for each project, as I suggest above,
is the next best optimisation:

=2E/gitweb.cgi > /dev/null  1.08s user 0.05s system 96% cpu 1.170 total

So, I think it makes sense to optimise gitweb and offer knobs for performan=
ce
tuning at the expense of the flexability of description and cloneurl files.
But, git-for-each-ref is swamping everything else.

--=20
see shy jo

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJZloDd8HHehbQuO8RAkWMAJ9igkWchqmSyF1ITr4kuttvHHlffwCgzTeE
2sMrIgh2ptryxVE6UQ8TXtU=
=dpwh
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
