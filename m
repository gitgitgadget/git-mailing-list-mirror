From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v3 6/9] write_entry(): cleanup of some duplicated code
Date: Wed, 04 Feb 2009 13:52:51 +0100
Message-ID: <a9e25f77aadd46fffb5db44d70995ab6cad8457d.1233751281.git.barvik@broadpark.no>
References: <cover.1233751281.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 13:55:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUhHT-0006OR-AS
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 13:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbZBDMxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 07:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757380AbZBDMxR
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 07:53:17 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:45423 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660AbZBDMxO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 07:53:14 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KEJ003JNL4JHW70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:07 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.216])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KEJ004C6L47S210@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Wed, 04 Feb 2009 13:53:07 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1233751281.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108356>

The switch-cases for S_IFREG and S_IFLNK was so similar that it will
be better to do some cleanup and use the common parts of it.

And the entry.c file should now be clean for 'gcc -Wextra' warnings.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 entry.c |   75 +++++++++++++++++++++++++-------------------------------------
 1 files changed, 30 insertions(+), 45 deletions(-)

diff --git a/entry.c b/entry.c
index cc8f0c6..1f53588 100644
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
@@ -93,36 +93,51 @@ static void *read_blob_entry(struct cache_entry *ce, const char *path, unsigned
 
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
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
 			return error("git checkout-index: unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
 
+		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
+			ret = symlink(new, path);
+			free(new);
+			if (ret)
+				return error("git checkout-index: unable to create symlink %s (%s)",
+					     path, strerror(errno));
+			break;
+		}
+
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
+		} else if (ce_mode_s_ifmt == S_IFREG) {
 			fd = create_file(path, ce->ce_mode);
+		} else {
+			fd = create_file(path, 0666);
+		}
 		if (fd < 0) {
 			free(new);
 			return error("git checkout-index: unable to create file %s (%s)",
@@ -135,36 +150,6 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 		if (wrote != size)
 			return error("git checkout-index: unable to write file %s", path);
 		break;
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
-		break;
 	case S_IFGITLINK:
 		if (to_tempfile)
 			return error("git checkout-index: cannot create temporary subproject %s", path);
-- 
1.6.1.349.g99fa5
