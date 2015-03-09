From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/16] list-files: add --ignored
Date: Mon,  9 Mar 2015 17:18:30 +0700
Message-ID: <1425896314-10941-13-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUunE-0002Tk-BK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbbCIKUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:07 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44065 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbbCIKUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:06 -0400
Received: by padet14 with SMTP id et14so47698851pad.11
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FYdNNvJWqt2KjScF0PAaXwZuUi0KKX2dmRueHaWnPeE=;
        b=XIzy3uDGbDQwrkgzu+Knn3o+zNVSC3Mwf/HaFDRjXB1NN/FNz1rBlXdy/qC4he7m7Y
         w9/w9peDTV8jJ0Z0krbJGQZeEgvkXHKTRRzVhd+5/LymrQoMWTKLf4p7XpDZgV3/aD0p
         DxCGsQ5fwcnkEpi7E2UygtvMOdb5g4kXVdcEEYaHwP+92BoxBbrXu7Vg5FIYIPHsm3pZ
         XQQg7ieEFOmd4GTWSnsDbx+4tMaosBZsKHBm9L2iXbz/CjzU8ec4RBxBFsrkGTcX/9bg
         itnWiSrTGbUNnW3PfLKxCpLoV5x/Oa1IDPRxUwckWqEPjXv9YAa5sbgcF624fdvtw1w+
         L41A==
X-Received: by 10.70.96.165 with SMTP id dt5mr51164791pdb.119.1425896405886;
        Mon, 09 Mar 2015 03:20:05 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id rj6sm3018276pdb.32.2015.03.09.03.20.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:20:04 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:20:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265154>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 93364b9..fbacad9 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -18,6 +18,7 @@ static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
 static int show_cached, show_untracked;
+static int show_ignored;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -30,6 +31,8 @@ struct option ls_options[] =3D {
 		 N_("show cached files (default)")),
 	OPT_BOOL('o', "others", &show_untracked,
 		 N_("show untracked files")),
+	OPT_BOOL('i', "ignored", &show_ignored,
+		 N_("show ignored files")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
@@ -161,7 +164,8 @@ static void populate_cached_entries(struct string_l=
ist *result,
 }
=20
 static void populate_untracked(struct string_list *result,
-			       const struct string_list *untracked)
+			       const struct string_list *untracked,
+			       const char *tag)
 {
 	int i;
=20
@@ -177,7 +181,7 @@ static void populate_untracked(struct string_list *=
result,
 		if (!matched(result, name, st.st_mode))
 			continue;
=20
-		add_one(result, name, st.st_mode, "??");
+		add_one(result, name, st.st_mode, tag);
 	}
 }
=20
@@ -186,18 +190,22 @@ static void wt_status_populate(struct string_list=
 *result,
 {
 	struct wt_status ws;
=20
-	if (!show_untracked)
+	if (!show_untracked && !show_ignored)
 		return;
=20
 	wt_status_prepare(&ws);
 	copy_pathspec(&ws.pathspec, &recursive_pathspec);
+	if (show_ignored)
+		ws.show_ignored_files =3D 1;
 	ws.relative_paths =3D 0;
 	ws.use_color =3D 0;
 	ws.fp =3D NULL;
 	wt_status_collect(&ws);
=20
 	if (show_untracked)
-		populate_untracked(result, &ws.untracked);
+		populate_untracked(result, &ws.untracked, "??");
+	if (show_ignored)
+		populate_untracked(result, &ws.ignored, "!!");
=20
 	qsort(result->items, result->nr, sizeof(*result->items), compare_outp=
ut);
 	string_list_remove_duplicates(result, 0);
@@ -207,7 +215,7 @@ static void cleanup_tags(struct string_list *result=
)
 {
 	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
=20
-	if (show_cached + show_untracked > 1)
+	if (show_cached + show_untracked + show_ignored > 1)
 		return;
=20
 	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
@@ -287,7 +295,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
-	if (!show_cached && !show_untracked)
+	if (!show_cached && !show_untracked && !show_ignored)
 		show_cached =3D 1;
=20
 	if (want_color(use_color))
--=20
2.3.0.rc1.137.g477eb31
