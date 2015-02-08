From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/21] list-files: do not show duplicate cached entries
Date: Sun,  8 Feb 2015 16:01:34 +0700
Message-ID: <1423386099-19994-17-git-send-email-pclouds@gmail.com>
References: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 10:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKNmc-0006NT-0e
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 10:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbbBHJDt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2015 04:03:49 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:41622 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782AbbBHJDr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 04:03:47 -0500
Received: by pdno5 with SMTP id o5so2146872pdn.8
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=tvMhm62NEPhD+Iw7mzqoK4yZA7431rmp1NFZMRPVccA=;
        b=y8Uttw1qTIphok2C1oUwlLnaWczTrZz6B3K6CI8gpBM4CHfYUlCkHXWSqDjon9tNZa
         jozeHNQmTIu22pjhWTr4o2MJSXrLzAGeXu7BK61msd+oVMGmfGYEMiCmv+SOmfSQTvkx
         Q92vwNo3XmPYimCz8SrXdcCzxSH8M6aouu9EH6bdVBDJMmG5LImT32DqDUPMn75vuJ+f
         9t1Lo/aGMTj5psUD5k4EaW/DvP9GUKYNqWIFE4pvGYCv/Ad8HNlROzLeTpKWhKU0FHwd
         /BF/fmCgfZi2PZuBpWvnZmPYjmYcpVUsfm31usH1hxDqUlY4k41oY/jddZEkgbnCKQIh
         woHg==
X-Received: by 10.70.131.232 with SMTP id op8mr19394035pdb.160.1423386226940;
        Sun, 08 Feb 2015 01:03:46 -0800 (PST)
Received: from lanh ([115.73.243.52])
        by mx.google.com with ESMTPSA id v6sm11238892pdp.50.2015.02.08.01.03.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Feb 2015 01:03:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Feb 2015 16:03:54 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1423386099-19994-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263503>

With the current show_files() "list-files -tcm" will show

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
index 8f10ab9..457d067 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -333,6 +333,53 @@ static void show_files(struct dir_struct *dir)
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
+	if (!(show_cached || show_unmerged || show_deleted || show_modified))
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
+		if (show_modified && (err || ce_modified(ce, &st, 0))) {
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
@@ -743,7 +790,10 @@ int cmd_ls_files(int argc, const char **argv, cons=
t char *cmd_prefix)
 		refresh_index(&the_index, REFRESH_QUIET | REFRESH_UNMERGED, &pathspe=
c, NULL, NULL);
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
2.3.0.rc1.137.g477eb31
