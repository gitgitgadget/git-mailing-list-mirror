From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/16] list-files: add file modification options -[admADM]
Date: Mon,  9 Mar 2015 17:18:32 +0700
Message-ID: <1425896314-10941-15-git-send-email-pclouds@gmail.com>
References: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 09 11:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUunQ-0002fR-Do
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 11:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbbCIKUU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2015 06:20:20 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33792 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbbCIKUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 06:20:18 -0400
Received: by pdno5 with SMTP id o5so19843916pdn.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 03:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WRJfVhyav23kNwOSAxK+EF+UqennkFK5LGLwKCKi24w=;
        b=py81tf9t/PHQbHXYu5iJr9+yK+l6AjDZJUBevcn0cwy6z9kV2jQFD7Tc/UE6Q33WrB
         9vm7k6gxoPtazB0DObR0SAUmPd+UeGnEUgkgiqH8xWR1GKSetwL795e+BfDEH0kiiD/J
         I/udiZrCLT4PHPpq3AN3vX2TiXUm0TGX0R8x1kyMT0BJ3UjNNAc+mPg94gONOMAgUPig
         fx/YUvRWgo3wEs4fIi+4e1IaEo+RcDWmdQp9VLeASR1QKCkLdSzjgr73oENlpG+zMvaO
         9dSC3CUfQeZnIe1y9YmtOf4vloAf2D6WXCZQEYN/qkTWdb1olfbmmbREn68i7jtKSaW+
         bIKA==
X-Received: by 10.66.184.106 with SMTP id et10mr53410711pac.138.1425896418004;
        Mon, 09 Mar 2015 03:20:18 -0700 (PDT)
Received: from lanh ([115.73.245.123])
        by mx.google.com with ESMTPSA id ba12sm18552142pac.23.2015.03.09.03.20.14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2015 03:20:17 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 09 Mar 2015 17:20:14 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425896314-10941-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265156>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 71 ++++++++++++++++++++++++++++++++++++++++++++=
++++----
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index a82410d..74836f6 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -17,8 +17,10 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
-static int show_cached, show_untracked, show_unmerged;
+static int show_cached, show_untracked, show_unmerged, show_changed;
 static int show_ignored;
+static int show_added, show_deleted, show_modified;
+static int show_wt_added, show_wt_deleted, show_wt_modified;
=20
 static const char * const ls_usage[] =3D {
 	N_("git list-files [options] [<pathspec>...]"),
@@ -35,6 +37,18 @@ struct option ls_options[] =3D {
 		 N_("show ignored files")),
 	OPT_BOOL('u', "unmerged", &show_unmerged,
 		 N_("show unmerged files")),
+	OPT_BOOL('a', "added", &show_added,
+		 N_("show added files compared to HEAD")),
+	OPT_BOOL('d', "deleted", &show_deleted,
+		 N_("show deleted files compared to HEAD")),
+	OPT_BOOL('m', "modified", &show_modified,
+		 N_("show modified files compared to HEAD")),
+	OPT_BOOL('A', "wt-added", &show_wt_added,
+		 N_("show added files in worktree")),
+	OPT_BOOL('D', "wt-deleted", &show_wt_deleted,
+		 N_("show deleted files in worktree")),
+	OPT_BOOL('M', "wt-modified", &show_wt_modified,
+		 N_("show modified files on worktree")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_COLUMN('C', "column", &colopts, N_("show files in columns")),
@@ -221,12 +235,52 @@ static void populate_unmerged(struct string_list =
*result,
 	}
 }
=20
+static void populate_changed(struct string_list *result,
+			     const struct string_list *change)
+{
+	int i;
+
+	for (i =3D 0; i < change->nr; i++) {
+		const struct string_list_item *item =3D change->items + i;
+		struct wt_status_change_data *d =3D item->util;
+		const char *name =3D item->string;
+		struct stat st;
+		char tag[2];
+
+		switch (d->stagemask)
+			continue;
+
+		tag[0] =3D d->index_status ? d->index_status : ' ';
+		tag[1] =3D d->worktree_status ? d->worktree_status : ' ';
+
+		if ((show_added       && tag[0] =3D=3D 'A') ||
+		    (show_deleted     && tag[0] =3D=3D 'D') ||
+		    (show_modified    && tag[0] !=3D ' ') ||
+		    (show_wt_added    && tag[1] =3D=3D 'A') ||
+		    (show_wt_deleted  && tag[1] =3D=3D 'D') ||
+		    (show_wt_modified && tag[1] !=3D ' '))
+			;	/* keep going */
+		else
+			continue;
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
-	if (!show_untracked && !show_ignored && !show_unmerged)
+	if (!show_untracked && !show_ignored &&
+	    !show_unmerged && !show_changed)
 		return;
=20
 	wt_status_prepare(&ws);
@@ -244,6 +298,8 @@ static void wt_status_populate(struct string_list *=
result,
 		populate_untracked(result, &ws.ignored, "!!");
 	if (show_unmerged)
 		populate_unmerged(result, &ws.change);
+	if (show_changed)
+		populate_changed(result, &ws.change);
=20
 	qsort(result->items, result->nr, sizeof(*result->items), compare_outp=
ut);
 	string_list_remove_duplicates(result, 0);
@@ -253,8 +309,9 @@ static void cleanup_tags(struct string_list *result=
)
 {
 	int i, same_1 =3D 1, same_2 =3D 1, pos, len;
=20
-	if (show_cached + show_untracked + show_ignored > 1 ||
-	    show_unmerged)
+	if (show_cached + show_untracked + show_ignored +
+	    show_added + show_deleted + show_wt_added + show_wt_deleted > 1 |=
|
+	    show_unmerged || show_modified || show_wt_modified)
 		return;
=20
 	for (i =3D 1; i < result->nr && (same_1 || same_2); i++) {
@@ -334,7 +391,11 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
=20
 	argc =3D parse_options(argc, argv, prefix, ls_options, ls_usage, 0);
=20
-	if (!show_cached && !show_untracked && !show_ignored && !show_unmerge=
d)
+	show_changed =3D
+		show_added || show_deleted || show_modified ||
+		show_wt_added || show_wt_deleted || show_wt_modified;
+	if (!show_cached && !show_untracked && !show_ignored &&
+	    !show_unmerged && !show_changed)
 		show_cached =3D 1;
=20
 	if (want_color(use_color))
--=20
2.3.0.rc1.137.g477eb31
