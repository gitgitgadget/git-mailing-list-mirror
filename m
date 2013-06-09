From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/45] ls-files: convert to use parse_pathspec
Date: Sun,  9 Jun 2013 13:25:53 +0700
Message-ID: <1370759178-1709-21-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ5m-0000gI-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab3FIG1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:00 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:56632 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3FIG1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:00 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so2643471pbb.14
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0c6G7M3wABV0yAQFrIJ55INRD6UDWQ3nEB2y6jFVu8c=;
        b=PNbCnYJb9ttkTbB2rK0FlrQKMP6ksFRIEyOD61kkpn8Rj+Qs+olv9Yk3ZZl09J1dzq
         nJsQFN/q2l4ZEhTJg76MfFX8PAOLqDCIVa4rt0OaJhHfe2LOj9/eegAOPqONzdmCSMwY
         clWnLde6g6cYYFWiTsSKvQ2buGnprgZ5noD3+S9r7x/Bga4Zr6GZ0/kHuSgFmnniYqEW
         Nrhiz/k+JSBh/IzBfTmHAnAh5pODY3ds7Aigb7MAbeeDKEn27xFabIkLzvqf6xg9BMvC
         oJ7Gp/7HhQ9Ko3sIbjUGFcZy7kHpTcG/Ao+f0zm7zeJnwUPtHbHBdw3F7flDRWH05/ln
         mAEw==
X-Received: by 10.68.111.228 with SMTP id il4mr5185925pbb.134.1370759219646;
        Sat, 08 Jun 2013 23:26:59 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id vz8sm10202818pac.20.2013.06.08.23.26.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:26:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:28:30 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226912>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 46 +++++++++++++---------------------------------
 1 file changed, 13 insertions(+), 33 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a0b7e30..1534a39 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -31,7 +31,7 @@ static int debug_mode;
 static const char *prefix;
 static int max_prefix_len;
 static int prefix_len;
-static const char **pathspec;
+static struct pathspec pathspec;
 static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
@@ -60,7 +60,7 @@ static void show_dir_entry(const char *tag, struct di=
r_entry *ent)
 	if (len >=3D ent->len)
 		die("git ls-files: internal error - directory entry not superset of =
prefix");
=20
-	if (!match_pathspec(pathspec, ent->name, ent->len, len, ps_matched))
+	if (!match_pathspec_depth(&pathspec, ent->name, ent->len, len, ps_mat=
ched))
 		return;
=20
 	fputs(tag, stdout);
@@ -135,7 +135,7 @@ static void show_ce_entry(const char *tag, struct c=
ache_entry *ce)
 	if (len >=3D ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of pref=
ix");
=20
-	if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), len, ps_match=
ed))
+	if (!match_pathspec_depth(&pathspec, ce->name, ce_namelen(ce), len, p=
s_matched))
 		return;
=20
 	if (tag && *tag && show_valid_bit &&
@@ -189,7 +189,7 @@ static void show_ru_info(void)
 		len =3D strlen(path);
 		if (len < max_prefix_len)
 			continue; /* outside of the prefix */
-		if (!match_pathspec(pathspec, path, len, max_prefix_len, ps_matched)=
)
+		if (!match_pathspec_depth(&pathspec, path, len, max_prefix_len, ps_m=
atched))
 			continue; /* uninterested */
 		for (i =3D 0; i < 3; i++) {
 			if (!ui->mode[i])
@@ -214,7 +214,7 @@ static void show_files(struct dir_struct *dir)
=20
 	/* For cached/deleted files we don't need to even do the readdir */
 	if (show_others || show_killed) {
-		fill_directory(dir, pathspec);
+		fill_directory(dir, pathspec.raw);
 		if (show_others)
 			show_other_files(dir);
 		if (show_killed)
@@ -282,21 +282,6 @@ static void prune_cache(const char *prefix)
 	active_nr =3D last;
 }
=20
-static void strip_trailing_slash_from_submodules(void)
-{
-	const char **p;
-
-	for (p =3D pathspec; *p !=3D NULL; p++) {
-		int len =3D strlen(*p), pos;
-
-		if (len < 1 || (*p)[len - 1] !=3D '/')
-			continue;
-		pos =3D cache_name_pos(*p, len - 1);
-		if (pos >=3D 0 && S_ISGITLINK(active_cache[pos]->ce_mode))
-			*p =3D xstrndup(*p, len - 1);
-	}
-}
-
 /*
  * Read the tree specified with --with-tree option
  * (typically, HEAD) into stage #1 and then
@@ -550,23 +535,18 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	if (require_work_tree && !is_inside_work_tree())
 		setup_work_tree();
=20
-	pathspec =3D get_pathspec(prefix, argv);
-
-	/* be nice with submodule paths ending in a slash */
-	if (pathspec)
-		strip_trailing_slash_from_submodules();
+	parse_pathspec(&pathspec, 0,
+		       PATHSPEC_PREFER_CWD |
+		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
+		       prefix, argv);
=20
 	/* Find common prefix for all pathspec's */
-	max_prefix =3D common_prefix(pathspec);
+	max_prefix =3D common_prefix(pathspec.raw);
 	max_prefix_len =3D max_prefix ? strlen(max_prefix) : 0;
=20
 	/* Treat unmatching pathspec elements as errors */
-	if (pathspec && error_unmatch) {
-		int num;
-		for (num =3D 0; pathspec[num]; num++)
-			;
-		ps_matched =3D xcalloc(1, num);
-	}
+	if (pathspec.nr && error_unmatch)
+		ps_matched =3D xcalloc(1, pathspec.nr);
=20
 	if ((dir.flags & DIR_SHOW_IGNORED) && !exc_given)
 		die("ls-files --ignored needs some exclude pattern");
@@ -593,7 +573,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	if (ps_matched) {
 		int bad;
-		bad =3D report_path_error(ps_matched, pathspec, prefix);
+		bad =3D report_path_error(ps_matched, pathspec.raw, prefix);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
=20
--=20
1.8.2.83.gc99314b
