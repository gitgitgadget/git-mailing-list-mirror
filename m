From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/25] list-files: only do diff that is actually useful
Date: Mon,  6 Apr 2015 20:52:31 +0700
Message-ID: <1428328354-14897-23-git-send-email-pclouds@gmail.com>
References: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 1425896314-10941-1-git-send-email-pclouds@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 15:55:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf7UU-0006F1-38
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 15:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbbDFNy6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 09:54:58 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33598 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbDFNy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 09:54:57 -0400
Received: by paboj16 with SMTP id oj16so45239291pab.0
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9gE4AQWLJyrURnjsRONNFXvUAR7lNpjoOvXyAzb9Vdg=;
        b=q+PnUjmG5Lo61RnjNME0J0QZMmQJUp8E7f0ir5+A4XwhqSw8dPJTSRxls4Qxzu4ffe
         l4idqNu2uile3Lb7OPu80tH6a7u+HPH9YLLo9lnj0i2SpFSTNphsDlojxzwAJBj5AEzc
         Heh+/DmAJES8Rsg7tPHoZhDTMEUqzx0hwQtqiTbEUCW0WKCRSr7WV9o1/uZYdPNXjR01
         gCrhJ/ePPWEHR5tP2SORo5wLRC1BKxU12vF+pnzPhfXxawU69jxPCVGdmiDfS1tYy9nq
         3jTfTElvm1q0LTOR8ntOes2/rVoDUm+ll0nJ4KoBDnyKmCR5OjsoBGR9U4cV8w6oofmg
         GczQ==
X-Received: by 10.68.225.162 with SMTP id rl2mr27125844pbc.117.1428328496953;
        Mon, 06 Apr 2015 06:54:56 -0700 (PDT)
Received: from lanh ([115.73.245.217])
        by mx.google.com with ESMTPSA id fa2sm4800513pdb.39.2015.04.06.06.54.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2015 06:54:56 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 06 Apr 2015 20:55:08 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1428328354-14897-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266867>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/list-files.c | 12 ++++++++++++
 wt-status.c          |  8 ++++++++
 wt-status.h          |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/builtin/list-files.c b/builtin/list-files.c
index 228c39b..fc9c8d4 100644
--- a/builtin/list-files.c
+++ b/builtin/list-files.c
@@ -365,6 +365,10 @@ static void wt_status_populate(struct item_list *r=
esult,
 	if (show_ignored)
 		ws.show_ignored_files =3D 1;
 	ws.no_rename =3D 1;
+	ws.show_index_changes =3D show_unmerged || show_added ||
+		show_modified || show_deleted;
+	ws.show_worktree_changes =3D show_unmerged || show_wt_added ||
+		show_wt_modified || show_wt_deleted;
 	ws.relative_paths =3D 0;
 	ws.use_color =3D 0;
 	ws.fp =3D NULL;
@@ -538,6 +542,14 @@ int cmd_list_files(int argc, const char **argv, co=
nst char *cmd_prefix)
 	if (!show_cached && !show_untracked && !show_ignored &&
 	    !show_unmerged && !show_changed)
 		show_cached =3D 1;
+	if (show_unmerged) {
+		int i;
+		for (i =3D 0; i < the_index.cache_nr; i++)
+			if (ce_stage(the_index.cache[i]))
+				break;
+		if (i =3D=3D the_index.cache_nr)
+			show_unmerged =3D 0;
+	}
=20
 	if (want_color(use_color))
 		parse_ls_color();
diff --git a/wt-status.c b/wt-status.c
index ba9b56c..ce149b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -126,6 +126,8 @@ void wt_status_prepare(struct wt_status *s)
 	memcpy(s->color_palette, default_wt_status_colors,
 	       sizeof(default_wt_status_colors));
 	s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
+	s->show_index_changes =3D 1;
+	s->show_worktree_changes =3D 1;
 	s->use_color =3D -1;
 	s->relative_paths =3D 1;
 	s->branch =3D resolve_refdup("HEAD", 0, sha1, NULL);
@@ -493,6 +495,9 @@ static void wt_status_collect_changes_worktree(stru=
ct wt_status *s)
 {
 	struct rev_info rev;
=20
+	if (!s->show_worktree_changes)
+		return;
+
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
@@ -514,6 +519,9 @@ static void wt_status_collect_changes_index(struct =
wt_status *s)
 	struct rev_info rev;
 	struct setup_revision_opt opt;
=20
+	if (!s->show_index_changes)
+		return;
+
 	init_revisions(&rev, NULL);
 	memset(&opt, 0, sizeof(opt));
 	opt.def =3D s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
diff --git a/wt-status.h b/wt-status.h
index dc94f35..1d7ad3a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -57,6 +57,8 @@ struct wt_status {
 	int show_ignored_files;
 	int no_rename;
 	enum untracked_status_type show_untracked_files;
+	int show_index_changes;
+	int show_worktree_changes;
 	const char *ignore_submodule_arg;
 	char color_palette[WT_STATUS_MAXSLOT][COLOR_MAXLEN];
 	unsigned colopts;
--=20
2.3.0.rc1.137.g477eb31
