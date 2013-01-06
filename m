From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/21] Convert report_path_error to take struct pathspec
Date: Sun,  6 Jan 2013 13:21:04 +0700
Message-ID: <1357453268-12543-18-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:23:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjdU-0000ab-59
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab3AFGWs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:48 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:64356 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346Ab3AFGWr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:47 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so8180094dad.10
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=GB0MqJQdLYAKi86PDVDFoNrWXxfvhNoEGiUmLL2ieE0=;
        b=0lNc5SZQt1tL0wMGb6+LrO1RFZM0VnQhxvUN1RCI6PTitybcrIfF54AU5VAr8nLAc7
         OzIaW8UNp6MJETiM4ph3qpT6DIBvvcriAS+AJDR+V1GYT05hfoglLF00gtAXi5JZDn6a
         Z092sCPRiFJtqKY9eOFBe/zg13cfkWSOwJJZpWMmKLiCiBG9am14pp1tVONGyUL0X2Hp
         e52aQUsPYQHlBtopKHQSSaXCXyne6JXDq5rbQ4uBhI5x7kTv4ItKgOvVK0es3VWN7+Gm
         wNxRHVsV8V34cQeZYQLTOYYBTqzpTEETnen6LMW4lXGN6TM9hw/iDTlmz7TEO7RFwx67
         bk/w==
X-Received: by 10.69.0.40 with SMTP id av8mr176801657pbd.117.1357453366508;
        Sat, 05 Jan 2013 22:22:46 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id is6sm35286614pbc.55.2013.01.05.22.22.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212771>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   | 14 ++++++--------
 builtin/ls-files.c | 14 ++++++++------
 cache.h            |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a7ddb35..648768e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -273,7 +273,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 		match_pathspec_depth(&opts->pathspec, ce->name, ce_namelen(ce), 0, p=
s_matched);
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec.raw, opts->prefix))
+	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix))
 		return 1;
=20
 	/* "checkout -m path" to recreate conflicted state */
diff --git a/builtin/commit.c b/builtin/commit.c
index 7b5f123..71c5afb 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -181,20 +181,18 @@ static int commit_index_files(void)
  * and return the paths that match the given pattern in list.
  */
 static int list_paths(struct string_list *list, const char *with_tree,
-		      const char *prefix, const char **pattern)
+		      const char *prefix, const struct pathspec *pattern)
 {
 	int i;
 	char *m;
=20
-	if (!pattern)
+	if (!pattern->nr)
 		return 0;
=20
-	for (i =3D 0; pattern[i]; i++)
-		;
-	m =3D xcalloc(1, i);
+	m =3D xcalloc(1, pattern->nr);
=20
 	if (with_tree) {
-		char *max_prefix =3D common_prefix(pattern);
+		char *max_prefix =3D common_prefix(pattern->raw);
 		overlay_tree_on_cache(with_tree, max_prefix ? max_prefix : prefix);
 		free(max_prefix);
 	}
@@ -205,7 +203,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
=20
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!match_pathspec_depth(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
@@ -396,7 +394,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
=20
 	memset(&partial, 0, sizeof(partial));
 	partial.strdup_strings =3D 1;
-	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, paths=
pec.raw))
+	if (list_paths(&partial, !current_head ? NULL : "HEAD", prefix, &path=
spec))
 		exit(1);
=20
 	discard_cache();
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 9336abd..be6e05d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -349,7 +349,9 @@ void overlay_tree_on_cache(const char *tree_name, c=
onst char *prefix)
 	}
 }
=20
-int report_path_error(const char *ps_matched, const char **pathspec, c=
onst char *prefix)
+int report_path_error(const char *ps_matched,
+		      const struct pathspec *pathspec,
+		      const char *prefix)
 {
 	/*
 	 * Make sure all pathspec matched; otherwise it is an error.
@@ -357,7 +359,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *name;
 	int num, errors =3D 0;
-	for (num =3D 0; pathspec[num]; num++) {
+	for (num =3D 0; num < pathspec->nr; num++) {
 		int other, found_dup;
=20
 		if (ps_matched[num])
@@ -367,11 +369,11 @@ int report_path_error(const char *ps_matched, con=
st char **pathspec, const char
 		 * twice.  Do not barf on such a mistake.
 		 */
 		for (found_dup =3D other =3D 0;
-		     !found_dup && pathspec[other];
+		     !found_dup && pathspec->raw[other];
 		     other++) {
 			if (other =3D=3D num || !ps_matched[other])
 				continue;
-			if (!strcmp(pathspec[other], pathspec[num]))
+			if (!strcmp(pathspec->raw[other], pathspec->raw[num]))
 				/*
 				 * Ok, we have a match already.
 				 */
@@ -380,7 +382,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 		if (found_dup)
 			continue;
=20
-		name =3D quote_path_relative(pathspec[num], -1, &sb, prefix);
+		name =3D quote_path_relative(pathspec->raw[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
 		      name);
 		errors++;
@@ -572,7 +574,7 @@ int cmd_ls_files(int argc, const char **argv, const=
 char *cmd_prefix)
=20
 	if (ps_matched) {
 		int bad;
-		bad =3D report_path_error(ps_matched, pathspec.raw, prefix);
+		bad =3D report_path_error(ps_matched, &pathspec, prefix);
 		if (bad)
 			fprintf(stderr, "Did you forget to 'git add'?\n");
=20
diff --git a/cache.h b/cache.h
index 7871cd1..3c34ef5 100644
--- a/cache.h
+++ b/cache.h
@@ -1258,7 +1258,7 @@ extern int ws_blank_line(const char *line, int le=
n, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
=20
 /* ls-files */
-int report_path_error(const char *ps_matched, const char **pathspec, c=
onst char *prefix);
+int report_path_error(const char *ps_matched, const struct pathspec *p=
athspec, const char *prefix);
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
=20
 char *alias_lookup(const char *alias);
--=20
1.8.0.rc2.23.g1fb49df
