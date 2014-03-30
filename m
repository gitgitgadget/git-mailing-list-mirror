From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 15/18] list-files: do not show duplicate cached entries
Date: Sun, 30 Mar 2014 20:56:06 +0700
Message-ID: <1396187769-30863-16-git-send-email-pclouds@gmail.com>
References: <1395841697-11742-1-git-send-email-pclouds@gmail.com>
 <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 15:57:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUGEb-0003Uw-Ex
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 15:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaC3N5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Mar 2014 09:57:08 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40600 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbaC3N5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 09:57:07 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so6782436pdi.5
        for <git@vger.kernel.org>; Sun, 30 Mar 2014 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FsGTX9jOLoX5PbSQti44yMaPGrehI0cAnsKqfrG3iMw=;
        b=lv17UKv9AyCDA/mUDZu8JmXAE2uNFTT8mkPuRjhW9p5rV0HKTwc5J8uf2woHRUO4jr
         nbolO6l8sPOOfJXNBmPV6YmKP8flN1ilMkT3Ff8jFnLVD8KyNDz7yKNK0OaEkiVB/W2T
         mufm6boGeLRSIIOYQ1l5Va3VhfBDq4zmMZ5ur5vVRLxBpohL9f98PtnOcafynhQ3ZeIw
         57YKbvs1TwbDRV2CyLu1MmEWNQaMn+kxtTkQrY8QF3RLJD7Hw6He9R2e3TrFr+V4T6mP
         Us9KMBgEuGso3uunWoBCIvwtilE3h8jHG789FTm+dji2Eje2Mce+XgHjjM/Xt1Mw89i0
         ZDcA==
X-Received: by 10.66.159.132 with SMTP id xc4mr19348276pab.27.1396187826519;
        Sun, 30 Mar 2014 06:57:06 -0700 (PDT)
Received: from lanh ([115.73.202.240])
        by mx.google.com with ESMTPSA id vh2sm37332124pbc.72.2014.03.30.06.57.03
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 30 Mar 2014 06:57:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Mar 2014 20:58:04 +0700
X-Mailer: git-send-email 1.9.1.345.ga1a145c
In-Reply-To: <1396187769-30863-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245479>

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
index ff2377f..9a8f687 100644
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
