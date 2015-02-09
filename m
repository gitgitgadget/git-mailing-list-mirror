From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] index-pack: reduce memory footprint a bit
Date: Mon,  9 Feb 2015 20:18:49 +0700
Message-ID: <1423487929-28019-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msporleder@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 14:18:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKoEp-0003Uo-6e
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 14:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277AbbBINSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Feb 2015 08:18:51 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57447 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759865AbbBINSu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 08:18:50 -0500
Received: by mail-pa0-f45.google.com with SMTP id et14so33837722pad.4
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 05:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2OfRcCmiOR0Mo3wj/VEJys5e6aQshGqC5aFloiCiZTs=;
        b=BwioZfYCZ97kuzZ8xqkaK8SQWItGEtKY10wcjCPpNDZS0IT2Bbxv25s431ToVY5GZY
         SMO70wcwRxG9ulCT/sMokWnrmnA/AYeIS2dzl09dwhN9DLTj7Lg++YB9w//G6JEotNra
         akU1HCQ8nTT7CTciYbKHJwwIpVUW5/gtsMhwiKOkjOdJMytC56KTgpQ5rMQaAFasTKNf
         Nl/aM7HE0uOrUhbKukqiLNSf/MKTGiJM1EMGAa66Qb5MNecflZCT6p4Q1a+WBSrqYAP2
         9ODNvn1p8Zl2jxcXYdKxXCNQyPJLL0gJgK9JQl5OSvO8tievq1jcS+B5TJv959a0pVb1
         xidg==
X-Received: by 10.66.55.41 with SMTP id o9mr28484816pap.80.1423487929692;
        Mon, 09 Feb 2015 05:18:49 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id ms9sm16403020pdb.41.2015.02.09.05.18.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Feb 2015 05:18:48 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Feb 2015 20:18:56 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <CACsJy8A=6m5sWnDhPPMNrWbZ=fOMXPxO_1GVh-WpHycf5gm+rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263566>

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

On a 3.4M object repo that's about 53MB. The saving is less impressive
compared to index-pack total memory use (about 400MB before delta
resolving, so the saving is just 13%)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I'm not sure if this patch is worth pursuing. It makes the code a
 little bit harder to read. I was just wondering how much memory could
 be saved..

 We could maybe save some more by splitting union delta_base with the
 assumption that pack-objects would utilize delta-ofs-offset as much
 as possible, which makes the delta_base.sha1[] a waste most of the
 time.
=20
 This repo has 2803447 deltas, and because it's a clone case, all
 delta should be ofs-delta, which means we waste about 32MB. But
 shrinking this could get ugly.

 builtin/index-pack.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 4632117..479ec5e 100644
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
+	char type;
+	char real_type;
+};
+
+struct object_entry_extra {
 	unsigned delta_depth;
 	int base_object_no;
 };
@@ -64,6 +67,7 @@ struct delta_entry {
 };
=20
 static struct object_entry *objects;
+static struct object_entry_extra *objects_extra;
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
+		objects_extra[i].delta_depth =3D objects_extra[j].delta_depth + 1;
 		deepest_delta_lock();
-		if (deepest_delta < delta_obj->delta_depth)
-			deepest_delta =3D delta_obj->delta_depth;
+		if (deepest_delta < objects_extra[i].delta_depth)
+			deepest_delta =3D objects_extra[i].delta_depth;
 		deepest_delta_unlock();
+		objects_extra[i].base_object_no =3D j;
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
+static int compare_and_swap_type(char *type,
 				 enum object_type want,
 				 enum object_type set)
 {
@@ -1499,7 +1505,7 @@ static void show_pack_info(int stat_only)
 		struct object_entry *obj =3D &objects[i];
=20
 		if (is_delta_type(obj->type))
-			chain_histogram[obj->delta_depth - 1]++;
+			chain_histogram[objects_extra[i].delta_depth - 1]++;
 		if (stat_only)
 			continue;
 		printf("%s %-6s %lu %lu %"PRIuMAX,
@@ -1508,8 +1514,8 @@ static void show_pack_info(int stat_only)
 		       (unsigned long)(obj[1].idx.offset - obj->idx.offset),
 		       (uintmax_t)obj->idx.offset);
 		if (is_delta_type(obj->type)) {
-			struct object_entry *bobj =3D &objects[obj->base_object_no];
-			printf(" %u %s", obj->delta_depth, sha1_to_hex(bobj->idx.sha1));
+			struct object_entry *bobj =3D &objects[objects_extra[i].base_object=
_no];
+			printf(" %u %s", objects_extra[i].delta_depth, sha1_to_hex(bobj->id=
x.sha1));
 		}
 		putchar('\n');
 	}
@@ -1672,6 +1678,8 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
+	if (show_stat)
+		objects_extra =3D xcalloc(nr_objects + 1, sizeof(struct object_entry=
_extra));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
--=20
2.3.0.rc1.137.g477eb31
