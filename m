From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/21] Convert read_cache_preload() to take struct pathspec
Date: Sun,  6 Jan 2013 13:21:01 +0700
Message-ID: <1357453268-12543-15-git-send-email-pclouds@gmail.com>
References: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 06 07:22:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrjdD-0000FW-UL
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:22:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420Ab3AFGWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2013 01:22:32 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:58541 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080Ab3AFGWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:22:31 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so8130567dak.2
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 22:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=tpso3h91RPiL+zzvGW8jIfhM9/MIK3Q490Wozcsohow=;
        b=AWxlm+CyjRWbeVxTXxwq6TTOHns7eFNprNgetNZ/BcSlSITbQoi+b6RWj9oUHDUdqG
         pU/NoO67Q5X5b+yM8UP9WoZUBIHLiLklN4FCtNckB5qX+mwCPB4+JWtblnbKq24CUgPc
         PpXcWqMMUcwK+qYgxzT2Hdjw/559wQpHNIk/s9sMHqPlw+NLrkey/TgDDVMOwJgOp0OX
         miXsMqZlI239BIUDRoEci2R6R0f+atFjotlabcrwVbQOLiOIZy+liBurWuW1twYB9R9F
         s/ccXXah0e6ItVBQXVYV34l9VFIVgx5P2Kq0W//83dfnKGwoL6CBCAmVrP9pPSfVL0M1
         oi/g==
