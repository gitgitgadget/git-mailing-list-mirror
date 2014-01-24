From: Brad King <brad.king@kitware.com>
Subject: [PATCH/RFC 3/3] merge-recursive: Tolerate missing file when HEAD is up to date
Date: Fri, 24 Jan 2014 10:01:03 -0500
Message-ID: <5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com> <cover.1390574980.git.brad.king@kitware.com>
Cc: gitster@pobox.com, newren@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 24 16:00:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6iFO-0005JE-9I
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 16:00:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752712AbaAXPAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 10:00:37 -0500
Received: from tripoint.kitware.com ([66.194.253.20]:59095 "EHLO
	vesper.kitware.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752599AbaAXPAf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 10:00:35 -0500
Received: by vesper.kitware.com (Postfix, from userid 1000)
	id 9893F9FBA7; Fri, 24 Jan 2014 10:01:03 -0500 (EST)
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <cover.1390574980.git.brad.king@kitware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241010>

Teach add_cacheinfo to optionally tolerate make_cache_entry failure when
the reason is ENOENT from lstat.  Tell it to do so in the call path when
the entry from HEAD is known to be up to date.

This fixes the 'merge-recursive w/ empty work tree - ours has rename'
case in t3030-merge-recursive.

Signed-off-by: Brad King <brad.king@kitware.com>
---
 merge-recursive.c          | 21 +++++++++++++--------
 t/t3030-merge-recursive.sh |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4394c44..6a2b962 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -198,13 +198,18 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 }
 
 static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
-		const char *path, int stage, int refresh, int options)
+			 const char *path, int stage, int refresh,
+			 int options, int noent_okay)
 {
 	struct cache_entry *ce;
+	int cache_errno = 0;
 	ce = make_cache_entry(mode, sha1 ? sha1 : null_sha1, path,
-			      stage, refresh, NULL);
-	if (!ce)
+			      stage, refresh, &cache_errno);
+	if (!ce) {
+		if(cache_errno == ENOENT && noent_okay)
+			return 0;
 		return error(_("addinfo_cache failed for path '%s'"), path);
+	}
 	return add_cache_entry(ce, options);
 }
 
@@ -552,13 +557,13 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 		if (remove_file_from_cache(path))
 			return -1;
 	if (o)
-		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
+		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options, 0))
 			return -1;
 	if (a)
-		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
+		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options, 0))
 			return -1;
 	if (b)
-		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
+		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options, 0))
 			return -1;
 	return 0;
 }
@@ -789,7 +794,7 @@ static void update_file_flags(struct merge_options *o,
 	}
  update_index:
 	if (update_cache)
-		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD, 0);
 }
 
 static void update_file(struct merge_options *o,
@@ -1624,7 +1629,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+				      0, (!o->call_depth), 0, 1);
 			return mfi.clean;
 		}
 	} else
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index b6d3ed0..c8ba895 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -518,7 +518,7 @@ test_expect_success 'reset and bind merge' '
 
 '
 
-test_expect_failure 'merge-recursive w/ empty work tree - ours has rename' '
+test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 	(
 	 GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
 	 export GIT_WORK_TREE &&
-- 
1.8.5.2
