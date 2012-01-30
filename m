From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] find_pack_entry(): do not keep packed_git pointer locally
Date: Mon, 30 Jan 2012 18:25:50 +0700
Message-ID: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 12:22:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrpJz-0006Xe-KO
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196Ab2A3LWr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 06:22:47 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48853 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab2A3LWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:22:46 -0500
Received: by dadi2 with SMTP id i2so3467066dad.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=0CWYQudo9Uey6lKqFMXrjxSyTk4Xba+OjyRwwiEur+8=;
        b=HwAiWy3kLIVcwyr5j70DD5y5BYnoDtfmbK+QiNsrIlTaXSjwq1RKcyh6tf7RDl1ud2
         YOdsVpunqZ6I4lJVvTOCuovlBwClB8yINaQRbZYW4zhPAxtGIKrXl+Fe3QFwvf22QySW
         xShRcSPI6J5McexaiRYVu8hG2/s+D0GKxm+sY=
Received: by 10.68.213.228 with SMTP id nv4mr40850882pbc.52.1327922566318;
        Mon, 30 Jan 2012 03:22:46 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id x4sm31258131pbx.16.2012.01.30.03.22.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 03:22:44 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 30 Jan 2012 18:25:51 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189344>

Commit f7c22cc (always start looking up objects in the last used pack
first - 2007-05-30) introduces a static packed_git* pointer as an
optimization.  The kept pointer however may become invalid if
free_pack_by_name() happens to free that particular pack.

Current code base does not access packs after calling
free_pack_by_name() so it should not be a problem. Anyway, move the
pointer out so that free_pack_by_name() can reset it to avoid running
into troubles in future.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 sha1_file.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 88f2151..4ecc953 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -54,6 +54,8 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
+static struct packed_git *find_pack_entry_last_found =3D (void *)1;
+
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
 	int i;
@@ -720,6 +722,8 @@ void free_pack_by_name(const char *pack_name)
 			close_pack_index(p);
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
+			if (find_pack_entry_last_found =3D=3D p)
+				find_pack_entry_last_found =3D (void*)1;
 			free(p);
 			return;
 		}
@@ -2012,14 +2016,13 @@ int is_pack_valid(struct packed_git *p)
=20
 static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
 {
-	static struct packed_git *last_found =3D (void *)1;
 	struct packed_git *p;
 	off_t offset;
=20
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p =3D (last_found =3D=3D (void *)1) ? packed_git : last_found;
+	p =3D (find_pack_entry_last_found =3D=3D (void *)1) ? packed_git : fi=
nd_pack_entry_last_found;
=20
 	do {
 		if (p->num_bad_objects) {
@@ -2046,16 +2049,16 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 			e->offset =3D offset;
 			e->p =3D p;
 			hashcpy(e->sha1, sha1);
-			last_found =3D p;
+			find_pack_entry_last_found =3D p;
 			return 1;
 		}
=20
 		next:
-		if (p =3D=3D last_found)
+		if (p =3D=3D find_pack_entry_last_found)
 			p =3D packed_git;
 		else
 			p =3D p->next;
-		if (p =3D=3D last_found)
+		if (p =3D=3D find_pack_entry_last_found)
 			p =3D p->next;
 	} while (p);
 	return 0;
--=20
1.7.8.36.g69ee2