X-Received: by 10.68.203.198 with SMTP id ks6mr175627134pbc.35.1357453350030;
        Sat, 05 Jan 2013 22:22:30 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id o11sm35298879pby.8.2013.01.05.22.22.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 22:22:29 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 06 Jan 2013 13:22:39 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1357453268-12543-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212768>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c   |  2 +-
 builtin/commit.c     |  4 ++--
 builtin/diff-files.c |  2 +-
 builtin/diff-index.c |  2 +-
 builtin/diff.c       |  4 ++--
 cache.h              |  4 +++-
 preload-index.c      | 20 +++++++++++---------
 7 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index da25298..00910dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -261,7 +261,7 @@ static int checkout_paths(const struct checkout_opt=
s *opts,
 	lock_file =3D xcalloc(1, sizeof(struct lock_file));
=20
 	newfd =3D hold_locked_index(lock_file, 1);
-	if (read_cache_preload(opts->pathspec.raw) < 0)
+	if (read_cache_preload(&opts->pathspec) < 0)
 		return error(_("corrupt index file"));
=20
 	if (opts->source_tree)
diff --git a/builtin/commit.c b/builtin/commit.c
index b706ebb..7b5f123 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -288,7 +288,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 	else
 		memset(&pathspec, 0, sizeof(pathspec));
=20
-	if (read_cache_preload(pathspec.raw) < 0)
+	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
=20
 	if (interactive) {
@@ -1209,7 +1209,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 	if (*argv)
 		parse_pathspec(&s.pathspec, PATHSPEC_FROMTOP, 0, prefix, argv);
=20
-	read_cache_preload(s.pathspec.raw);
+	read_cache_preload(&s.pathspec);
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec.=
raw, NULL, NULL);
=20
 	fd =3D hold_locked_index(&index_lock, 0);
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 46085f8..9200069 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -61,7 +61,7 @@ int cmd_diff_files(int argc, const char **argv, const=
 char *prefix)
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
 		rev.combine_merges =3D rev.dense_combined_merges =3D 1;
=20
-	if (read_cache_preload(rev.diffopt.pathspec.raw) < 0) {
+	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 1c737f7..ce15b23 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -43,7 +43,7 @@ int cmd_diff_index(int argc, const char **argv, const=
 char *prefix)
 		usage(diff_cache_usage);
 	if (!cached) {
 		setup_work_tree();
-		if (read_cache_preload(rev.diffopt.pathspec.raw) < 0) {
+		if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 			perror("read_cache_preload");
 			return -1;
 		}
diff --git a/builtin/diff.c b/builtin/diff.c
index 8c2af6c..62bdc4d 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -140,7 +140,7 @@ static int builtin_diff_index(struct rev_info *revs=
,
 		usage(builtin_diff_usage);
 	if (!cached) {
 		setup_work_tree();
-		if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
+		if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
 			perror("read_cache_preload");
 			return -1;
 		}
@@ -240,7 +240,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 		revs->combine_merges =3D revs->dense_combined_merges =3D 1;
=20
 	setup_work_tree();
-	if (read_cache_preload(revs->diffopt.pathspec.raw) < 0) {
+	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
 		return -1;
 	}
diff --git a/cache.h b/cache.h
index 890d89b..7871cd1 100644
--- a/cache.h
+++ b/cache.h
@@ -182,6 +182,8 @@ struct cache_entry {
 #error "CE_EXTENDED_FLAGS out of range"
 #endif
=20
+struct pathspec;
+
 /*
  * Copy the sha1 and stat state of a cache entry from one to
  * another. But we never change the name, or the hash state!
@@ -433,7 +435,7 @@ extern int init_db(const char *template_dir, unsign=
ed int flags);
=20
 /* Initialize and use the cache information */
 extern int read_index(struct index_state *);
-extern int read_index_preload(struct index_state *, const char **paths=
pec);
+extern int read_index_preload(struct index_state *, const struct paths=
pec *pathspec);
 extern int read_index_from(struct index_state *, const char *path);
 extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
diff --git a/preload-index.c b/preload-index.c
index 49cb08d..91f27f7 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -4,7 +4,8 @@
 #include "cache.h"
=20
 #ifdef NO_PTHREADS
-static void preload_index(struct index_state *index, const char **path=
spec)
+static void preload_index(struct index_state *index,
+			  const struct pathspec *pathspec)
 {
 	; /* nothing */
 }
@@ -24,7 +25,7 @@ static void preload_index(struct index_state *index, =
const char **pathspec)
 struct thread_data {
 	pthread_t pthread;
 	struct index_state *index;
-	const char **pathspec;
+	struct pathspec pathspec;
 	int offset, nr;
 };
=20
@@ -35,9 +36,7 @@ static void *preload_thread(void *_data)
 	struct index_state *index =3D p->index;
 	struct cache_entry **cep =3D index->cache + p->offset;
 	struct cache_def cache;
-	struct pathspec pathspec;
=20
-	init_pathspec(&pathspec, p->pathspec);
 	memset(&cache, 0, sizeof(cache));
 	nr =3D p->nr;
 	if (nr + p->offset > index->cache_nr)
@@ -53,7 +52,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_uptodate(ce))
 			continue;
-		if (!ce_path_match(ce, &pathspec))
+		if (!ce_path_match(ce, &p->pathspec))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(c=
e)))
 			continue;
@@ -63,11 +62,11 @@ static void *preload_thread(void *_data)
 			continue;
 		ce_mark_uptodate(ce);
 	} while (--nr > 0);
-	free_pathspec(&pathspec);
 	return NULL;
 }
=20
-static void preload_index(struct index_state *index, const char **path=
spec)
+static void preload_index(struct index_state *index,
+			  const struct pathspec *pathspec)
 {
 	int threads, i, work, offset;
 	struct thread_data data[MAX_PARALLEL];
@@ -82,10 +81,12 @@ static void preload_index(struct index_state *index=
, const char **pathspec)
 		threads =3D MAX_PARALLEL;
 	offset =3D 0;
 	work =3D DIV_ROUND_UP(index->cache_nr, threads);
+	memset(&data, 0, sizeof(data));
 	for (i =3D 0; i < threads; i++) {
 		struct thread_data *p =3D data+i;
 		p->index =3D index;
-		p->pathspec =3D pathspec;
+		if (pathspec)
+			p->pathspec =3D *pathspec;
 		p->offset =3D offset;
 		p->nr =3D work;
 		offset +=3D work;
@@ -100,7 +101,8 @@ static void preload_index(struct index_state *index=
, const char **pathspec)
 }
 #endif
=20
-int read_index_preload(struct index_state *index, const char **pathspe=
c)
+int read_index_preload(struct index_state *index,
+		       const struct pathspec *pathspec)
 {
 	int retval =3D read_index(index);
=20
--=20
1.8.0.rc2.23.g1fb49df
