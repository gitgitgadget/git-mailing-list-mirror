From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/31] Export parse_pathspec() and convert some get_pathspec() calls
Date: Sun, 13 Jan 2013 19:35:13 +0700
Message-ID: <1358080539-17436-6-git-send-email-pclouds@gmail.com>
References: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 13:36:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMnZ-0005yf-KW
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab3AMMgF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 07:36:05 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57245 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876Ab3AMMgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:36:03 -0500
Received: by mail-pa0-f48.google.com with SMTP id fa1so1776006pad.7
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 04:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=p1Tw5CZaPQLHhwy29J5Kd1EDWtImkxWBXWK87nZ5xKI=;
        b=OCuHGV1OjPVZws7XrXaoLtIoWR6Ddug6mgwWOIXShJBpJc0NBCzMeidokZQzZYeR4Y
         0UeoWcXjIEwSgJMEGSf9MfoKS+D5VZrNbjGLO1mWwnJK0zvIi/Y10Ln+sDinjH6gC7eA
         rU+SUgD8pT562aDr/+iqn2Wj7JyFsvRcrTxZbRvabelO5+0BV30OuxDahzScFTETp22X
         G1/Gm8CDQ/RB8Ss9bBuTBltIKklJ/jK7qW2k/bxIjJ5AI37A6tFUquAmKshyh3BTp54W
         ++0xrEh+mPenO9qykG5g8WgqRzl6EayoO4MFSPR/sN+SOhLNJ4bmKZOef55u0EkPQhjd
         /nHA==
X-Received: by 10.66.85.70 with SMTP id f6mr214333408paz.76.1358080562751;
        Sun, 13 Jan 2013 04:36:02 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id sb3sm6287335pbc.44.2013.01.13.04.35.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 04:36:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jan 2013 19:36:16 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358080539-17436-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213345>

These call sites follow the pattern:

   paths =3D get_pathspec(prefix, argv);
   init_pathspec(&pathspec, paths);

which can be converted into a single parse_pathspec() call.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/grep.c         | 4 +---
 builtin/ls-tree.c      | 8 +++++++-
 builtin/update-index.c | 3 +--
 cache.h                | 6 ++++++
 revision.c             | 4 ++--
 setup.c                | 7 +++----
 6 files changed, 20 insertions(+), 12 deletions(-)

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
index fb76e38..e03aaaf 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -166,7 +166,13 @@ int cmd_ls_tree(int argc, const char **argv, const=
 char *prefix)
 	if (get_sha1(argv[0], sha1))
 		die("Not a valid object name %s", argv[0]);
=20
-	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
+	/*
+	 * show_recursive() rolls its own matching code and is
+	 * generally ignorant of 'struct pathspec'. The magic mask
+	 * cannot be lifted until it is converted to use
+	 * match_pathspec_depth() or tree_entry_interesting()
+	 */
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
index 136e4c7..858c7e4 100644
--- a/cache.h
+++ b/cache.h
@@ -474,6 +474,9 @@ extern int index_name_is_other(const struct index_s=
tate *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entr=
y *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry =
*, struct stat *, unsigned int);
=20
+/* Pathspec magic */
+#define PATHSPEC_FROMTOP    (1<<0)
+
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern sastisfies GFNM_ONE=
STAR */
=20
 struct pathspec {
@@ -494,6 +497,9 @@ struct pathspec {
 };
=20
 extern int init_pathspec(struct pathspec *, const char **);
+extern void parse_pathspec(struct pathspec *pathspec, unsigned magic_m=
ask,
+			   unsigned flags, const char *prefix,
+			   const char **args);
 extern void copy_pathspec(struct pathspec *dst, const struct pathspec =
*src);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pa=
thspec *pathspec);
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
index a1ad012..0c9fc75 100644
--- a/setup.c
+++ b/setup.c
@@ -162,7 +162,6 @@ void verify_non_filename(const char *prefix, const =
char *arg)
  *	{ PATHSPEC_REGEXP, '\0', "regexp" },
  *
  */
-#define PATHSPEC_FROMTOP    (1<<0)
=20
 static struct pathspec_magic {
 	unsigned bit;
@@ -276,9 +275,9 @@ static int pathspec_item_cmp(const void *a_, const =
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
