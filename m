From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 16/21] Convert report_path_error to take struct pathspec
Date: Fri, 11 Jan 2013 18:21:10 +0700
Message-ID: <1357903275-16804-17-git-send-email-pclouds@gmail.com>
References: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 12:23:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtchS-0007la-9T
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066Ab3AKLWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jan 2013 06:22:42 -0500
Received: from mail-pb0-f52.google.com ([209.85.160.52]:53013 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3AKLWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:22:41 -0500
Received: by mail-pb0-f52.google.com with SMTP id ro2so902470pbb.25
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=610gtulr6gBLKfu3oOhliGaTZvodSUA2GJOa175fRp8=;
        b=dd/Qzek+heOIW7zZ1OPZsDA8lB91yFIQO6pUsvykxcJvd2s7YVBmvTMcgueK3xzwU2
         IXmHIaOsJhTstbW5akCa+xXUoc8ZoHt/cpet4OIASSZ51hfY3aUfZ6LTu/bJPR5Y+ZaC
         r3PSEJ9hUQG6WS9KGHJdKxGsoQK/GSC0RSBVbBcvt5KzKPW8kIv1gbsVVfHdXyRL/Tf7
         eWkNRmaDDuVdd8YUozM9DJwKtWIfYtVEi/OvmZQYcJ61A9hBEflzzWaFc6w4t1RK11yj
         L9aFtTsx6cNIbU+e7PRzUEk4hs/D9tSd2JvDadEFKklTGJA44GD8U91iJgnnM0QwoQcV
         eAyw==
X-Received: by 10.68.134.232 with SMTP id pn8mr224939069pbb.47.1357903361347;
        Fri, 11 Jan 2013 03:22:41 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id d2sm2944144paw.19.2013.01.11.03.22.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jan 2013 03:22:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 11 Jan 2013 18:22:56 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357903275-16804-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213209>


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
index 069d853..8777c19 100644
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
@@ -395,7 +393,7 @@ static char *prepare_index(int argc, const char **a=
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
index c594ded..40eaa04 100644
--- a/cache.h
+++ b/cache.h
@@ -1262,7 +1262,7 @@ extern int ws_blank_line(const char *line, int le=
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
