From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/45] Convert report_path_error to take struct pathspec
Date: Sun,  9 Jun 2013 13:26:03 +0700
Message-ID: <1370759178-1709-31-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:28:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6n-0001JF-N5
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3FIG2E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:28:04 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61830 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3FIG2D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:28:03 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so708858pbc.7
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KiBM13+A/EBqxnRR9y90kwfL6yeFMLARNaumM6Jy7VM=;
        b=DIsPfUMdP+MtDuuEXol51t5Ce2Nf/1dYYhkziCfes/6Q865FFJpROCjWhq9pRQ7dl5
         v3QiTHi4XMJNHL6pT7DFdGehqWosT93qwt4+lLYUNK2ZLfC7Zl5YsqaCTFPm+YvlPtGU
         z1LegK9BPEzBgL3N694hD3pLcnQ0QRi3UpNaqYwSnsN3S99fYKmuScVqtHPnVLdgPZFu
         L35TmKZ3tWmzd09NeRZWYQx0dSpBchdi9K3lSBUTDl1FeNFOP+0D443OwJCBJa2VU7LN
         U4yqAVWShkM6QmLvGXpH9dlx7HRk4XkfXEQAWV6nxpWsdvDHV9aijNly0pf6FHkjd42O
         zquw==
X-Received: by 10.66.159.66 with SMTP id xa2mr9375312pab.36.1370759282372;
        Sat, 08 Jun 2013 23:28:02 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id cc15sm10284015pac.1.2013.06.08.23.27.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:28:01 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:33 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226922>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   | 14 ++++++--------
 builtin/ls-files.c | 19 +++++++++++--------
 cache.h            |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index be08061..f543533 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -304,7 +304,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 			ce->ce_flags |=3D CE_MATCHED;
 	}
=20
-	if (report_path_error(ps_matched, opts->pathspec.raw, opts->prefix)) =
{
+	if (report_path_error(ps_matched, &opts->pathspec, opts->prefix)) {
 		free(ps_matched);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 171de9f..e5a3bb5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -183,20 +183,18 @@ static int commit_index_files(void)
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
@@ -207,7 +205,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
=20
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!match_pathspec_depth(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
@@ -397,7 +395,7 @@ static char *prepare_index(int argc, const char **a=
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
index 1534a39..f6db498 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -344,15 +344,16 @@ void overlay_tree_on_cache(const char *tree_name,=
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
@@ -360,13 +361,16 @@ int report_path_error(const char *ps_matched, con=
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
@@ -375,9 +379,8 @@ int report_path_error(const char *ps_matched, const=
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
@@ -573,7 +576,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index 19e0d87..f978e88 100644
--- a/cache.h
+++ b/cache.h
@@ -1294,7 +1294,7 @@ extern int ws_blank_line(const char *line, int le=
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
1.8.2.83.gc99314b
