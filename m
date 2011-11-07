From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] fsck: avoid reading every object twice
Date: Mon,  7 Nov 2011 09:59:25 +0700
Message-ID: <1320634766-24511-4-git-send-email-pclouds@gmail.com>
References: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stephen Boyd <bebarino@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 04:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNFSd-00089R-9i
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 04:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab1KGDBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 22:01:18 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62897 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1KGDBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 22:01:18 -0500
Received: by gyc15 with SMTP id 15so3696948gyc.19
        for <git@vger.kernel.org>; Sun, 06 Nov 2011 19:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=faYyWowrnLwdnq/GdsFpjVU/fAv+IJ/PDm9hSpNBPIQ=;
        b=OyrtFCdlZtK4c62KvKOxpAJotcSU2gILZEkYnUnTVk4D9dFpA1QwMz+yupmGiYF7kQ
         0tRrvc0tdPUH7sFho/3cU2PrfKfttqsehz4TJJhqyHhYhA7VRycrPsQIjfyW4G4D68zw
         ye3/k0qnRmqbiOPFGsQHpQqtjVlNs9cFFYlYE=
Received: by 10.42.163.202 with SMTP id d10mr38008361icy.47.1320634877259;
        Sun, 06 Nov 2011 19:01:17 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.230.110])
        by mx.google.com with ESMTPS id b2sm3862736pbc.2.2011.11.06.19.01.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 Nov 2011 19:01:15 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 07 Nov 2011 09:59:57 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320634766-24511-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184942>

During verify_pack() all objects are read for SHA-1 check. Then
fsck_sha1() is called on every object, which read the object again
(fsck_sha1 -> parse_object -> read_sha1_file).

Avoid reading an object twice, do fsck_sha1 while we have an object
uncompressed data in verify_pack.

On git.git, with this patch I got:

$ /usr/bin/time ./git fsck >/dev/null
98.97user 0.90system 1:40.01elapsed 99%CPU (0avgtext+0avgdata 616624max=
resident)k
0inputs+0outputs (0major+194186minor)pagefaults 0swaps

Without it:

$ /usr/bin/time ./git fsck >/dev/null
231.23user 2.35system 3:53.82elapsed 99%CPU (0avgtext+0avgdata 636688ma=
xresident)k
0inputs+0outputs (0major+461629minor)pagefaults 0swaps

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c |   42 +++++++++++++++++++++++++-----------------
 pack-check.c   |   13 ++++++++++---
 pack.h         |    5 ++++-
 3 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 4ead98d..0603f64 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -282,14 +282,8 @@ static void check_connectivity(void)
 	}
 }
=20
-static int fsck_sha1(const unsigned char *sha1)
+static int fsck_obj(struct object *obj)
 {
-	struct object *obj =3D parse_object(sha1);
-	if (!obj) {
-		errors_found |=3D ERROR_OBJECT;
-		return error("%s: object corrupt or missing",
-			     sha1_to_hex(sha1));
-	}
 	if (obj->flags & SEEN)
 		return 0;
 	obj->flags |=3D SEEN;
@@ -332,6 +326,29 @@ static int fsck_sha1(const unsigned char *sha1)
 	return 0;
 }
=20
+static int fsck_sha1(const unsigned char *sha1)
+{
+	struct object *obj =3D parse_object(sha1);
+	if (!obj) {
+		errors_found |=3D ERROR_OBJECT;
+		return error("%s: object corrupt or missing",
+			     sha1_to_hex(sha1));
+	}
+	return fsck_obj(obj);
+}
+
+static int fsck_obj_buffer(const unsigned char *sha1, enum object_type=
 type,
+			   unsigned long size, void *buffer, int *eaten)
+{
+	struct object *obj;
+	obj =3D parse_object_buffer(sha1, type, size, buffer, eaten);
+	if (!obj) {
+		errors_found |=3D ERROR_OBJECT;
+		return error("%s: object corrupt or missing", sha1_to_hex(sha1));
+	}
+	return fsck_obj(obj);
+}
+
 /*
  * This is the sorting chunk size: make it reasonably
  * big so that we can sort well..
@@ -627,17 +644,8 @@ int cmd_fsck(int argc, const char **argv, const ch=
ar *prefix)
 		prepare_packed_git();
 		for (p =3D packed_git; p; p =3D p->next)
 			/* verify gives error messages itself */
-			if (verify_pack(p))
+			if (verify_pack(p, fsck_obj_buffer))
 				errors_found |=3D ERROR_PACK;
-
-		for (p =3D packed_git; p; p =3D p->next) {
-			uint32_t j, num;
-			if (open_pack_index(p))
-				continue;
-			num =3D p->num_objects;
-			for (j =3D 0; j < num; j++)
-				fsck_sha1(nth_packed_object_sha1(p, j));
-		}
 	}
=20
 	heads =3D 0;
diff --git a/pack-check.c b/pack-check.c
index 7ac9b3a..3b48b86 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -42,7 +42,8 @@ int check_pack_crc(struct packed_git *p, struct pack_=
window **w_curs,
 }
=20
 static int verify_packfile(struct packed_git *p,
-		struct pack_window **w_curs)
+			   struct pack_window **w_curs,
+			   verify_fn fn)
 {
 	off_t index_size =3D p->index_size;
 	const unsigned char *index_base =3D p->index_data;
@@ -120,6 +121,12 @@ static int verify_packfile(struct packed_git *p,
 		else if (check_sha1_signature(entries[i].sha1, data, size, typename(=
type)))
 			err =3D error("packed %s from %s is corrupt",
 				    sha1_to_hex(entries[i].sha1), p->pack_name);
+		else if (fn) {
+			int eaten =3D 0;
+			fn(entries[i].sha1, type, size, data, &eaten);
+			if (eaten)
+				data =3D NULL;
+		}
 		free(data);
 	}
 	free(entries);
@@ -150,7 +157,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
=20
-int verify_pack(struct packed_git *p)
+int verify_pack(struct packed_git *p, verify_fn fn)
 {
 	int err =3D 0;
 	struct pack_window *w_curs =3D NULL;
@@ -159,7 +166,7 @@ int verify_pack(struct packed_git *p)
 	if (!p->index_data)
 		return -1;
=20
-	err |=3D verify_packfile(p, &w_curs);
+	err |=3D verify_packfile(p, &w_curs, fn);
 	unuse_pack(&w_curs);
=20
 	return err;
diff --git a/pack.h b/pack.h
index 722a54e..70f3c29 100644
--- a/pack.h
+++ b/pack.h
@@ -70,10 +70,13 @@ struct pack_idx_entry {
 	off_t offset;
 };
=20
+
+typedef int (*verify_fn)(const unsigned char*, enum object_type, unsig=
ned long, void*, int*);
+
 extern const char *write_idx_file(const char *index_name, struct pack_=
idx_entry **objects, int nr_objects, const struct pack_idx_option *, un=
signed char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w=
_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct packed_git *);
+extern int verify_pack(struct packed_git *, verify_fn fn);
 extern void fixup_pack_header_footer(int, unsigned char *, const char =
*, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
 extern int encode_in_pack_object_header(enum object_type, uintmax_t, u=
nsigned char *);
--=20
1.7.4.74.g639db
