From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/16] index-pack: support completing thin packs v4
Date: Mon,  9 Sep 2013 20:58:07 +0700
Message-ID: <1378735087-4813-17-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1yH-0005cY-2u
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587Ab3IIN5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:57:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:51483 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554Ab3IIN5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:57:05 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so6328771pad.0
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m9mca5+SgV1bXnTi0MUu0cLf4ObzdELBdQEjQ+tJm7I=;
        b=hf24Geu8np5+ExWYxpD9N/ArNAmiZrx6ropR8SvIu+/LvGPDdLzWKS/ow+7cgwB+D9
         BjqnLx9AJm1+AMrHqbAAo+HAi6jy1nFBhdY1utwVzW+sec2KiafWQiwe4ce5AW0GImWC
         y+s7eG2NcszaPCjguO8Q8PUk3cNRshscSqrH4VxAM8W2jpOyu+lQQ93zmZYmeKUDr9H7
         3/t8S8u8WHb+WmNztfzswSuo9XAD8HzbYEaZjxhOdEGvSsXzuP4Tgug7RIXh2M+jUBKM
         nJxtQEy9grXrK//RVZetpf4s/5nflmvqoq729Rvpp9e9sls6mxEe1SvrHhhbSP1JDemX
         BFSQ==
X-Received: by 10.68.204.136 with SMTP id ky8mr1943489pbc.192.1378735025060;
        Mon, 09 Sep 2013 06:57:05 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id qf7sm17788410pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:57:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 21:00:09 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234344>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 53 +++++++++++++++++++++++++++++++++++++-------=
--------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dc9961b..8a6e2a3 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -97,7 +97,7 @@ static unsigned char input_buffer[4096];
 static unsigned int input_offset, input_len;
 static off_t consumed_bytes;
 static unsigned deepest_delta;
-static git_SHA_CTX input_ctx;
+static git_SHA_CTX input_ctx, output_ctx;
 static uint32_t input_crc32;
 static int input_fd, output_fd, pack_fd;
=20
@@ -1511,6 +1511,7 @@ static void parse_pack_objects(unsigned char *sha=
1)
 			/* Got End-of-Pack signal? */
 			eop_byte =3D fill(1);
 			if (*eop_byte =3D=3D 0) {
+				output_ctx =3D input_ctx;
 				git_SHA1_Update(&input_ctx, eop_byte, 1);
 				use(1);
 				/*
@@ -1540,7 +1541,8 @@ static void parse_pack_objects(unsigned char *sha=
1)
 		free(data);
 		display_progress(progress, i+1);
 	}
-	objects[i].idx.offset =3D consumed_bytes;
+	nr_objects =3D i;
+	objects[nr_objects].idx.offset =3D consumed_bytes;
 	stop_progress(&progress);
=20
 	if (!eop)
@@ -1634,7 +1636,7 @@ static void conclude_pack(int fix_thin_pack, cons=
t char *curr_pack, unsigned cha
 		return;
 	}
=20
-	if (fix_thin_pack) {
+	if (fix_thin_pack && !packv4) {
 		struct sha1file *f;
 		unsigned char read_sha1[20], tail_sha1[20];
 		struct strbuf msg =3D STRBUF_INIT;
@@ -1661,6 +1663,26 @@ static void conclude_pack(int fix_thin_pack, con=
st char *curr_pack, unsigned cha
 		if (hashcmp(read_sha1, tail_sha1) !=3D 0)
 			die(_("Unexpected tail checksum for %s "
 			      "(disk corruption?)"), curr_pack);
+	} else	if (fix_thin_pack && packv4) {
+		struct sha1file *f;
+		struct strbuf msg =3D STRBUF_INIT;
+		int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
+		int nr_objects_initial =3D nr_objects;
+		if (nr_unresolved <=3D 0)
+			die(_("confusion beyond insanity"));
+		f =3D sha1fd(output_fd, curr_pack);
+		f->ctx =3D output_ctx; /* resume sha-1 from right before EOP */
+		fix_unresolved_deltas(f, nr_unresolved);
+		if (nr_objects !=3D nr_objects_final)
+			die(_("pack number inconsistency, expected %u got %u"),
+			    nr_objects, nr_objects_final);
+		strbuf_addf(&msg, _("completed with %d local objects"),
+			    nr_objects_final - nr_objects_initial);
+		stop_progress_msg(&progress, msg.buf);
+		strbuf_release(&msg);
+		sha1close(f, pack_sha1, 0);
+		write_or_die(output_fd, pack_sha1, 20);
+		fsync_or_die(output_fd, f->name);
 	}
 	if (nr_deltas !=3D nr_resolved_deltas)
 		die(Q_("pack has %d unresolved delta",
@@ -1700,16 +1722,15 @@ static struct object_entry *append_obj_to_pack(=
struct sha1file *f,
 {
 	struct object_entry *obj =3D &objects[nr_objects++];
 	unsigned char header[10];
-	unsigned long s =3D size;
-	int n =3D 0;
-	unsigned char c =3D (type << 4) | (s & 15);
-	s >>=3D 4;
-	while (s) {
-		header[n++] =3D c | 0x80;
-		c =3D s & 0x7f;
-		s >>=3D 7;
-	}
-	header[n++] =3D c;
+	int n;
+
+	if (packv4) {
+		if (nr_objects > nr_objects_final)
+			die(_("too many objects"));
+		/* TODO: convert OBJ_TREE to OBJ_PV4_TREE using pv4_encode_tree */
+		n =3D pv4_encode_object_header(type, size, header);
+	} else
+		n =3D encode_in_pack_object_header(type, size, header);
 	crc32_begin(f);
 	sha1write(f, header, n);
 	obj[0].size =3D size;
@@ -1748,7 +1769,8 @@ static void fix_unresolved_deltas(struct sha1file=
 *f, int nr_unresolved)
 	 */
 	sorted_by_pos =3D xmalloc(nr_unresolved * sizeof(*sorted_by_pos));
 	for (i =3D 0; i < nr_deltas; i++) {
-		if (objects[deltas[i].obj_no].real_type !=3D OBJ_REF_DELTA)
+		struct object_entry *obj =3D objects + deltas[i].obj_no;
+		if (obj->real_type !=3D OBJ_REF_DELTA && !is_delta_tree(obj))
 			continue;
 		sorted_by_pos[n++] =3D &deltas[i];
 	}
@@ -1756,10 +1778,11 @@ static void fix_unresolved_deltas(struct sha1fi=
le *f, int nr_unresolved)
=20
 	for (i =3D 0; i < n; i++) {
 		struct delta_entry *d =3D sorted_by_pos[i];
+		struct object_entry *obj =3D objects + d->obj_no;
 		enum object_type type;
 		struct base_data *base_obj =3D alloc_base_data();
=20
-		if (objects[d->obj_no].real_type !=3D OBJ_REF_DELTA)
+		if (obj->real_type !=3D OBJ_REF_DELTA && !is_delta_tree(obj))
 			continue;
 		base_obj->data =3D read_sha1_file(d->base.sha1, &type, &base_obj->si=
ze);
 		if (!base_obj->data)
--=20
1.8.2.83.gc99314b
