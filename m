From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/4] index-pack: restructure pack processing into three main functions
Date: Sun,  6 May 2012 19:31:54 +0700
Message-ID: <1336307516-1809-2-git-send-email-pclouds@gmail.com>
References: <7v8vh8c6mx.fsf@alter.siamese.dyndns.org>
 <1336307516-1809-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 14:35:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR0gn-0007dj-9Y
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 14:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab2EFMfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 08:35:44 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:52189 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab2EFMfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 08:35:43 -0400
Received: by mail-pz0-f51.google.com with SMTP id t11so171877daj.10
        for <git@vger.kernel.org>; Sun, 06 May 2012 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=P5wK7RVPNAdcLWpCdbinelIlPRSZnS3JA4gYbjv8Sko=;
        b=1Fpw7T7WrF/IMu2gJZI2C1lWE3GPfJWXw/Ufc/5hYeHwMTlEucFRrOsI/rPWB8i1VS
         is9pQuO7dqRPA6WUbXtFj8ayi1a9gYiOuXQVAOhPcear+u0iMzbYqWsJpOOzho24rkBo
         9IHPc5tg5VE2obCuIA4Xznmb78J8xqaKqy8O7vzWx+7MimEdO1JITuCAaCMTXzbw7D3h
         iknqHqr8MnGXZoj9xsPrxF5X16fub7qWdqKWPLyLxCMwkZ94uFmJ7Ua/Ln/zsK9+iE69
         Ezsqsv6fKyUPEYezBt1lBgto38/p4aFp1GxzyRWqxsUKcC1I2g7+I81E1HQjn01ZeyB1
         cgEw==
Received: by 10.68.237.198 with SMTP id ve6mr14486300pbc.116.1336307743594;
        Sun, 06 May 2012 05:35:43 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id vl10sm14845682pbc.37.2012.05.06.05.35.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 05:35:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 19:32:08 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336307516-1809-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197175>

The second pass in parse_pack_objects() are split into
resolve_deltas(). The final phase, fixing thin pack or just seal the
pack, is now in conclude_pack() function. Main pack processing is now
a sequence of these functions:

 - parse_pack_objects() reads through the input pack
 - resolve_deltas()     makes sure all deltas can be resolved
 - conclude_pack()      seals the output pack
 - write_idx_file()     writes companion index file
 - final()              moves the pack/index to proper place

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c |  128 +++++++++++++++++++++++++++++-------------=
--------
 1 files changed, 75 insertions(+), 53 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dd1c5c9..a4be4a6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -682,19 +682,26 @@ static int compare_delta_entry(const void *a, con=
st void *b)
 				   objects[delta_b->obj_no].type);
 }
=20
-/* Parse all objects and return the pack content SHA1 hash */
+static void resolve_base(struct object_entry *obj)
+{
+	struct base_data *base_obj =3D alloc_base_data();
+	base_obj->obj =3D obj;
+	base_obj->data =3D NULL;
+	find_unresolved_deltas(base_obj);
+}
+
+/*
+ * First pass:
+ * - find locations of all objects;
+ * - calculate SHA1 of all non-delta objects;
+ * - remember base (SHA1 or offset) for all deltas.
+ */
 static void parse_pack_objects(unsigned char *sha1)
 {
 	int i;
 	struct delta_entry *delta =3D deltas;
 	struct stat st;
=20
-	/*
-	 * First pass:
-	 * - find locations of all objects;
-	 * - calculate SHA1 of all non-delta objects;
-	 * - remember base (SHA1 or offset) for all deltas.
-	 */
 	if (verbose)
 		progress =3D start_progress(
 				from_stdin ? "Receiving objects" : "Indexing objects",
@@ -728,6 +735,19 @@ static void parse_pack_objects(unsigned char *sha1=
)
 	if (S_ISREG(st.st_mode) &&
 			lseek(input_fd, 0, SEEK_CUR) - input_len !=3D st.st_size)
 		die("pack has junk at the end");
+}
+
+/*
+ * Second pass:
+ * - for all non-delta objects, look if it is used as a base for
+ *   deltas;
+ * - if used as a base, uncompress the object and apply all deltas,
+ *   recursively checking if the resulting object is used as a base
+ *   for some more deltas.
+ */
+static void resolve_deltas(void)
+{
+	int i;
=20
 	if (!nr_deltas)
 		return;
@@ -736,29 +756,63 @@ static void parse_pack_objects(unsigned char *sha=
1)
 	qsort(deltas, nr_deltas, sizeof(struct delta_entry),
 	      compare_delta_entry);
=20
-	/*
-	 * Second pass:
-	 * - for all non-delta objects, look if it is used as a base for
-	 *   deltas;
-	 * - if used as a base, uncompress the object and apply all deltas,
-	 *   recursively checking if the resulting object is used as a base
-	 *   for some more deltas.
-	 */
 	if (verbose)
 		progress =3D start_progress("Resolving deltas", nr_deltas);
 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
-		struct base_data *base_obj =3D alloc_base_data();
=20
 		if (is_delta_type(obj->type))
 			continue;
-		base_obj->obj =3D obj;
-		base_obj->data =3D NULL;
-		find_unresolved_deltas(base_obj);
+		resolve_base(obj);
 		display_progress(progress, nr_resolved_deltas);
 	}
 }
