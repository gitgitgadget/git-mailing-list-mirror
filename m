From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Optimize diff-cache -p --cached
Date: Tue, 03 May 2005 15:10:25 -0700
Message-ID: <7vk6mgt0z2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 00:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT5VX-0005Qc-Mm
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbVECWLC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 18:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVECWLC
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 18:11:02 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39891 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261845AbVECWK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 18:10:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503221024.BKZG19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 18:10:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch optimizes "diff-cache -p --cached" by avoiding to
inflate blobs to create temporary files when either the blob
recorded in the cache or in the compared tree matches the
corresponding file in the work tree.

Here is an informal benchmark on my Duron 750.  The tests were
done by running unpatched and patched alternately number of
times, and these are the last three pairs:

 real 0m0.738s user 0m0.630s sys 0m0.100s unpatched
 real 0m0.695s user 0m0.590s sys 0m0.100s patched
 real 0m0.733s user 0m0.560s sys 0m0.170s unpatched
 real 0m0.705s user 0m0.590s sys 0m0.110s patched
 real 0m0.732s user 0m0.550s sys 0m0.180s unpatched
 real 0m0.692s user 0m0.590s sys 0m0.100s patched

The benchmark was run in a fully checked out linux-2.6 GIT
repository.  The work tree matched one commit, and comparison
was done against another commit which was 20-or-so commits
before the work tree.

$ new=a6ad57fb4b5e9d68553f4440377b99f75588fa88
$ old=cd63499cbe37e53e6cc084c8a35d911a4613c797
$ git-read-tree $new
$ git-checkout-cache -f -a
$ git-update-cache --refresh
$ git-rev-tree $new ^$old | wc -l
19
$ export GIT_EXTERNAL_DIFF=true
$ time git-diff-cache -p --cached $old

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree-helper.c |    6 ++--
diff.c             |   67 ++++++++++++++++++++++++++++++++++++++++++-----------
diff.h             |   13 +++-------
3 files changed, 62 insertions(+), 24 deletions(-)

# - 2: Use GIT_EXTERNAL_DIFF exit status to terminate diff early.
# + 5: diff-cache --cached case optimization.
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
@@ -285,7 +326,7 @@ void diff_addremove(int addremove, unsig
 	char concatpath[PATH_MAX];
 	struct diff_spec spec[2], *one, *two;
 
-	memcpy(spec[0].u.sha1, sha1, 20);
+	memcpy(spec[0].blob_sha1, sha1, 20);
 	spec[0].mode = mode;
 	spec[0].sha1_valid = spec[0].file_valid = 1;
 	spec[1].file_valid = 0;
@@ -310,9 +351,9 @@ void diff_change(unsigned old_mode, unsi
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

