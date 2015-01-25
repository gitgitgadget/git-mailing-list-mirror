From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 16/21] list-files: do not show duplicate cached entries
Date: Sun, 25 Jan 2015 19:37:51 +0700
Message-ID: <1422189476-7518-17-git-send-email-pclouds@gmail.com>
References: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 13:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFMJA-0003W6-3F
	for gcvg-git-2@plane.gmane.org; Sun, 25 Jan 2015 13:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559AbbAYM2t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2015 07:28:49 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:64819 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbAYM2r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 07:28:47 -0500
Received: by mail-pa0-f54.google.com with SMTP id eu11so6467756pac.13
        for <git@vger.kernel.org>; Sun, 25 Jan 2015 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ey9Y9QELed3Vgvrxg049/7aTdOd5Cc/wV3x+Favpu00=;
        b=M76NYT7SIU5Fd2yPCcfzPo919xKX5+R3l7ByVh/dq8cYU1nTlXYrIf7yLoGNxahzqZ
         /AseUDod3kpmQixZmMAx/i16qWLPGKp859dAJQ//tplZvMN2Zj0JdtWlliwzWytLvdnW
         DSQVmTjDE9WiiUxTKG0rTTGU5Vs6h8lUTbyDqzY97r4ge06+iBzZHJ2Gjc6upVkOQYBW
         ZlIVoZKJ1r11JCg++Xuw5HR3nKQq+DFYyq+bLunC/VOzk2VEYmkcXRcpL8+MqFIC1sAH
         G0D86fW/dt+NzpA65ldRVByccjNzQ5D8G7A98GG3tQq1JSH8qqzvnsYOMlqgO8T0hkd5
         k78w==
X-Received: by 10.68.197.72 with SMTP id is8mr26518035pbc.17.1422188927014;
        Sun, 25 Jan 2015 04:28:47 -0800 (PST)
Received: from lanh ([115.73.204.104])
        by mx.google.com with ESMTPSA id v7sm7119971pdl.56.2015.01.25.04.28.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Jan 2015 04:28:46 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 25 Jan 2015 19:40:11 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
In-Reply-To: <1422189476-7518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263012>

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
index 154dd9d..1a1c9c8 100644
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
2.2.0.84.ge9c7a8a
