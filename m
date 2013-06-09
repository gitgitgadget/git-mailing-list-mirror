From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/45] Convert read_cache_preload() to take struct pathspec
Date: Sun,  9 Jun 2013 13:25:59 +0700
Message-ID: <1370759178-1709-27-git-send-email-pclouds@gmail.com>
References: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 08:27:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlZ6M-00014r-Is
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 08:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab3FIG1i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 02:27:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41658 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab3FIG1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 02:27:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so1133526pbb.33
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N6LoszV54gVdfcM/2fkHymUcNQjASK9T1hXMNHfpqf4=;
        b=PZKq1uYCXAfEQxgSekEzUkWvNnv5IaETfPx7MVT9/PgxvDQJ712PkE2ufvt/DiFF4x
         0vhDbUWdOPNTGXnQ/rxd6gS9IPO1NLll7qKmqCHSubTk8rSfGGonVpzsezAlzK14UXJT
         Bed/8Qs1+bSVCPBaU/mboNyqjg3aEoZEebFqRq58gnIVr/uAGAvhqGXQouZcHLwxCFl7
         Jkn/IybkkuTeEpm3ceFc639Bjb8GPMwP9zF1IUUs1oZrbJ9/U9UJ05EkRU8moj9kHhVq
         dZd9gFUyWvzU7uRietFYXj12QlbSUjOQc+Zv1SfeBuNjSAr59Na8qMxbSsGvEyx9oHGK
         5JvA==
X-Received: by 10.68.217.7 with SMTP id ou7mr5120540pbc.8.1370759257291;
        Sat, 08 Jun 2013 23:27:37 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id pe9sm5494656pbc.35.2013.06.08.23.27.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 23:27:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:29:08 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370759178-1709-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226918>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c   |  2 +-
 builtin/commit.c     |  4 ++--
 builtin/diff-files.c |  2 +-
 builtin/diff-index.c |  2 +-
 builtin/diff.c       |  4 ++--
 cache.h              |  2 +-
 preload-index.c      | 20 +++++++++++---------
 7 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 197198b..d7a65e4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -262,7 +262,7 @@ static int checkout_paths(const struct checkout_opt=
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
index 833c7be..171de9f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -289,7 +289,7 @@ static char *prepare_index(int argc, const char **a=
rgv, const char *prefix,
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
=20
-	if (read_cache_preload(pathspec.raw) < 0)
+	if (read_cache_preload(&pathspec) < 0)
 		die(_("index file corrupt"));
=20
 	if (interactive) {
@@ -1201,7 +1201,7 @@ int cmd_status(int argc, const char **argv, const=
 char *prefix)
 		       PATHSPEC_PREFER_FULL,
 		       prefix, argv);
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
index d237e0a..6b4e3f9 100644
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
index 5917375..19e0d87 100644
--- a/cache.h
+++ b/cache.h
@@ -443,7 +443,7 @@ extern int init_db(const char *template_dir, unsign=
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
index cddfffa..8c44ceb 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -5,7 +5,8 @@
 #include "pathspec.h"
=20
 #ifdef NO_PTHREADS
-static void preload_index(struct index_state *index, const char **path=
spec)
+static void preload_index(struct index_state *index,
+			  const struct pathspec *pathspec)
 {
 	; /* nothing */
 }
@@ -25,7 +26,7 @@ static void preload_index(struct index_state *index, =
const char **pathspec)
 struct thread_data {
 	pthread_t pthread;
 	struct index_state *index;
-	const char **pathspec;
+	struct pathspec pathspec;
 	int offset, nr;
 };
=20
@@ -36,9 +37,7 @@ static void *preload_thread(void *_data)
 	struct index_state *index =3D p->index;
 	struct cache_entry **cep =3D index->cache + p->offset;
 	struct cache_def cache;
-	struct pathspec pathspec;
=20
-	init_pathspec(&pathspec, p->pathspec);
 	memset(&cache, 0, sizeof(cache));
 	nr =3D p->nr;
 	if (nr + p->offset > index->cache_nr)
@@ -54,7 +53,7 @@ static void *preload_thread(void *_data)
 			continue;
 		if (ce_uptodate(ce))
 			continue;
-		if (!ce_path_match(ce, &pathspec))
+		if (!ce_path_match(ce, &p->pathspec))
 			continue;
 		if (threaded_has_symlink_leading_path(&cache, ce->name, ce_namelen(c=
e)))
 			continue;
@@ -64,11 +63,11 @@ static void *preload_thread(void *_data)
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
@@ -83,10 +82,12 @@ static void preload_index(struct index_state *index=
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
+			copy_pathspec(&p->pathspec, pathspec);
 		p->offset =3D offset;
 		p->nr =3D work;
 		offset +=3D work;
@@ -101,7 +102,8 @@ static void preload_index(struct index_state *index=
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
1.8.2.83.gc99314b
