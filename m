From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Show original and resulting blob object info in diff output.
Date: Thu, 06 Oct 2005 19:33:19 -0700
Message-ID: <7vachm5a4w.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
	<m1y8575i9y.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060731560.31407@g5.osdl.org>
	<m1wtkqk89a.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510060756060.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 04:34:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENi3b-0001rc-Tq
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 04:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbVJGCdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 22:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVJGCdr
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 22:33:47 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43188 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751345AbVJGCdq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 22:33:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007023308.DUWF776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 22:33:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510060756060.31407@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 6 Oct 2005 07:59:36 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9794>

This adds more cruft to diff --git header to record the blob SHA1 and
the mode the patch/diff is intended to be applied against, to help the
receiving end fall back on a three-way merge.  The new header looks
like this:

    diff --git a/apply.c b/apply.c
    old index 7be50413538868412a87c847f8fa184cadd0fa2a 100644
    new index 83660822fcbb9edac523634999e30d65c2790cae 100644
    --- a/apply.c
    +++ b/apply.c
    @@ -14,6 +14,7 @@
     //    files that are being modified, but doesn't apply the patch
     //  --stat does just a diffstat, and doesn't actually apply
    +//  --show-index-info shows the old and new index info for...
    ...

There is a counterpart option --show-index-info to git-apply command
to summarize this:

    - 7be5041... 100644	apply.c
    + 8366082... 100644	apply.c
    - ec2a161... 100644	cache.h
    + 514adb8... 100644	cache.h
    - ...

Upon receiving such a patch, if the patch did not apply cleanly to the
target tree, the recipient can try to find the matching old objects in
her object database and create a temporary tree, apply the patch to
that temporary tree, and attempt a 3-way merge between the patched
temporary tree and the target tree using the original temporary tree
as the common ancestor.

The patch lifts the code to compute the hash for an on-filesystem
object from update-index.c and makes it available to the diff output
routine.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

    Linus Torvalds <torvalds@osdl.org> writes:

    > On Thu, 6 Oct 2005, Eric W. Biederman wrote:
    >> 
    >> After thinking about it I don't think you need to look through the
    >> history to use it for a merge3 operation.   As I recall merge3 only
    >> looks at the base and the two derived versions of the file.  If we
    >> have the sha1 of the original in the git repository I think all we
    >> need to compute is the diff between that sha1 the current version
    >> file.  And then apply the merge3 algorithm to combine the two sets of
    >> changes.
    >
    > Ahh, that I can definitely agree with. In fact, it makes perfect sense.

    And this is a sample implementation to do so.  Will not
    graduate "pu" until the receiving end gets ready and unless
    people agree that the additional cruft is not too
    distracting.

 apply.c                        |   64 +++++++++++++++++++++++++++++++++-
 cache.h                        |    1 +
 diff.c                         |   76 +++++++++++++++++++++++++++++-----------
 sha1_file.c                    |   39 +++++++++++++++++++++
 t/diff-lib.sh                  |   10 ++++-
 t/t4000-diff-format.sh         |    6 +++
 t/t4001-diff-rename.sh         |    3 +-
 t/t4004-diff-rename-symlink.sh |    3 +-
 update-index.c                 |   33 ++---------------
 9 files changed, 179 insertions(+), 56 deletions(-)

applies-to: 8cf0bb652ffde36e57bca5d6f33287305a61bb74
2c48a811a36ee6e12aeb044b3d1ff459b8d958c2
diff --git a/apply.c b/apply.c
old index 7be50413538868412a87c847f8fa184cadd0fa2a 100644
new index ed2eac2c67dd003c8a0eaa7325e1543d1472777d 100644
--- a/apply.c
+++ b/apply.c
@@ -14,6 +14,7 @@
 //    files that are being modified, but doesn't apply the patch
 //  --stat does just a diffstat, and doesn't actually apply
 //  --show-files shows the directory changes
+//  --show-index-info shows the old and new index info for paths if available.
 //
 static int check_index = 0;
 static int write_index = 0;
