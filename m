From: Timo Sirainen <tss@iki.fi>
Subject: [PATCH] -Werror fixes
Date: Tue, 09 Aug 2005 18:30:22 +0300
Message-ID: <1123601422.21306.46.camel@hurina>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jW7pQd2/rcy2T66C7qzh"
X-From: git-owner@vger.kernel.org Tue Aug 09 17:32:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2W3r-0005Ln-4d
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 17:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVHIPad (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 11:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVHIPad
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 11:30:33 -0400
Received: from kone17.procontrol.vip.fi ([212.149.71.178]:21183 "EHLO
	danu.procontrol.fi") by vger.kernel.org with ESMTP id S964821AbVHIPac
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 11:30:32 -0400
Received: from hurina (82-203-177-3.dsl.gohome.fi [82.203.177.3])
	by danu.procontrol.fi (Postfix) with ESMTP id 550041C351C6
	for <git@vger.kernel.org>; Tue,  9 Aug 2005 18:30:22 +0300 (EEST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.0.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-jW7pQd2/rcy2T66C7qzh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

GCC's format __attribute__ is good for checking errors, especially with
-Werror=3D2 parameter. Patch below fixes most of the reported problems
against 2005-08-09 snapshot.

Also how about trying to implement some kind of generically usable
string object? Now the code uses sprintf/snprintf/etc. in various
different ways with their own memory allocations, and it looks all messy
and difficult to verify their correctness.

diff -ru git-current/apply.c git-modified/apply.c
--- git-current/apply.c	2005-08-09 18:00:06.000000000 +0300
+++ git-modified/apply.c	2005-08-09 17:50:13.712911497 +0300
@@ -563,7 +563,7 @@
 			struct fragment dummy;
 			if (parse_fragment_header(line, len, &dummy) < 0)
 				continue;
-			error("patch fragment without header at line %d: %.*s", linenr, len-1, =
line);
+			error("patch fragment without header at line %d: %.*s", linenr, (int)le=
n-1, line);
 		}
=20
 		if (size < len + 6)
@@ -968,7 +968,7 @@
=20
 	while (frag) {
 		if (apply_one_fragment(desc, frag) < 0)
-			return error("patch failed: %s:%d", patch->old_name, frag->oldpos);
+			return error("patch failed: %s:%ld", patch->old_name, frag->oldpos);
 		frag =3D frag->next;
 	}
 	return 0;
diff -ru git-current/cache.h git-modified/cache.h
--- git-current/cache.h	2005-08-09 18:00:06.000000000 +0300
+++ git-modified/cache.h	2005-08-09 18:14:37.858158948 +0300
@@ -40,6 +40,10 @@
 #define NORETURN
 #endif
=20
+#ifndef __attribute__
+#define __attribute(x)
+#endif
+
 /*
  * Intensive research over the course of many years has shown that
  * port 9418 is totally unused by anything else. Or
@@ -171,8 +175,8 @@
 #define TYPE_CHANGED    0x0040
=20
 /* Return a statically allocated filename matching the sha1 signature */
-extern char *mkpath(const char *fmt, ...);
-extern char *git_path(const char *fmt, ...);
+extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1=
, 2)));
+extern char *git_path(const char *fmt, ...) __attribute__((format (printf,=
 1, 2)));
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
@@ -218,8 +222,8 @@
=20
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
-extern void die(const char *err, ...) NORETURN;
-extern int error(const char *err, ...);
+extern void die(const char *err, ...) NORETURN __attribute__((format (prin=
tf, 1, 2)));
+extern int error(const char *err, ...) __attribute__((format (printf, 1, 2=
)));
=20
 extern int base_name_compare(const char *name1, int len1, int mode1, const=
 char *name2, int len2, int mode2);
 extern int cache_name_compare(const char *name1, int len1, const char *nam=
e2, int len2);
diff -ru git-current/clone-pack.c git-modified/clone-pack.c
--- git-current/clone-pack.c	2005-08-09 18:00:06.000000000 +0300
+++ git-modified/clone-pack.c	2005-08-09 17:53:32.295922222 +0300
@@ -30,7 +30,7 @@
=20
 static void write_one_ref(struct ref *ref)
 {
-	char *path =3D git_path(ref->name);
+	char *path =3D git_path("%s", ref->name);
 	int fd;
 	char *hex;
=20
diff -ru git-current/connect.c git-modified/connect.c
--- git-current/connect.c	2005-08-09 18:00:06.000000000 +0300
+++ git-modified/connect.c	2005-08-09 17:46:35.187838763 +0300
@@ -166,7 +166,8 @@
 			if (matched_src)
 				break;
 			errs =3D 1;
-			error("src refspec %s does not match any.");
+			error("src refspec %s does not match any.",
+			      rs[i].src);
 			break;
 		default:
 			errs =3D 1;
diff -ru git-current/csum-file.h git-modified/csum-file.h
--- git-current/csum-file.h	2005-08-09 18:00:06.000000000 +0300
+++ git-modified/csum-file.h	2005-08-09 18:02:33.825363592 +0300
@@ -11,7 +11,7 @@
 };
