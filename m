From: Jeff King <peff@peff.net>
Subject: [PATCH 8/8] diff: optionally use rename cache
Date: Sat, 4 Aug 2012 13:14:21 -0400
Message-ID: <20120804171421.GH19378@sigill.intra.peff.net>
References: <20120804170905.GA19267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:14:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxhvo-0005qI-Bt
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab2HDROX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:14:23 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51705 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753864Ab2HDROW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:14:22 -0400
Received: (qmail 2165 invoked by uid 107); 4 Aug 2012 17:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:14:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:14:21 -0400
Content-Disposition: inline
In-Reply-To: <20120804170905.GA19267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202889>

This speeds up estimate_similarity by caching the similarity
score of pairs of blob sha1s.

Signed-off-by: Jeff King <peff@peff.net>
---
Some interesting things to time with this are:

  - "git log --raw -M" on a repo with a lot of paths or a lot of renames
    (I found on git.git, the speedup was not that impressive)

  - "git log --raw -C -C" on any repo (this speeds up a lot in git.git).

  - "git show -M" on commits with very large blobs

 cache.h           |  1 +
 diff.c            |  6 ++++++
 diffcore-rename.c | 11 ++++++++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 23a2f93..7ee1caf 100644
--- a/cache.h
+++ b/cache.h
@@ -1228,6 +1228,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags);
 
 /* diff.c */
 extern int diff_auto_refresh_index;
+extern int diff_cache_renames;
 
 /* match-trees.c */
 void shift_tree(const unsigned char *, const unsigned char *, unsigned char *, int);
diff --git a/diff.c b/diff.c
index 95706a5..c84e043 100644
--- a/diff.c
+++ b/diff.c
@@ -34,6 +34,7 @@ static int diff_no_prefix;
 static int diff_stat_graph_width;
 static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
+int diff_cache_renames;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -214,6 +215,11 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.cacherenames")) {
+		diff_cache_renames = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!prefixcmp(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 216a7a4..611e1d3 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,6 +6,7 @@
 #include "diffcore.h"
 #include "hash.h"
 #include "progress.h"
+#include "metadata-cache.h"
 
 /* Table of rename/copy destinations */
 
@@ -137,7 +138,8 @@ static int estimate_similarity(struct diff_filespec *src,
 	 */
 	unsigned long max_size, delta_size, base_size, src_copied, literal_added;
 	unsigned long delta_limit;
-	int score;
+	uint32_t score;
+	struct sha1pair pair;
 
 	/* We deal only with regular files.  Symlink renames are handled
 	 * only when they are exact matches --- in other words, no edits
@@ -175,6 +177,11 @@ static int estimate_similarity(struct diff_filespec *src,
 	if (max_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
 		return 0;
 
+	hashcpy(pair.one, src->sha1);
+	hashcpy(pair.two, dst->sha1);
+	if (diff_cache_renames && rename_cache_get(&pair, &score))
+			return score;
+
 	if (!src->cnt_data && diff_populate_filespec(src, 0))
 		return 0;
 	if (!dst->cnt_data && diff_populate_filespec(dst, 0))
@@ -195,6 +202,8 @@ static int estimate_similarity(struct diff_filespec *src,
 		score = 0; /* should not happen */
 	else
 		score = (int)(src_copied * MAX_SCORE / max_size);
+	if (diff_cache_renames)
+		rename_cache_set(&pair, score);
 	return score;
 }
 
-- 
1.7.12.rc1.7.g7a223a6
