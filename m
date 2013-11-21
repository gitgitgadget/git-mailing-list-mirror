From: Jeff King <peff@peff.net>
Subject: [PATCH] drop support for "experimental" loose objects
Date: Thu, 21 Nov 2013 06:41:58 -0500
Message-ID: <20131121114157.GA7171@sigill.intra.peff.net>
References: <20131120203350.GA31139@kitenet.net>
 <20131120213348.GA29004@sigill.intra.peff.net>
 <20131120222805.GC26468@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 12:42:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjSe9-0004GY-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 12:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab3KULmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 06:42:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:43175 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754118Ab3KULmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 06:42:03 -0500
Received: (qmail 11976 invoked by uid 102); 21 Nov 2013 11:42:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Nov 2013 05:42:03 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Nov 2013 06:41:58 -0500
Content-Disposition: inline
In-Reply-To: <20131120222805.GC26468@kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238118>

On Wed, Nov 20, 2013 at 06:28:06PM -0400, Joey Hess wrote:

> Jeff King wrote:
> > As for your specific corruption, I can't make heads or tails of it.=
 It
> > is not a single-bit error.
>=20
> Oh, I should have mentioned that I am generating corrupt git
> repositories mechanically for testing. I think in this case it prepen=
ded
> some garbage to an object.

Ah. That explains a lot (yes, dropping the first 19 bytes of your
corrupted file recovers the object).

I still think we should probably do this, though:

-- >8 --
Subject: drop support for "experimental" loose objects

In git v1.4.3, we introduced a new loose object format that
encoded some object information outside of the zlib stream.
Ultimately the format was dropped in v1.5.3, but we kept the
reading side around to help people migrate objects. Each
time we open a loose object, we use a heuristic to check
whether it is in the normal loose format or the
experimental one.

This heuristic is robust in the face of valid data, but it
tends to treat corrupted or garbage data as an experimental
object. With the regular format, we would notice quickly
that zlib's crc does not check out and complain. With the
experimental object, we are likely to extract a nonsensical
object size and try to allocate a huge buffer, resulting in
xmalloc calling "die".

This latter behavior is much worse for two reasons. One,
git reports an allocation error when the real error is
corruption. And two, the program dies unconditionally, so
you cannot even run fsck (which would otherwise ignore the
broken object and keep going).

We could try to improve the heuristic to err on the side of
normal objects in the face of corruption, but there is
really little point. The experimental format is long-dead,
and was never enabled by default to begin with. We can
instead simply remove it. The only affected repository would
be one that explicitly set core.legacyheaders in 2007, and
then never repacked in the intervening 6 years.

Signed-off-by: Jeff King <peff@peff.net>
---
The test objects removed are all binary. Git seems to guess a few as
non-binary, though, because they don't contain any NULs, and includes
gross binary bytes in the patch below. In theory the mail's transfer
encoding will take care of this. We'll see, I guess. :)

 sha1_file.c                                        |  74 -------------=
--------
 t/t1013-loose-object-format.sh                     |  66 -------------=
-----
 .../14/9cedb5c46929d18e0f118e9fa31927487af3b6      | Bin 117 -> 0 byte=
s
 .../16/56f9233d999f61ef23ef390b9c71d75399f435      | Bin 17 -> 0 bytes
 .../1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd      | Bin 18 -> 0 bytes
 .../25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99      | Bin 19 -> 0 bytes
 .../2e/65efe2a145dda7ee51d1741299f848e5bf752e      | Bin 10 -> 0 bytes
 .../6b/aee0540ea990d9761a3eb9ab183003a71c3696      | Bin 181 -> 0 byte=
s
 .../70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd      | Bin 26 -> 0 bytes
 .../76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb      |   2 -
 .../78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09      | Bin 139 -> 0 byte=
s
 .../7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8      | Bin 54 -> 0 bytes
 .../85/df50785d62d3b05ab03d9cbf7e4a0b49449730      | Bin 13 -> 0 bytes
 .../8d/4e360d6c70fbd72411991c02a09c442cf7a9fa      | Bin 156 -> 0 byte=
