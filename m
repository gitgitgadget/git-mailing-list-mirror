From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/11] pack v4: allocate dicts from the beginning
Date: Sun,  8 Sep 2013 22:04:10 +0700
Message-ID: <1378652660-6731-2-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:01:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgUh-0003A1-2s
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231Ab3IHPBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:01:35 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:46833 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202Ab3IHPB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:01:28 -0400
Received: by mail-pd0-f169.google.com with SMTP id r10so5220571pdi.28
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NRq57kqydQqkmerOy/Z8WbiSvKUHpiPUhMLS31Kw61Y=;
        b=fiqrFeVzRyDtyfJlL3w3D6Ys2FzSAPvllQw8914ufVVHOJn5GlfV4tBupGOeekqXd6
         JpBnTKMZljOKYHihw4qJtK+t8qX/I7srqwHuGbEAPJS80OJ058SqiR4FX9CqOIxfpZIq
         Ds+DTypCywpQg035SBOot8Q12YETCfwjbFmV+MlAe8/33vZmf0STsBNTvVT1g3TuWpl6
         Xpi6fk06mXHY1Pexj++mJpyBTkhYMqTktrRaFQRnACjCvEoWgzJikdyT5KUUyVmm3ape
         iNcQ7A7pLexUnQDYsC3WHBOWIwiFuL4AZ4lgP0XDRmliqu5kQWC7PMUgP1l/9ZFpHwRc
         ZCcA==
X-Received: by 10.68.19.226 with SMTP id i2mr3015636pbe.131.1378652488471;
        Sun, 08 Sep 2013 08:01:28 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id y5sm10474536pbs.18.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:01:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:04:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234240>

commit_ident_table and tree_path_table are local to packv4-create.c
and test-packv4.c. Move them out of add_*_dict_entries so
add_*_dict_entries can be exported to pack-objects.c

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 packv4-create.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/packv4-create.c b/packv4-create.c
index 38fa594..dbc2a03 100644
--- a/packv4-create.c
+++ b/packv4-create.c
@@ -181,14 +181,12 @@ static char *get_nameend_and_tz(char *from, int *=
tz_val)
 	return end;
 }
=20
-static int add_commit_dict_entries(void *buf, unsigned long size)
+int add_commit_dict_entries(struct dict_table *commit_ident_table,
+			    void *buf, unsigned long size)
 {
 	char *name, *end =3D NULL;
 	int tz_val;
=20
-	if (!commit_ident_table)
-		commit_ident_table =3D create_dict_table();
-
 	/* parse and add author info */
 	name =3D strstr(buf, "\nauthor ");
 	if (name) {
@@ -212,14 +210,12 @@ static int add_commit_dict_entries(void *buf, uns=
igned long size)
 	return 0;
 }
=20
-static int add_tree_dict_entries(void *buf, unsigned long size)
+static int add_tree_dict_entries(struct dict_table *tree_path_table,
+				 void *buf, unsigned long size)
 {
 	struct tree_desc desc;
 	struct name_entry name_entry;
=20
-	if (!tree_path_table)
-		tree_path_table =3D create_dict_table();
-
 	init_tree_desc(&desc, buf, size);
 	while (tree_entry(&desc, &name_entry)) {
 		int pathlen =3D tree_entry_len(&name_entry);
@@ -659,6 +655,9 @@ static int create_pack_dictionaries(struct packed_g=
it *p,
 	struct progress *progress_state;
 	unsigned int i;
=20
+	commit_ident_table =3D create_dict_table();
+	tree_path_table =3D create_dict_table();
+
 	progress_state =3D start_progress("Scanning objects", p->num_objects)=
;
 	for (i =3D 0; i < p->num_objects; i++) {
 		struct pack_idx_entry *obj =3D obj_list[i];
@@ -666,7 +665,8 @@ static int create_pack_dictionaries(struct packed_g=
it *p,
 		enum object_type type;
 		unsigned long size;
 		struct object_info oi =3D {};
-		int (*add_dict_entries)(void *, unsigned long);
+		int (*add_dict_entries)(struct dict_table *, void *, unsigned long);
+		struct dict_table *dict;
=20
 		display_progress(progress_state, i+1);
=20
@@ -679,9 +679,11 @@ static int create_pack_dictionaries(struct packed_=
git *p,
 		switch (type) {
 		case OBJ_COMMIT:
 			add_dict_entries =3D add_commit_dict_entries;
+			dict =3D commit_ident_table;
 			break;
 		case OBJ_TREE:
 			add_dict_entries =3D add_tree_dict_entries;
+			dict =3D tree_path_table;
 			break;
 		default:
 			continue;
@@ -693,7 +695,7 @@ static int create_pack_dictionaries(struct packed_g=
it *p,
 		if (check_sha1_signature(obj->sha1, data, size, typename(type)))
 			die("packed %s from %s is corrupt",
 			    sha1_to_hex(obj->sha1), p->pack_name);
-		if (add_dict_entries(data, size) < 0)
+		if (add_dict_entries(dict, data, size) < 0)
 			die("can't process %s object %s",
 				typename(type), sha1_to_hex(obj->sha1));
 		free(data);
--=20
1.8.2.83.gc99314b
