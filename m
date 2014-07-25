From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] refs.c: rewrite resolve_gitlink_ref() to use parse_ref()
Date: Fri, 25 Jul 2014 17:43:59 +0700
Message-ID: <1406285039-22469-5-git-send-email-pclouds@gmail.com>
References: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:44:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAczV-0004K2-2W
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 12:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760182AbaGYKol convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 06:44:41 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33594 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbaGYKoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 06:44:37 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so5500837pdj.12
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 03:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iUwP0fuBd7yDhNo4cjVptXYVDh0+C1Y+tppbsu2M3ZM=;
        b=AywHlil23BrlMsJs6gj+BUYV2hcWm3LdZcgymyB9aMiu8QDrrJ5F7SfW24l/geGntc
         J+U1glaJyxPH/qLbSclqRz0FFbGYF+3ja/g8EsH9uAAzvKwHojKatzGfg5QuECZzfAwx
         aJ096aLKst5PIUr6kYw9AvW53J2H8i68F9hJ2mAnZjf9aBoX6b8fOmgNQC9elIjVHs4j
         db5Zvd6yTESkPZUnVKwi1Zr+X1H4e/yeofkumInfNwKCPGRpqsboivvtjChyAvdaD+0+
         YvJVk/DnTqabFgtsvD4RgN0NIeIstP+5av6m6FDHrfCGXHsIZPkwwupfGvHzoBHCWOyu
         KhYw==
X-Received: by 10.70.127.133 with SMTP id ng5mr3169756pdb.80.1406285077007;
        Fri, 25 Jul 2014 03:44:37 -0700 (PDT)
Received: from lanh ([115.73.251.194])
        by mx.google.com with ESMTPSA id dr9sm11146334pdb.78.2014.07.25.03.44.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jul 2014 03:44:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 25 Jul 2014 17:44:34 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1406285039-22469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254207>

resolve_gitlink_ref_recursive() is less strict than the old
resolve_ref_unsafe() (which is now parse_ref()). It also has another
random limit 128 bytes for symrefs.

This brings MAXREFLEN check to resolve_ref* family. It looks like an
arbitrary limit though (added in 0ebde32 (Add 'resolve_gitlink_ref()'
helper function - 2007-04-09)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 refs.c | 68 +++++++++++++++++++++++++---------------------------------=
--------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/refs.c b/refs.c
index 2769f20..24503e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1436,48 +1436,11 @@ static int resolve_gitlink_packed_ref(struct re=
f_cache *refs,
 	return 0;
 }
=20
-static int resolve_gitlink_ref_recursive(struct ref_cache *refs,
-					 const char *refname, unsigned char *sha1,
-					 int recursion)
-{
-	int fd, len;
-	char buffer[128], *p;
-	char *path;
-
-	if (recursion > MAXDEPTH || strlen(refname) > MAXREFLEN)
-		return -1;
-	path =3D *refs->name
-		? git_path_submodule(refs->name, "%s", refname)
-		: git_path("%s", refname);
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		return resolve_gitlink_packed_ref(refs, refname, sha1);
-
-	len =3D read(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-	if (len < 0)
-		return -1;
-	while (len && isspace(buffer[len-1]))
-		len--;
-	buffer[len] =3D 0;
-
-	/* Was it a detached head or an old-fashioned symlink? */
-	if (!get_sha1_hex(buffer, sha1))
-		return 0;
-
-	/* Symref? */
-	if (strncmp(buffer, "ref:", 4))
-		return -1;
-	p =3D buffer + 4;
-	while (isspace(*p))
-		p++;
-
-	return resolve_gitlink_ref_recursive(refs, p, sha1, recursion+1);
-}
-
 int resolve_gitlink_ref(const char *path, const char *refname, unsigne=
d char *sha1)
 {
-	int len =3D strlen(path), retval;
+	struct strbuf result =3D STRBUF_INIT;
+	int len =3D strlen(path), retval =3D 0;
+	int depth =3D MAXDEPTH;
 	char *submodule;
 	struct ref_cache *refs;
=20
@@ -1489,8 +1452,24 @@ int resolve_gitlink_ref(const char *path, const =
char *refname, unsigned char *sh
 	refs =3D get_ref_cache(submodule);
 	free(submodule);
=20
-	retval =3D resolve_gitlink_ref_recursive(refs, refname, sha1, 0);
-	return retval;
+	strbuf_addstr(&result, refname);
+	while (!retval) {
+		if (--depth < 0) {
+			errno =3D ELOOP;
+			retval =3D -1;
+			break;
+		}
+		path =3D *refs->name
+			? git_path_submodule(refs->name, "%s", result.buf)
+			: git_path("%s", result.buf);
+		retval =3D parse_ref(path, &result, sha1, NULL);
+		if (retval =3D=3D -2) {
+			retval =3D resolve_gitlink_packed_ref(refs, result.buf, sha1);
+			retval =3D retval ? -1 : 1;
+		}
+	}
+	strbuf_release(&result);
+	return retval > 0 ? 0 : -1;
 }
=20
 /*
@@ -1540,6 +1519,11 @@ int parse_ref(const char *path, struct strbuf *r=
ef,
 	struct stat st;
 	const char *buf;
=20
+	if (ref->len > MAXREFLEN) {
+		errno =3D ENAMETOOLONG;
+		return -1;
+	}
+
 	/*
 	 * We might have to loop back here to avoid a race condition:
 	 * first we lstat() the file, then we try to read it as a link
--=20
1.9.1.346.ga2b5940
