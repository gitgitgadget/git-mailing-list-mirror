From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Optimize diff-cache -p --cached
Date: Wed, 04 May 2005 16:56:37 -0700
Message-ID: <7vk6memtoq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:51:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTTdz-0000Hy-5C
	for gcvg-git@gmane.org; Thu, 05 May 2005 01:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVEDX50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 19:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVEDX50
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 19:57:26 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:44729 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261961AbVEDX5E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 19:57:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504235637.HURV22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 19:56:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


  ** Linus, I am sending this one in the mail partly because my
  ** next patch to prepare the diff side for the symlink work by
  ** Kay Siever is on top of this one.  If you pull from
  ** http://members.cox.net/junkio/git-jc.git/ it already
  ** contains this patch.

This patch optimizes "diff-cache -p --cached" by avoiding to
inflate blobs into temporary files when the blob recorded in the
cache matches the corresponding file in the work tree.  The file
in the work tree is passed as the comparison source in such a
case instead.

This optimization kicks in only when we have already read the
cache this optimization and this is deliberate.  Especially,
diff-tree does not use this code, because changes are contained
in small number of files relative to the project size most of
the time, and reading cache is so expensive for a large project
that the cost of reading it outweighs the savings by not
inflating blobs.

Also this patch cleans up the structure passed from diff clients
by removing one unused structure member.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

