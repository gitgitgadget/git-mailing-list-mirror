From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2 v2] setup: return correct prefix if worktree is '/'
Date: Sat, 26 Mar 2011 16:04:24 +0700
Message-ID: <1301130265-27287-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 10:05:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3PQX-0001NZ-Mo
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 10:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1CZJEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 05:04:40 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34621 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab1CZJEi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 05:04:38 -0400
Received: by iyb14 with SMTP id 14so1311876iyb.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 02:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=RUHbR9fcwUy8oZBQUdJb/6sc/2FCKknIakTzg2zz+6E=;
        b=QJQxHy74D+j2rRfnHFQB5C6z0YpK34ypNcXACb5Q+RlCGnXFMTMFTvXwp6+ScKDsFG
         yhcKlZoaouvAQdkIHWIniYbF/7wNAxRSf05hzZeYgpkM5nTOincOnd5mzsjottdheNFo
         NIOXTOj0IozdWyJaVA/nU5LE0yK6fy9qpMbDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=jKKoPL7fhDX1vYRV2IkkmmaDSTJUb0BoBQ6j+hY598+WtQqtU+yAh0dT5p0G9XzT6m
         sPBLDV20V3tu9TRxKXMA0NKP7OkU7i1NGHl085jBtsZOEYXzEC9l2Hf700D99gXeHDB8
         QqXP6Uj/bbZcBabh0VJ7nNWIaFey27gaM2PvY=
Received: by 10.42.29.1 with SMTP id p1mr2880209icc.318.1301130278001;
        Sat, 26 Mar 2011 02:04:38 -0700 (PDT)
Received: from tre ([115.73.209.201])
        by mx.google.com with ESMTPS id vr5sm1206744icb.0.2011.03.26.02.04.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Mar 2011 02:04:36 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 26 Mar 2011 16:04:26 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170045>

The same old problem reappears after setup code is reworked.  We tend
to assume there is at least one path component in a path and forget
that path can be simply '/'.

Reported-by: Matthijs Kooijman <matthijs@stdin.nl>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 It just looks better than previous version.

 dir.c   |   31 +++++++++++++++++++++++++++++++
 dir.h   |    1 +
 setup.c |    7 ++++---
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index 325fb56..6c49a73 100644
--- a/dir.c
+++ b/dir.c
@@ -1152,6 +1152,37 @@ char *get_relative_cwd(char *buffer, int size, c=
onst char *dir)
 	}
 }
=20
+ * Given two normalized paths (a trailing slash is ok), if subdir is
+ * outside dir, return -1.  Otherwise return the offset in subdir that
+ * can be used as relative path to dir.
+ */
+int dir_inside_of(const char *subdir, const char *dir)
+{
+	int offset =3D 0;
+
+	assert(dir && subdir && *dir && *subdir);
+
+	while (*dir && *subdir && *dir =3D=3D *subdir) {
+		dir++;
+		subdir++;
+		offset++;
+	}
+
+	/* hel[p]/me vs hel[l]/yeah */
+	if (*dir && *subdir)
+		return -1;
+
+	if (!*subdir)
+		return !*dir ? offset : -1; /* same dir */
+
+	/* foo/[b]ar vs foo/[] */
+	if (is_dir_sep(dir[-1]))
+		return is_dir_sep(subdir[-1]) ? offset : -1;
+
+	/* foo[/]bar vs foo[] */
+	return is_dir_sep(*subdir) ? offset + 1 : -1;
+}
+
 int is_inside_dir(const char *dir)
 {
 	char buffer[PATH_MAX];
diff --git a/dir.h b/dir.h
index aa511da..83e2992 100644
--- a/dir.h
+++ b/dir.h
@@ -87,6 +87,7 @@ extern int file_exists(const char *);
=20
 extern char *get_relative_cwd(char *buffer, int size, const char *dir)=
;
 extern int is_inside_dir(const char *dir);
+extern int dir_inside_of(const char *subdir, const char *dir);
=20
 static inline int is_dot_or_dotdot(const char *name)
 {
diff --git a/setup.c b/setup.c
index 03cd84f..b6e6b5a 100644
--- a/setup.c
+++ b/setup.c
@@ -325,6 +325,7 @@ static const char *setup_explicit_git_dir(const cha=
r *gitdirenv,
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *worktree;
 	char *gitfile;
+	int offset;
=20
 	if (PATH_MAX - 40 < strlen(gitdirenv))
 		die("'$%s' too big", GIT_DIR_ENVIRONMENT);
@@ -390,15 +391,15 @@ static const char *setup_explicit_git_dir(const c=
har *gitdirenv,
 		return NULL;
 	}
=20
-	if (!prefixcmp(cwd, worktree) &&
-	    cwd[strlen(worktree)] =3D=3D '/') { /* cwd inside worktree */
+	offset =3D dir_inside_of(cwd, worktree);
+	if (offset >=3D 0) {	/* cwd inside worktree? */
 		set_git_dir(real_path(gitdirenv));
 		if (chdir(worktree))
 			die_errno("Could not chdir to '%s'", worktree);
 		cwd[len++] =3D '/';
 		cwd[len] =3D '\0';
 		free(gitfile);
-		return cwd + strlen(worktree) + 1;
+		return cwd + offset;
 	}
=20
 	/* cwd outside worktree */
--=20
1.7.4.74.g639db
