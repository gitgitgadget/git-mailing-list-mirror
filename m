From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v1 3/6] cleanup of write_entry() in entry.c
Date: Mon, 26 Jan 2009 22:17:14 +0100
Message-ID: <1233004637-15112-4-git-send-email-barvik@broadpark.no>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 22:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRYrF-0000UB-OW
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 22:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZAZVRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZAZVR3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 16:17:29 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:62238 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbZAZVR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 16:17:26 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KE3003TWKH1XC90@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:25 +0100 (CET)
Received: from localhost.localdomain ([80.203.78.144])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KE3001KZKGTUNC0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 26 Jan 2009 22:17:25 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107285>

The switch-cases for S_IFREG and S_IFLNK was so similar that it will
be better to do some cleanup and use the common parts of it.

Also fold the longest lines such that no line is longer then 80 chars
or so.

And the entry.c file should now be clean for 'gcc -Wextra' warnings.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---

If people do not like this approach I can be willing to drop it from
this patch-series, but then I get some source code duplication from
the next patch (4/6).


 entry.c |  114 +++++++++++++++++++++++++++++++-------------------------------
 1 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/entry.c b/entry.c
index c2404ea..8543755 100644
--- a/entry.c
+++ b/entry.c
@@ -78,7 +78,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned long *size)
+static void *read_blob_entry(struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
 	void *new = read_sha1_file(ce->sha1, &type, size);
@@ -91,88 +91,86 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 	return NULL;
 }
 
-static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
+static int
+write_entry(struct cache_entry *ce, char *path, const struct checkout *state,
+	    int to_tempfile)
 {
-	int fd;
-	long wrote;
-
-	switch (ce->ce_mode & S_IFMT) {
-		char *new;
-		struct strbuf buf;
-		unsigned long size;
-
+	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
+	int fd, ret;
+	char *new;
+	struct strbuf buf = STRBUF_INIT;
+	unsigned long size;
+	size_t wrote, newsize = 0;
+
+	switch (ce_mode_s_ifmt) {
 	case S_IFREG:
-		new = read_blob_entry(ce, path, &size);
+	case S_IFLNK:
+		new = read_blob_entry(ce, &size);
 		if (!new)
-			return error("git checkout-index: unable to read sha1 file of %s (%s)",
-				path, sha1_to_hex(ce->sha1));
+			return error("git checkout-index: "\
+				     "unable to read sha1 file of %s (%s)",
+				     path, sha1_to_hex(ce->sha1));
+
+		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
+			ret = symlink(new, path);
+			free(new);
+			if (ret)
+				return error("git checkout-index: "\
+					     "unable to create symlink %s (%s)",
+					     path, strerror(errno));
+			break;
+		}
 
 		/*
 		 * Convert from git internal format to working tree format
 		 */
-		strbuf_init(&buf, 0);
-		if (convert_to_working_tree(ce->name, new, size, &buf)) {
-			size_t newsize = 0;
+		if (ce_mode_s_ifmt == S_IFREG &&
+		    convert_to_working_tree(ce->name, new, size, &buf)) {
 			free(new);
 			new = strbuf_detach(&buf, &newsize);
 			size = newsize;
 		}
 
 		if (to_tempfile) {
-			strcpy(path, ".merge_file_XXXXXX");
+			if (ce_mode_s_ifmt == S_IFREG)
+				strcpy(path, ".merge_file_XXXXXX");
+			else
+				strcpy(path, ".merge_link_XXXXXX");
 			fd = mkstemp(path);
-		} else
-			fd = create_file(path, ce->ce_mode);
+		} else {
+			if (ce_mode_s_ifmt == S_IFREG)
+				fd = create_file(path, ce->ce_mode);
+			else
+				fd = create_file(path, 0666);
+		}
 		if (fd < 0) {
 			free(new);
-			return error("git checkout-index: unable to create file %s (%s)",
-				path, strerror(errno));
+			return error("git checkout-index: "\
+				     "unable to create file %s (%s)",
+				     path, strerror(errno));
 		}
 
 		wrote = write_in_full(fd, new, size);
 		close(fd);
 		free(new);
 		if (wrote != size)
-			return error("git checkout-index: unable to write file %s", path);
-		break;
-	case S_IFLNK:
-		new = read_blob_entry(ce, path, &size);
-		if (!new)
-			return error("git checkout-index: unable to read sha1 file of %s (%s)",
-				path, sha1_to_hex(ce->sha1));
-		if (to_tempfile || !has_symlinks) {
-			if (to_tempfile) {
-				strcpy(path, ".merge_link_XXXXXX");
-				fd = mkstemp(path);
-			} else
-				fd = create_file(path, 0666);
-			if (fd < 0) {
-				free(new);
-				return error("git checkout-index: unable to create "
-						 "file %s (%s)", path, strerror(errno));
-			}
-			wrote = write_in_full(fd, new, size);
-			close(fd);
-			free(new);
-			if (wrote != size)
-				return error("git checkout-index: unable to write file %s",
-					path);
-		} else {
-			wrote = symlink(new, path);
-			free(new);
-			if (wrote)
-				return error("git checkout-index: unable to create "
-						 "symlink %s (%s)", path, strerror(errno));
-		}
+			return error("git checkout-index: "\
+				     "unable to write file %s", path);
+
 		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
-			return error("git checkout-index: cannot create temporary subproject %s", path);
+			return error("git checkout-index: "\
+				     "cannot create temporary subproject %s",
+				     path);
 		if (mkdir(path, 0777) < 0)
-			return error("git checkout-index: cannot create subproject directory %s", path);
+			return error("git checkout-index: "\
+				     "cannot create subproject directory %s (%s)",
+				     path, strerror(errno));
 		break;
 	default:
-		return error("git checkout-index: unknown file mode for %s", path);
+		return error("git checkout-index: "\
+			     "unknown file mode for %s", path);
 	}
 
 	if (state->refresh_cache) {
@@ -202,7 +200,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			return 0;
 		if (!state->force) {
 			if (!state->quiet)
-				fprintf(stderr, "git-checkout-index: %s already exists\n", path);
+				fprintf(stderr, "git-checkout-index: "\
+					"%s already exists\n", path);
 			return -1;
 		}
 
@@ -220,7 +219,8 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 				return error("%s is a directory", path);
 			remove_subtree(path);
 		} else if (unlink(path))
-			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
+			return error("unable to unlink old '%s' (%s)",
+				     path, strerror(errno));
 	} else if (state->not_new)
 		return 0;
 	create_directories(len, path, state);
-- 
1.6.1.349.g99fa5
