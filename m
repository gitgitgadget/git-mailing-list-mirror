From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/16] list-files: add --unmerged
Date: Mon,  9 Mar 2015 17:18:31 +0700
Message-ID: <1425896314-10941-14-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUunK-0002Zg-8l
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754230AbbCIKUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:13 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33335 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbbCIKUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:12 -0400
Received: by padet14 with SMTP id et14so75097060pad.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=fL5lQctw+eJgg/QAXBKz22haBEMXL6pBU8o3fTDiYV8=;
        b=coYFBBMUcwYBVc1NSF6fQKiR7BcPtrAyo3OmSXZMuFPNstZ2/YOtricmGhbni/2wWN
         xlaKVhqKI8zhaCJtgi2DEuRUpR1YPBsqJ8x9M2TI692/b7YFBA7gPvyd41rUwKWrIF72
         illM4HRLirEVTRoRzjuBYxFVZeRSkFvm5cAMTwFqCpiWsdgmJGwqQh4u3ONbrBS6PwYR
         x7FcKqDL/desUshxvzw/gkXrv6rcZnlrv7zhh+3Gd2Ra+qLupmS28YPuL7+usMY0Ou6y
         b8M/TueY8FIxLKZFshttUeDWG71xUlyuFKg9ZV/e60TXe16jo9vviBjey2ml7OJWdngR
         nxIg==
X-Received: by 10.70.131.15 with SMTP id oi15mr51739453pdb.161.1425896412035;
        Mon, 09 Mar 2015 03:20:12 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id qa1sm18380951pdb.84.2015.03.09.03.20.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:20:11 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:20:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265155>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 47 +++++++++++++++++++++++++++++++++++++++++++-=
---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index fbacad9..a82410d 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -17,7 +17,7 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
-static int show_cached, show_untracked;
+static int show_cached, show_untracked, show_unmerged;
 static int show_ignored;
=20
 static const char * const ls_usage[] =3D {
@@ -33,6 +33,8 @@ struct option ls_options[] =3D {
 		 N_("show untracked files")),
 	OPT_BOOL('i', "ignored", &show_ignored,
 		 N_("show ignored files")),
+	OPT_BOOL('u', "unmerged", &show_unmerged,
+		 N_("show unmerged files")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
@@ -185,12 +187,46 @@ static void populate_untracked(struct string_list=
 *result,
 	}
 }
=20
+static void populate_unmerged(struct string_list *result,
+			      const struct string_list *change)
+{
+	int i;
+
+	for (i =3D 0; i < change->nr; i++) {
+		const struct string_list_item *item =3D change->items + i;
+		struct wt_status_change_data *d =3D item->util;
+		const char *name =3D item->string;
+		const char *tag;
+		struct stat st;
+
+		switch (d->stagemask) {
+		case 1: tag =3D "DD"; break; /* both deleted */
+		case 2: tag =3D "AU"; break; /* added by us */
+		case 3: tag =3D "UD"; break; /* deleted by them */
+		case 4: tag =3D "UA"; break; /* added by them */
+		case 5: tag =3D "DU"; break; /* deleted by us */
+		case 6: tag =3D "AA"; break; /* both added */
+		case 7: tag =3D "UU"; break; /* both modified */
+		default: continue;
+		}
+
+		if (lstat(name, &st))
+			/* color_filename() treats this as an orphan file */
+			st.st_mode =3D 0;
+
+		if (!matched(result, name, st.st_mode))
+			continue;
+
+		add_one(result, name, st.st_mode, tag);
+	}
+}
+
 static void wt_status_populate(struct string_list *result,
 			       struct index_state *istate)
 {
 	struct wt_status ws;
=20
-	if (!show_untracked && !show_ignored)
+	if (!show_untracked && !show_ignored && !show_unmerged)
 		return;
=20
 	wt_status_prepare(&ws);
@@ -206,6 +242,8 @@ static void wt_status_populate(struct string_list *=
result,
 		populate_untracked(result, &ws.untracked, "??");
 	if (show_ignored)
 		populate_untracked(result, &ws.ignored, "!!");
+	if (show_unmerged)
+		populate_unmerged(result, &ws.change);
=20
 	qsort(result->items, result->nr, sizeof(*result->items), compare_outp=
ut);
 	string_list_remove_duplicates(result, 0);
@@ -215,7 +253,8 @@ static void cleanup_tags(struct string_list *result=
)
 {
 	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
=20
-	if (show_cached + show_untracked + show_ignored > 1)
+	if (show_cached + show_untracked + show_ignored > 1 ||
+	    show_unmerged)
 		return;
=20
 	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
@@ -295,7 +334,7 @@ int cmd_list_files(int argc, const char **argv, con=
st char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
-	if (!show_cached && !show_untracked && !show_ignored)
+	if (!show_cached && !show_untracked && !show_ignored && !show_unmerge=
d)
 		show_cached =3D 1;
=20
 	if (want_color(use_color))
--=20
2.3.0.rc1.137.g477eb31
