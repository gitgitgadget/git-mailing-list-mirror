From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/12] index-pack: parse v4 header and dictionaries
Date: Sat,  7 Sep 2013 17:43:12 +0700
Message-ID: <1378550599-25365-6-git-send-email-pclouds@gmail.com>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 07 12:41:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIFx0-0002mq-HC
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 12:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab3IGKlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Sep 2013 06:41:06 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33266 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3IGKlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 06:41:04 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp13so4318626pab.21
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eh9nAO2pWwkQjDlZMQLktdqXqJVABvZIi9p7CAlcbqo=;
        b=Fb6OOrlho29bD1st1JfVLHhoe3IvRJpRVzSc23NMJP7uDsbZ3csCVs6tcqd1Gw7Z5O
         dwYCHbHWLW39RgF1/xjsPxb3rFlNO2Uh141a3/EDCH0VhNK5E7FtI3S4YwE3PNH4kWJ+
         3cAztS+77FhwQwp0TkO87mSuq8w/228la6QesH/J/+jcPTe4LCMW5rZGEUSUCjY8cwWW
         YSv6YwEwikVhyx4hF/he4NWlKjRAIYXGx00i2aQ43QhDwjKXrmJ5j8ApnxrFBf4tXZf4
         YTHWh+QV6bUT+NnOA35yrQvRaWkNTrtbGLefI9Cu7DhLPwnIs4CVZJB7m0CB9ZwYXh7t
         gfhg==
X-Received: by 10.66.119.136 with SMTP id ku8mr8913320pab.121.1378550463520;
        Sat, 07 Sep 2013 03:41:03 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id tg7sm3375923pbc.36.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 07 Sep 2013 03:41:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 07 Sep 2013 17:44:11 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378550599-25365-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234123>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c | 61 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0dd7193..59b6c56 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -11,6 +11,7 @@
 #include "exec_cmd.h"
 #include "streaming.h"
 #include "thread-utils.h"
+#include "packv4-parse.h"
=20
 static const char index_pack_usage[] =3D
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=3D<msg>] [--ve=
rify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
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
=20
 static struct progress *progress;
=20
@@ -300,6 +304,21 @@ static uintmax_t read_varint(void)
 	return val;
 }
=20
+static void *read_data(int size)
+{
+	const int max =3D sizeof(input_buffer);
+	void *buf;
+	char *p;
+	p =3D buf =3D xmalloc(size);
+	while (size) {
+		int to_fill =3D size > max ? max : size;
+		memcpy(p, fill_and_use(to_fill), to_fill);
+		p +=3D to_fill;
+		size -=3D to_fill;
+	}
+	return buf;
+}
+
 static const char *open_pack_file(const char *pack_name)
 {
 	if (from_stdin) {
@@ -332,7 +351,9 @@ static void parse_pack_header(void)
 	/* Header consistency check */
 	if (hdr->hdr_signature !=3D htonl(PACK_SIGNATURE))
 		die(_("pack signature mismatch"));
-	if (!pack_version_ok(hdr->hdr_version))
+	if (hdr->hdr_version =3D=3D htonl(4))
+		packv4 =3D 1;
+	else if (!pack_version_ok(hdr->hdr_version))
 		die(_("pack version %"PRIu32" unsupported"),
 			ntohl(hdr->hdr_version));
=20
@@ -1013,6 +1034,31 @@ static void *threaded_second_pass(void *data)
 }
 #endif
=20
+static struct packv4_dict *read_dict(void)
+{
+	unsigned long size;
+	unsigned char *data;
+	struct packv4_dict *dict;
+
+	size =3D read_varint();
+	data =3D xmallocz(size);
+	read_and_inflate(consumed_bytes, data, size, 0, NULL, NULL);
+	dict =3D pv4_create_dict(data, size);
+	if (!dict)
+		die("unable to parse dictionary");
+	return dict;
+}
+
+static void parse_dictionaries(void)
+{
+	if (!packv4)
+		return;
+
+	sha1_table =3D read_data(20 * nr_objects);
+	name_dict =3D read_dict();
+	path_dict =3D read_dict();
+}
+
 /*
  * First pass:
  * - find locations of all objects;
@@ -1651,6 +1697,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	parse_pack_header();
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
+	parse_dictionaries();
 	parse_pack_objects(pack_sha1);
 	resolve_deltas();
 	conclude_pack(fix_thin_pack, curr_pack, pack_sha1);
@@ -1661,6 +1708,9 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (show_stat)
 		show_pack_info(stat_only);
=20
+	if (packv4)
+		die("we're not there yet");
+
 	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
 	for (i =3D 0; i < nr_objects; i++)
 		idx_objects[i] =3D &objects[i].idx;
@@ -1677,6 +1727,15 @@ int cmd_index_pack(int argc, const char **argv, =
const char *prefix)
 	free(objects);
 	free(index_name_buf);
 	free(keep_name_buf);
+	free(sha1_table);
+	if (name_dict) {
+		free((void*)name_dict->data);
+		free(name_dict);
+	}
+	if (path_dict) {
+		free((void*)path_dict->data);
+		free(path_dict);
+	}
 	if (pack_name =3D=3D NULL)
 		free((void *) curr_pack);
 	if (index_name =3D=3D NULL)
--=20
1.8.2.83.gc99314b
