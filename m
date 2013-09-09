From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 01/16] pack v4: allocate dicts from the beginning
Date: Mon,  9 Sep 2013 20:57:52 +0700
Message-ID: <1378735087-4813-2-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:55:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1wU-0002kL-Vb
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab3IINzs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:55:48 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46433 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab3IINzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:55:16 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so6198502pde.24
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NRq57kqydQqkmerOy/Z8WbiSvKUHpiPUhMLS31Kw61Y=;
        b=q9ysc7wcw7NenqmD/HqoT5E9VQndnp1oOkMXauI878njhWsGuGZKv5a+zRxR3AaRQf
         botJaLX792IIyRU05dG7vhpT824uUearDhoiKEpBzQ+rsd88y9Vl1ec90u2s/bTQ7ZrN
         h8LoLok6xCuueimD3T0ux2i8usv84RBBSDH4loWtGtM81+JLLjs7hGLEOEdx36ZkqiPi
         eZMqjiPetX9n9lb9/yK/LiaBSDgECyec8+NM9nfnUbjt/g250rtd6y91JR7Gm6EKgEOX
         RHVqIsfOd+Ek3e5Bzsc82A6qrqyCZp6qx+J0pzRhZLFUYyYMlviiBVW31rIwj2n8QxYw
         fvbA==
X-Received: by 10.67.14.231 with SMTP id fj7mr8752841pad.115.1378734916423;
        Mon, 09 Sep 2013 06:55:16 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id f2sm15471200pbg.44.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:55:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:58:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234333>

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
