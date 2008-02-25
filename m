From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use a single implementation and API for copy_file()
Date: Mon, 25 Feb 2008 14:24:48 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802251421200.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-176216948-1203967488=:19024"
Cc: git@vger.kernel.org, krh@redhat.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTix6-0003yO-Fd
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbYBYTYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753920AbYBYTYv
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:24:51 -0500
Received: from iabervon.org ([66.92.72.58]:37641 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688AbYBYTYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:24:50 -0500
Received: (qmail 8032 invoked by uid 1000); 25 Feb 2008 19:24:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Feb 2008 19:24:48 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75052>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-176216948-1203967488=:19024
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Originally by Kristian Høgsberg; I fixed the conversion of rerere, which 
had a different API.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This is a preliminary for builtin-clone, but stands on its own.

 builtin-init-db.c |   21 ---------------------
 builtin-rerere.c  |   19 +------------------
 cache.h           |    1 +
 copy.c            |   21 +++++++++++++++++++++
 diff.c            |    8 ++++----
 5 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 5d7cdda..79eaf8d 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -29,27 +29,6 @@ static void safe_create_dir(const char *dir, int share)
 		die("Could not make %s writable by group\n", dir);
 }
 
-static int copy_file(const char *dst, const char *src, int mode)
-{
-	int fdi, fdo, status;
-
-	mode = (mode & 0111) ? 0777 : 0666;
-	if ((fdi = open(src, O_RDONLY)) < 0)
-		return fdi;
-	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
-		close(fdi);
-		return fdo;
-	}
-	status = copy_fd(fdi, fdo);
-	if (close(fdo) != 0)
-		return error("%s: write error: %s", dst, strerror(errno));
-
-	if (!status && adjust_shared_perm(dst))
-		return -1;
-
-	return status;
-}
-
 static void copy_templates_1(char *path, int baselen,
 			     char *template, int template_baselen,
 			     DIR *dir)
diff --git a/builtin-rerere.c b/builtin-rerere.c
index b0c17bd..c607aad 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -267,23 +267,6 @@ static int diff_two(const char *file1, const char *label1,
 	return 0;
 }
 
-static int copy_file(const char *src, const char *dest)
-{
-	FILE *in, *out;
-	char buffer[32768];
-	int count;
-
-	if (!(in = fopen(src, "r")))
-		return error("Could not open %s", src);
-	if (!(out = fopen(dest, "w")))
-		return error("Could not open %s", dest);
-	while ((count = fread(buffer, 1, sizeof(buffer), in)))
-		fwrite(buffer, 1, count, out);
-	fclose(in);
-	fclose(out);
-	return 0;
-}
-
 static int do_plain_rerere(struct path_list *rr, int fd)
 {
 	struct path_list conflict = { NULL, 0, 0, 1 };
@@ -343,7 +326,7 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 			continue;
 
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-		copy_file(path, rr_path(name, "postimage"));
+		copy_file(rr_path(name, "postimage"), path, 0666);
 tail_optimization:
 		if (i < rr->nr - 1)
 			memmove(rr->items + i,
diff --git a/cache.h b/cache.h
index 040aecf..660ea04 100644
--- a/cache.h
+++ b/cache.h
@@ -712,6 +712,7 @@ extern const char *git_log_output_encoding;
 /* IO helper functions */
 extern void maybe_flush_or_die(FILE *, const char *);
 extern int copy_fd(int ifd, int ofd);
+extern int copy_file(const char *dst, const char *src, int mode);
 extern int read_in_full(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/copy.c b/copy.c
index c225d1b..afc4fbf 100644
--- a/copy.c
+++ b/copy.c
@@ -34,3 +34,24 @@ int copy_fd(int ifd, int ofd)
 	close(ifd);
 	return 0;
 }
+
+int copy_file(const char *dst, const char *src, int mode)
+{
+	int fdi, fdo, status;
+
+	mode = (mode & 0111) ? 0777 : 0666;
+	if ((fdi = open(src, O_RDONLY)) < 0)
+		return fdi;
+	if ((fdo = open(dst, O_WRONLY | O_CREAT | O_EXCL, mode)) < 0) {
+		close(fdi);
+		return fdo;
+	}
+	status = copy_fd(fdi, fdo);
+	if (close(fdo) != 0)
+		return error("%s: write error: %s", dst, strerror(errno));
+
+	if (!status && adjust_shared_perm(dst))
+		return -1;
+
+	return status;
+}
diff --git a/diff.c b/diff.c
index 1885013..ad16164 100644
--- a/diff.c
+++ b/diff.c
@@ -271,8 +271,8 @@ static void print_line_count(int count)
 	}
 }
 
-static void copy_file(int prefix, const char *data, int size,
-		const char *set, const char *reset)
+static void copy_file_with_prefix(int prefix, const char *data, int size,
+				  const char *set, const char *reset)
 {
 	int ch, nl_just_seen = 1;
 	while (0 < size--) {
@@ -330,9 +330,9 @@ static void emit_rewrite_diff(const char *name_a,
 	print_line_count(lc_b);
 	printf(" @@%s\n", reset);
 	if (lc_a)
-		copy_file('-', one->data, one->size, old, reset);
+		copy_file_with_prefix('-', one->data, one->size, old, reset);
 	if (lc_b)
-		copy_file('+', two->data, two->size, new, reset);
+		copy_file_with_prefix('+', two->data, two->size, new, reset);
 }
 
 static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
-- 
1.5.4.2.261.g851a5.dirty
--1547844168-176216948-1203967488=:19024--
