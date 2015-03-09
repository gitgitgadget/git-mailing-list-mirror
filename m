From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/16] list-files: add --cached and --others
Date: Mon,  9 Mar 2015 17:18:29 +0700
Message-ID: <1425896314-10941-12-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUun8-0002Oy-9c
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbbCIKUC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:02 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42403 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbbCIKUA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:00 -0400
Received: by padfa1 with SMTP id fa1so71561867pad.9
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eduhLyWcL2AnmcRsmDx2IwxIVKMgJS7X9m8qL0T5sx8=;
        b=Pl9d8Aj6g8YCSGOplHuS3IhoNiKM26h8oVWGX1zm289b/C2ETuxZghn7RSnbP42Yy+
         vXUKMKK8tIPAPvgi5xXpyJl1dqkPbDHE8rbbmo7kUECK15R+2vAfP2JhBDtV0h38haTp
         UCDi0cVzrIiUbal8/7j14q+M/3slI84isw4R+U+2hoqHddeL5OqIg5k2panxkwwiOteO
         Uzncffm6YNMWLoPNHwj2ooMzNDz5fcCh77EiGVjcubU6a5gDKO6lFBTI7Ko16tQ8q80v
         5rbNU5F4fTSAYlK475hq0JSip3cCubkugbKlANCxPmtYX65FezxzFixOrTlFjmlt1i2B
         NuOQ==
X-Received: by 10.70.37.202 with SMTP id a10mr52863421pdk.108.1425896399567;
        Mon, 09 Mar 2015 03:19:59 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id t13sm10240631pdl.20.2015.03.09.03.19.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:19:58 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:19:55 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265153>

If no filter options are specified, --cached is the default.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 62 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 62 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index eb51e7a..93364b9 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "column.h"
 #include "color.h"
+#include "wt-status.h"
=20
 static struct pathspec pathspec;
 static struct pathspec recursive_pathspec;
@@ -16,6 +17,7 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
+static int show_cached, show_untracked;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -23,6 +25,13 @@ static const char * const ls_usage[] =3D {
 };
=20
 struct option ls_options[] =3D {
+	OPT_GROUP(N_("Filter options")),
+	OPT_BOOL('c', "cached", &show_cached,
+		 N_("show cached files (default)")),
+	OPT_BOOL('o', "others", &show_untracked,
+		 N_("show untracked files")),
+
+	OPT_GROUP(N_("Other")),
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
 	OPT_SET_INT('1', NULL, &colopts,
 		    N_("shortcut for --no-column"), COL_PARSEOPT),
@@ -133,6 +142,9 @@ static void populate_cached_entries(struct string_l=
ist *result,
 {
 	int i;
=20
+	if (!show_cached)
+		return;
+
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce =3D istate->cache[i];
=20
@@ -148,10 +160,56 @@ static void populate_cached_entries(struct string=
_list *result,
 	string_list_remove_duplicates(result, 0);
 }
=20
+static void populate_untracked(struct string_list *result,
+			       const struct string_list *untracked)
+{
+	int i;
+
+	for (i =3D 0; i < untracked->nr; i++) {
+		const struct string_list_item *item =3D untracked->items + i;
+		const char *name =3D item->string;
+		struct stat st;
+
+		if (lstat(name, &st))
+			/* color_filename() treats this as an orphan file */
+			st.st_mode =3D 0;
+
+		if (!matched(result, name, st.st_mode))
+			continue;
+
+		add_one(result, name, st.st_mode, "??");
+	}
+}
+
+static void wt_status_populate(struct string_list *result,
+			       struct index_state *istate)
+{
+	struct wt_status ws;
+
+	if (!show_untracked)
+		return;
+
+	wt_status_prepare(&ws);
+	copy_pathspec(&ws.pathspec, &recursive_pathspec);
+	ws.relative_paths =3D 0;
+	ws.use_color =3D 0;
+	ws.fp =3D NULL;
+	wt_status_collect(&ws);
+
+	if (show_untracked)
+		populate_untracked(result, &ws.untracked);
+
+	qsort(result->items, result->nr, sizeof(*result->items), compare_outp=
ut);
+	string_list_remove_duplicates(result, 0);
+}
+
 static void cleanup_tags(struct string_list *result)
 {
 	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
=20
+	if (show_cached + show_untracked > 1)
+		return;
+
 	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
 		const char *s0 =3D result->items[i - 1].string;
 		const char *s1 =3D result->items[i].string;
@@ -229,6 +287,9 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
+	if (!show_cached && !show_untracked)
+		show_cached =3D 1;
+
 	if (want_color(use_color))
 		parse_ls_color();
=20
@@ -248,6 +309,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
 		      &recursive_pathspec, NULL, NULL);
=20
 	populate_cached_entries(&result, &the_index);
+	wt_status_populate(&result, &the_index);
 	cleanup_tags(&result);
 	display(&result);
 	string_list_clear(&result, 0);
--=20
2.3.0.rc1.137.g477eb31
