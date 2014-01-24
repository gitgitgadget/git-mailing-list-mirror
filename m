From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 6/9] Pass directory indicator to match_pathspec_item()
Date: Fri, 24 Jan 2014 20:40:33 +0700
Message-ID: <1390570836-20394-7-git-send-email-pclouds@gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pawel.sikora@agmk.net,
	Jens.Lehmann@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 14:35:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6gvD-0005CB-QF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 14:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbaAXNfn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 08:35:43 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49389 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752209AbaAXNfm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 08:35:42 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so3252636pbb.15
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 05:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MigxOomsluWfemHKqTlIpCpUFnIDcwTp0M70dGDIS1E=;
        b=VGiD72xYDoQrrIES5mOyA5AyPhxXzX89KJbU6m16IAVh4ZAT0LNEpG+aBR2OzdX35D
         gPNApREP5VEIL1glYcY49zGHmXTN69QlJSHkXmg8qQpyZIi1+PfERsgxwqlRhBaLu7OJ
         xtG5n8XyZ8yLo3WrJ6hsWhUYG1vvkSfgqAv0Qz1jawYCvbv31GLjH29WpoNlMJZjexVO
         NAHdnF2vU9JhyLC7/Usf2sB/+pk7kRh+7eXrS3qQUoAsncOlD52Da5mpTmCyqQB/rOnu
         p8+jlIxIyciLGPpfElm2B3cPid0UO9yDh0TMwHCxnvbmVTvKhafUP/hxPxkpxI49AUY6
         E+UQ==
X-Received: by 10.68.190.228 with SMTP id gt4mr14644499pbc.94.1390570542436;
        Fri, 24 Jan 2014 05:35:42 -0800 (PST)
Received: from lanh ([115.73.192.112])
        by mx.google.com with ESMTPSA id pe3sm3331113pbc.23.2014.01.24.05.35.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Jan 2014 05:35:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 24 Jan 2014 20:41:17 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241004>

This patch activates the DO_MATCH_DIRECTORY code in m_p_i(), which
makes "git diff HEAD submodule/" and "git diff HEAD submodule" produce
the same output. Previously only the version without trailing slash
returns the difference (if any).

That's the effect of new ce_path_match(). dir_path_match() is not
executed by the new tests. And it should not introduce regressions.

Previously if path "dir/" is passed in with pathspec "dir/", they
obviously match. With new dir_path_match(), the path becomes
_directory_ "dir" vs pathspec "dir/", which is not executed by the old
code path in m_p_i(). The new code path is executed and produces the
same result.

The other case is pathspec "dir" and path "dir/" is now turned to
"dir" (with DO_MATCH_DIRECTORY). Still the same result before or after
the patch.

So why change? Because of the next patch about clean.c.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c          |  2 +-
 builtin/ls-files.c       |  5 +++--
 dir.c                    |  4 ++--
 dir.h                    | 10 +++++++---
 rerere.c                 |  2 +-
 t/t4010-diff-pathspec.sh | 17 +++++++++++++++++
 6 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index f59c753..4c9680a 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -962,7 +962,7 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
=20
 		if (pathspec.nr)
 			matches =3D match_pathspec(&pathspec, ent->name,
-						 len, 0, NULL);
+						 len, 0, NULL, 0);
=20
 		if (S_ISDIR(st.st_mode)) {
 			if (remove_directories || (matches =3D=3D MATCHED_EXACTLY)) {
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 02db0e1..47c3880 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -140,7 +140,8 @@ static void show_ce_entry(const char *tag, const st=
ruct cache_entry *ce)
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
 	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched))
+			    len, ps_matched,
+			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
 		return;
=20
 	if (tag && *tag && show_valid_bit &&
@@ -197,7 +198,7 @@ static void show_ru_info(void)
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
 		if (!match_pathspec(&pathspec, path, len,
-				    max_prefix_len, ps_matched))
+				    max_prefix_len, ps_matched, 0))
 			continue; /* uninterested */
 		for (i =3D 0; i < 3; i++) {
 			if (!ui->mode[i])
diff --git a/dir.c b/dir.c
index 7b50072..2fd0ebd 100644
--- a/dir.c
+++ b/dir.c
@@ -360,10 +360,10 @@ static int do_match_pathspec(const struct pathspe=
c *ps,
=20
 int match_pathspec(const struct pathspec *ps,
 		   const char *name, int namelen,
-		   int prefix, char *seen)
+		   int prefix, char *seen, int is_dir)
 {
 	int positive, negative;
-	unsigned flags =3D 0;
+	unsigned flags =3D is_dir ? DO_MATCH_DIRECTORY : 0;
 	positive =3D do_match_pathspec(ps, name, namelen,
 				     prefix, seen, flags);
 	if (!(ps->magic & PATHSPEC_EXCLUDE) || !positive)
diff --git a/dir.h b/dir.h
index c31ed9a..55e5345 100644
--- a/dir.h
+++ b/dir.h
@@ -134,7 +134,7 @@ extern int no_wildcard(const char *string);
 extern char *common_prefix(const struct pathspec *pathspec);
 extern int match_pathspec(const struct pathspec *pathspec,
 			  const char *name, int namelen,
-			  int prefix, char *seen);
+			  int prefix, char *seen, int is_dir);
 extern int within_depth(const char *name, int namelen, int depth, int =
max_depth);
=20
 extern int fill_directory(struct dir_struct *dir, const struct pathspe=
c *pathspec);
@@ -209,14 +209,18 @@ static inline int ce_path_match(const struct cach=
e_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
 {
-	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen,
+			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
 }
=20
 static inline int dir_path_match(const struct dir_entry *ent,
 				 const struct pathspec *pathspec,
 				 int prefix, char *seen)
 {
-	return match_pathspec(pathspec, ent->name, ent->len, prefix, seen);
+	int has_trailing_dir =3D ent->len && ent->name[ent->len - 1] =3D=3D '=
/';
+	int len =3D has_trailing_dir ? ent->len - 1 : ent->len;
+	return match_pathspec(pathspec, ent->name, len, prefix, seen,
+			      has_trailing_dir);
 }
=20
 #endif
diff --git a/rerere.c b/rerere.c
index 34a21c4..d55aa8a 100644
--- a/rerere.c
+++ b/rerere.c
@@ -673,7 +673,7 @@ int rerere_forget(struct pathspec *pathspec)
 	for (i =3D 0; i < conflict.nr; i++) {
 		struct string_list_item *it =3D &conflict.items[i];
 		if (!match_pathspec(pathspec, it->string,
-				    strlen(it->string), 0, NULL))
+				    strlen(it->string), 0, NULL, 0))
 			continue;
 		rerere_forget_one_path(it->string, &merge_rr);
 	}
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index af5134b..167af53 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -110,4 +110,21 @@ test_expect_success 'diff-tree -r with wildcard' '
 	test_cmp expected result
 '
=20
+test_expect_success 'setup submodules' '
+	test_tick &&
+	git init submod &&
+	( cd submod && test_commit first; ) &&
+	git add submod &&
+	git commit -m first &&
+	( cd submod && test_commit second; ) &&
+	git add submod &&
+	git commit -m second
+'
+
+test_expect_success 'diff-cache ignores trailing slash on submodule pa=
th' '
+	git diff --name-only HEAD^ submod >expect &&
+	git diff --name-only HEAD^ submod/ >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.8.5.2.240.g8478abd
