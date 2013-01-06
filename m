From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/21] Export parse_pathspec() and convert some get_pathspec() calls
Date: Sun,  6 Jan 2013 13:20:51 +0700
Message-ID: <1357453268-12543-5-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjcB-0007d0-KG
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab3AFGV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:21:28 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44561 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3AFGV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:21:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so10084460pad.33
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=gqvFcoD3DjkdVeomG7CC8wQZ6QuqLo/hIpQ4IbPZF6M=;
        b=jdC+BmAkhD6UBCrl/GDORwM4a6HXZZmbF55qtZve1wIJUfSMA4nlTVuy5JYOZFZDLb
         JPfzDLt5X0Hl/h1N6Ge9rCTa1W2Qd/HJdDDvL38hKybfoDd1GvvUaa/UXkoeLB0uqi9r
         dzlCM/mSSwzkRQ1TZV8gda5rh9aFptfTEOQI0wjdtovKcrjJh0MEmO4//I/k6mSNcZSz
         YSDyhnBzftd8Fd3LJsdR8qNeVTn7FvvexOvrLHORELZa9w2g88T4orpP4/4pOM/ttOXu
         XjEkeA25g3gL/SBlY4WQrCql+QthcCyaS/kqJdgTaaSpAO6B+WcTzZ4Z6wMW/i1izKCj
         I29Q==
X-Received: by 10.66.85.74 with SMTP id f10mr167535893paz.38.1357453285571;
        Sat, 05 Jan 2013 22:21:25 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id bi8sm32564868pab.15.2013.01.05.22.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:21:24 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:21:35 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212758>

These call sites follow the pattern:

   paths =3D get_pathspec(prefix, argv);
   init_pathspec(&pathspec, paths);

which can be converted into a single parse_pathspec() call.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         | 4 +---
 builtin/ls-tree.c      | 2 +-
 builtin/update-index.c | 3 +--
 cache.h                | 6 ++++++
 revision.c             | 4 ++--
 setup.c                | 6 +++---
 6 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0e1b6c8..705f9ff 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -630,7 +630,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	const char *show_in_pager =3D NULL, *default_pager =3D "dummy";
 	struct grep_opt opt;
 	struct object_array list =3D OBJECT_ARRAY_INIT;
-	const char **paths =3D NULL;
 	struct pathspec pathspec;
 	struct string_list path_list =3D STRING_LIST_INIT_NODUP;
 	int i;
@@ -857,8 +856,7 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 			verify_filename(prefix, argv[j], j =3D=3D i);
 	}
=20
-	paths =3D get_pathspec(prefix, argv + i);
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + i);
 	pathspec.max_depth =3D opt.max_depth;
 	pathspec.recursive =3D 1;
=20
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..a78ba53 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,7 +166,7 @@ int cmd_ls_tree(int argc, const char **argv, const =
char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, argv + 1);
 	for (i =3D 0; i < pathspec.nr; i++)
 		pathspec.items[i].nowildcard_len =3D pathspec.items[i].len;
 	pathspec.has_wildcard =3D 0;
diff --git a/builtin/update-index.c b/builtin/update-index.c
index ada1dff..6728e59 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -546,10 +546,9 @@ static int do_reupdate(int ac, const char **av,
 	 */
 	int pos;
 	int has_head =3D 1;
-	const char **paths =3D get_pathspec(prefix, av + 1);
 	struct pathspec pathspec;
=20
-	init_pathspec(&pathspec, paths);
+	parse_pathspec(&pathspec, PATHSPEC_FROMTOP, 0, prefix, av + 1);
=20
 	if (read_ref("HEAD", head_sha1))
 		/* If there is no HEAD, that means it is an initial
diff --git a/cache.h b/cache.h
index 9304d91..e52365d 100644
--- a/cache.h
+++ b/cache.h
@@ -473,6 +473,9 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+/* Pathspec magic */
+#define PATHSPEC_FROMTOP    (1<<0)
+
 struct pathspec {
 	const char **raw; /* get_pathspec() result, not freed by free_pathspe=
c() */
 	int nr;
@@ -487,6 +490,9 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void parse_pathspec(struct pathspec *pathspec, unsigned magic,
+			   unsigned flags, const char *prefix,
+			   const char **args);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
=20
diff --git a/revision.c b/revision.c
index 95d21e6..a044242 100644
--- a/revision.c
+++ b/revision.c
@@ -1851,8 +1851,8 @@ int setup_revisions(int argc, const char **argv, =
struct rev_info *revs, struct s
 		 */
 		ALLOC_GROW(prune_data.path, prune_data.nr+1, prune_data.alloc);
 		prune_data.path[prune_data.nr++] =3D NULL;
-		init_pathspec(&revs->prune_data,
-			      get_pathspec(revs->prefix, prune_data.path));
+		parse_pathspec(&revs->prune_data, PATHSPEC_FROMTOP, 0,
+			       revs->prefix, prune_data.path);
 	}
=20
 	if (revs->def =3D=3D NULL)
diff --git a/setup.c b/setup.c
index 573ef79..cd6680e 100644
--- a/setup.c
+++ b/setup.c
@@ -268,9 +268,9 @@ static int pathspec_item_cmp(const void *a_, const =
void *b_)
  * Given command line arguments and a prefix, convert the input to
  * pathspec. die() if any magic other than ones in magic_mask.
  */
-static void parse_pathspec(struct pathspec *pathspec,
-			   unsigned magic_mask, unsigned flags,
-			   const char *prefix, const char **argv)
+void parse_pathspec(struct pathspec *pathspec,
+		    unsigned magic_mask, unsigned flags,
+		    const char *prefix, const char **argv)
 {
 	struct pathspec_item *item;
 	const char *entry =3D *argv;
--=20
1.8.0.rc2.23.g1fb49df