s
 .../95/b1625de3ba8b2214d1e0d0591138aea733f64f      | Bin 252 -> 0 byte=
s
 .../9a/e9e86b7bd6cb1472d9373702d8249973da0832      | Bin 11 -> 0 bytes
 .../bd/15045f6ce8ff75747562173640456a394412c8      | Bin 34 -> 0 bytes
 .../e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391      | Bin 9 -> 0 bytes
 .../f8/16d5255855ac160652ee5253b06cd8ee14165a      |   1 -
 19 files changed, 143 deletions(-)
 delete mode 100755 t/t1013-loose-object-format.sh
 delete mode 100644 t/t1013/objects/14/9cedb5c46929d18e0f118e9fa3192748=
7af3b6
 delete mode 100644 t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d753=
99f435
 delete mode 100644 t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761=
fc9bbd
 delete mode 100644 t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd=
3ebe99
 delete mode 100644 t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5=
bf752e
 delete mode 100644 t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a7=
1c3696
 delete mode 100644 t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6ad=
ca18fd
 delete mode 100644 t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436b=
c79cbb
 delete mode 100644 t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50=
b66c09
 delete mode 100644 t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb=
0fa6e8
 delete mode 100644 t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49=
449730
 delete mode 100644 t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442c=
f7a9fa
 delete mode 100644 t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea7=
33f64f
 delete mode 100644 t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973=
da0832
 delete mode 100644 t/t1013/objects/bd/15045f6ce8ff75747562173640456a39=
4412c8
 delete mode 100644 t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e4=
8c5391
 delete mode 100644 t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee=
14165a

diff --git a/sha1_file.c b/sha1_file.c
index 7dadd04..a72fcb6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1442,51 +1442,6 @@ void *map_sha1_file(const unsigned char *sha1, u=
nsigned long *size)
 	return map;
 }
