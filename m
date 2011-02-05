From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] sha1_file.c: move find_cached_object up so sha1_object_info can use it
Date: Sat,  5 Feb 2011 21:03:01 +0700
Message-ID: <1296914582-619-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 15:04:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plikf-0001r3-UD
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 15:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab1BEOEc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Feb 2011 09:04:32 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56182 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab1BEOEb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 09:04:31 -0500
Received: by pwj3 with SMTP id 3so615542pwj.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 06:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=TJL+XjfjP+DyBFeEe6t2jjh/RC60gKAfuTphenfBlno=;
        b=gLk+FjG2EKBsC5zPWShb0q9xVcth3UrfUZcMrXk3OgEawquo8OWKsp/eevXxNv0ngI
         xqzt9gY6gP3NE5K+x4TYJw9C8qlbccgzC16VraHOSHXUidL2lS4tHi2TCyFSyPms1/bo
         ByPt8FHPlRfrX/plyzTEa7gZ8XAMBNsnuNwZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MOtPX80nX8ICC9Y+FnDZdk0K4S8S3jnZg1p00xEAeWg8YdwLK22mo81TlEg+IpFOBG
         sHIyIa+WqMrdvtZMu2mvuZnGV2P/fdfG379M0HAXL1yWn7a+9fPsPoCrPjYmk479UWZZ
         UmvsbRp9EkFFhrLM/Hy50NwvW3PMztkbQyPUw=
Received: by 10.142.188.2 with SMTP id l2mr12994282wff.4.1296914671159;
        Sat, 05 Feb 2011 06:04:31 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.232.10])
        by mx.google.com with ESMTPS id v19sm2623966wfh.0.2011.02.05.06.04.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Feb 2011 06:04:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 05 Feb 2011 21:03:03 +0700
X-Mailer: git-send-email 1.7.3.4.878.g439c7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166091>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |   70 +++++++++++++++++++++++++++++----------------------=
-------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index d86a8db..9fd7e16 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -37,6 +37,41 @@ const unsigned char null_sha1[20];
=20
 static int git_open_noatime(const char *name, struct packed_git *p);
=20
+/*
+ * This is meant to hold a *small* number of objects that you would
+ * want read_sha1_file() to be able to return, but yet you do not want
+ * to write them into the object store (e.g. a browse-only
+ * application).
+ */
+static struct cached_object {
+	unsigned char sha1[20];
+	enum object_type type;
+	void *buf;
+	unsigned long size;
+} *cached_objects;
+static int cached_object_nr, cached_object_alloc;
+
+static struct cached_object empty_tree =3D {
+	EMPTY_TREE_SHA1_BIN,
+	OBJ_TREE,
+	"",
+	0
+};
+
+static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
+{
+	int i;
+	struct cached_object *co =3D cached_objects;
+
+	for (i =3D 0; i < cached_object_nr; i++, co++) {
+		if (!hashcmp(co->sha1, sha1))
+			return co;
+	}
+	if (!hashcmp(sha1, empty_tree.sha1))
+		return &empty_tree;
+	return NULL;
+}
+
 int safe_create_leading_directories(char *path)
 {
 	char *pos =3D path + offset_1st_component(path);
@@ -2033,41 +2068,6 @@ static void *read_packed_sha1(const unsigned cha=
r *sha1,
 	return data;
 }
=20
-/*
- * This is meant to hold a *small* number of objects that you would
- * want read_sha1_file() to be able to return, but yet you do not want
- * to write them into the object store (e.g. a browse-only
- * application).
- */
-static struct cached_object {
-	unsigned char sha1[20];
-	enum object_type type;
-	void *buf;
-	unsigned long size;
-} *cached_objects;
-static int cached_object_nr, cached_object_alloc;
-
-static struct cached_object empty_tree =3D {
-	EMPTY_TREE_SHA1_BIN,
-	OBJ_TREE,
-	"",
-	0
-};
-
-static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
-{
-	int i;
-	struct cached_object *co =3D cached_objects;
-
-	for (i =3D 0; i < cached_object_nr; i++, co++) {
-		if (!hashcmp(co->sha1, sha1))
-			return co;
-	}
-	if (!hashcmp(sha1, empty_tree.sha1))
-		return &empty_tree;
-	return NULL;
-}
-
 int pretend_sha1_file(void *buf, unsigned long len, enum object_type t=
ype,
 		      unsigned char *sha1)
 {
--=20
1.7.3.4.878.g439c7