--- a/diff-tree-helper.c
+++ b/diff-tree-helper.c
@@ -35,7 +35,7 @@ static int parse_oneside_change(const ch
 	if (strncmp(cp, "\tblob\t", 6))
 		return -1;
 	cp += 6;
-	if (get_sha1_hex(cp, one->u.sha1))
+	if (get_sha1_hex(cp, one->blob_sha1))
 		return -1;
 	cp += 40;
 	if (*cp++ != '\t')
@@ -83,13 +83,13 @@ static int parse_diff_tree_output(const 
 		if (strncmp(cp, "\tblob\t", 6))
 			return -1;
 		cp += 6;
-		if (get_sha1_hex(cp, old.u.sha1))
+		if (get_sha1_hex(cp, old.blob_sha1))
 			return -1;
 		cp += 40;
 		if (strncmp(cp, "->", 2))
 			return -1;
 		cp += 2;
-		if (get_sha1_hex(cp, new.u.sha1))
+		if (get_sha1_hex(cp, new.blob_sha1))
 			return -1;
 		cp += 40;
 		if (*cp++ != '\t')

--- a/diff.c
+++ b/diff.c
@@ -132,11 +132,50 @@ static void builtin_diff(const char *nam
 	execlp("/bin/sh","sh", "-c", cmd, NULL);
 }
 
+/*
+ * Given a name and sha1 pair, if the dircache tells us the file in
+ * the work tree has that object contents, return true, so that
+ * prepare_temp_file() does not have to inflate and extract.
+ */
+static int work_tree_matches(const char *name, const unsigned char *sha1)
+{
+	struct cache_entry *ce;
+	struct stat st;
+	int pos, len;
+	
+	/* We do not read the cache ourselves here, because the
+	 * benchmark with my previous version that always reads cache
+	 * shows that it makes things worse for diff-tree comparing
+	 * two linux-2.6 kernel trees in an already checked out work
+	 * tree.  This is because most diff-tree comparison deals with
+	 * only a small number of files, while reading the cache is
+	 * expensive for a large project, and its cost outweighs the
+	 * savings we get by not inflating the object to a temporary
+	 * file.  Practically, this code only helps when we are used
+	 * by diff-cache --cached, which does read the cache before
+	 * calling us.
+	 */ 
+	if (!active_cache)
+		return 0;
+
+	len = strlen(name);
+	pos = cache_name_pos(name, len);
+	if (pos < 0)
+		return 0;
+	ce = active_cache[pos];
+	if ((stat(name, &st) < 0) ||
+	    cache_match_stat(ce, &st) ||
+	    memcmp(sha1, ce->sha1, 20))
+		return 0;
+	return 1;
+}
+
 static void prepare_temp_file(const char *name,
 			      struct diff_tempfile *temp,
 			      struct diff_spec *one)
 {
 	static unsigned char null_sha1[20] = { 0, };
+	int use_work_tree = 0;
 
 	if (!one->file_valid) {
 	not_a_valid_file:
@@ -150,20 +189,22 @@ static void prepare_temp_file(const char
 	}
 
 	if (one->sha1_valid &&
-	    !memcmp(one->u.sha1, null_sha1, sizeof(null_sha1))) {
-		one->sha1_valid = 0;
-		one->u.name = name;
-	}
+	    (!memcmp(one->blob_sha1, null_sha1, sizeof(null_sha1)) ||
+	     work_tree_matches(name, one->blob_sha1)))
+		use_work_tree = 1;
 
-	if (!one->sha1_valid) {
+	if (!one->sha1_valid || use_work_tree) {
 		struct stat st;
-		temp->name = one->u.name;
+		temp->name = name;
 		if (stat(temp->name, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
 			die("stat(%s): %s", temp->name, strerror(errno));
 		}
-		strcpy(temp->hex, sha1_to_hex(null_sha1));
+		if (!one->sha1_valid)
+			strcpy(temp->hex, sha1_to_hex(null_sha1));
+		else
+			strcpy(temp->hex, sha1_to_hex(one->blob_sha1));
 		sprintf(temp->mode, "%06o",
 			S_IFREG |ce_permissions(st.st_mode));
 	}
@@ -173,10 +214,10 @@ static void prepare_temp_file(const char
 		char type[20];
 		unsigned long size;
 
-		blob = read_sha1_file(one->u.sha1, type, &size);
+		blob = read_sha1_file(one->blob_sha1, type, &size);
 		if (!blob || strcmp(type, "blob"))
 			die("unable to read blob object for %s (%s)",
-			    name, sha1_to_hex(one->u.sha1));
+			    name, sha1_to_hex(one->blob_sha1));
 
 		strcpy(temp->tmp_path, ".diff_XXXXXX");
 		fd = mkstemp(temp->tmp_path);
@@ -187,7 +228,7 @@ static void prepare_temp_file(const char
 		close(fd);
 		free(blob);
 		temp->name = temp->tmp_path;
-		strcpy(temp->hex, sha1_to_hex(one->u.sha1));
+		strcpy(temp->hex, sha1_to_hex(one->blob_sha1));
 		temp->hex[40] = 0;
 		sprintf(temp->mode, "%06o", one->mode);
 	}
@@ -286,7 +327,7 @@ void diff_addremove(int addremove, unsig
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
-	memcpy(spec[0].u.sha1, sha1, 20);
+	memcpy(spec[0].blob_sha1, sha1, 20);
 	spec[0].mode = mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
 	spec[1].file_valid = 0;
@@ -311,9 +352,9 @@ void diff_change(unsigned old_mode, unsi
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2];
 
-	memcpy(spec[0].u.sha1, old_sha1, 20);
+	memcpy(spec[0].blob_sha1, old_sha1, 20);
 	spec[0].mode = old_mode;
-	memcpy(spec[1].u.sha1, new_sha1, 20);
+	memcpy(spec[1].blob_sha1, new_sha1, 20);
 	spec[1].mode = new_mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
 	spec[1].sha1_valid = spec[1].file_valid = 1;

--- a/diff.h
+++ b/diff.h
@@ -20,15 +20,12 @@ extern void diff_unmerge(const char *pat
 /* These are for diff-tree-helper */
 
 struct diff_spec {
-	union {
-		const char *name;       /* path on the filesystem */
-		unsigned char sha1[20]; /* blob object ID */
-	} u;
+	unsigned char blob_sha1[20];
 	unsigned short mode;	 /* file mode */
-	unsigned sha1_valid : 1; /* if true, use u.sha1 and trust mode.
-				  * (however with a NULL SHA1, read them
-				  * from the file!).
-				  * if false, use u.name and read mode from
+	unsigned sha1_valid : 1; /* if true, use blob_sha1 and trust mode;
+				  * however with a NULL SHA1, read them
+				  * from the file system.
+				  * if false, use the name and read mode from
 				  * the filesystem.
 				  */
 	unsigned file_valid : 1; /* if false the file does not even exist */



