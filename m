From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] untracked-cache: fix subdirectory handling
Date: Fri,  7 Aug 2015 13:17:53 -0400
Message-ID: <1438967873-792-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 07 19:18:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlHP-00061i-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbbHGRR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:17:59 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:33446 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315AbbHGRR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:17:57 -0400
Received: by qged69 with SMTP id d69so79114579qge.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=06B7IrzUKMgwWNoic3nXGH6tTvWgxHk34pB160GHBBo=;
        b=PNslLpKaNmchJP20oFJlPOl9znzvCS5KMD+qmL+DbuaixwGHQSSThzoj0mXc7XKF1u
         EeKy3vfzrRWXDKeTxLms2jcDuNNeXF+h/mhYLHl4E1ZUMHjvTS3DPfQSbxFwE4RIYNXq
         JB7B7sKIWTnX/luas83kRt8Ly0AVFWn3nGxo2oW9Nkj179vX0tVO2ZXyc8iO5+jj0yw0
         SIgPZB9jB3s9ENOaTOCwA47BUvLbYX4eldvc6SYRt9HB9Z3YEhAo51vnGFWn/SdgJtLF
         fEawH6ATKFMj0NXRDhi/ShJuWZbQObwmDF5a5cNRoLt/bvZ5HGgorr+Dn0DRMFj7Fxz5
         xijg==
X-Gm-Message-State: ALoCoQlSbls0kgn8JoyTUnT4FUZkqsvcl9b+JSrRZjHjJeF5odKuq0WwVGL2jMNmhuGAH60t8oGk
X-Received: by 10.140.238.86 with SMTP id j83mr15658560qhc.37.1438967876893;
        Fri, 07 Aug 2015 10:17:56 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 126sm5207340qhc.49.2015.08.07.10.17.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Aug 2015 10:17:56 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275475>

Previously, some calls lookup_untracked would pass a full path.  But
lookup_untracked assumes that the portion of the path up to and
including to the untracked_cache_dir has been removed.  So
lookup_untracked would be looking in the untracked_cache for 'foo' for
'foo/bar' (instead of just looking for 'bar').  This would cause
untracked cache corruption.

To fix this, untracked_cache_dir learns to track its depth.  Callers
to lookup_untracked which have a full path now first trim off a
sufficient number of path prefixes.  A new helper function,
lookup_untracked_recursive, helps untracked_cache_invalidate_path to
perform this operation.

Signed-off-by: David Turner <dturner@twopensource.com>
---
This version removes debugging cruft.  Oops!

---
 dir.c                             | 50 ++++++++++++++++++++-------
 dir.h                             |  1 +
 t/t7063-status-untracked-cache.sh | 72 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 110 insertions(+), 13 deletions(-)

diff --git a/dir.c b/dir.c
index e7b89fe..314080b 100644
--- a/dir.c
+++ b/dir.c
@@ -631,6 +631,7 @@ static struct untracked_cache_dir *lookup_untracked(struct untracked_cache *uc,
 	memset(d, 0, sizeof(*d));
 	memcpy(d->name, name, len);
 	d->name[len] = '\0';
+	d->depth = dir->depth + 1;
 
 	ALLOC_GROW(dir->dirs, dir->dirs_nr + 1, dir->dirs_alloc);
 	memmove(dir->dirs + first + 1, dir->dirs + first,
@@ -1324,7 +1325,19 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	if (!(dir->flags & DIR_HIDE_EMPTY_DIRECTORIES))
 		return exclude ? path_excluded : path_untracked;
 
-	untracked = lookup_untracked(dir->untracked, untracked, dirname, len);
+	if (untracked) {
+		const char *cur = dirname;
+		int i;
+
+		for (i = 0; i < untracked->depth; i++) {
+			cur = strchr(cur, '/');
+			assert(cur);
+			cur++;
+		}
+		untracked = lookup_untracked(dir->untracked, untracked,
+					     cur,
+					     len - (cur - dirname));
+	}
 	return read_directory_recursive(dir, dirname, len,
 					untracked, 1, simplify);
 }
@@ -2431,7 +2444,7 @@ static void stat_data_from_disk(struct stat_data *to, const struct stat_data *fr
 }
 
 static int read_one_dir(struct untracked_cache_dir **untracked_,
-			struct read_data *rd)
+			struct read_data *rd, int depth)
 {
 	struct untracked_cache_dir ud, *untracked;
 	const unsigned char *next, *data = rd->data, *end = rd->end;
@@ -2444,6 +2457,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	value = decode_varint(&next);
 	if (next > end)
 		return -1;
+	ud.depth = depth;
 	ud.recurse	   = 1;
 	ud.untracked_alloc = value;
 	ud.untracked_nr	   = value;
@@ -2480,7 +2494,7 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	rd->data = data;
 
 	for (i = 0; i < untracked->dirs_nr; i++) {
-		len = read_one_dir(untracked->dirs + i, rd);
+		len = read_one_dir(untracked->dirs + i, rd, depth + 1);
 		if (len < 0)
 			return -1;
 	}
@@ -2577,7 +2591,7 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	rd.index      = 0;
 	rd.ucd        = xmalloc(sizeof(*rd.ucd) * len);
 
-	if (read_one_dir(&uc->root, &rd) || rd.index != len)
+	if (read_one_dir(&uc->root, &rd, 0) || rd.index != len)
 		goto done;
 
 	next = rd.data;
@@ -2614,20 +2628,32 @@ done2:
 	return uc;
 }
 
