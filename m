From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/21] index-pack, pack-objects: allow creating .idx v2 with .pack v4
Date: Wed, 11 Sep 2013 13:06:20 +0700
Message-ID: <1378879582-15372-20-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdcC-0007iD-5g
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab3IKGJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:09:20 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:39398 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab3IKGJT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:09:19 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so8737072pdj.32
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2AKK3Xr61ukNSSUEAV7d5R975SA5jF0ONDYEGJlY0tM=;
        b=X8S44IhjNJyai5GhtZHDwBxd7D+2fljfkW/lsYANMlGKapKHTm1KMuPgIB2zCoZnB3
         wYOhjgbRtyy1ApcMkRPva4eV6gNmBsiTGqEJjHHCTgHWo06UCY4QHAgo7NEmhTaGMgWq
         4IdfM68nzM3nmQQfeEqxbRg4VhdlbzxKrcIERteocQMK0So7Czb1vFIsiqlmtu2ED7Mb
         ezL8btYCUZ3e1WaXHJMOrCy/eCFJ69G+itkIoszXgWlsx1nXU3fb4LqjDNfLqdBPj6Vo
         MTF9jcbpvhe4NZdRt+vjqdFNxYLoD6F+BgXOd0395pMORMHrhxxhRnFe6Ay/n0ycTn3B
         R09A==
X-Received: by 10.68.36.132 with SMTP id q4mr18837848pbj.118.1378879758750;
        Tue, 10 Sep 2013 23:09:18 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id zq10sm1119772pab.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:09:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:09:11 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234543>

While .idx v3 is recommended because it's smaller, there is no reason
why .idx v2 can't use with .pack v4. Enable it, at least for the test
suite as some tests need to this kind of information from show-index
and show-index does not support .idx v3.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/index-pack.c   | 14 ++++++++++----
 builtin/pack-objects.c | 14 ++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1895adf..4607dc6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -89,7 +89,7 @@ static int verbose;
 static int show_stat;
 static int check_self_contained_and_connected;
 static int packv4;
-
+static int idx_version_set;
 static struct progress *progress;
=20
 /* We always read in 4kB chunks. */
@@ -1892,8 +1892,9 @@ static int git_index_pack_config(const char *k, c=
onst char *v, void *cb)
=20
 	if (!strcmp(k, "pack.indexversion")) {
 		opts->version =3D git_config_int(k, v);
-		if (opts->version > 2)
+		if (opts->version > 3)
 			die(_("bad pack.indexversion=3D%"PRIu32), opts->version);
+		idx_version_set =3D 1;
 		return 0;
 	}
 	if (!strcmp(k, "pack.threads")) {
@@ -2107,12 +2108,13 @@ int cmd_index_pack(int argc, const char **argv,=
 const char *prefix)
 			} else if (!prefixcmp(arg, "--index-version=3D")) {
 				char *c;
 				opts.version =3D strtoul(arg + 16, &c, 10);
-				if (opts.version > 2)
+				if (opts.version > 3)
 					die(_("bad %s"), arg);
 				if (*c =3D=3D ',')
 					opts.off32_limit =3D strtoul(c+1, &c, 0);
 				if (*c || opts.off32_limit & 0x80000000)
 					die(_("bad %s"), arg);
+				idx_version_set =3D 1;
 			} else
 				usage(index_pack_usage);
 			continue;
@@ -2151,6 +2153,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 		if (!index_name)
 			die(_("--verify with no packfile name given"));
 		read_idx_option(&opts, index_name);
+		idx_version_set =3D 1;
 		opts.flags |=3D WRITE_IDX_VERIFY | WRITE_IDX_STRICT;
 	}
 	if (strict)
@@ -2167,6 +2170,9 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
=20
 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
+	if (!packv4 && opts.version >=3D 3)
+		die(_("pack idx version %d does not work with pack version %d"),
+		    opts.version, 4);
 	objects =3D xcalloc(nr_objects + 1, sizeof(struct object_entry));
 	deltas =3D xcalloc(nr_objects, sizeof(struct delta_entry));
 	parse_dictionaries();
@@ -2180,7 +2186,7 @@ int cmd_index_pack(int argc, const char **argv, c=
onst char *prefix)
 	if (show_stat)
 		show_pack_info(stat_only);
=20
-	if (packv4)
+	if (packv4 && !idx_version_set)
 		opts.version =3D 3;
=20
 	idx_objects =3D xmalloc((nr_objects) * sizeof(struct pack_idx_entry *=
));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ac25973..f604fa5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -66,7 +66,7 @@ static uint32_t nr_objects, nr_alloc, nr_result, nr_w=
ritten;
=20
 static struct packv4_tables v4;
=20
-static int non_empty;
+static int non_empty, idx_version_set;
 static int reuse_delta =3D 1, reuse_object =3D 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
 static unsigned long unpack_unreachable_expiration;
@@ -2205,7 +2205,8 @@ static void prepare_pack(int window, int depth)
 		sort_dict_entries_by_hits(v4.commit_ident_table);
 		sort_dict_entries_by_hits(v4.tree_path_table);
 		v4.all_objs =3D xmalloc(nr_objects * sizeof(*v4.all_objs));
-		pack_idx_opts.version =3D 3;
+		if (!idx_version_set)
+			pack_idx_opts.version =3D 3;
 		allow_ofs_delta =3D 0;
 	}
=20
@@ -2319,9 +2320,10 @@ static int git_pack_config(const char *k, const =
char *v, void *cb)
 	}
 	if (!strcmp(k, "pack.indexversion")) {
 		pack_idx_opts.version =3D git_config_int(k, v);
-		if (pack_idx_opts.version > 2)
+		if (pack_idx_opts.version > 3)
 			die("bad pack.indexversion=3D%"PRIu32,
 			    pack_idx_opts.version);
+		idx_version_set =3D 1;
 		return 0;
 	}
 	return git_default_config(k, v, cb);
@@ -2604,12 +2606,13 @@ static int option_parse_index_version(const str=
uct option *opt,
 	char *c;
 	const char *val =3D arg;
 	pack_idx_opts.version =3D strtoul(val, &c, 10);
-	if (pack_idx_opts.version > 2)
+	if (pack_idx_opts.version > 3)
 		die(_("unsupported index version %s"), val);
 	if (*c =3D=3D ',' && c[1])
 		pack_idx_opts.off32_limit =3D strtoul(c+1, &c, 0);
 	if (*c || pack_idx_opts.off32_limit & 0x80000000)
 		die(_("bad index version '%s'"), val);
+	idx_version_set =3D 1;
 	return 0;
 }
=20
@@ -2739,6 +2742,9 @@ int cmd_pack_objects(int argc, const char **argv,=
 const char *prefix)
 		usage_with_options(pack_usage, pack_objects_options);
 	if (pack_version !=3D 2 && pack_version !=3D 4)
 		die(_("pack version %d is not supported"), pack_version);
+	if (pack_version < 4 && pack_idx_opts.version >=3D 3)
+		die(_("pack idx version %d cannot be used with pack version %d"),
+		    pack_idx_opts.version, pack_version);
=20
 	rp_av[rp_ac++] =3D "pack-objects";
 	if (thin) {
--=20
1.8.2.82.gc24b958
