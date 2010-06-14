From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: strip off leading slashes on --trunk
	argument
Date: Mon, 14 Jun 2010 04:57:35 +0000
Message-ID: <20100614045735.GA22999@dcvr.yhbt.net>
References: <20090915113634.GC22524@ra.ncl.ac.uk> <20100613112743.GA21855@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Dowland <jmtd@debian.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 06:58:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO1kz-0007Pk-AL
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 06:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100Ab0FNE5h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 00:57:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55612 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab0FNE5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 00:57:36 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDBD01F516;
	Mon, 14 Jun 2010 04:57:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100613112743.GA21855@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149067>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> The following command
>=20
>  git svn clone \
> 	-r9500:10006 \
> 	svn://svn.debian.org/svn/pkg-games/packages \
> 	--trunk=3D/trunk/freedoom \
> 	--branches=3D/branches/freedoom \
> 	--tags=3D/tags/freedoom \
> 	freedoom.git.2009091
>=20
> produces strange results:
>=20
> With v1.6.3.3 (and perhaps earlier versions), this would fetch up to
> and including r9978 (the last revision of the no_iwad_alternatives
> branch before it was deleted), check it out, and prematurely declare
> success, leaving out some commits to the trunk (r9984, r9985, r10006)
> from after the branch was merged.
>=20
> With v1.6.5-rc0~74 (svn: allow branches outside of refs/remotes,
> 2009-08-11) and later, this fetches up to and including r9978 and the=
n
> attempts a post-fetch checkout and fails.
>=20
>  r9978 =3D 25f0920175c395f0f22f54ae7a2318147f745274
>  (refs/remotes/no_iwad_alternatives)
>  fatal: refs/remotes/trunk: not a valid SHA1
>  update-ref refs/heads/master refs/remotes/trunk: command returned er=
ror: 128
>=20
> Checking .git/config reveals
>=20
>  fetch =3D packages//trunk/freedoom:refs/remotes/trunk
>=20
> And with both 1.6.3.3 and 1.7.1, using --trunk=3Dtrunk/freedom withou=
t
> the leading slash (/) works fine.
>=20
> Moral: git-svn needs to scrub an initial / from $_trunk and related
> arguments it receives.  Make it so.
>=20
> Reported-by: Jon Dowland <jmtd@debian.org>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Acked-by: Eric Wong <normalperson@yhbt.net>

=2E..and pushed out to git://git.bogomips.org/git-svn along with
one follow-up patch:

Eric Wong (1):
      git svn: avoid unnecessary '/' in paths for SVN

Jonathan Nieder (1):
      git-svn: strip off leading slashes on --trunk argument

> ---
> Hi Eric,
>=20
> It=E2=80=99s not clear to me what=E2=80=99s going on here, but this s=
eems to fix it.
> Insights?

The svn:// server is more picky about the "//" than http:// or file://.

So we were skipping fetches from trunk completely, and never created
a ref for it.  Since git-svn attempts to checkout a "master" ref based
on trunk, it fails since trunk is a non-existent ref.

=46rom b1a954a37cea7d5a0a123758f6c2ad9005d4481e Mon Sep 17 00:00:00 200=
1
=46rom: Eric Wong <normalperson@yhbt.net>
Date: Mon, 14 Jun 2010 04:31:10 +0000
Subject: [PATCH] git svn: avoid unnecessary '/' in paths for SVN

svn:// servers are more picky regarding redundant slashes
than file:// and http(s)://-backed respositories.  Since
the last commit, we avoid putting unnecessary slashes in
$GIT_CONFIG, but this doesn't help users who are already
set up that way.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 80ab450..19d6848 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2055,6 +2055,9 @@ sub new {
 		         "\":$ref_id\$\" in config\n";
 		($self->{path}, undef) =3D split(/\s*:\s*/, $fetch);
 	}
+	$self->{path} =3D~ s{/+}{/}g;
+	$self->{path} =3D~ s{\A/}{};
+	$self->{path} =3D~ s{/\z}{};
 	$self->{url} =3D command_oneline('config', '--get',
 	                               "svn-remote.$repo_id.url") or
                   die "Failed to read \"svn-remote.$repo_id.url\" in c=
onfig\n";
--=20
Eric Wong
