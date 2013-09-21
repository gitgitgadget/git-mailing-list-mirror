From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/17] pack-objects: do not add type OBJ_NONE to objects[] in pack v4
Date: Sat, 21 Sep 2013 20:57:58 +0700
Message-ID: <1379771883-10278-13-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNf9-0001WX-VV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535Ab3IUNzw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:52 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42242 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455Ab3IUNzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so532624pab.4
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tSE/Xf7U4fWs1rVO78UbSoYZWE8MtsxfZdqyE5xl6S4=;
        b=Ll6xx1qZiaGuquD252EOOKmfXeeTwKMxq6LTwsOvLP3b+RDCBGnnCekAaR+mjEEWA8
         45DvOn+GsfQBDCfekFosGlsxugoG1MdnopWWwhqaoyNBSiEG7skpzClwwXcw3gg01i7n
         rpVWwTlKpTWrI+bC2j5WggHMrYeLo6Rhaes3pqfBHRK+8Qt2wcTb04ACz/FBldiDWUYI
         LpHaUjC5K0Y1o9IF4Hvvf/J5sadcU4jHH2Nmle7dtiCZx9r9+513ggtGHdDHU0EUe3Rn
         kueeVQAPHjhqD+NPmoW9O7I/AGsvEDWTAvOXn7wJko/kIVEULgB8RqgYPKrW8lqIuF2Q
         c2Pw==
X-Received: by 10.66.219.233 with SMTP id pr9mr14427028pac.45.1379771750958;
        Sat, 21 Sep 2013 06:55:50 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id yo2sm25710883pab.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:59:13 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235113>

This is a longer explation of what is noted in the patch. When object
names are received from stdin, we lazily put OBJ_NONE as type to
objects[]. check_object() is called for each entry in objects[] later,
when it checks for ref-delta and ofs-delta for straight copy to the
pack later.

In pack v4, we don't store commits and trees as ref-delta and we need
a way to know those are delta objects in pack v2 sources are actually
commits or trees. We detect that with "type" field in struct
object_entry, which is correctly filled when --revs is passed. Without
--revs, the "type" field would be OBJ_NONE and we would need another
sha1_object_info() or similar call to detect the true object type.

Because we need object type anyway in this code path for building up
ident and path dictionaries, fill correct type as well.

Without this, the condition "pack_version < 4 || entry->type !=3D
OBJ_TREE" in check_object() is always true when --revs is not used,
and we will encode trees as OBJ_REF_DELTA with the base either
OBJ_TREE or OBJ_PV4_TREE. That kills pv4 tree format advantages.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1e0c2e6..01954cb 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1496,6 +1496,7 @@ static void check_object(struct object_entry *ent=
ry)
 			 */
 			if (pack_version < 4 || entry->type !=3D OBJ_TREE)
 				entry->type =3D entry->in_pack_type;
+			assert(entry->type !=3D OBJ_NONE);
 			entry->delta =3D base_entry;
 			entry->delta_size =3D entry->size;
 			entry->delta_sibling =3D base_entry->delta_child;
@@ -2361,7 +2362,6 @@ static void read_object_list_from_stdin(void)
 			die("expected sha1, got garbage:\n %s", line);
=20
 		add_preferred_base_object(line+41);
-		add_object_entry(sha1, 0, line+41, 0);
=20
 		if (pack_version =3D=3D 4) {
 			void *data;
@@ -2370,7 +2370,17 @@ static void read_object_list_from_stdin(void)
 			int (*add_dict_entries)(struct dict_table *, void *, unsigned long)=
;
 			struct dict_table *dict;
=20
-			switch (sha1_object_info(sha1, &size)) {
+			type =3D sha1_object_info(sha1, &size);
+			/*
+			 * In v2, we can afford to keep entry->type =3D=3D
+			 * OBJ_NONE and check_object() will fill it
+			 * later. In v4, we need to know the type
+			 * right now, don't waste time looking for
+			 * type again later in check_object() when the
+			 * in-pack type is ref-delta.
+			 */
+			add_object_entry(sha1, type, line+41, 0);
+			switch (type) {
 			case OBJ_COMMIT:
 				add_dict_entries =3D add_commit_dict_entries;
 				dict =3D v4.commit_ident_table;
@@ -2389,7 +2399,8 @@ static void read_object_list_from_stdin(void)
 				die("can't process %s object %s",
 				    typename(type), sha1_to_hex(sha1));
 			free(data);
-		}
+		} else
+			add_object_entry(sha1, 0, line+41, 0);
 	}
 }
=20
--=20
1.8.2.83.gc99314b
