From: Jeff King <peff@peff.net>
Subject: [PATCH 65/67] fsck: use for_each_loose_file_in_objdir
Date: Tue, 15 Sep 2015 12:15:27 -0400
Message-ID: <20150915161527.GM29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:15:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbstK-0001w1-QG
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbIOQPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:15:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:59481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751622AbbIOQPa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:15:30 -0400
Received: (qmail 14698 invoked by uid 102); 15 Sep 2015 16:15:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:15:29 -0500
Received: (qmail 8044 invoked by uid 107); 15 Sep 2015 16:15:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:15:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:15:27 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277970>

Since 27e1e22 (prune: factor out loose-object directory
traversal, 2014-10-15), we now have a generic callback
system for iterating over the loose object directories. This
is used by prune, count-objects, etc.

We did not convert git-fsck at the time because it
implemented an inode-sorting scheme that was not part of the
generic code. Now that the inode-sorting code is gone, we
can reuse the generic code.  The result is shorter,
hopefully more readable, and drops some unchecked sprintf
calls.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 69 ++++++++++++++++++++--------------------------------------
 1 file changed, 23 insertions(+), 46 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 73c3596..2fe6a31 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -365,45 +365,6 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 	return fsck_obj(obj);
 }
 
-static inline int is_loose_object_file(struct dirent *de,
-				       char *name, unsigned char *sha1)
-{
-	if (strlen(de->d_name) != 38)
-		return 0;
-	memcpy(name + 2, de->d_name, 39);
-	return !get_sha1_hex(name, sha1);
-}
-
-static void fsck_dir(int i, char *path)
-{
-	DIR *dir = opendir(path);
-	struct dirent *de;
-	char name[100];
-
-	if (!dir)
-		return;
-
-	if (verbose)
-		fprintf(stderr, "Checking directory %s\n", path);
-
-	sprintf(name, "%02x", i);
-	while ((de = readdir(dir)) != NULL) {
-		unsigned char sha1[20];
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-		if (is_loose_object_file(de, name, sha1)) {
-			if (fsck_sha1(sha1))
-				errors_found |= ERROR_OBJECT;
-			continue;
-		}
-		if (starts_with(de->d_name, "tmp_obj_"))
-			continue;
-		fprintf(stderr, "bad sha1 file: %s/%s\n", path, de->d_name);
-	}
-	closedir(dir);
-}
-
 static int default_refs;
 
 static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1)
@@ -491,9 +452,28 @@ static void get_default_heads(void)
 	}
 }
 
+static int fsck_loose(const unsigned char *sha1, const char *path, void *data)
+{
+	if (fsck_sha1(sha1))
+		errors_found |= ERROR_OBJECT;
+	return 0;
+}
+
+static int fsck_cruft(const char *basename, const char *path, void *data)
+{
+	if (!starts_with(basename, "tmp_obj_"))
+		fprintf(stderr, "bad sha1 file: %s\n", path);
+	return 0;
+}
+
+static int fsck_subdir(int nr, const char *path, void *progress)
+{
+	display_progress(progress, nr + 1);
+	return 0;
+}
+
 static void fsck_object_dir(const char *path)
 {
-	int i;
 	struct progress *progress = NULL;
 
 	if (verbose)
@@ -501,12 +481,9 @@ static void fsck_object_dir(const char *path)
 
 	if (show_progress)
 		progress = start_progress(_("Checking object directories"), 256);
-	for (i = 0; i < 256; i++) {
-		static char dir[4096];
-		sprintf(dir, "%s/%02x", path, i);
-		fsck_dir(i, dir);
-		display_progress(progress, i+1);
-	}
+
+	for_each_loose_file_in_objdir(path, fsck_loose, fsck_cruft, fsck_subdir,
+				      progress);
 	stop_progress(&progress);
 }
 
-- 
2.6.0.rc2.408.ga2926b9
