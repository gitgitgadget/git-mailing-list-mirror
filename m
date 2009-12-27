From: Nathaniel W Filardo <nwf@cs.jhu.edu>
Subject: [RESEND] [PATCH] Endianness bug in index cache logic
Date: Sun, 27 Dec 2009 01:11:21 -0500
Message-ID: <20091227061121.GP14941@gradx.cs.jhu.edu>
References: <20091204202928.GW17192@gradx.cs.jhu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tZCmRiovzb4sxAVa"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 07:13:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NOmNy-0006DJ-Kf
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 07:13:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbZL0GLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 01:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZL0GLY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 01:11:24 -0500
Received: from blaze.cs.jhu.edu ([128.220.13.50]:59699 "EHLO blaze.cs.jhu.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbZL0GLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 01:11:23 -0500
Received: from gradx.cs.jhu.edu (gradx.cs.jhu.edu [128.220.13.52])
	by blaze.cs.jhu.edu (8.14.3/8.14.3) with ESMTP id nBR6BMhd019067
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 27 Dec 2009 01:11:22 -0500 (EST)
Received: from gradx.cs.jhu.edu (localhost.localdomain [127.0.0.1])
	by gradx.cs.jhu.edu (8.14.2/8.13.1) with ESMTP id nBR6BMwc001212
	for <git@vger.kernel.org>; Sun, 27 Dec 2009 01:11:22 -0500
Received: (from nwf@localhost)
	by gradx.cs.jhu.edu (8.14.2/8.13.8/Submit) id nBR6BMIS001211
	for git@vger.kernel.org; Sun, 27 Dec 2009 01:11:22 -0500
Content-Disposition: inline
In-Reply-To: <20091204202928.GW17192@gradx.cs.jhu.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135702>


--tZCmRiovzb4sxAVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2009 at 03:29:28PM -0500, Nathaniel W Filardo wrote:
> On Fri, Dec 04, 2009 at 09:16:40PM +0100, Andreas Schwab wrote:
> > Nathaniel W Filardo <nwf@cs.jhu.edu> writes:
> >=20
> > > On this machine,
> > >
> > > mirrors hydra:/tank0/mirrors/misc% uname -a
> > > FreeBSD hydra.priv.oc.ietfng.org 9.0-CURRENT FreeBSD 9.0-CURRENT #13:=
 Sat Nov 14 19:40:25 EST 2009 root@hydra.priv.oc.ietfng.org:/systank/obj/sy=
stank/src/sys/NWFKERN  sparc64
> > >
> > > attempting to fetch from an svn source yields the following error:
> > >
> > > rs hydra:/tank0/mirrors/misc% git svn init -s https://joshua.svn.sour=
ceforge.net/svnroot/joshua test-joshua
> > > Initialized empty Git repository in /tank0/mirrors/misc/test-joshua/.=
git/                                      =20
> > > mirrors hydra:/tank0/mirrors/misc% cd test-joshua                    =
                                          =20
> > > mirrors hydra:/tank0/mirrors/misc/test-joshua% git svn fetch
> > >         A       scripts/distributedLM/config.template      =20
> > > [...]
> > >         A       build.xml
> > > r1 =3D fe84a7d821ec6d92da75133ac7ad1deb476b6484 (refs/remotes/trunk)
> > > error: index uses  extension, which we do not understand
> > > fatal: index file corrupt
> > > write-tree: command returned error: 128
> >=20
> > I could not reproduce that on powerpc (both 32bit and 64bit).
> >=20
> > Andreas.

I got some free time and tracked it down.  The following one-line delta
fixes this issue for me; AIUI on sparc64 "unsigned long" is 8 bits and in
the wrong endianness for the memcpy trick to work as written?  I could be
sligntly off in my assessment of the problem, tho'.

index 1bbaf1c..9033dd3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1322,7 +1322,7 @@ int read_index_from(struct index_state *istate, const=
 char *path)
                 * extension name (4-byte) and section length
                 * in 4-byte network byte order.
                 */
-               unsigned long extsize;
+               uint32_t extsize;
                memcpy(&extsize, (char *)mmap + src_offset + 4, 4);
                extsize =3D ntohl(extsize);
                if (read_index_extension(istate,

--nwf;

--tZCmRiovzb4sxAVa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAks2+okACgkQTeQabvr9Tc8qSwCeMnyVPmdlW0eJkMfprts772Cq
wPYAnAwafmrPKuxUyHGl4doOEJSSboZR
=fQNx
-----END PGP SIGNATURE-----

--tZCmRiovzb4sxAVa--
