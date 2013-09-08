From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/11] pack-objects: create pack v4 tables
Date: Sun,  8 Sep 2013 22:04:17 +0700
Message-ID: <1378652660-6731-9-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:02:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgVE-0003eC-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148Ab3IHPCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:02:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58220 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab3IHPCK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:02:10 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so5135691pde.23
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KaUHOxVAmhQyhfeCOENCvucajjCD3tJRTvxEl0qZogM=;
        b=f9fcM5qsDCw5uh2ZFqhgQmue5j899r/8cd00vvu+9CYz2xTSkoOKb46B0sjPRCc/AM
         IStJrRHw4bqQ2lgCMPpFTcOs57mxC3qM0QbpQZPKuzyZp8xaI/l3WpJ0c2nwtLjI0YL7
         31gG5bxH6NVpTvn7Khg+WJ5/PAGvfwgkm7DyJaTikC8UFmUdqklFDtWr2D81fnPQk3vD
         8QUXlRnVPk6nAcvRlrcJ0jsByPexX8ZQ1obU+1s1I2h02lzbrSzHikPTAbwvCCpOlWR5
         c8lCVegWovMcw9exWP0Lh6p+S0v6RJljzRbbg/EqzsidCebYN5bzy1MmdMI2usd8U8CO
         eDYQ==
X-Received: by 10.68.198.98 with SMTP id jb2mr569634pbc.197.1378652529525;
        Sun, 08 Sep 2013 08:02:09 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id xn12sm11454715pac.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 08:02:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 22:05:18 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234247>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 87 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index b38d3dc..69a22c1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -18,6 +18,7 @@
 #include "refs.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "packv4-create.h"
=20
 static const char *pack_usage[] =3D {
 	N_("git pack-objects --stdout [options...] [< ref-list | < object-lis=
t]"),
@@ -61,6 +62,8 @@ static struct object_entry *objects;
 static struct pack_idx_entry **written_list;
 static uint32_t nr_objects, nr_alloc, nr_result, nr_written;
=20
+static struct packv4_tables v4;
+
 static int non_empty;
 static int reuse_delta =3D 1, reuse_object =3D 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
@@ -2039,12 +2042,42 @@ static int add_ref_tag(const char *path, const =
unsigned char *sha1, int flag, vo
 	return 0;
 }
=20
+static int sha1_idx_sort(const void *a_, const void *b_)
+{
+	const struct pack_idx_entry *a =3D a_;
+	const struct pack_idx_entry *b =3D b_;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+static void prepare_sha1_table(void)
+{
+	unsigned i;
+	/*
+	 * This table includes SHA-1s that may not be present in the
+	 * pack. One of the use of such SHA-1 is for completing thin
+	 * packs, where index-pack does not need to add SHA-1 to the
+	 * table at completion time.
+	 */
+	v4.all_objs =3D xmalloc(nr_objects * sizeof(*v4.all_objs));
+	v4.all_objs_nr =3D nr_objects;
+	for (i =3D 0; i < nr_objects; i++)
+		v4.all_objs[i] =3D objects[i].idx;
+	qsort(v4.all_objs, nr_objects, sizeof(*v4.all_objs),
+	      sha1_idx_sort);
+}
+
 static void prepare_pack(int window, int depth)
 {
 	struct object_entry **delta_list;
 	uint32_t i, nr_deltas;
 	unsigned n;
=20
+	if (pack_version =3D=3D 4) {
+		sort_dict_entries_by_hits(v4.commit_ident_table);
+		sort_dict_entries_by_hits(v4.tree_path_table);
+		prepare_sha1_table();
+	}
+
 	get_object_details();
=20
 	/*
@@ -2191,6 +2224,34 @@ static void read_object_list_from_stdin(void)
=20
 		add_preferred_base_object(line+41);
 		add_object_entry(sha1, 0, line+41, 0);
+
+		if (pack_version =3D=3D 4) {
+			void *data;
+			enum object_type type;
+			unsigned long size;
+			int (*add_dict_entries)(struct dict_table *, void *, unsigned long)=
;
+			struct dict_table *dict;
+
+			switch (sha1_object_info(sha1, &size)) {
+			case OBJ_COMMIT:
+				add_dict_entries =3D add_commit_dict_entries;
+				dict =3D v4.commit_ident_table;
+				break;
+			case OBJ_TREE:
+				add_dict_entries =3D add_tree_dict_entries;
+				dict =3D v4.tree_path_table;
+				break;
+			default:
+				continue;
+			}
+			data =3D read_sha1_file(sha1, &type, &size);
+			if (!data)
+				die("cannot unpack %s", sha1_to_hex(sha1));
+			if (add_dict_entries(dict, data, size) < 0)
+				die("can't process %s object %s",
+				    typename(type), sha1_to_hex(sha1));
+			free(data);
+		}
 	}
 }
=20
@@ -2198,10 +2259,26 @@ static void read_object_list_from_stdin(void)
=20
 static void show_commit(struct commit *commit, void *data)
 {
+	if (pack_version =3D=3D 4) {
+		unsigned long size;
+		enum object_type type;
+		unsigned char *buf;
+
+		/* commit->buffer is NULL most of the time, don't bother */
+		buf =3D read_sha1_file(commit->object.sha1, &type, &size);
+		add_commit_dict_entries(v4.commit_ident_table, buf, size);
+		free(buf);
+	}
 	add_object_entry(commit->object.sha1, OBJ_COMMIT, NULL, 0);
 	commit->object.flags |=3D OBJECT_ADDED;
 }
=20
+static void show_tree_entry(const struct name_entry *entry, void *data=
)
+{
+	dict_add_entry(v4.tree_path_table, entry->mode, entry->path,
+		       tree_entry_len(entry));
+}
+
 static void show_object(struct object *obj,
 			const struct name_path *path, const char *last,
 			void *data)
@@ -2380,7 +2457,9 @@ static void get_object_list(int ac, const char **=
av)
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	traverse_commit_list(&revs, show_commit, NULL, show_object, NULL);
+	traverse_commit_list(&revs, show_commit,
+			     pack_version =3D=3D 4 ? show_tree_entry : NULL,
+			     show_object, NULL);
=20
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
@@ -2527,7 +2606,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	}
 	if (pack_to_stdout !=3D !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
-	if (pack_version !=3D 2)
+	if (pack_version !=3D 2 && pack_version !=3D 4)
 		die(_("pack version %d is not supported"), pack_version);
=20
 	rp_av[rp_ac++] =3D "pack-objects";
@@ -2579,6 +2658,10 @@ int cmd_pack_objects(int argc, const char **argv=
, const char *prefix)
 		progress =3D 2;
=20
 	prepare_packed_git();
+	if (pack_version =3D=3D 4) {
+		v4.commit_ident_table =3D create_dict_table();
+		v4.tree_path_table =3D create_dict_table();
+	}
=20
 	if (progress)
 		progress_state =3D start_progress("Counting objects", 0);
--=20
1.8.2.83.gc99314b
