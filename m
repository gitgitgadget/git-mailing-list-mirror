From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/26] Clear CE_WATCHED when set CE_VALID alone
Date: Mon,  3 Feb 2014 11:28:59 +0700
Message-ID: <1391401754-15347-12-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:30:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABAz-0001Cr-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894AbaBCEaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:30:22 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58044 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbaBCEaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:30:20 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa1so6619406pad.13
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=R3nfc8GwUedp0Wyc0Z8a4KJXVVJGzz2PWYxk98IrYf0=;
        b=bDtBXv8/PAhQNWb57yEYiHi3WmYtqBZ7mkTBYgVwX+Gw3r95tNC2GHG6Oky9ZUz5Do
         hKgMbCqoTy12LP+Gdj9XYHNmT4WrdADcWvmS/+gQ1KKa4Fev0pVTNH7K41Y+2BBp3UtR
         YXS5yq9YCVHN76D68f8KUi8T/4p0kXZLgYhUzOyuI5LHYhJquvKACVQoYOBQ+XfgEyFl
         OLOPHB+yfh8xTGYHjXaQgeY/+8020TOT37MihWYOn2INeH2RQYoQ98+dbRW8CvIXlbo7
         lIigoiO7OkZlKNebhfWn5nWj1QPZTc379GhLPfZub6WsELRjezAfkVrIgZbd0PafFNCM
         4jeA==
X-Received: by 10.66.149.231 with SMTP id ud7mr35416381pab.8.1391401820350;
        Sun, 02 Feb 2014 20:30:20 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id cz3sm51419434pbc.9.2014.02.02.20.30.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:30:19 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:30:18 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241407>

If CE_WATCHED is set, CE_VALID is controlled by CE_WATCHED and will be
cleared bfore writing to disk. Users of --assume-unchanged therefore
need to clear CE_WATCHED to avoid this side effect.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 12 ++++++++----
 read-cache.c           |  2 +-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index e3a10d7..9283fd6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -50,9 +50,13 @@ static int mark_ce_flags(const char *path, int flag,=
 int mark)
 	int namelen =3D strlen(path);
 	int pos =3D cache_name_pos(path, namelen);
 	if (0 <=3D pos) {
-		if (mark)
-			active_cache[pos]->ce_flags |=3D flag;
-		else
+		if (mark) {
+			struct cache_entry *ce =3D active_cache[pos];
+			if (flag =3D=3D CE_VALID)
+				ce->ce_flags =3D (ce->ce_flags & ~CE_WATCHED) | CE_VALID;
+			else
+				ce->ce_flags |=3D flag;
+		} else
 			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
 		active_cache_changed =3D 1;
@@ -235,7 +239,7 @@ static int add_cacheinfo(unsigned int mode, const u=
nsigned char *sha1,
 	ce->ce_namelen =3D len;
 	ce->ce_mode =3D create_ce_mode(mode);
 	if (assume_unchanged)
-		ce->ce_flags |=3D CE_VALID;
+		ce->ce_flags =3D (ce->ce_flags & ~CE_WATCHED) | CE_VALID;
 	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
diff --git a/read-cache.c b/read-cache.c
index 098d3b6..8961864 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -133,7 +133,7 @@ void fill_stat_cache_info(struct cache_entry *ce, s=
truct stat *st)
 	fill_stat_data(&ce->ce_stat_data, st);
=20
 	if (assume_unchanged)
-		ce->ce_flags |=3D CE_VALID;
+		ce->ce_flags =3D (ce->ce_flags & ~CE_WATCHED) | CE_VALID;
=20
 	if (S_ISREG(st->st_mode))
 		ce_mark_uptodate(ce);
--=20
1.8.5.2.240.g8478abd