@@ -22,8 +23,9 @@ static int summary = 0;
 static int check = 0;
 static int apply = 1;
 static int show_files = 0;
+static int show_index_info = 0;
 static const char apply_usage[] =
-"git-apply [--stat] [--summary] [--check] [--index] [--apply] [--show-files] <patch>...";
+"git-apply [--stat] [--summary] [--check] [--index] [--apply] [--show-files] [--show-index-info] <patch>...";
 
 /*
  * For "diff-stat" like behaviour, we keep track of the biggest change
@@ -56,6 +58,8 @@ struct patch {
 	struct fragment *fragments;
 	char *result;
 	unsigned long resultsize;
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
 	struct patch *next;
 };
 
@@ -334,6 +338,24 @@ static int gitdiff_dissimilarity(const c
 	return 0;
 }
 
+static int gitdiff_old_index(const char *line, struct patch *patch)
+{
+	if (get_sha1_hex(line, patch->old_sha1))
+		memcpy(patch->old_sha1, null_sha1, 20);
+	else
+		gitdiff_oldmode(line + 41, patch);
+	return 0;
+}
+
+static int gitdiff_new_index(const char *line, struct patch *patch)
+{
+	if (get_sha1_hex(line, patch->new_sha1))
+		memcpy(patch->new_sha1, null_sha1, 20);
+	else
+		gitdiff_newmode(line + 41, patch);
+	return 0;
+}
+
 /*
  * This is normal for a diff that doesn't change anything: we'll fall through
  * into the next diff. Tell the parser to break out.
@@ -438,6 +460,8 @@ static int parse_git_header(char *line, 
 			{ "rename to ", gitdiff_renamedst },
 			{ "similarity index ", gitdiff_similarity },
 			{ "dissimilarity index ", gitdiff_dissimilarity },
+			{ "old index ", gitdiff_old_index },
+			{ "new index ", gitdiff_new_index },
 			{ "", gitdiff_unrecognized },
 		};
 		int i;
@@ -1136,6 +1160,36 @@ static void show_file_list(struct patch 
 	}
 }
 
+static inline int is_null_sha1(const unsigned char *sha1)
+{
+	return !memcmp(sha1, null_sha1, 20);
+}
+
+static void show_index_list(struct patch *list)
+{
+	struct patch *patch;
+
+	for (patch = list; patch; patch = patch->next) {
+		if ( (!patch->is_delete && is_null_sha1(patch->new_sha1)) ||
+		     (!patch->is_new && is_null_sha1(patch->old_sha1)) )
+			die("patch does not record sha1 information");
+	}
+
+	for (patch = list; patch; patch = patch->next) {
+		if (!is_null_sha1(patch->old_sha1))
+			printf("- %s %06o	%s\n",
+			       sha1_to_hex(patch->old_sha1),
+			       patch->old_mode,
+			       patch->old_name);
+
+		if (!is_null_sha1(patch->new_sha1))
+			printf("+ %s %06o	%s\n",
+			       sha1_to_hex(patch->new_sha1),
+			       patch->new_mode,
+			       patch->new_name);
+	}
+}
+
 static void stat_patch_list(struct patch *patch)
 {
 	int files, adds, dels;
@@ -1476,6 +1530,9 @@ static int apply_patch(int fd)
 	if (show_files)
 		show_file_list(list);
 
+	if (show_index_info)
+		show_index_list(list);
+
 	if (diffstat)
 		stat_patch_list(list);
 
@@ -1534,6 +1591,11 @@ int main(int argc, char **argv)
 			show_files = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--show-index-info")) {
+			apply = 0;
+			show_index_info = 1;
+			continue;
+		}
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
diff --git a/cache.h b/cache.h
old index ec2a1610b2fd6edec6c95847d4377f9c0241b738 100644
new index 514adb8f8ed621d98175bea0d701576de13eb620 100644
--- a/cache.h
+++ b/cache.h
@@ -165,6 +165,7 @@ extern int ce_match_stat(struct cache_en
 extern int ce_modified(struct cache_entry *ce, struct stat *st);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type);
+extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 struct cache_file {
diff --git a/diff.c b/diff.c
old index 7d06b035ae8b6a53f10a7f94251a24d911baa509 100644
new index b602e25ccb2b4cf56dbfb5f2797651b1e44d4585 100644
--- a/diff.c
+++ b/diff.c
@@ -596,15 +596,31 @@ static void run_external_diff(const char
 	remove_tempfile();
 }
 
+static void diff_fill_sha1_info(struct diff_filespec *one)
+{
+	if (DIFF_FILE_VALID(one)) {
+		if (!one->sha1_valid) {
+			struct stat st;
+			if (stat(one->path, &st) < 0)
+				die("stat %s", one->path);
+			if (index_path(one->sha1, one->path, &st, 0))
+				die("cannot hash %s\n", one->path);
+		}
+	}
+	else
+		memset(one->sha1, 0, 20);
+}
+
 static void run_diff(struct diff_filepair *p)
 {
 	const char *pgm = external_diff();
-	char msg_[PATH_MAX*2+200], *xfrm_msg;
+	char msg[PATH_MAX*2+300], *xfrm_msg;
 	struct diff_filespec *one;
 	struct diff_filespec *two;
 	const char *name;
 	const char *other;
 	int complete_rewrite = 0;
+	int len;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
@@ -616,38 +632,58 @@ static void run_diff(struct diff_filepai
 	name = p->one->path;
 	other = (strcmp(name, p->two->path) ? p->two->path : NULL);
 	one = p->one; two = p->two;
+
+	diff_fill_sha1_info(one);
+	diff_fill_sha1_info(two);
+
+	len = 0;
+	if (memcmp(one->sha1, two->sha1, 20)) {
+		if (memcmp(one->sha1, null_sha1, 20))
+			len += snprintf(msg + len, sizeof(msg) - len,
+					"old index %s %06o\n",
+					sha1_to_hex(one->sha1),
+					one->mode);
+		if (memcmp(two->sha1, null_sha1, 20))
+			len += snprintf(msg + len, sizeof(msg) - len,
+					"new index %s %06o\n",
+					sha1_to_hex(two->sha1),
+					two->mode);
+	}
+
 	switch (p->status) {
 	case DIFF_STATUS_COPIED:
-		sprintf(msg_,
-			"similarity index %d%%\n"
-			"copy from %s\n"
-			"copy to %s",
-			(int)(0.5 + p->score * 100.0/MAX_SCORE),
-			name, other);
-		xfrm_msg = msg_;
+		len += snprintf(msg + len, sizeof(msg) - len,
+				"similarity index %d%%\n"
+				"copy from %s\n"
+				"copy to %s\n",
+				(int)(0.5 + p->score * 100.0/MAX_SCORE),
+				name, other);
 		break;
 	case DIFF_STATUS_RENAMED:
-		sprintf(msg_,
-			"similarity index %d%%\n"
-			"rename from %s\n"
-			"rename to %s",
-			(int)(0.5 + p->score * 100.0/MAX_SCORE),
-			name, other);
-		xfrm_msg = msg_;
+		len += snprintf(msg + len, sizeof(msg) - len,
+				"similarity index %d%%\n"
+				"rename from %s\n"
+				"rename to %s\n",
+				(int)(0.5 + p->score * 100.0/MAX_SCORE),
+				name, other);
 		break;
 	case DIFF_STATUS_MODIFIED:
 		if (p->score) {
-			sprintf(msg_,
-				"dissimilarity index %d%%",
-				(int)(0.5 + p->score * 100.0/MAX_SCORE));
-			xfrm_msg = msg_;
+			len += snprintf(msg + len, sizeof(msg) - len,
+					"dissimilarity index %d%%\n",
+					(int)(0.5 + p->score *
+					      100.0/MAX_SCORE));
 			complete_rewrite = 1;
 			break;
 		}
 		/* fallthru */
 	default:
