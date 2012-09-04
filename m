From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Tue, 04 Sep 2012 22:23:38 +0200
Message-ID: <5046634A.4020608@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx> <5026D081.2040906@tu-clausthal.de> <20120830222603.GA20289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:24:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8zfG-0008O6-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 22:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab2IDUXz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Sep 2012 16:23:55 -0400
Received: from india601.server4you.de ([85.25.151.105]:42037 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab2IDUXy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 16:23:54 -0400
Received: from [192.168.2.105] (p4FFDB57E.dip.t-dialin.net [79.253.181.126])
	by india601.server4you.de (Postfix) with ESMTPSA id 205A1FB;
	Tue,  4 Sep 2012 22:23:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:15.0) Gecko/20120824 Thunderbird/15.0
In-Reply-To: <20120830222603.GA20289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204782>

Am 31.08.2012 00:26, schrieb Jeff King:
> Ping on this stalled discussion.

Sorry, I got distracted by other stuff again.  I did some experiments,
though, and here's a preliminary result.

> It seems like there are two separate issues here:
>=20
>    1. Knowing the encoding of pathnames in the repository.
>=20
>    2. Setting the right flags in zip output.
>=20
> A full solution would handle both parts, but let's ignore (1) for a
> moment, and assume we have utf-8 (or can massage into utf-8 from an
> encoding specified by the user).

Yes, good thinking.  Re-encoding may be beneficial for tar files as wel=
l,
but we can ignore that point for the moment.

> It seems like just setting the magic utf-8 flag would be the only thi=
ng
> we need to do, according to the standard. But according to discussion=
s
> referenced elsewhere in this thread, that flag was invented only in
> 2007, so we may be dealing with older implementations (I have no idea
> how common they would be; that may be the problem with Windows 7's zi=
p
> you are seeing). We could re-encode to cp437, which the standard
> specifies, but apparently some implementations do not respect that
> (and use a local code page instead). And it cannot represent all utf-=
8
> characters, anyway.

Yes, we could do that, plus adding an extra field with a UTF-8 version =
of
the path.  That's the legacy method invented by Info-ZIP.  They switche=
d
to using the new flag on Linux at least, though.

> It sounds like 7-zip has figured out a more portable solution. Can yo=
u
> show us a sample of 7-zip's output with utf-8 characters to compare t=
o
> what git generates? I wonder if it is using a combination of methods.

I'm not so sure they produce more portable files.  I created an archive
with files named ja=D1=8F.txt, sm=C3=B8rrebr=C3=B8d.txt, s=C3=BCd.txt a=
nd =E2=82=ACuro.txt with 7-Zip
on Windows 7 and while unzip on Ubuntu 12.04 managed to recreate the
cyrillic character and the Euro symbol, it mangled the slashed o and th=
e
umlaut.

With the following patch I could create archives with git on Linux and
msysgit and extract them flawlessly on Windows with 7-Zip and with
Info-ZIP unzip on Linux, but not with unzip on Windows, where it mangle=
d
all non-ASCII characters.

This gets confusing; it would help to have a compatibility matrix for a=
ll
intersting extractors and character classes -- for each proposed soluti=
on
or archiver we'd like to imitate.

But now for the patch, which is a bit confusing as well.  I'm curious t=
o
hear about results for more platforms, extractors and character classes=
=2E
Based on that we can see if we need to generate the extra fields instea=
d
of relying on the new flag.

-- >8 --
Subject: [PATCH] archive-zip: support UTF-8 paths

Set general purpose flag 11 if we encounter a path that contains
non-ASCII characters.  We assume that all paths are given as UTF-8; no
conversion is done.

The flag seems to be ignored by unzip unless we also mark the archive
entry as coming from a Unix system.  This is done by setting the field
creator_version ("version made by" in the standard[1]) to 0x03NN.

The NN part represents the version of the standard supported by us, and
this patch sets it to 3f (for version 6.3) for Unix paths.  We keep
creator_version set to 0 (FAT filesystem, standard version 0) in the
non-special cases, as before.

But when we declare a file to have a Unix path, then we have to set the
file mode as well, or unzip will extract the files with the permission
set 0000, i.e. inaccessible by all.

[1] http://www.pkware.com/documents/casestudies/APPNOTE.TXT

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-zip.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index f5af81f..928da1d 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -4,6 +4,8 @@
 #include "cache.h"
 #include "archive.h"
 #include "streaming.h"
+#include "commit.h"
+#include "utf8.h"
=20
 static int zip_date;
 static int zip_time;
@@ -16,7 +18,8 @@ static unsigned int zip_dir_offset;
 static unsigned int zip_dir_entries;
=20
 #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
-#define ZIP_STREAM (8)
+#define ZIP_STREAM	(1 <<  3)
+#define ZIP_UTF8	(1 << 11)
=20
 struct zip_local_header {
 	unsigned char magic[4];
@@ -173,7 +176,8 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
-	unsigned long attr2;
+	unsigned int creator_version =3D 0;
+	unsigned long attr2 =3D 0;
 	unsigned long compressed_size;
 	unsigned long crc;
 	unsigned long direntsize;
@@ -187,6 +191,13 @@ static int write_zip_entry(struct archiver_args *a=
rgs,
=20
 	crc =3D crc32(0, NULL, 0);
=20
+	if (has_non_ascii(path)) {
+		if (is_utf8(path))
+			flags |=3D ZIP_UTF8;
+		else
+			warning("Path is not valid UTF-8: %s", path);
+	}
+
 	if (pathlen > 0xffff) {
 		return error("path too long (%d chars, SHA1: %s): %s",
 				(int)pathlen, sha1_to_hex(sha1), path);
@@ -204,10 +215,15 @@ static int write_zip_entry(struct archiver_args *=
args,
 		enum object_type type =3D sha1_object_info(sha1, &size);
=20
 		method =3D 0;
-		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :
-			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && args->compression_level !=3D 0 && size > 0)
 			method =3D 8;
+		if (S_ISLNK(mode) || (mode & 0111) || (flags & ZIP_UTF8)) {
+			creator_version =3D 0x033f;
+			attr2 =3D mode;
+			if (S_ISLNK(mode))
+				attr2 |=3D 0777;
+			attr2 <<=3D 16;
+		}
 		compressed_size =3D size;
=20
 		if (S_ISREG(mode) && type =3D=3D OBJ_BLOB && !args->convert &&
@@ -254,8 +270,7 @@ static int write_zip_entry(struct archiver_args *ar=
gs,
 	}
=20
 	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version,
-		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
+	copy_le16(dirent.creator_version, creator_version);
 	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, flags);
 	copy_le16(dirent.compression_method, method);
--=20
1.7.11.msysgit.1.1.gbf71771
