From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 07/14] index-pack: parse v4 header and dictionaries
Date: Sun,  8 Sep 2013 14:22:33 +0700
Message-ID: <1378624960-8919-8-git-send-email-pclouds@gmail.com>
References: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 08 09:20:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIZIG-00041P-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 09:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab3IHHUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 03:20:17 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:58391 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab3IHHUP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 03:20:15 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so4865124pbc.21
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mMy1s0ry/Nc5a4uWuRbsINDzC/mg5pX4jdjPYSdx/TM=;
        b=dzqedtixg483YqpUrtZpG7nou/nqM41qOuzJ0215cCJJ+hJP3hRmEq8uGVCIvJS1SI
         bgEOaxWtPsSAV+lvpVIEJH/52EE147XgDAle3ID9VxxtSbzP3fmpSRom09p7j6i/wT0q
         6Ti1JBlRyToe76UGft4kfaDRvzZXj0m8am4VDBd9eWyP+8YvKCteMD+T4CvWFw7FDaYy
         9aneVdLRF+qe5+C3vIs3E9yItbP56Ez3HzOiYbw0BhTuSHw8Q36lLTqvjSPMoIr/phI9
         aALIBBvn/rV5b/Ks1aSG5GSAWGnYrsmCEw8wcH51zJrWxWOrpMWC5kG/okvvA8iCLSAB
         ETVg==
X-Received: by 10.68.178.2 with SMTP id cu2mr48125pbc.161.1378624815405;
        Sun, 08 Sep 2013 00:20:15 -0700 (PDT)
Received: from lanh ([115.73.228.17])
        by mx.google.com with ESMTPSA id tz3sm8443890pbc.20.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 00:20:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Sep 2013 14:23:24 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378624960-8919-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234204>

---
 builtin/index-pack.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3389262..83e6e79 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "packv4-parse.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -70,6 +71,8 @@ struct delta_entry {
 static struct object_entry *objects;
 static struct delta_entry *deltas;
 static struct thread_local nothread_data;
+static unsigned char *sha1_table;
+static struct packv4_dict *name_dict, *path_dict;
 static int nr_objects;
 static int nr_deltas;
 static int nr_resolved_deltas;
@@ -81,6 +84,7 @@ static int do_fsck_object;
 static int verbose;
 static int show_stat;
 static int check_self_contained_and_connected;
+static int packv4;
 
 static struct progress *progress;
 
@@ -334,7 +338,9 @@ static void parse_pack_header(void)
 	/* Header consistency check */
 	if (hdr->hdr_signature != htonl(PACK_SIGNATURE))
 		die(_("pack signature mismatch"));
-	if (!pack_version_ok(hdr->hdr_version))
+	if (hdr->hdr_version == htonl(4))
+		packv4 = 1;
+	else if (!pack_version_ok(hdr->hdr_version))
 		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
 
@@ -1035,6 +1041,40 @@ static void *threaded_second_pass(void *data)
 }
 #endif
 
+static struct packv4_dict *read_dict(void)
+{
+	unsigned long size;
+	unsigned char *data;
+	struct packv4_dict *dict;
+
+	size = read_varint();
+	data = xmallocz(size);
+	read_and_inflate(consumed_bytes, data, size, 0, NULL, NULL);
+	dict = pv4_create_dict(data, size);
+	if (!dict)
+		die("unable to parse dictionary");
+	return dict;
+}
+
+static void parse_dictionaries(void)
+{
+	int i;
+	if (!packv4)
+		return;
+
+	sha1_table = xmalloc(20 * nr_objects);
+	hashcpy(sha1_table, fill_and_use(20));
+	for (i = 1; i < nr_objects; i++) {
+		unsigned char *p = sha1_table + i * 20;
+		hashcpy(p, fill_and_use(20));
+		if (hashcmp(p - 20, p) >= 0)
+			die(_("wrong order in SHA-1 table at entry %d"), i);
+	}
+
+	name_dict = read_dict();
+	path_dict = read_dict();
+}
+
 /*
  * First pass:
  * - find locations of all objects;
@@ -1673,6 +1713,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	parse_pack_header();
 	objects = xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas = xcalloc(nr_objects, sizeof(struct delta_entry));
+	parse_dictionaries();
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
@@ -1683,6 +1724,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (show_stat)
 		show_pack_info(stat_only);
 
+	if (packv4)
+		die("we're not there yet");
+
 	idx_objects = xmalloc((nr_objects) * sizeof(struct pack_idx_entry *));
 	for (i = 0; i < nr_objects; i++)
 		idx_objects[i] = &objects[i].idx;
@@ -1699,6 +1743,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
+	free(sha1_table);
+	pv4_free_dict(name_dict);
+	pv4_free_dict(path_dict);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
-- 
1.8.2.83.gc99314b
