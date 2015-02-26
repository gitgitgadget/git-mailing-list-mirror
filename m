From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/2] index-pack: reduce object_entry size to save memory
Date: Thu, 26 Feb 2015 17:52:07 +0700
Message-ID: <1424947928-19396-2-git-send-email-pclouds@gmail.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
 <1424947928-19396-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, msporleder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 11:52:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQw34-0004WR-TV
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 11:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbbBZKwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2015 05:52:01 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46701 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbBZKwA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 05:52:00 -0500
Received: by pdjy10 with SMTP id y10so12116622pdj.13
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 02:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jlAqA8NXzIye8aH3J5/9nXvyFkljjd66UUzX4VfD1ts=;
        b=awTsbgvoc7Q/gLz3nv077DfUJyOwwhi39b+1GozOEp6GmGdW2Tt2IXjERgCp9/IJt9
         15i6jv7h3tW5dSgHJGsNhIaQhmE03X4mXMBTJ/2HpdIKOocifMyRLaJDBliVY2Kn4VdG
         iXRNM4ifeFhQOLWXXJUx+3zRt4elrqx07oz5/zIL9D/9wu0rVVCHmHDxbLdWhlHGJ60V
         BhoScjSoW7gWLtFK2mTsRyqz40MIcWZGN7ue77A6zY7FrRE55fBoiy3Wx/aPRk9VrPc5
         Ty23K/elLCeKzRBy6dbUsrqaT6V7grfAVLdIclqSTmsBc/NAmAvnkorPYXawfNBViyeT
         XBCA==
X-Received: by 10.68.125.164 with SMTP id mr4mr13617844pbb.27.1424947919976;
        Thu, 26 Feb 2015 02:51:59 -0800 (PST)
Received: from lanh ([115.73.213.171])
        by mx.google.com with ESMTPSA id b15sm592700pdk.69.2015.02.26.02.51.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 02:51:59 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 26 Feb 2015 17:52:24 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1424947928-19396-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264430>

=46or each object in the input pack, we need one struct object_entry. O=
n
x86-64, this struct is 64 bytes long. Although:

 - The 8 bytes for delta_depth and base_object_no are only useful when
   show_stat is set. And it's never set unless someone is debugging.

 - The three fields hdr_size, type and real_type take 4 bytes each
   even though they never use more than 4 bits.

By moving delta_depth and base_object_no out of struct object_entry
and make the other 3 fields one byte long instead of 4, we shrink 25%
of this struct.

On a 3.4M object repo (*) that's about 53MB. The saving is less
impressive compared to index-pack memory use for basic bookkeeping (**)=
,
about 16%.

(*) linux-2.6.git already has 4M objects as of v3.19-rc7 so this is
not an unrealistic number of objects that we have to deal with.

(**)  3.4M * (sizeof(object_entry) + sizeof(delta_entry)) =3D 311MB

Brought-up-by: Matthew Sporleder <msporleder@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4632117..9d854fb 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -18,9 +18,12 @@ static const char index_pack_usage[] =3D
 struct object_entry {
 	struct pack_idx_entry idx;
 	unsigned long size;
-	unsigned int hdr_size;
-	enum object_type type;
-	enum object_type real_type;
+	unsigned char hdr_size;
+	signed char type;
+	signed char real_type;
+};
+
+struct object_stat {
 	unsigned delta_depth;
 	int base_object_no;
 };
@@ -64,6 +67,7 @@ struct delta_entry {
 };
=20
 static struct object_entry *objects;
+static struct object_stat *obj_stat;
 static struct delta_entry *deltas;
 static struct thread_local nothread_data;
 static int nr_objects;
@@ -873,13 +877,15 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
 	void *base_data, *delta_data;
=20
 	if (show_stat) {
-		delta_obj->delta_depth =3D base->obj->delta_depth + 1;
+		int i =3D delta_obj - objects;
+		int j =3D base->obj - objects;
+		obj_stat[i].delta_depth =3D obj_stat[j].delta_depth + 1;
 		deepest_delta_lock();
-		if (deepest_delta < delta_obj->delta_depth)
-			deepest_delta =3D delta_obj->delta_depth;
+		if (deepest_delta < obj_stat[i].delta_depth)
+			deepest_delta =3D obj_stat[i].delta_depth;
 		deepest_delta_unlock();
+		obj_stat[i].base_object_no =3D j;
 	}
-	delta_obj->base_object_no =3D base->obj - objects;
 	delta_data =3D get_data_from_pack(delta_obj);
 	base_data =3D get_base_data(base);
 	result->obj =3D delta_obj;
@@ -902,7 +908,7 @@ static void resolve_delta(struct object_entry *delt=
a_obj,
  * "want"; if so, swap in "set" and return true. Otherwise, leave it u=
ntouched
  * and return false.
  */
-static int compare_and_swap_type(enum object_type *type,
+static int compare_and_swap_type(signed char *type,
 				 enum object_type want,
 				 enum object_type set)
 {
@@ -1499,7 +1505,7 @@ static void show_pack_info(int stat_only)
 		struct object_entry *obj =3D &objects[i];
=20
 		if (is_delta_type(obj->type))
-			chain_histogram[obj->delta_depth - 1]++;
+			chain_histogram[obj_stat[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
@@ -1508,8 +1514,8 @@ static void show_pack_info(int stat_only)
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
-			struct object_entry *bobj =3D &objects[obj->base_object_no];
-			printf(" %u %s", obj->delta_depth, sha1_to_hex(bobj->idx.sha1));
+			struct object_entry *bobj =3D &objects[obj_stat[i].base_object_no];
+			printf(" %u %s", obj_stat[i].delta_depth, sha1_to_hex(bobj->idx.sha=
1));
 		}
 		putchar('\n');
 	}
@@ -1672,6 +1678,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
+	if (show_stat)
+		obj_stat =3D xcalloc(nr_objects + 1, sizeof(struct object_stat));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
--=20
2.3.0.rc1.137.g477eb31
