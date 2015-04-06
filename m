From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/25] list-files: add --unmerged
Date: Mon,  6 Apr 2015 20:52:25 +0700
Message-ID: <1428328354-14897-17-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7Ts-0005nn-RL
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350AbbDFNyU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:20 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33668 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbbDFNyT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:19 -0400
Received: by pdbnk13 with SMTP id nk13so45368543pdb.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/AwRyCbaseeYOb9eFmdHxBiV4AfwId8YoS7f5kAmamw=;
        b=NLEVaEXxvGcnum0/y/YpVaHb/SRGgijGc9i/BWFmRj7Fi1hY4fshwnY4oKUBGcnQJu
         V06d3vdhlaaD1KGNFFqDO2b7lJoufpHCMZrdJ3Az+LQ24oWmCGIPxC8IVLrI+Rl0Q+g8
         6A1mOqn/g3mxnVH4sh5K4hPQoTThqw9vaglaJCuYRUPRUkjiXwcnvUF+zOVgHL8ifKIY
         L9cDfjgk8FI8n1NYcEnyMiKSd6dUbbbhwPBPXJUHBCPfzB0cMYW2o0aboy4U4zc34Rwk
         cMKelUL9CKnAVYgcia6aSDcQljDr+mTJq3KE+Pp9u5PbhmjryRiDCP8U+AiD7iIvjhEA
         juSA==
X-Received: by 10.68.139.225 with SMTP id rb1mr27695823pbb.93.1428328459389;
        Mon, 06 Apr 2015 06:54:19 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id r7sm4805271pdm.16.2015.04.06.06.54.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:54:30 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266861>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c  | 50 +++++++++++++++++++++++++++++++++++++++++++=
++-----
 t/t7013-list-files.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 31991a4..fe15417 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -11,7 +11,8 @@
 enum item_type {
 	FROM_INDEX,
 	FROM_WORKTREE,
-	IS_DIR
+	IS_DIR,
+	IS_UNMERGED
 };
=20
 struct item {
@@ -38,7 +39,7 @@ static int max_depth;
 static int show_dirs;
 static int use_color =3D -1;
 static int show_indicator;
-static int show_cached, show_untracked;
+static int show_cached, show_untracked, show_unmerged;
 static int show_ignored;
=20
 static const char * const ls_usage[] =3D {
@@ -54,6 +55,8 @@ struct option ls_options[] =3D {
 		 N_("show untracked files")),
 	OPT_BOOL('i', "ignored", &show_ignored,
 		 N_("show ignored files")),
+	OPT_BOOL('u', "unmerged", &show_unmerged,
+		 N_("show unmerged files")),
=20
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL(0, "tag", &show_tag, N_("show tags")),
@@ -97,6 +100,7 @@ static mode_t get_mode(const struct item *item)
 	case FROM_INDEX:
 		return item->ce->ce_mode;
 	case FROM_WORKTREE:
+	case IS_UNMERGED:
 		return item->st.st_mode;
 	}
 	return S_IFREG;
@@ -225,12 +229,46 @@ static void populate_untracked(struct item_list *=
result,
 	}
 }
=20
+static void populate_unmerged(struct item_list *result,
+			      const struct string_list *change)
+{
+	int i;
+
+	for (i =3D 0; i < change->nr; i++) {
+		const struct string_list_item *it =3D change->items + i;
+		struct wt_status_change_data *d =3D it->util;
+		const char *name =3D it->string;
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
+		add_wt_item(result, IS_UNMERGED, name, tag, &st);
+	}
+}
+
 static void wt_status_populate(struct item_list *result,
 			       struct index_state *istate)
 {
 	struct wt_status ws;
=20
-	if (!show_untracked && !show_ignored)
+	if (!show_untracked && !show_ignored && !show_unmerged)
 		return;
=20
 	wt_status_prepare(&ws);
@@ -246,6 +284,8 @@ static void wt_status_populate(struct item_list *re=
sult,
 		populate_untracked(result, &ws.untracked, "??");
 	if (show_ignored)
 		populate_untracked(result, &ws.ignored, "!!");
+	if (show_unmerged)
+		populate_unmerged(result, &ws.change);
=20
 	remove_duplicates(result);
 }
@@ -260,7 +300,7 @@ static void cleanup_tags(struct item_list *result)
 		return;
 	}
=20
-	if (show_tag > 0 ||
+	if (show_tag > 0 || show_unmerged ||
 	    show_cached + show_untracked + show_ignored > 1) {
 		result->tag_pos =3D 0;
 		result->tag_len =3D 2;
@@ -398,7 +438,7 @@ int cmd_list_files(int argc, const char **argv, con=
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
diff --git a/t/t7013-list-files.sh b/t/t7013-list-files.sh
index 6b76d1f..7fe9673 100755
--- a/t/t7013-list-files.sh
+++ b/t/t7013-list-files.sh
@@ -218,4 +218,39 @@ test_expect_success '--classify' '
 	)
 '
=20
+test_expect_success 'list-files unmerged' '
+	(
+	add_stage() {
+		echo "100644 $1 $2	$3" | git update-index --index-info
+	}
+	git init 3 &&
+	cd 3 &&
+	test_commit 1 &&
+	SHA1=3D`echo 1 | git hash-object -w --stdin` &&
+	add_stage $SHA1 1 deleted-by-both &&
+	add_stage $SHA1 2 added-by-us &&
+	add_stage $SHA1 1 deleted-by-them &&
+	add_stage $SHA1 2 deleted-by-them &&
+	add_stage $SHA1 3 added-by-them &&
+	add_stage $SHA1 3 deleted-by-us &&
+	add_stage $SHA1 1 deleted-by-us &&
+	add_stage $SHA1 2 added-by-both &&
+	add_stage $SHA1 3 added-by-both &&
+	add_stage $SHA1 1 modified-by-both &&
+	add_stage $SHA1 2 modified-by-both &&
+	add_stage $SHA1 3 modified-by-both &&
+	git list-files -u >actual &&
+	cat >expected <<-\EOF &&
+	AA added-by-both
+	UA added-by-them
+	AU added-by-us
+	DD deleted-by-both
+	UD deleted-by-them
+	DU deleted-by-us
+	UU modified-by-both
+	EOF
+	test_cmp expected actual
+	)
+'
+
 test_done
--=20
2.3.0.rc1.137.g477eb31