=20
-/*
- * There used to be a second loose object header format which
- * was meant to mimic the in-pack format, allowing for direct
- * copy of the object data.  This format turned up not to be
- * really worth it and we no longer write loose objects in that
- * format.
- */
-static int experimental_loose_object(unsigned char *map)
-{
-	unsigned int word;
-
-	/*
-	 * We must determine if the buffer contains the standard
-	 * zlib-deflated stream or the experimental format based
-	 * on the in-pack object format. Compare the header byte
-	 * for each format:
-	 *
-	 * RFC1950 zlib w/ deflate : 0www1000 : 0 <=3D www <=3D 7
-	 * Experimental pack-based : Stttssss : ttt =3D 1,2,3,4
-	 *
-	 * If bit 7 is clear and bits 0-3 equal 8, the buffer MUST be
-	 * in standard loose-object format, UNLESS it is a Git-pack
-	 * format object *exactly* 8 bytes in size when inflated.
-	 *
-	 * However, RFC1950 also specifies that the 1st 16-bit word
-	 * must be divisible by 31 - this checksum tells us our buffer
-	 * is in the standard format, giving a false positive only if
-	 * the 1st word of the Git-pack format object happens to be
-	 * divisible by 31, ie:
-	 *      ((byte0 * 256) + byte1) % 31 =3D 0
-	 *   =3D>        0ttt10000www1000 % 31 =3D 0
-	 *
-	 * As it happens, this case can only arise for www=3D3 & ttt=3D1
-	 * - ie, a Commit object, which would have to be 8 bytes in
-	 * size. As no Commit can be that small, we find that the
-	 * combination of these two criteria (bitmask & checksum)
-	 * can always correctly determine the buffer format.
-	 */
-	word =3D (map[0] << 8) + map[1];
-	if ((map[0] & 0x8F) =3D=3D 0x08 && !(word % 31))
-		return 0;
-	else
-		return 1;
-}
-
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
@@ -1514,14 +1469,6 @@ unsigned long unpack_object_header_buffer(const =
unsigned char *buf,
=20
 int unpack_sha1_header(git_zstream *stream, unsigned char *map, unsign=
ed long mapsize, void *buffer, unsigned long bufsiz)
 {
-	unsigned long size, used;
-	static const char valid_loose_object_type[8] =3D {
-		0, /* OBJ_EXT */
-		1, 1, 1, 1, /* "commit", "tree", "blob", "tag" */
-		0, /* "delta" and others are invalid in a loose object */
-	};
-	enum object_type type;
-
 	/* Get the data stream */
 	memset(stream, 0, sizeof(*stream));
 	stream->next_in =3D map;
@@ -1529,27 +1476,6 @@ int unpack_sha1_header(git_zstream *stream, unsi=
gned char *map, unsigned long ma
 	stream->next_out =3D buffer;
 	stream->avail_out =3D bufsiz;
=20
-	if (experimental_loose_object(map)) {
-		/*
-		 * The old experimental format we no longer produce;
-		 * we can still read it.
-		 */
-		used =3D unpack_object_header_buffer(map, mapsize, &type, &size);
-		if (!used || !valid_loose_object_type[type])
-			return -1;
-		map +=3D used;
-		mapsize -=3D used;
-
-		/* Set up the stream for the rest.. */
-		stream->next_in =3D map;
-		stream->avail_in =3D mapsize;
-		git_inflate_init(stream);
-
-		/* And generate the fake traditional header */
-		stream->total_out =3D 1 + snprintf(buffer, bufsiz, "%s %lu",
-						 typename(type), size);
-		return 0;
-	}
 	git_inflate_init(stream);
 	return git_inflate(stream, 0);
 }
diff --git a/t/t1013-loose-object-format.sh b/t/t1013-loose-object-form=
at.sh
deleted file mode 100755
index fbf5f2f..0000000
--- a/t/t1013-loose-object-format.sh
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2011 Roberto Tyley
-#
-
-test_description=3D'Correctly identify and parse loose object headers
-
-There are two file formats for loose objects - the original standard
-format, and the experimental format introduced with Git v1.4.3, later
-deprecated with v1.5.3. Although Git no longer writes the
-experimental format, objects in both formats must be read, with the
-format for a given file being determined by the header.
-
-Detecting file format based on header is not entirely trivial, not
-least because the first byte of a zlib-deflated stream will vary
-depending on how much memory was allocated for the deflation window
-buffer when the object was written out (for example 4KB on Android,
-rather that 32KB on a normal PC).
-
-The loose objects used as test vectors have been generated with the
-following Git versions:
-
-standard format: Git v1.7.4.1
-experimental format: Git v1.4.3 (legacyheaders=3Dfalse)
-standard format, deflated with 4KB window size: Agit/JGit on Android
-'
-
-. ./test-lib.sh
-
-assert_blob_equals() {
-	printf "%s" "$2" >expected &&
-	git cat-file -p "$1" >actual &&
-	test_cmp expected actual
-}
-
-test_expect_success setup '
-	cp -R "$TEST_DIRECTORY/t1013/objects" .git/ &&
-	git --version
-'
-
-test_expect_success 'read standard-format loose objects' '
-	git cat-file tag 8d4e360d6c70fbd72411991c02a09c442cf7a9fa &&
-	git cat-file commit 6baee0540ea990d9761a3eb9ab183003a71c3696 &&
-	git ls-tree 7a37b887a73791d12d26c0d3e39568a8fb0fa6e8 &&
-	assert_blob_equals "257cc5642cb1a054f08cc83f2d943e56fd3ebe99" "foo$LF=
"
-'
-
-test_expect_success 'read experimental-format loose objects' '
-	git cat-file tag 76e7fa9941f4d5f97f64fea65a2cba436bc79cbb &&
-	git cat-file commit 7875c6237d3fcdd0ac2f0decc7d3fa6a50b66c09 &&
-	git ls-tree 95b1625de3ba8b2214d1e0d0591138aea733f64f &&
-	assert_blob_equals "2e65efe2a145dda7ee51d1741299f848e5bf752e" "a" &&
-	assert_blob_equals "9ae9e86b7bd6cb1472d9373702d8249973da0832" "ab" &&
-	assert_blob_equals "85df50785d62d3b05ab03d9cbf7e4a0b49449730" "abcd" =
&&
-	assert_blob_equals "1656f9233d999f61ef23ef390b9c71d75399f435" "abcdef=
gh" &&
-	assert_blob_equals "1e72a6b2c4a577ab0338860fa9fe87f761fc9bbd" "abcdef=
ghi" &&
-	assert_blob_equals "70e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd" "abcdef=
ghijklmnop" &&
-	assert_blob_equals "bd15045f6ce8ff75747562173640456a394412c8" "abcdef=
ghijklmnopqrstuvwx"
-'
-
-test_expect_success 'read standard-format objects deflated with smalle=
r window buffer' '
-	git cat-file tag f816d5255855ac160652ee5253b06cd8ee14165a &&
-	git cat-file tag 149cedb5c46929d18e0f118e9fa31927487af3b6
-'
-
-test_done
diff --git a/t/t1013/objects/14/9cedb5c46929d18e0f118e9fa31927487af3b6 =
b/t/t1013/objects/14/9cedb5c46929d18e0f118e9fa31927487af3b6
deleted file mode 100644
index 472fd1458e03e47136416bce60d6e7c893a468ab..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 117
zcmV-*0E+)ei51K-4#F@DKvCwL!aJ&DH^jjbLR`g3tWwmHs(9h{l<n&c-*p0_eCp+8
z)q#teVY;BH2sX(~8m)*Hx<<sPnQCO=3D;NQ)l_H~^-`0>zp+xy&xqlfV?lkEVv$I`1V
X&;Ic{P^6Jl5+pbyA%^e+FOeitJb^w>

diff --git a/t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d75399f435 =
b/t/t1013/objects/16/56f9233d999f61ef23ef390b9c71d75399f435
deleted file mode 100644
index c379d74ae2b40faae9c31cb7478bc7f42a6fb13c..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 17
YcmcDhnB(o^<>%?^eV&1VkAYbg05K>8VgLXD

diff --git a/t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd =
b/t/t1013/objects/1e/72a6b2c4a577ab0338860fa9fe87f761fc9bbd
deleted file mode 100644
index 93706305bcff060547181ee4b7d3a8583b691181..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 18
ZcmcDlnB(o^<>%?^ef|UsgJ2(X9{@cS1}Ojl

diff --git a/t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99 =
b/t/t1013/objects/25/7cc5642cb1a054f08cc83f2d943e56fd3ebe99
deleted file mode 100644
index bdcf704c9e663f3a11b3146b1b455bc2581b4761..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 19
acmb<m^geacKgb}_<MjFGObnu-%uWDJxd#LQ

diff --git a/t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5bf752e =
b/t/t1013/objects/2e/65efe2a145dda7ee51d1741299f848e5bf752e
deleted file mode 100644
index ad62c43e418c11254cede4dc94982ac6a30dbe9c..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 10
RcmXr4nB&dDz>vg{1ON`X0$Bh6

diff --git a/t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a71c3696 =
b/t/t1013/objects/6b/aee0540ea990d9761a3eb9ab183003a71c3696
deleted file mode 100644
index 3d2f0337dbb64c092b4a7e9bd324a66986cfe01a..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 181
zcmV;m080OO0i}>jY6CG41+&&EdLIz_c+?s&#*jt!#uw=3D6?r{d&BO_}9zP*3BL6-Fv
zMe(?t&r^etx{p>>0V(2;GZIGZz4#y@v6HB=3D?^32b4sN8R*<7gV+yFCnoI*s2Ba1lV
zFgj7@=3DRk=3D%H>8K4H?*{$QejsHt*yZRcG4TH>l<x*;`Xpmm5FA{#V*GU_~=3D6l7@~(=
y
j=3DbbbBs%`pTkNNr&2`txXKEU_mgI{mauB<nAL=3Dsix5bRpF

diff --git a/t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd =
b/t/t1013/objects/70/e6a83d8dcb26fc8bc0cf702e2ddeb6adca18fd
deleted file mode 100644
index b3f71a6ee5802b36b4576c5ebf111f30ef2017a4..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 26
icmdnMSTV=3Dj$IH*t*Zcg5GpEj-JbPN7fx*mytrGyBA`4~!

diff --git a/t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb =
b/t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb
deleted file mode 100644
index af4e9a7..0000000
--- a/t/t1013/objects/76/e7fa9941f4d5f97f64fea65a2cba436bc79cbb
+++ /dev/null
@@ -1,2 +0,0 @@
-=C3=82=0Bx=C2=9C%=C3=8CA=0E=C2=820=10@=C3=91}O1{cSZ(=C2=98=18=C3=A3=C3=
=8E=C2=BD=C3=A1=02=C3=83th=C2=AA=C2=94=C2=92Z=C2=8C=C3=9C=C3=9E=C2=A0=C3=
=8B=C3=BF=16?=0D=0F=C2=A6=02m=C3=976d=C2=B5i=C2=9D=19=C3=899=C2=85=C2=A4=
G=C3=A5=C2=98h=07=C2=B4=C3=98=C2=A8=C3=81ZR'Q=C2=B6=C2=85=C2=81R=C2=8C=C2=
=A1=C2=88=C2=82=1E=C3=B8=C2=B3p=0E=C2=91=C3=A7=C2=82=C3=93qL9=C3=A2=C3=8F=
=3Dg=C2=B8=C2=A7=C2=81sI=C3=90o=13op=C3=8E=C3=BF=C2=94e=C3=8F=C2=AB_1=C2=
=BB=C2=80=C2=B3=C2=A4$=C3=97=C3=A7=05*Si=C2=AB=C3=ABNwpP=C2=95RB=C3=B4=C3=
=BB=C3=85=C3=81=C3=BA
-=C2=B3=C2=87[(=C3=B0=C2=AEd-=C2=8D=C3=B8=02=C3=81L9=C3=A1
\ No newline at end of file
diff --git a/t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09 =
b/t/t1013/objects/78/75c6237d3fcdd0ac2f0decc7d3fa6a50b66c09
deleted file mode 100644
index 3dd28be5c61840c23486bc654213c493c5387d75..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 139
zcmV;60CfM64S1ZT%u5QwFc1LHeNHiZA!PEi1rc|y+=3Dv&LG*cUF4TP!E+lzPvmv8f=3D
zF+(2`MjJA_L|w8LeMUCfgdWj##I$#AjDA$K%2XR%YvLvqZrjWo9NLdszC7JmYPrx;
t4^^*^BcMYYt&hRN&Y&@BsLN7B_}@oeC^Ni^OmHp&FVtQ;^#LMbK`4x{Jre)`

diff --git a/t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8 =
b/t/t1013/objects/7a/37b887a73791d12d26c0d3e39568a8fb0fa6e8
deleted file mode 100644
index 2b97b264c33f78fe6c8230b5bbeacd6409d9f963..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 54
zcmV-60LlM&0V^p=3DO;s>9XD~D{Ff%bx2yqP#(RK6mab-}gIhvxgaY4w3o)h-EQ|!Y2
M+U=3DVO05jJR92g)Lz5oCK

diff --git a/t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49449730 =
b/t/t1013/objects/85/df50785d62d3b05ab03d9cbf7e4a0b49449730
deleted file mode 100644
index 6dff746876aab1acb9b42c557cdda69164d68398..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 13
UcmXr1nB(o^<;Tdte1owY030|2-~a#s

diff --git a/t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442cf7a9fa =
b/t/t1013/objects/8d/4e360d6c70fbd72411991c02a09c442cf7a9fa
deleted file mode 100644
index cb41e92d076c191245389bedfc0184ff78511c03..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 156
zcmV;N0Av4n0VRw<3c@fD06pgwdly5tsfhs*Z{DRJ*tBb?+D6i?(BE72I0G|63DCPu
zj(2VaTqI_*uMJZOrVHL7S&o4s9;`8zJhs*ar(}6Cw0RhMQL;WJp|PXV?QXdY^mB;|
zTyx|i8JgwE3mnTIwS4iM<~8VP)NR)D;{<52a+SALfUQAelxip??qHt!F~Ox5c%$~Z
K)~G%MG&zg-a!8y2

diff --git a/t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea733f64f =
b/t/t1013/objects/95/b1625de3ba8b2214d1e0d0591138aea733f64f
deleted file mode 100644
index 7ac46b4f703aa00cd96c42971a237e3da5bbb5ca..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 252
zcmV<Y00aN25_p_5G%zqTF;Pg(OwTCME2$`95DWXMY&&y);(O)ymfUj+uLsZkVrmFc
zl$Kvw1Xj~}KcFHu>GFoC4YqUk*LiV!x=3Dc5Ks>#dDO9iWuD_XYc$kOuF%oc6@EC02B
zPy91`FH}uFREb{d`$r31?=3DF8Ac(Fui<`0jj`%CqpN{TZpN>Wqvz{(1qt+4Gqt@fw;
z!1)3_-Fw^Co|5<rRaR1-npaY(3wPLFQI`0e7ynC3N|VIR99*+3U4%}+mF9z$%zF7E
zyZYK`k)oUC=3D1ezKW)|P#FoG(nN-ct@c{caa>`fQ1IeT|&t}Bnaap*};@I(N)b$dQ6
C6@X{}

diff --git a/t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973da0832 =
b/t/t1013/objects/9a/e9e86b7bd6cb1472d9373702d8249973da0832
deleted file mode 100644
index 9d8316d4e598e32ef17b3918cf00276c8c1bffba..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 11
ScmXr2nB(ok#K5S=3Da0CDn4+6^o

diff --git a/t/t1013/objects/bd/15045f6ce8ff75747562173640456a394412c8 =
b/t/t1013/objects/bd/15045f6ce8ff75747562173640456a394412c8
deleted file mode 100644
index eebf23956e3b8ac736fa04e682b4214ac75c716a..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 34
qcmdnNSTV=3Dj$IH*t*Zcg5GpEj-JbPMSLq|(bQ&)RE14GpTE?oczGYz%?

diff --git a/t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391 =
b/t/t1013/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
deleted file mode 100644
index 134cf1937963c733d7affa6919f9835db864188a..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 9
OcmXr0n8VBf1dIR)&;dyR

diff --git a/t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a =
b/t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a
deleted file mode 100644
index 26b75ae..0000000
--- a/t/t1013/objects/f8/16d5255855ac160652ee5253b06cd8ee14165a
+++ /dev/null
@@ -1 +0,0 @@
-H=C2=89=15=C3=8C=C3=81=0E=C2=820=0C=C2=80a=C3=8F{=C2=8A=C3=9E=0DI=C2=BB=
e=1D&=C3=86=C3=B8*=C2=A5=1D=C2=88=01G=C2=B0=17=C3=9F^=C2=B8=C3=BD=C3=B9=
=0E=C2=BF=C3=8B=04D=C3=A5=C3=92=C2=86wU=C2=87=C3=92=C2=97=C2=AC=1CS=C2=B1=
4=C2=AA=19=C2=8A=C3=86=11=C2=AD=C2=AA=C2=9E ,=19=07f=C3=85[=C3=B0=C3=9F=
VA=C3=9B=C2=BA=C3=8E=1E=C3=BCx=C3=88=C3=87=C3=B66[wtG=C2=A7Lu=07=C2=B8?=
=C2=97=C2=A6=C2=B2=C2=BC=C3=9A=C3=97=1F@=C2=89"g=C3=AC{=C2=86+=12b=08=7F=
y=C2=BE%M
\ No newline at end of file
--=20
1.8.5.rc2.442.gbff39ff
