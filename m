From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] teach update-index --refresh about --data-unchanged
Date: Sun, 31 Oct 2010 18:28:05 -0400
Message-ID: <20101031222805.GB31257@arf.padd.com>
References: <20101031174430.GA30236@arf.padd.com>
 <20101031195933.GA21240@burratino>
 <20101031222644.GA31257@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 31 23:28:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCgNq-0004qG-Kv
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 23:28:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756800Ab0JaW2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 18:28:09 -0400
Received: from honk.padd.com ([74.3.171.149]:36347 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab0JaW2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 18:28:08 -0400
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 310E0276;
	Sun, 31 Oct 2010 15:28:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 67CD3319E9; Sun, 31 Oct 2010 18:28:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20101031222644.GA31257@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160455>

When a repository has been copied with rsync, or cloned using
a volume manager, the index can be incorrect even though the
data is unchanged.  This new flag tells update-index --refresh
that it is not necessary to reread the data contents.  Without
this flag, everything works, but it is much slower due to the
need to read all files.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-update-index.txt |    9 +++++++++
 builtin/update-index.c             |    6 +++++-
 cache.h                            |    9 ++++++---
 read-cache.c                       |   16 ++++++++++------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 765d4b3..69aaaee 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
+	     [--data-unchanged]
 	     [--assume-unchanged | --no-assume-unchanged]
 	     [--skip-worktree | --no-skip-worktree]
 	     [--ignore-submodules]
@@ -65,6 +66,14 @@ OPTIONS
 	behavior is to error out.  This option makes 'git update-index'
         continue anyway.
 
+--data-unchanged::
+	When refreshing the cache, do not re-read all data
+	files to verify that they are unchanged.  This flag
+	attests that even though the index may be invalid, file content
+	has not been changed.  This situation can happen when
+	a repository is copied with `rsync` or with a volume manager
+	clone command.
+
 --ignore-missing::
 	Ignores missing files during a --refresh
 
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 3ab214d..dc609cc 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -398,7 +398,7 @@ static void read_index_info(int line_termination)
 }
 
 static const char update_index_usage[] =
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--data-unchanged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -635,6 +635,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				refresh_flags |= REFRESH_UNMERGED;
 				continue;
 			}
+			if (!strcmp(path, "--data-unchanged")) {
+				refresh_flags |= REFRESH_DATA_UNCHANGED;
+				continue;
+			}
 			if (!strcmp(path, "--refresh")) {
 				setup_work_tree();
 				has_errors |= refresh_cache(refresh_flags);
diff --git a/cache.h b/cache.h
index 1e690d1..b2e692c 100644
--- a/cache.h
+++ b/cache.h
@@ -485,11 +485,13 @@ extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
 extern int index_name_is_other(const struct index_state *, const char *, int);
 
 /* do stat comparison even if CE_VALID is true */
-#define CE_MATCH_IGNORE_VALID		01
+#define CE_MATCH_IGNORE_VALID		0x1
 /* do not check the contents but report dirty on racily-clean entries */
-#define CE_MATCH_RACY_IS_DIRTY		02
+#define CE_MATCH_RACY_IS_DIRTY		0x2
 /* do stat comparison even if CE_SKIP_WORKTREE is true */
-#define CE_MATCH_IGNORE_SKIP_WORKTREE	04
+#define CE_MATCH_IGNORE_SKIP_WORKTREE	0x4
+/* trust that the contents of files have not been modified */
+#define CE_MATCH_DATA_UNCHANGED		0x8
 extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
@@ -504,6 +506,7 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_MISSING	0x0008	/* ignore non-existent */
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
+#define REFRESH_DATA_UNCHANGED	0x0040	/* no need to read all files, trust unmodified */
 extern int refresh_index(struct index_state *, unsigned int flags, const char **pathspec, char *seen, char *header_msg);
 
 struct lock_file {
diff --git a/read-cache.c b/read-cache.c
index 1f42473..26d5d5f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -137,12 +137,14 @@ static int ce_compare_gitlink(struct cache_entry *ce)
 	return hashcmp(sha1, ce->sha1);
 }
 
-static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
+static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st,
+				int options)
 {
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
-		if (ce_compare_data(ce, st))
-			return DATA_CHANGED;
+		if (!(options & CE_MATCH_DATA_UNCHANGED))
+			if (ce_compare_data(ce, st))
+				return DATA_CHANGED;
 		break;
 	case S_IFLNK:
 		if (ce_compare_link(ce, xsize_t(st->st_size)))
@@ -304,7 +306,7 @@ int ie_match_stat(const struct index_state *istate,
 		if (assume_racy_is_modified)
 			changed |= DATA_CHANGED;
 		else
-			changed |= ce_modified_check_fs(ce, st);
+			changed |= ce_modified_check_fs(ce, st, 0);
 	}
 
 	return changed;
@@ -343,7 +345,7 @@ int ie_modified(const struct index_state *istate,
 	    (S_ISGITLINK(ce->ce_mode) || ce->ce_size != 0))
 		return changed;
 
-	changed_fs = ce_modified_check_fs(ce, st);
+	changed_fs = ce_modified_check_fs(ce, st, options);
 	if (changed_fs)
 		return changed | changed_fs;
 	return 0;
@@ -1108,6 +1110,8 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 
 	needs_update_fmt = (in_porcelain ? "M\t%s\n" : "%s: needs update\n");
 	needs_merge_fmt = (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
+	if (flags & REFRESH_DATA_UNCHANGED)
+	    options |= CE_MATCH_DATA_UNCHANGED;
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
 		int cache_errno = 0;
@@ -1481,7 +1485,7 @@ static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
 		return;
 	if (ce_match_stat_basic(ce, &st))
 		return;
-	if (ce_modified_check_fs(ce, &st)) {
+	if (ce_modified_check_fs(ce, &st, 0)) {
 		/* This is "racily clean"; smudge it.  Note that this
 		 * is a tricky code.  At first glance, it may appear
 		 * that it can break with this sequence:
-- 
1.7.2.3
