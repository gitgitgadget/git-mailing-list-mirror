From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/17] ls: do not show duplicate cached entries
Date: Wed, 26 Mar 2014 20:48:16 +0700
Message-ID: <1395841697-11742-17-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 26 14:49:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSoCt-0000rK-4b
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 14:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbaCZNtW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Mar 2014 09:49:22 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57338 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbaCZNtV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 09:49:21 -0400
Received: by mail-pa0-f41.google.com with SMTP id fa1so1966191pad.28
        for <git@vger.kernel.org>; Wed, 26 Mar 2014 06:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IwCbO738/LJmv+bjxSfba+AzrXR7jBL882sh3fU6pjw=;
        b=pcPZCxtK3SKs+KkbVv6IDLHK0dO0Y1YJE5xZL7BK2ur91KPm1HlyrixIFiGEnN36nL
         u0TRTidNAmCxcdoxKYhVHru2vyVGnNKGZ18rqZkrLGt6WwikT2veE6VNrGFXZnFTusy2
         iS15obxqJbDIjdc+/ZyeK85znVMgFGXkOfjzoh+kKDzx98/l3HqWm3jwyWEpR/d/JdOw
         mAU5b0Jv3EqHtl1iWGPaLfaTQz2p0QYpqtyHmNjD6OL5O3KPR5WMtcvOHWlEYPLdW/cf
         N01x91aOKkebeRPHLZSs/0vOFS+xCPuXUmXfIZjUAi9MJNED7uw30AGOnFRBuF37izyR
         UWyg==
X-Received: by 10.66.26.15 with SMTP id h15mr85123992pag.24.1395841761041;
        Wed, 26 Mar 2014 06:49:21 -0700 (PDT)
Received: from lanh ([115.73.224.106])
        by mx.google.com with ESMTPSA id id10sm58545263pbc.35.2014.03.26.06.49.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 26 Mar 2014 06:49:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 26 Mar 2014 20:50:13 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245195>

With the current show_files() "ls -tcm" will show

  foo.c
M foo.c

The first item is redundant. If "foo.c" is modified, we know it's in
the cache. Introduce show_files_compact to do that because ls-files is
plumbing and scripts may already depend on current display behavior.

Another difference in show_files_compact() is it does not show
skip-worktree (aka outside sparse checkout) entries anymore, which
makes sense in porcelain context.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 709d8b1..cd8e35c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -337,6 +337,53 @@ static void show_files(struct dir_struct *dir)
 	}
 }
=20
+static void show_files_compact(struct dir_struct *dir)
+{
+	int i;
+
+	/* For cached/deleted files we don't need to even do the readdir */
+	if (show_others || show_killed) {
+		if (!show_others)
+			dir->flags |=3D DIR_COLLECT_KILLED_ONLY;
+		fill_directory(dir, &pathspec);
+		if (show_others)
+			show_other_files(dir);
+		if (show_killed)
+			show_killed_files(dir);
+	}
+	if (!(show_cached || show_stage || show_deleted || show_modified))
+		return;
+	for (i =3D 0; i < active_nr; i++) {
+		const struct cache_entry *ce =3D active_cache[i];
+		struct stat st;
+		int err, shown =3D 0;
+		if ((dir->flags & DIR_SHOW_IGNORED) &&
+		    !ce_excluded(dir, ce))
+			continue;
+		if (show_unmerged && !ce_stage(ce))
+			continue;
+		if (ce->ce_flags & CE_UPDATE)
+			continue;
+		if (ce_skip_worktree(ce))
+			continue;
+		err =3D lstat(ce->name, &st);
+		if (show_deleted && err) {
+			show_ce_entry(tag_removed, ce);
+			shown =3D 1;
+		}
+		if (show_modified && ce_modified(ce, &st, 0)) {
+			show_ce_entry(tag_modified, ce);
+			shown =3D 1;
+		}
+		if (ce_stage(ce)) {
+			show_ce_entry(tag_unmerged, ce);
+			shown =3D 1;
+		}
+		if (!shown && show_cached)
+			show_ce_entry(tag_cached, ce);
+	}
+}
+
 /*
  * Prune the index to only contain stuff starting with "prefix"
  */
@@ -606,7 +653,10 @@ static int ls_files(const char **argv, const char =
*prefix)
 		refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
 		setup_pager();
 	}
-	show_files(&dir);
+	if (porcelain)
+		show_files_compact(&dir);
+	else
+		show_files(&dir);
 	if (show_resolve_undo)
 		show_ru_info();
=20
--=20
1.9.1.345.ga1a145c