+static struct untracked_cache_dir *lookup_untracked_recursive(
+	struct untracked_cache *uc, struct untracked_cache_dir *dir,
+	const char *path, int len)
+{
+	const char *rest = strchr(path, '/');
+
+	if (rest) {
+		int component_len = rest - path;
+		struct untracked_cache_dir *d =
+			lookup_untracked(uc, dir, path, component_len);
+		return lookup_untracked_recursive(uc, d, rest + 1,
+						  len - (component_len + 1));
+	} else {
+		return dir;
+	}
+}
+
 void untracked_cache_invalidate_path(struct index_state *istate,
 				     const char *path)
 {
-	const char *sep;
 	struct untracked_cache_dir *d;
 	if (!istate->untracked || !istate->untracked->root)
 		return;
-	sep = strrchr(path, '/');
-	if (sep)
-		d = lookup_untracked(istate->untracked,
-				     istate->untracked->root,
-				     path, sep - path);
-	else
-		d = istate->untracked->root;
+	d = lookup_untracked_recursive(istate->untracked,
+				       istate->untracked->root,
+				       path, strlen(path));
 	istate->untracked->dir_invalidated++;
 	d->valid = 0;
 	d->untracked_nr = 0;
diff --git a/dir.h b/dir.h
index 7b5855d..885ed43 100644
--- a/dir.h
+++ b/dir.h
@@ -109,6 +109,7 @@ struct sha1_stat {
  *  excludes_file_sha1[])
  */
 struct untracked_cache_dir {
+	unsigned int depth;
 	struct untracked_cache_dir **dirs;
 	char **untracked;
 	struct stat_data stat_data;
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index ff23f4e..ca8dc3a 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -408,7 +408,8 @@ test_expect_success 'set up sparse checkout' '
 	test_path_is_file done/one
 '
 
-test_expect_success 'create files, some of which are gitignored' '
+test_expect_success 'create/modify files, some of which are gitignored' '
+	echo two bis >done/two &&
 	echo three >done/three && # three is gitignored
 	echo four >done/four && # four is gitignored at a higher level
 	echo five >done/five # five is not gitignored
@@ -420,6 +421,7 @@ test_expect_success 'test sparse status with untracked cache' '
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
+ M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
@@ -459,6 +461,7 @@ test_expect_success 'test sparse status again with untracked cache' '
 	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
 	git status --porcelain >../status.actual &&
 	cat >../status.expect <<EOF &&
+ M done/two
 ?? .gitignore
 ?? done/five
 ?? dtwo/
@@ -473,4 +476,71 @@ EOF
 	test_cmp ../trace.expect ../trace
 '
 
+test_expect_success 'set up for test of subdir and sparse checkouts' '
+	mkdir done/sub &&
+	mkdir done/sub/sub &&
+	echo "sub" > done/sub/sub/file
+'
+
+test_expect_success 'test sparse status with untracked cache and subdir' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	cat >../status.expect <<EOF &&
+ M done/two
+?? .gitignore
+?? done/five
+?? done/sub/
+?? dtwo/
+EOF
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 2
+gitignore invalidation: 0
+directory invalidation: 1
+opendir: 3
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
+test_expect_success 'verify untracked cache dump (sparse/subdirs)' '
+	test-dump-untracked-cache >../actual &&
+	cat >../expect <<EOF &&
+info/exclude 13263c0978fb9fad16b2d580fb800b6d811c3ff0
+core.excludesfile 0000000000000000000000000000000000000000
+exclude_per_dir .gitignore
+flags 00000006
+/ e6fcc8f2ee31bae321d66afd183fcb7237afae6e recurse valid
+.gitignore
+dtwo/
+/done/ 1946f0437f90c5005533cbe1736a6451ca301714 recurse valid
+five
+sub/
+/done/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+sub/
+/done/sub/sub/ 0000000000000000000000000000000000000000 recurse check_only valid
+file
+/dthree/ 0000000000000000000000000000000000000000 recurse check_only valid
+/dtwo/ 0000000000000000000000000000000000000000 recurse check_only valid
+two
+EOF
+	test_cmp ../expect ../actual
+'
+
+test_expect_success 'test sparse status again with untracked cache and subdir' '
+	avoid_racy &&
+	: >../trace &&
+	GIT_TRACE_UNTRACKED_STATS="$TRASH_DIRECTORY/trace" \
+	git status --porcelain >../status.actual &&
+	test_cmp ../status.expect ../status.actual &&
+	cat >../trace.expect <<EOF &&
+node creation: 0
+gitignore invalidation: 0
+directory invalidation: 0
+opendir: 0
+EOF
+	test_cmp ../trace.expect ../trace
+'
+
 test_done
-- 
2.0.4.315.gad8727a-twtrsrc