=20
+/*
+ * Third pass:
+ * - append objects to convert thin pack to full pack if required
+ * - write the final 20-byte SHA-1
+ */
+static void fix_unresolved_deltas(struct sha1file *f, int nr_unresolve=
d);
+static void conclude_pack(int fix_thin_pack, const char *curr_pack, un=
signed char *pack_sha1)
+{
+	if (nr_deltas =3D=3D nr_resolved_deltas) {
+		stop_progress(&progress);
+		/* Flush remaining pack final 20-byte SHA1. */
+		flush();
+		return;
+	}
+
+	if (fix_thin_pack) {
+		struct sha1file *f;
+		unsigned char read_sha1[20], tail_sha1[20];
+		char msg[48];
+		int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
+		int nr_objects_initial =3D nr_objects;
+		if (nr_unresolved <=3D 0)
+			die("confusion beyond insanity");
+		objects =3D xrealloc(objects,
+				   (nr_objects + nr_unresolved + 1)
+				   * sizeof(*objects));
+		f =3D sha1fd(output_fd, curr_pack);
+		fix_unresolved_deltas(f, nr_unresolved);
+		sprintf(msg, "completed with %d local objects",
+			nr_objects - nr_objects_initial);
+		stop_progress_msg(&progress, msg);
+		sha1close(f, tail_sha1, 0);
+		hashcpy(read_sha1, pack_sha1);
+		fixup_pack_header_footer(output_fd, pack_sha1,
+					 curr_pack, nr_objects,
+					 read_sha1, consumed_bytes-20);
+		if (hashcmp(read_sha1, tail_sha1) !=3D 0)
+			die("Unexpected tail checksum for %s "
+			    "(disk corruption?)", curr_pack);
+	}
+	if (nr_deltas !=3D nr_resolved_deltas)
+		die("pack has %d unresolved deltas",
+		    nr_deltas - nr_resolved_deltas);
+}
+
 static int write_compressed(struct sha1file *f, void *in, unsigned int=
 size)
 {
 	git_zstream stream;
@@ -1196,40 +1250,8 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_pack_objects(pack_sha1);
-	if (nr_deltas =3D=3D nr_resolved_deltas) {
-		stop_progress(&progress);
-		/* Flush remaining pack final 20-byte SHA1. */
-		flush();
-	} else {
-		if (fix_thin_pack) {
-			struct sha1file *f;
-			unsigned char read_sha1[20], tail_sha1[20];
-			char msg[48];
-			int nr_unresolved =3D nr_deltas - nr_resolved_deltas;
-			int nr_objects_initial =3D nr_objects;
-			if (nr_unresolved <=3D 0)
-				die("confusion beyond insanity");
-			objects =3D xrealloc(objects,
-					   (nr_objects + nr_unresolved + 1)
-					   * sizeof(*objects));
-			f =3D sha1fd(output_fd, curr_pack);
-			fix_unresolved_deltas(f, nr_unresolved);
-			sprintf(msg, "completed with %d local objects",
-				nr_objects - nr_objects_initial);
-			stop_progress_msg(&progress, msg);
-			sha1close(f, tail_sha1, 0);
-			hashcpy(read_sha1, pack_sha1);
-			fixup_pack_header_footer(output_fd, pack_sha1,
-						 curr_pack, nr_objects,
-						 read_sha1, consumed_bytes-20);
-			if (hashcmp(read_sha1, tail_sha1) !=3D 0)
-				die("Unexpected tail checksum for %s "
-				    "(disk corruption?)", curr_pack);
-		}
-		if (nr_deltas !=3D nr_resolved_deltas)
-			die("pack has %d unresolved deltas",
-			    nr_deltas - nr_resolved_deltas);
-	}
+	resolve_deltas();
+	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
 	free(deltas);
 	if (strict)
 		check_objects();
--=20
1.7.8.36.g69ee2