-		xfrm_msg = NULL;
+		/* nothing */
+		;
 	}
+	if (len)
+		msg[--len] = 0;
+	xfrm_msg = len ? msg : NULL;
 
 	if (!pgm &&
 	    DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two) &&
diff --git a/sha1_file.c b/sha1_file.c
old index 895c1fab6fc00b8131e44851f33b79b1d2310b12 100644
new index 287f618827d9b2fd472c06add42ead65de291822 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1545,3 +1545,42 @@ int index_fd(unsigned char *sha1, int fd
 		munmap(buf, size);
 	return ret;
 }
+
+int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object)
+{
+	int fd;
+	char *target;
+
+	switch (st->st_mode & S_IFMT) {
+	case S_IFREG:
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return error("open(\"%s\"): %s", path,
+				     strerror(errno));
+		if (index_fd(sha1, fd, st, write_object, NULL) < 0)
+			return error("%s: failed to insert into database",
+				     path);
+		break;
+	case S_IFLNK:
+		target = xmalloc(st->st_size+1);
+		if (readlink(path, target, st->st_size+1) != st->st_size) {
+			char *errstr = strerror(errno);
+			free(target);
+			return error("readlink(\"%s\"): %s", path,
+			             errstr);
+		}
+		if (!write_object) {
+			unsigned char hdr[50];
+			int hdrlen;
+			write_sha1_file_prepare(target, st->st_size, "blob",
+						sha1, hdr, &hdrlen);
+		} else if (write_sha1_file(target, st->st_size, "blob", sha1))
+			return error("%s: failed to insert into database",
+				     path);
+		free(target);
+		break;
+	default:
+		return error("%s: unsupported file type", path);
+	}
+	return 0;
+}
diff --git a/t/diff-lib.sh b/t/diff-lib.sh
old index a912f435aa67d7b2cde09f0b8c9855442c6c2377 100755
new index a4095db2ed3b57d5e042c5ca49dd912c1c534cf8 100755
--- a/t/diff-lib.sh
+++ b/t/diff-lib.sh
@@ -29,7 +29,13 @@ compare_diff_raw_z () {
 compare_diff_patch () {
     # When heuristics are improved, the score numbers would change.
     # Ignore them while comparing.
-    sed -e '/^[dis]*imilarity index [0-9]*%$/d' <"$1" >.tmp-1
-    sed -e '/^[dis]*imilarity index [0-9]*%$/d' <"$2" >.tmp-2
+    sed -e '
+	/^[dis]*imilarity index [0-9]*%$/d
+	/^[no][el][dw] index [0-9a-f]* [0-7]*$/d
+    ' <"$1" >.tmp-1
+    sed -e '
+	/^[dis]*imilarity index [0-9]*%$/d
+	/^[no][el][dw] index [0-9a-f]* [0-7]*$/d
+    ' <"$2" >.tmp-2
     diff -u .tmp-1 .tmp-2 && rm -f .tmp-1 .tmp-2
 }
diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
old index f3b6330a9b4af0e68d9e402ab7d82e600c939ccc 100755
new index fa387cc24b8e5e6c92df9d1d504b805c92b94e36 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -7,6 +7,7 @@ test_description='Test built-in diff out
 
 '
 . ./test-lib.sh
+. ../diff-lib.sh
 
 echo >path0 'Line 1
 Line 2
@@ -29,6 +30,8 @@ cat >expected <<\EOF
 diff --git a/path0 b/path0
 old mode 100644
 new mode 100755
+old index 85d7fd2fbbe9564fe6ecc5e72416adb36e62d658 100644
+new index 6ad36e52f0002937ed2de6a1c15d8a0ae5df056a 100755
 --- a/path0
 +++ b/path0
 @@ -1,3 +1,3 @@
@@ -38,6 +41,7 @@ new mode 100755
 +Line 3
 diff --git a/path1 b/path1
 deleted file mode 100755
+old index 85d7fd2fbbe9564fe6ecc5e72416adb36e62d658 100755
 --- a/path1
 +++ /dev/null
 @@ -1,3 +0,0 @@
@@ -48,6 +52,6 @@ EOF
 
 test_expect_success \
     'validate git-diff-files -p output.' \
-    'cmp -s current expected'
+    'compare_diff_patch current expected'
 
 test_done
diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
old index be474856824f8e6659151590ed5acff38187e97d 100755
new index 2e3c20d6b9468bf413e97d422e7dbe13ac4238cd 100755
--- a/t/t4001-diff-rename.sh
+++ b/t/t4001-diff-rename.sh
@@ -7,6 +7,7 @@ test_description='Test rename detection 
 
 '
 . ./test-lib.sh
+. ../diff-lib.sh
 
 echo >path0 'Line 1
 Line 2
@@ -61,6 +62,6 @@ EOF
 
 test_expect_success \
     'validate the output.' \
-    'diff -I "similarity.*" >/dev/null current expected'
+    'compare_diff_patch current expected'
 
 test_done
diff --git a/t/t4004-diff-rename-symlink.sh b/t/t4004-diff-rename-symlink.sh
old index f59614ae255b33f450a784200716c9fd63b0a054 100755
new index a23aaa0a9471c68b233480cf34c7115d1f40e154 100755
--- a/t/t4004-diff-rename-symlink.sh
+++ b/t/t4004-diff-rename-symlink.sh
@@ -10,6 +10,7 @@ copy of symbolic links, but should not p
 by an edit for them.
 '
 . ./test-lib.sh
+. ../diff-lib.sh
 
 test_expect_success \
     'prepare reference tree' \
@@ -61,6 +62,6 @@ EOF
 
 test_expect_success \
     'validate diff output' \
-    'diff -u current expected'
+    'compare_diff_patch current expected'
 
 test_done
diff --git a/update-index.c b/update-index.c
old index b825a11d2f6d8a53f5e42e4f157ba036a13edb59 100644
new index 9dc518877b67bedced29ac91ecd8fafbb2a60135 100644
--- a/update-index.c
+++ b/update-index.c
@@ -37,8 +37,6 @@ static int add_file_to_cache(const char 
 	int size, namelen, option, status;
 	struct cache_entry *ce;
 	struct stat st;
-	int fd;
-	char *target;
 
 	status = lstat(path, &st);
 	if (status < 0 || S_ISDIR(st.st_mode)) {
@@ -77,34 +75,9 @@ static int add_file_to_cache(const char 
 	fill_stat_cache_info(ce, &st);
 	ce->ce_mode = create_ce_mode(st.st_mode);
 	ce->ce_flags = htons(namelen);
-	switch (st.st_mode & S_IFMT) {
-	case S_IFREG:
-		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return error("open(\"%s\"): %s", path, strerror(errno));
-		if (index_fd(ce->sha1, fd, &st, !info_only, NULL) < 0)
-			return error("%s: failed to insert into database", path);
-		break;
-	case S_IFLNK:
-		target = xmalloc(st.st_size+1);
-		if (readlink(path, target, st.st_size+1) != st.st_size) {
-			char *errstr = strerror(errno);
-			free(target);
-			return error("readlink(\"%s\"): %s", path,
-			             errstr);
-		}
-		if (info_only) {
-			unsigned char hdr[50];
-			int hdrlen;
-			write_sha1_file_prepare(target, st.st_size, "blob",
-						ce->sha1, hdr, &hdrlen);
-		} else if (write_sha1_file(target, st.st_size, "blob", ce->sha1))
-			return error("%s: failed to insert into database", path);
-		free(target);
-		break;
-	default:
-		return error("%s: unsupported file type", path);
-	}
+
+	if (index_path(ce->sha1, path, &st, !info_only))
+		return -1;
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
---
0.99.8.GIT
