From: Elfyn McBratney <beu@gentoo.org>
Subject: Re: First cut at git port to Cygwin
Date: Sat, 8 Oct 2005 18:38:13 +0100
Message-ID: <20051008173812.GA20870@gentoo.org>
References: <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home> <4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home> <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Cc: Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <fork0@users.sourceforge.net>,
	Chuck Lever <cel@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	Christopher Faylor <me@cgf.cx>,
	"H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:40:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOIen-0005Vc-1J
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 19:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVJHRiV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbVJHRiV
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 13:38:21 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1542 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932171AbVJHRiU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2005 13:38:20 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy.emcb.local)
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1EOIeF-0009RV-1J; Sat, 08 Oct 2005 17:38:15 +0000
Received: by zippy.emcb.local (Postfix, from userid 1001)
	id 45F85148041; Sat,  8 Oct 2005 18:38:13 +0100 (BST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Alex Riesen <fork0@users.sourceforge.net>,
	Chuck Lever <cel@citi.umich.edu>, Junio C Hamano <junkio@cox.net>,
	Christopher Faylor <me@cgf.cx>, "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
Organisation: Gentoo Foundation, Inc.
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9841>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 08, 2005 at 09:11:03AM -0700, Linus Torvalds wrote:
 >=20
 > On Fri, 7 Oct 2005, Alex Riesen wrote:
 > >=20
 > > Make read_cache copy the index into memory, to improve portability on
 > > other OS's which have mmap too, tend to use it less commonly.
 >=20
 > I really think that you should just get rid of the mmap.
 >=20
 > As it is, you're just slowing the code down on sane architectures. That'=
s=20
 > not good.
 >=20
 > So I'd suggest something like this instead.
 >=20
 > Totally untested, of course.
 >=20
 > 		Linus

Slightly adjusted diff below so it compiles ;)  (Note: only the second
die() un hunk #1 was changed.)

Best,
Elfyn

----
diff --git a/read-cache.c b/read-cache.c
--- a/read-cache.c
+++ b/read-cache.c
@@ -454,13 +454,39 @@ static int verify_hdr(struct cache_heade
 	return 0;
 }
=20
+static void *map_index_file(int fd, size_t size)
+{
+	void *map;
+#ifdef NO_MMAP
+	map =3D malloc(size);
+	if (!map)
+		die("Unable to allocate index file mapping");
+	if (read(fd, map, size) !=3D size)
+		die("Unable to read %z bytes from index", size);
+#else
+	map =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (map =3D=3D MAP_FAILED)
+		die("index file mmap failed (%s)", strerror(errno));
+#endif
+	return map;
+}
+
+static void unmap_index_file(void *map, size_t size)
+{
+#ifdef NO_MMAP
+	free(map);
+#else
+	munmap(map, size);
+#endif
+}
+
 int read_cache(void)
 {
 	int fd, i;
 	struct stat st;
 	unsigned long size, offset;
-	void *map;
 	struct cache_header *hdr;
+	void *map;
=20
 	errno =3D EBUSY;
 	if (active_cache)
@@ -475,16 +501,15 @@ int read_cache(void)
 	}
=20
 	size =3D 0; // avoid gcc warning
-	map =3D MAP_FAILED;
-	if (!fstat(fd, &st)) {
-		size =3D st.st_size;
-		errno =3D EINVAL;
-		if (size >=3D sizeof(struct cache_header) + 20)
-			map =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
-	}
+	if (fstat(fd, &st))
+		die("unable to fstat index file");
+
+	size =3D st.st_size;
+	errno =3D EINVAL;
+	if (size < sizeof(struct cache_header) + 20)
+		goto corrupt;
+	map =3D map_index_file(fd, size);
 	close(fd);
-	if (map =3D=3D MAP_FAILED)
-		die("index file mmap failed (%s)", strerror(errno));
=20
 	hdr =3D map;
 	if (verify_hdr(hdr, size) < 0)
@@ -503,8 +528,9 @@ int read_cache(void)
 	return active_nr;
=20
 unmap:
-	munmap(map, size);
+	unmap_index_file(map, size);
 	errno =3D EINVAL;
+corrupt:
 	die("index file corrupt");
 }


--=20
Elfyn McBratney
Gentoo Developer/Perl Team Lead
beu/irc.freenode.net                            http://dev.gentoo.org/~beu/
+------------O.o--------------------- http://dev.gentoo.org/~beu/pubkey.asc

PGP Key ID: 0x69DF17AD
PGP Key Fingerprint:
  DBD3 B756 ED58 B1B4 47B9  B3BD 8D41 E597 69DF 17AD

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDSAQEjUHll2nfF60RAnOLAKC7SLYKjtc6NCztQv+wgXcCa6fmrQCfSc3O
aIsuZvR2WgXTGTM/9eAjZQ8=
=eDNn
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
