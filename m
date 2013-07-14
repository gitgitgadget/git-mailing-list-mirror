From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 30/46] Convert report_path_error to take struct pathspec
Date: Sun, 14 Jul 2013 15:35:53 +0700
Message-ID: <1373790969-13000-31-git-send-email-pclouds@gmail.com>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 10:39:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyHpw-0002tO-Ij
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 10:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab3GNIjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Jul 2013 04:39:16 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33062 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3GNIjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 04:39:14 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so9816040pdc.5
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 01:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WCaP89FKmwZr5FL6LenAUir2HQZ4ZXD6OG5oSUO9HPE=;
        b=sAuQl2rM/jjevTHsuvVavAvOxmBbqYm7Pkk2DIAzjTHABpRhhDULRlwWHRnI33hNRU
         NR7vf4XEEW3E+snQu1fe9b+9eESojEXuWEmTA+ufyUksurB30A/VcpeFtoyLjC5ERBfy
         0KprnlAuH8OmvaV+k6uZurb/As35CSib7EPHTxCmrwzBZTjw/nW4+/CefqmJ2GhYwkdN
         wc2BilYWxSkcNahuYtbwBe6AUFBdcKr6j9fVmwU1orKZDZNUG8adsnsaGtm1isdEPoHw
         BvMPDcppSxO0RZdFMLvfdj7K23jLnjXR73q7DtzgirlpVeCy+FdwvDeLznpAIFVX2c2n
         8thg==
X-Received: by 10.66.37.77 with SMTP id w13mr51142052paj.73.1373791154101;
        Sun, 14 Jul 2013 01:39:14 -0700 (PDT)
Received: from lanh ([115.73.210.100])
        by mx.google.com with ESMTPSA id sp4sm7212362pbc.45.2013.07.14.01.39.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 01:39:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 14 Jul 2013 15:39:25 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230342>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c |  2 +-
 builtin/commit.c   | 14 ++++++--------
 builtin/ls-files.c | 19 +++++++++++--------
 cache.h            |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c2f3571..7ea1100 100644
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
index 0344ec7..eaecf7c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -188,20 +188,18 @@ static int commit_index_files(void)
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
@@ -212,7 +210,7 @@ static int list_paths(struct string_list *list, con=
st char *with_tree,
=20
 		if (ce->ce_flags & CE_UPDATE)
 			continue;
-		if (!match_pathspec(pattern, ce->name, ce_namelen(ce), 0, m))
+		if (!match_pathspec_depth(pattern, ce->name, ce_namelen(ce), 0, m))
 			continue;
 		item =3D string_list_insert(list, ce->name);
 		if (ce_skip_worktree(ce))
@@ -402,7 +400,7 @@ static char *prepare_index(int argc, const char **a=
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
index f1be425..50e6edf 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -346,15 +346,16 @@ void overlay_tree_on_cache(const char *tree_name,=
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
@@ -362,13 +363,16 @@ int report_path_error(const char *ps_matched, con=
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
@@ -377,9 +381,8 @@ int report_path_error(const char *ps_matched, const=
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
@@ -575,7 +578,7 @@ int cmd_ls_files(int argc, const char **argv, const=
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
index 0370546..42c9920 100644
--- a/cache.h
+++ b/cache.h
@@ -1312,7 +1312,7 @@ extern int ws_blank_line(const char *line, int le=
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
