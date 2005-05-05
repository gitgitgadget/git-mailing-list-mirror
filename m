From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Prepare diff side for upcoming symlink work.
Date: Wed, 04 May 2005 17:00:40 -0700
Message-ID: <7vd5s6mthz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:54:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTThM-0000ca-CN
	for gcvg-git@gmane.org; Thu, 05 May 2005 01:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVEEABB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 20:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVEEABB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 20:01:01 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:58109 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261963AbVEEAAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 20:00:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050505000040.BVYK20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 20:00:40 -0400
To: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch prepares the external diff interface engine for the
change to store the symbolic links in the cache, being worked on
by Kay Sievers.

The main thing it does is when comparing with the work tree, it
prepares the counterpart to the blob being compared by doing a
readlink followed by sending that result to a temporary file to
be diffed.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- a/diff.c
+++ b/diff.c
@@ -163,13 +163,35 @@ static int work_tree_matches(const char 
 	if (pos < 0)
 		return 0;
 	ce = active_cache[pos];
-	if ((stat(name, &st) < 0) ||
+	if ((lstat(name, &st) < 0) ||
+	    !S_ISREG(st.st_mode) ||
 	    cache_match_stat(ce, &st) ||
 	    memcmp(sha1, ce->sha1, 20))
 		return 0;
 	return 1;
 }
 
+static void prep_temp_blob(struct diff_tempfile *temp,
+			   void *blob,
+			   unsigned long size,
+			   unsigned char *sha1,
+			   int mode)
+{
+	int fd;
+
+	strcpy(temp->tmp_path, ".diff_XXXXXX");
+	fd = mkstemp(temp->tmp_path);
+	if (fd < 0)
+		die("unable to create temp-file");
+	if (write(fd, blob, size) != size)
+		die("unable to write temp-file");
+	close(fd);
+	temp->name = temp->tmp_path;
+	strcpy(temp->hex, sha1_to_hex(sha1));
+	temp->hex[40] = 0;
+	sprintf(temp->mode, "%06o", mode);
+}
+
 static void prepare_temp_file(const char *name,
 			      struct diff_tempfile *temp,
 			      struct diff_spec *one)
@@ -196,20 +218,35 @@ static void prepare_temp_file(const char
 	if (!one->sha1_valid || use_work_tree) {
 		struct stat st;
 		temp->name = name;
-		if (stat(temp->name, &st) < 0) {
+		if (lstat(temp->name, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
 			die("stat(%s): %s", temp->name, strerror(errno));
 		}
+		if (S_ISLNK(st.st_mode)) {
+			int ret;
+			char *buf, buf_[1024];
+			buf = ((sizeof(buf_) < st.st_size) ?
+			       xmalloc(st.st_size) : buf_);
+			ret = readlink(name, buf, st.st_size);
+			if (ret < 0)
+				die("readlink(%s)", name);
+			prep_temp_blob(temp, buf, st.st_size,
+				       (one->sha1_valid ?
+					one->blob_sha1 : null_sha1),
+				       (one->sha1_valid ?
+					one->mode : 
+					S_IFREG|ce_permissions(st.st_mode)));
+		}
 		if (!one->sha1_valid)
 			strcpy(temp->hex, sha1_to_hex(null_sha1));
 		else
 			strcpy(temp->hex, sha1_to_hex(one->blob_sha1));
 		sprintf(temp->mode, "%06o",
-			S_IFREG |ce_permissions(st.st_mode));
+			S_IFREG | ce_permissions(st.st_mode));
+		return;
 	}
 	else {
-		int fd;
 		void *blob;
 		char type[20];
 		unsigned long size;
@@ -218,19 +255,8 @@ static void prepare_temp_file(const char
 		if (!blob || strcmp(type, "blob"))
 			die("unable to read blob object for %s (%s)",
 			    name, sha1_to_hex(one->blob_sha1));
-
-		strcpy(temp->tmp_path, ".diff_XXXXXX");
-		fd = mkstemp(temp->tmp_path);
-		if (fd < 0)
-			die("unable to create temp-file");
-		if (write(fd, blob, size) != size)
-			die("unable to write temp-file");
-		close(fd);
+		prep_temp_blob(temp, blob, size, one->blob_sha1, one->mode);
 		free(blob);
-		temp->name = temp->tmp_path;
-		strcpy(temp->hex, sha1_to_hex(one->blob_sha1));
-		temp->hex[40] = 0;
-		sprintf(temp->mode, "%06o", one->mode);
 	}
 }
 

