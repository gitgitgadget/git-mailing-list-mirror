From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 24/26] ls-files: print CE_WATCHED as W (or "w" with CE_VALID)
Date: Mon,  3 Feb 2014 11:29:12 +0700
Message-ID: <1391401754-15347-25-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABCA-0001dn-LP
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021AbaBCEbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:38 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:43332 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbaBCEbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:37 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so6624157pbc.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=50KcVvXr8fXxE8RpfGDxwG7zzY9QlhItY50xxBclLcE=;
        b=SeEWFlMpRDuplCLC6PfuZ4YOb2usrNPyxEPey/m9aSoMPqeP4s966uWDwP4x/R00pd
         +pNvP8XNJMqTuzZ1UyAKE3v+RFK9F7rPflbmpzog9jZBy9ShYv+6CPLtBd4GrQLkkDhL
         qD0vc36gR2jRQojgdRKIrl+RP/SK23znD72FPXK1t3WtKYkLJgHsTvObuu0He49FLlB9
         bYRAo3QqwJ8rSkNbtjwpJqvY0erFcPQKMuszXwqVqHYmOMLL2+PFkVIxm9MASlvV3HoW
         0yp103yn5jHV/c8oNlP+6CYuU7LxV0XklHsvfYTHN/fXdWXmxdatZy1xYWQ+7sIvUa+V
         OfMg==
X-Received: by 10.66.253.33 with SMTP id zx1mr34945252pac.28.1391401897197;
        Sun, 02 Feb 2014 20:31:37 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id da3sm51420111pbc.30.2014.02.02.20.31.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:35 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241419>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-ls-files.txt |  1 +
 builtin/ls-files.c             | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-file=
s.txt
index c0856a6..bdb17a5 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -123,6 +123,7 @@ a space) at the start of each line:
 	R::	removed/deleted
 	C::	modified/changed
 	K::	to be killed
+	W::	being watched by `git file-watcher`
 	?::	other
=20
 -v::
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e1cf6d8..f1f7c07 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -46,6 +46,7 @@ static const char *tag_killed =3D "";
 static const char *tag_modified =3D "";
 static const char *tag_skip_worktree =3D "";
 static const char *tag_resolve_undo =3D "";
+static const char *tag_watched =3D "";
=20
 static void write_name(const char *name)
 {
@@ -231,6 +232,7 @@ static void show_files(struct dir_struct *dir)
 	if (show_cached || show_stage) {
 		for (i =3D 0; i < active_nr; i++) {
 			const struct cache_entry *ce =3D active_cache[i];
+			const char *tag;
 			if ((dir->flags & DIR_SHOW_IGNORED) &&
 			    !ce_excluded(dir, ce))
 				continue;
@@ -238,8 +240,15 @@ static void show_files(struct dir_struct *dir)
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
 				continue;
-			show_ce_entry(ce_stage(ce) ? tag_unmerged :
-				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
+			if (ce_stage(ce))
+				tag =3D tag_unmerged;
+			else if (ce_skip_worktree(ce))
+				tag =3D tag_skip_worktree;
+			else if (ce->ce_flags & CE_WATCHED)
+				tag =3D tag_watched;
+			else
+				tag =3D tag_cached;
+			show_ce_entry(tag, ce);
 		}
 	}
 	if (show_deleted || show_modified) {
@@ -530,6 +539,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
 		tag_killed =3D "K ";
 		tag_skip_worktree =3D "S ";
 		tag_resolve_undo =3D "U ";
+		tag_watched =3D "W ";
 	}
 	if (show_modified || show_others || show_deleted || (dir.flags & DIR_=
SHOW_IGNORED) || show_killed)
 		require_work_tree =3D 1;
--=20
1.8.5.2.240.g8478abd
