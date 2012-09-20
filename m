From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 05/14] Rename excluded_from_list() to is_excluded_from_list()
Date: Thu, 20 Sep 2012 20:46:14 +0100
Message-ID: <1348170383-15751-6-git-send-email-git@adamspiers.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:46:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEmhz-0000NV-Oh
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 21:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab2ITTqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 15:46:31 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:46183 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab2ITTq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 15:46:29 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C9C2C2E5E9;
	Thu, 20 Sep 2012 20:46:28 +0100 (BST)
X-Mailer: git-send-email 1.7.12.147.g6d168f4
In-Reply-To: <1348170383-15751-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206073>

Continue adopting clearer names for exclude functions.  This 'is_*'
naming pattern for functions returning booleans was discussed here:

http://thread.gmane.org/gmane.comp.version-control.git/204661/focus=204924

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 dir.c          | 11 ++++++-----
 dir.h          |  4 ++--
 unpack-trees.c |  8 +++++---
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/dir.c b/dir.c
index dad1582..8f262f6 100644
--- a/dir.c
+++ b/dir.c
@@ -514,9 +514,9 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
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
 
@@ -596,8 +596,9 @@ static int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
 
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
index 41a5e32..6904a35 100644
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
index 724f69b..56127c9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -837,7 +837,8 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 {
 	struct cache_entry **cache_end;
 	int dtype = DT_DIR;
-	int ret = excluded_from_list(prefix, prefix_len, basename, &dtype, el);
+	int ret = is_excluded_from_list(prefix, prefix_len,
+					basename, &dtype, el);
 
 	prefix[prefix_len++] = '/';
 
@@ -856,7 +857,7 @@ static int clear_ce_flags_dir(struct cache_entry **cache, int nr,
 	 * with ret (iow, we know in advance the incl/excl
 	 * decision for the entire directory), clear flag here without
 	 * calling clear_ce_flags_1(). That function will call
-	 * the expensive excluded_from_list() on every entry.
+	 * the expensive is_excluded_from_list() on every entry.
 	 */
 	return clear_ce_flags_1(cache, cache_end - cache,
 				prefix, prefix_len,
@@ -939,7 +940,8 @@ static int clear_ce_flags_1(struct cache_entry **cache, int nr,
 
 		/* Non-directory */
 		dtype = ce_to_dtype(ce);
-		ret = excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, el);
+		ret = is_excluded_from_list(ce->name, ce_namelen(ce),
+					    name, &dtype, el);
 		if (ret < 0)
 			ret = defval;
 		if (ret > 0)
-- 
1.7.12.147.g6d168f4