=20
 extern struct sha1file *sha1fd(int fd, const char *name);
-extern struct sha1file *sha1create(const char *fmt, ...);
+extern struct sha1file *sha1create(const char *fmt, ...) __attribute__((fo=
rmat (printf, 1, 2)));
 extern int sha1close(struct sha1file *, unsigned char *, int);
 extern int sha1write(struct sha1file *, void *, unsigned int);
 extern int sha1write_compressed(struct sha1file *, void *, unsigned int);
diff -ru git-current/pack-check.c git-modified/pack-check.c
--- git-current/pack-check.c	2005-08-09 18:00:07.000000000 +0300
+++ git-modified/pack-check.c	2005-08-09 17:46:24.084918180 +0300
@@ -15,7 +15,7 @@
 	/* Header consistency check */
 	hdr =3D p->pack_base;
 	if (hdr->hdr_signature !=3D htonl(PACK_SIGNATURE))
-		return error("Packfile signature mismatch", p->pack_name);
+		return error("Packfile %s signature mismatch", p->pack_name);
 	if (hdr->hdr_version !=3D htonl(PACK_VERSION))
 		return error("Packfile version %d different from ours %d",
 			     ntohl(hdr->hdr_version), PACK_VERSION);
diff -ru git-current/pkt-line.h git-modified/pkt-line.h
--- git-current/pkt-line.h	2005-08-09 18:00:07.000000000 +0300
+++ git-modified/pkt-line.h	2005-08-09 18:02:56.637125022 +0300
@@ -5,7 +5,7 @@
  * Silly packetized line writing interface
  */
 void packet_flush(int fd);
-void packet_write(int fd, const char *fmt, ...);
+void packet_write(int fd, const char *fmt, ...) __attribute__((format (pri=
ntf, 2, 3)));
=20
 int packet_read_line(int fd, char *buffer, unsigned size);
=20
diff -ru git-current/refs.c git-modified/refs.c
--- git-current/refs.c	2005-08-09 18:00:07.000000000 +0300
+++ git-modified/refs.c	2005-08-09 17:53:25.318217137 +0300
@@ -6,7 +6,7 @@
 static int read_ref(const char *refname, unsigned char *sha1)
 {
 	int ret =3D -1;
-	int fd =3D open(git_path(refname), O_RDONLY);
+	int fd =3D open(git_path("%s", refname), O_RDONLY);
=20
 	if (fd >=3D 0) {
 		char buffer[60];
@@ -20,7 +20,7 @@
 static int do_for_each_ref(const char *base, int (*fn)(const char *path, c=
onst unsigned char *sha1))
 {
 	int retval =3D 0;
-	DIR *dir =3D opendir(git_path(base));
+	DIR *dir =3D opendir(git_path("%s", base));
=20
 	if (dir) {
 		struct dirent *de;
@@ -46,7 +46,7 @@
 			if (namelen > 255)
 				continue;
 			memcpy(path + baselen, de->d_name, namelen+1);
-			if (lstat(git_path(path), &st) < 0)
+			if (lstat(git_path("%s", path), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
 				retval =3D do_for_each_ref(path, fn);
diff -ru git-current/tar-tree.c git-modified/tar-tree.c
--- git-current/tar-tree.c	2005-08-09 18:00:07.000000000 +0300
+++ git-modified/tar-tree.c	2005-08-09 17:49:27.512564400 +0300
@@ -325,8 +325,8 @@
 	memcpy(&header[257], "ustar", 6);
 	memcpy(&header[263], "00", 2);
=20
-	printf(&header[329], "%07o", 0);	/* devmajor */
-	printf(&header[337], "%07o", 0);	/* devminor */
+	sprintf(&header[329], "%07o", 0);	/* devmajor */
+	sprintf(&header[337], "%07o", 0);	/* devminor */
=20
 	memset(&header[148], ' ', 8);
 	for (i =3D 0; i < RECORDSIZE; i++)


--=-jW7pQd2/rcy2T66C7qzh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC+MwOyUhSUUBViskRApk/AJ9RUJYzbweZa6AL7MFB+IBb67N5cQCfSH/d
eqxYbb6bv8oZsXjwkLfi4Dc=
=WHEY
-----END PGP SIGNATURE-----

--=-jW7pQd2/rcy2T66C7qzh--
