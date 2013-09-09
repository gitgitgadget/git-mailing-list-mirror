From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 11/16] pack-objects: create pack v4 tables
Date: Mon,  9 Sep 2013 20:58:02 +0700
Message-ID: <1378735087-4813-12-git-send-email-pclouds@gmail.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
 <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 15:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ1xC-0003uR-Tm
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 15:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab3IIN43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 09:56:29 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:42534 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859Ab3IIN42 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 09:56:28 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so6131081pbc.18
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VsyXbBfPotmdnFuD+/O0AaUzyTRxWeO+g3bhDVvdGIY=;
        b=IbPW01bWUymid9RP0F0oeZxQfDaMwMZbHBuT36bnCtVuooAtdLDTkRwL8gk5UeyHL4
         EhePoXl04n7DplfluMt4THmX7RH3pFLbf5lH3nwVFWTfvUlSbqrdHODPknzeewM+jweT
         jdVG5h98TQJDsGpwcV0JR8Hare+Eka8/Oo3rIDwhWIm5O+Cm3kVXU6U1c5KiRUhTl528
         0tJ+B5ib3hIE1ZvUS/ApFkSmaoxjAB93Oxa3dqMwuYNnTUfEUzEapx30FRbDoxR0IbEF
         p2D0mpdX3tMSQvw1z8yaONpHh7FpYoYer6nJM69tvI8+N0oyJOI3FmrGAKnebOy2DNgh
         167w==
X-Received: by 10.66.146.199 with SMTP id te7mr20598068pab.106.1378734988046;
        Mon, 09 Sep 2013 06:56:28 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id q1sm16449606pbd.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Sep 2013 06:56:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Sep 2013 20:59:32 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378735087-4813-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234339>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-objects.c | 62 ++++++++++++++++++++++++++++++++++++++++++=
++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fb2394d..60ea5a7 100644
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
@@ -2052,6 +2055,11 @@ static void prepare_pack(int window, int depth)
 	uint32_t i, nr_deltas;
 	unsigned n;
=20
+	if (pack_version =3D=3D 4) {
+		sort_dict_entries_by_hits(v4.commit_ident_table);
+		sort_dict_entries_by_hits(v4.tree_path_table);
+	}
+
 	get_object_details();
=20
 	/*
@@ -2198,6 +2206,34 @@ static void read_object_list_from_stdin(void)
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
@@ -2205,10 +2241,26 @@ static void read_object_list_from_stdin(void)
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
@@ -2387,7 +2439,9 @@ static void get_object_list(int ac, const char **=
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
@@ -2534,7 +2588,7 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 	}
 	if (pack_to_stdout !=3D !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
-	if (pack_version !=3D 2)
+	if (pack_version !=3D 2 && pack_version !=3D 4)
 		die(_("pack version %d is not supported"), pack_version);
=20
 	rp_av[rp_ac++] =3D "pack-objects";
@@ -2586,6 +2640,10 @@ int cmd_pack_objects(int argc, const char **argv=
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
