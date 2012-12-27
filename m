From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 05/19] dir.c: rename excluded_from_list() to is_excluded_from_list()
Date: Thu, 27 Dec 2012 02:32:24 +0000
Message-ID: <1356575558-2674-6-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3HL-0006HI-2c
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351Ab2L0Ccp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:45 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53762 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab2L0Ccn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:43 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 8972B2E5E6
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:42 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212169>

Continue adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204924

Also adjust their callers as necessary.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c          | 11 ++++++-----
 dir.h          |  4 ++--
 unpack-trees.c |  8 +++++---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index f1c0abd..0800491 100644
--- a/dir.c
+++ b/dir.c
@@ -605,9 +605,9 @@ int match_pathname(const char *pathname, int pathlen,
 /* Scan the list and let the last match determine the fate.
  * Return 1 for exclude, 0 for include and -1 for undecided.
  */
-int excluded_from_list(const char *pathname,
-		       int pathlen, const char *basename, int *dtype,
-		       struct exclude_list *el)
+int is_excluded_from_list(const char *pathname,
+			  int pathlen, const char *basename, int *dtype,
+			  struct exclude_list *el)
 {
 	int i;
 
@@ -654,8 +654,9 @@ static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 
 	prep_exclude(dir, pathname, basename-pathname);
 	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		switch (excluded_from_list(pathname, pathlen, basename,
-					   dtype_p, &dir->exclude_list[st])) {
+		switch (is_excluded_from_list(pathname, pathlen,
+					      basename, dtype_p,
+					      &dir->exclude_list[st])) {
 		case 0:
 			return 0;
 		case 1:
diff --git a/dir.h b/dir.h
index c59bad8..554f87a 100644
--- a/dir.h
+++ b/dir.h
@@ -98,8 +98,8 @@ extern int within_depth(const char *name, int namelen, int depth, int max_depth)
 extern int fill_directory(struct dir_struct *dir, const char **pathspec);
 extern int read_directory(struct dir_struct *, const char *path, int len, const char **pathspec);
 
-extern int excluded_from_list(const char *pathname, int pathlen, const char *basename,
-			      int *dtype, struct exclude_list *el);
+extern int is_excluded_from_list(const char *pathname, int pathlen, const char *basename,
+				 int *dtype, struct exclude_list *el);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
 
 /*
diff --git a/unpack-trees.c b/unpack-trees.c
index 3ac6370..c0da094 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -836,7 +836,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
-	int ret = excluded_from_list(prefix, prefix_len, basename, &dtype, el);
+	int ret = is_excluded_from_list(prefix, prefix_len,
+					basename, &dtype, el);
 
 	prefix[prefix_len++] = '/';
 
@@ -855,7 +856,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * with ret (iow, we know in advance the incl/excl
 	 * decision for the entire directory), clear flag here without
 	 * calling clear_ce_flags_1(). That function will call
-	 * the expensive excluded_from_list() on every entry.
+	 * the expensive is_excluded_from_list() on every entry.
 	 */
 	return clear_ce_flags_1(cache, cache_end - cache,
 				prefix, prefix_len,
@@ -938,7 +939,8 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
-		ret = excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, el);
+		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
+					    name, &dtype, el);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
-- 
1.7.11.2.249.g31c7954
