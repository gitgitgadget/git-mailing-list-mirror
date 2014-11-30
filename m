From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 15/19] list-files: do not show duplicate cached entries
Date: Sun, 30 Nov 2014 15:56:03 +0700
Message-ID: <1417337767-4505-16-git-send-email-pclouds@gmail.com>
References: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:58:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv0Kp-0003J1-HD
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbaK3I6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:58:23 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:64155 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbaK3I6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:58:23 -0500
Received: by mail-pa0-f51.google.com with SMTP id ey11so9076378pad.24
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=bH9csQcMYdSYH6lkbb/wEvGgxNz7oVEeVRU6cT8fqOs=;
        b=k2OkHp9VHZ5XvIW7GdERvHs557TyMAkfIfjb0Nw6oixMr1qeQCoB9EDzecT8ExMaM5
         +maYli4Lu0sam+EHKJ03b8QGp/J+FvPApkmuKDz7YHmMUeQPf+561DdXtcr92C6zMSW1
         nK3JDXBHRnbKIJFPvSaeKNWNZSsKMaPh+TtkC8oELCoB3uSEuJD1XjcQrPqNReLx1Ovv
         YX7G/j8Jc5Of8UpCW8TvQva/CzFcYNHQAwWqzfEqGqhAp/hObZ0Acz4i7IJPEgoli/0P
         bkNL6q2fnSfmwk95mSQAiVUt6ur1RHxXcb6p91n6fnAhAFmDLr7ShaNsVPYy/5/Fk1UN
         NNUw==
X-Received: by 10.66.140.8 with SMTP id rc8mr90282116pab.83.1417337902798;
        Sun, 30 Nov 2014 00:58:22 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id te2sm14312190pbc.51.2014.11.30.00.58.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:58:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:58:20 +0700
X-Mailer: git-send-email 2.2.0.60.gb7b3c64
In-Reply-To: <1417337767-4505-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260438>

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
index 42c530d..fc70265 100644
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
2.2.0.60.gb7b3c64
