From: Jeff King <peff@peff.net>
Subject: [PATCHv2 3/9] archive: refactor list of archive formats
Date: Tue, 21 Jun 2011 21:23:33 -0400
Message-ID: <20110622012333.GC30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:23:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCAP-0004dP-H4
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757765Ab1FVBXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:23:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757545Ab1FVBXf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:23:35 -0400
Received: (qmail 7397 invoked by uid 107); 22 Jun 2011 01:23:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:23:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:23:33 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176206>

Most of the tar and zip code was nicely split out into two
abstracted files which knew only about their specific
formats. The entry point to this code was a single "write
archive" function.

However, as these basic formats grow more complex (e.g., by
handling multiple file extensions and format names), a
static list of the entry point functions won't be enough.
Instead, let's provide a way for the tar and zip code to
tell the main archive code what they support by registering
archiver names and functions.

Signed-off-by: Jeff King <peff@peff.net>
---
New in v2. This turns archivers more into proper objects, rather than a
hard-coded list of functions, and makes the rest of the series much
cleaner.

 archive-tar.c |   16 +++++++++++++---
 archive-zip.c |   13 ++++++++++++-
 archive.c     |   33 +++++++++++++++++----------------
 archive.h     |   17 ++++++++++-------
 4 files changed, 52 insertions(+), 27 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 1ab1a2c..930375b 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -234,12 +234,10 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
-int write_tar_archive(struct archiver_args *args)
+static int write_tar_archive(struct archiver_args *args)
 {
 	int err = 0;
 
-	git_config(git_tar_config, NULL);
-
 	if (args->commit_sha1)
 		err = write_global_extended_header(args);
 	if (!err)
@@ -248,3 +246,15 @@ int write_tar_archive(struct archiver_args *args)
 		write_trailer();
 	return err;
 }
+
+static struct archiver tar_archiver = {
+	"tar",
+	write_tar_archive,
+	0
+};
+
+void init_tar_archiver(void)
+{
+	register_archiver(&tar_archiver);
+	git_config(git_tar_config, NULL);
+}
diff --git a/archive-zip.c b/archive-zip.c
index cf28504..a776d83 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -261,7 +261,7 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
 	*dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
 }
 
-int write_zip_archive(struct archiver_args *args)
+static int write_zip_archive(struct archiver_args *args)
 {
 	int err;
 
@@ -278,3 +278,14 @@ int write_zip_archive(struct archiver_args *args)
 
 	return err;
 }
+
+static struct archiver zip_archiver = {
+	"zip",
+	write_zip_archive,
+	ARCHIVER_WANT_COMPRESSION_LEVELS
+};
+
+void init_zip_archiver(void)
+{
+	register_archiver(&zip_archiver);
+}
diff --git a/archive.c b/archive.c
index 2616676..f0b4e85 100644
--- a/archive.c
+++ b/archive.c
@@ -14,16 +14,15 @@ static char const * const archive_usage[] = {
 	NULL
 };
 
-#define USES_ZLIB_COMPRESSION 1
-
-static const struct archiver {
-	const char *name;
-	write_archive_fn_t write_archive;
-	unsigned int flags;
-} archivers[] = {
-	{ "tar", write_tar_archive },
-	{ "zip", write_zip_archive, USES_ZLIB_COMPRESSION },
-};
+static const struct archiver **archivers;
+static int nr_archivers;
+static int alloc_archivers;
+
+void register_archiver(struct archiver *ar)
+{
+	ALLOC_GROW(archivers, nr_archivers + 1, alloc_archivers);
+	archivers[nr_archivers++] = ar;
+}
 
 static void format_subst(const struct commit *commit,
                          const char *src, size_t len,
@@ -208,9 +207,9 @@ static const struct archiver *lookup_archiver(const char *name)
 	if (!name)
 		return NULL;
 
-	for (i = 0; i < ARRAY_SIZE(archivers); i++) {
-		if (!strcmp(name, archivers[i].name))
-			return &archivers[i];
+	for (i = 0; i < nr_archivers; i++) {
+		if (!strcmp(name, archivers[i]->name))
+			return archivers[i];
 	}
 	return NULL;
 }
@@ -355,8 +354,8 @@ static int parse_archive_args(int argc, const char **argv,
 		base = "";
 
 	if (list) {
-		for (i = 0; i < ARRAY_SIZE(archivers); i++)
-			printf("%s\n", archivers[i].name);
+		for (i = 0; i < nr_archivers; i++)
+			printf("%s\n", archivers[i]->name);
 		exit(0);
 	}
 
@@ -369,7 +368,7 @@ static int parse_archive_args(int argc, const char **argv,
 
 	args->compression_level = Z_DEFAULT_COMPRESSION;
 	if (compression_level != -1) {
-		if ((*ar)->flags & USES_ZLIB_COMPRESSION)
+		if ((*ar)->flags & ARCHIVER_WANT_COMPRESSION_LEVELS)
 			args->compression_level = compression_level;
 		else {
 			die("Argument not supported for format '%s': -%d",
@@ -395,6 +394,8 @@ int write_archive(int argc, const char **argv, const char *prefix,
 		prefix = setup_git_directory_gently(&nongit);
 
 	git_config(git_default_config, NULL);
+	init_tar_archiver();
+	init_zip_archiver();
 
 	argc = parse_archive_args(argc, argv, &ar, &args);
 	if (nongit) {
diff --git a/archive.h b/archive.h
index 038ac35..f39cede 100644
--- a/archive.h
+++ b/archive.h
@@ -14,15 +14,18 @@ struct archiver_args {
 	int compression_level;
 };
 
-typedef int (*write_archive_fn_t)(struct archiver_args *);
+#define ARCHIVER_WANT_COMPRESSION_LEVELS 1
+struct archiver {
+	const char *name;
+	int (*write_archive)(struct archiver_args *);
+	unsigned flags;
+};
+extern void register_archiver(struct archiver *);
 
-typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
+extern void init_tar_archiver(void);
+extern void init_zip_archiver(void);
 
-/*
- * Archive-format specific backends.
- */
-extern int write_tar_archive(struct archiver_args *);
-extern int write_zip_archive(struct archiver_args *);
+typedef int (*write_archive_entry_fn_t)(struct archiver_args *args, const unsigned char *sha1, const char *path, size_t pathlen, unsigned int mode, void *buffer, unsigned long size);
 
 extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 extern int write_archive(int argc, const char **argv, const char *prefix, int setup_prefix);
-- 
1.7.5.4.44.g4b107
