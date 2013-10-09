From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] list-object.c: take "advantage" of new pv4_tree_desc interface
Date: Wed,  9 Oct 2013 21:46:16 +0700
Message-ID: <1381329976-32082-10-git-send-email-pclouds@gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 09 16:43:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTuzV-0007mV-0S
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 16:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab3JIOnt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Oct 2013 10:43:49 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:57206 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755692Ab3JIOns (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 10:43:48 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so999873pbc.26
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yS5+q7ReXRKzVnGbBoQkz/1Fv8WsIyeFiSTjsVFbzDA=;
        b=OxA8w0Mvxr6Sl5M9R5aDXmthzuDpcLDgs4yIzp263ThogHme7lZpJBAwTDs2aGhbVL
         LSnSwWXJ20YPb1IZgelhWTbnO9OGv4Xt1n4t1yCdeFZy1HadiSGAjC5/eJ8o3ytKNS0U
         dGBTxmWpSgw4ElGbG/OgW7rIK5akl2Wmmbhr6k8N64ABTNTk2ovU+1UUMh/oOZ/aEtU/
         ibaBmfVCkzvFmQ6ulqIkGHDXW1GLcLRnaQQ8Ptdzc6hhfWCXvW018Q2PnxOrTHSf5ikV
         J8CSiLFKOHvX+piE1jkG3hRwYqTP8EkQujYSte5FzLCkAb9FO+oATpuiCnWpNk67L1Ol
         BSrQ==
X-Received: by 10.66.136.71 with SMTP id py7mr10038145pab.2.1381329827279;
        Wed, 09 Oct 2013 07:43:47 -0700 (PDT)
Received: from lanh ([115.73.225.201])
        by mx.google.com with ESMTPSA id fk4sm55378133pab.23.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 07:43:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 09 Oct 2013 21:47:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235820>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 list-objects.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index 6def897..39ad3e6 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "revision.h"
 #include "list-objects.h"
+#include "packv4-parse.h"
=20
 static void process_blob(struct rev_info *revs,
 			 struct blob *blob,
@@ -60,6 +61,7 @@ static void process_gitlink(struct rev_info *revs,
 }
=20
 static void process_tree(struct rev_info *revs,
+			 struct pv4_tree_desc *desc,
 			 struct tree *tree,
 			 show_tree_entry_fn show_tree_entry,
 			 show_object_fn show,
@@ -69,8 +71,6 @@ static void process_tree(struct rev_info *revs,
 			 void *cb_data)
 {
 	struct object *obj =3D &tree->object;
-	struct tree_desc desc;
-	struct name_entry entry;
 	struct name_path me;
 	enum interesting match =3D revs->diffopt.pathspec.nr =3D=3D 0 ?
 		all_entries_interesting: entry_not_interesting;
@@ -96,11 +96,10 @@ static void process_tree(struct rev_info *revs,
 			strbuf_addch(base, '/');
 	}
=20
-	init_tree_desc(&desc, tree->buffer, tree->size);
-
-	while (tree_entry(&desc, &entry)) {
+	while (pv4_tree_entry(desc)) {
+		struct name_entry *entry =3D &desc->v2.entry;
 		if (match !=3D all_entries_interesting) {
-			match =3D tree_entry_interesting(&entry, base, 0,
+			match =3D tree_entry_interesting(entry, base, 0,
 						       &revs->diffopt.pathspec);
 			if (match =3D=3D all_entries_not_interesting)
 				break;
@@ -109,22 +108,26 @@ static void process_tree(struct rev_info *revs,
 		}
=20
 		if (show_tree_entry)
-			show_tree_entry(&entry, cb_data);
+			show_tree_entry(entry, cb_data);
=20
-		if (S_ISDIR(entry.mode))
+		if (S_ISDIR(entry->mode)) {
+			struct pv4_tree_desc sub_desc;
+			pv4_tree_desc_from_entry(&sub_desc, desc, 0);
 			process_tree(revs,
-				     lookup_tree(entry.sha1),
+				     &sub_desc,
+				     pv4_lookup_tree(desc),
 				     show_tree_entry,
-				     show, &me, base, entry.path,
+				     show, &me, base, entry->path,
 				     cb_data);
-		else if (S_ISGITLINK(entry.mode))
-			process_gitlink(revs, entry.sha1,
-					show, &me, entry.path,
+			pv4_release_tree_desc(&sub_desc);
+		} else if (S_ISGITLINK(entry->mode))
+			process_gitlink(revs, entry->sha1,
+					show, &me, entry->path,
 					cb_data);
 		else
 			process_blob(revs,
-				     lookup_blob(entry.sha1),
-				     show, &me, entry.path,
+				     pv4_lookup_blob(desc),
+				     show, &me, entry->path,
 				     cb_data);
 	}
 	strbuf_setlen(base, baselen);
@@ -202,9 +205,12 @@ void traverse_commit_list(struct rev_info *revs,
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_TREE) {
-			process_tree(revs, (struct tree *)obj,
+			struct pv4_tree_desc desc;
+			pv4_tree_desc_from_sha1(&desc, obj->sha1, 0);
+			process_tree(revs, &desc, (struct tree *)obj,
 				     show_tree_entry, show_object,
 				     NULL, &base, name, data);
+			pv4_release_tree_desc(&desc);
 			continue;
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
--=20
1.8.2.83.gc99314b
