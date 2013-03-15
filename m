From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v1 30/45] Convert report_path_error to take struct pathspec
Date: Fri, 15 Mar 2013 13:06:45 +0700
Message-ID: <1363327620-29017-31-git-send-email-pclouds@gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 07:27:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGO7S-00073Z-I2
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 07:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab3COG1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 02:27:32 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:62886 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab3COG1b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 02:27:31 -0400
Received: by mail-ia0-f169.google.com with SMTP id j5so2903930iaf.14
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 23:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=x2dStti7omPFhVKfoOMHDCnpAKRIodlKIljfYq61h7M=;
        b=lOWsLwy/7Fcj3ibCqmuSCRnCMUykszurtzO5CY848oHiyf/EExVQtbcskUx7Fl1bCE
         33JTG0FrGZcX5muGxXed1zexCawpy/U1AAJPlJm2QV0dYdT/rz7btDXTaR4Spm+DtdH0
         e9zEl5lartoEktCnTf0stTQV7EswmTu9EbT4MVnFlOy8gtHQBB3KNQLwVAD+tHQsO8nK
         Do5dmnuUb/jpMBQtNwc8wvOFWrZm29QkVbj1XPm/Ch7dDBBBFrmbvIpbigRBuY1K31+1
         UgMgZd558gD+Jr3yfdPfm8srTleV5W2R6/iuE/ZaM2lhXrA2nOh44tdOv+MA1qWv1icP
         3zEw==
X-Received: by 10.50.46.202 with SMTP id x10mr454976igm.87.1363328850834;
        Thu, 14 Mar 2013 23:27:30 -0700 (PDT)
Received: from tre ([115.74.58.84])
        by mx.google.com with ESMTPS id gy3sm731825igc.10.2013.03.14.23.27.27
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 14 Mar 2013 23:27:30 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Fri, 15 Mar 2013 13:10:33 +0700
X-Mailer: git-send-email 1.8.0.rc0.19.g7bbb31d
In-Reply-To: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218217>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   | 14 ++++++--------
 builtin/ls-files.c | 19 +++++++++++--------
 cache.h            |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 132bfe6..cd459e1 100644
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
index 564f359..eba53af 100644
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
index bd64829..a33ea18 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -351,15 +351,16 @@ void overlay_tree_on_cache(const char *tree_name,=
 const char *prefix)
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
 	 */
 	struct strbuf sb =3D STRBUF_INIT;
-	const char *name;
 	int num, errors =3D 0;
-	for (num =3D 0; pathspec[num]; num++) {
+	for (num =3D 0; num < pathspec->nr; num++) {
 		int other, found_dup;
=20
 		if (ps_matched[num])
@@ -367,13 +368,16 @@ int report_path_error(const char *ps_matched, con=
st char **pathspec, const char
 		/*
 		 * The caller might have fed identical pathspec
 		 * twice.  Do not barf on such a mistake.
+		 * FIXME: parse_pathspec should have eliminated
+		 * duplicate pathspec.
 		 */
 		for (found_dup =3D other =3D 0;
-		     !found_dup && pathspec[other];
+		     !found_dup && other < pathspec->nr;
 		     other++) {
 			if (other =3D=3D num || !ps_matched[other])
 				continue;
-			if (!strcmp(pathspec[other], pathspec[num]))
+			if (!strcmp(pathspec->items[other].original,
+				    pathspec->items[num].original))
 				/*
 				 * Ok, we have a match already.
 				 */
@@ -382,9 +386,8 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 		if (found_dup)
 			continue;
=20
-		name =3D quote_path_relative(pathspec[num], -1, &sb, prefix);
 		error("pathspec '%s' did not match any file(s) known to git.",
-		      name);
+		      pathspec->items[num].original);
 		errors++;
 	}
 	strbuf_release(&sb);
@@ -580,7 +583,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index cc90d7b..e5c3e26 100644
--- a/cache.h
+++ b/cache.h
@@ -1267,7 +1267,7 @@ extern int ws_blank_line(const char *line, int le=
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
1.8.0.rc0.19.g7bbb31d
