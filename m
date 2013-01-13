From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 22/31] Convert report_path_error to take struct pathspec
Date: Sun, 13 Jan 2013 19:35:30 +0700
Message-ID: <1358080539-17436-23-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMpj-0007tH-BY
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175Ab3AMMiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:38:19 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:56024 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755142Ab3AMMiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:38:18 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so1768147pac.15
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=+F5BVSbLcN8FeLNc9LbALKhtRzl0YVw7HLXTdyplVz0=;
        b=BgKqnOOuHdI39YWVrgr8ZHQzVNrVtFnedv4+hfj3VGYApqmAj7r2BxXiBaLxWjG3Yn
         Fux9fAaQpILkHQNc2X0XFYKsMjz5tHQKttnPAdZHnkUpafEMPLPBTDhnik+eU2DL4CId
         qbaZNeIgo5p6Zmpfv/BSikDFhecoMTtaRo9EUqkHGcY/lRXLlVLGcoC6dtBmWBWbQ9V0
         cTIipG4hH+hIdwKAZIdRkSL/mrJbgs4swL0nuJlTeiH/A9mh2h9zilQOMzsNO1T+fOgp
         7BTSYT19XTuIWVh7L4nATtc1lum16wDJxFsxY2ic4Cr6WSOMxQ+SKtp74OkgPc91bXju
         1yDA==
X-Received: by 10.68.224.130 with SMTP id rc2mr56204456pbc.156.1358080697791;
        Sun, 13 Jan 2013 04:38:17 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id c2sm6749554pay.34.2013.01.13.04.38.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:38:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:38:31 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213362>

This commit fixes a subtle bug in ls-files and commit:

- when match_pathspec() returns seen[], it follows the order of the
  input "const char **pathspec", which is now pathspec.raw[]

- when match_pathspec() returns seen[], it follows the order of
  pathspec.items[]

- due to 86e4ca6 (tree_entry_interesting(): fix depth limit with
  overlapping pathspecs - 2010-12-15), pathspec.items[] is sorted, but
  pathspec.raw[] is NOT.

by converting from match_pathspec() to match_pathspec_depth(), we also
have to switch the original path array. We haven't done so because
there are other call sites of report_path_error() that relies on old
order. We now follow pathspec.items[] order.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   | 14 ++++++--------
 builtin/ls-files.c | 19 +++++++++++--------
 cache.h            |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 97ea496..d2fc996 100644
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
index 8905bd3..4bf3238 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -349,15 +349,16 @@ void overlay_tree_on_cache(const char *tree_name,=
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
@@ -365,13 +366,16 @@ int report_path_error(const char *ps_matched, con=
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
@@ -380,9 +384,8 @@ int report_path_error(const char *ps_matched, const=
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
@@ -571,7 +574,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index fb8a1f7..f3be326 100644
--- a/cache.h
+++ b/cache.h
@@ -1289,7 +1289,7 @@ extern int ws_blank_line(const char *line, int le=
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
