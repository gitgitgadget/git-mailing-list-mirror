From: Florian Forster <octo@verplant.org>
Subject: [PATCH 3/7] Don't instantiate structures with FAMs.
Date: Sun, 18 Jun 2006 17:18:05 +0200
Message-ID: <11506438892551-git-send-email-octo@verplant.org>
References: <11506438893796-git-send-email-octo@verplant.org>
Reply-To: Florian Forster <octo@verplant.org>
Cc: Florian Forster <octo@verplant.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 17:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Frz2o-0005K3-Ar
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 17:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWFRPSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWFRPSU
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 11:18:20 -0400
Received: from verplant.org ([213.95.21.52]:36745 "EHLO huhu.verplant.org")
	by vger.kernel.org with ESMTP id S1751178AbWFRPSO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 11:18:14 -0400
Received: from leeloo.lan.home.verplant.org ([2001:780:104:1:2e0:18ff:fead:37e4] ident=Debian-exim)
	by huhu.verplant.org with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Frz2S-0004ZZ-2g; Sun, 18 Jun 2006 17:18:12 +0200
Received: from localhost
	([127.0.0.1] helo=localhost.localdomain ident=octo)
	by leeloo.lan.home.verplant.org with esmtp (Exim 4.62)
	(envelope-from <octo@verplant.org>)
	id 1Frz2P-00028O-9R; Sun, 18 Jun 2006 17:18:09 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3
In-Reply-To: <11506438893796-git-send-email-octo@verplant.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22091>

Since structures with `flexible array members' are an incomplete datatype ANSI
C99 forbids creating instances of them. This patch removes such an instance
from `diff-lib.c' and replaces it with a pointer to a `struct
combine_diff_path'. Since all neccessary memory is allocated at once the number
of calls to `xmalloc' is not increased.

Signed-off-by: Florian Forster <octo@verplant.org>


---

 diff-lib.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

c163a36f0bd0e07ffb9ee7d4bfb22f1cbb38eef8
diff --git a/diff-lib.c b/diff-lib.c
index 2183b41..fdc1173 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -34,21 +34,23 @@ int run_diff_files(struct rev_info *revs
 			continue;
 
 		if (ce_stage(ce)) {
-			struct {
-				struct combine_diff_path p;
-				struct combine_diff_parent filler[5];
-			} combine;
+			struct combine_diff_path *dpath;
 			int num_compare_stages = 0;
+			size_t path_len;
 
-			combine.p.next = NULL;
-			combine.p.len = ce_namelen(ce);
-			combine.p.path = xmalloc(combine.p.len + 1);
-			memcpy(combine.p.path, ce->name, combine.p.len);
-			combine.p.path[combine.p.len] = 0;
-			combine.p.mode = 0;
-			memset(combine.p.sha1, 0, 20);
-			memset(&combine.p.parent[0], 0,
-			       sizeof(combine.filler));
+			path_len = ce_namelen(ce);
+
+			dpath = xmalloc (combine_diff_path_size (5, path_len));
+			dpath->path = (char *) &(dpath->parent[5]);
+
+			dpath->next = NULL;
+			dpath->len = path_len;
+			memcpy(dpath->path, ce->name, path_len);
+			dpath->path[path_len] = '\0';
+			dpath->mode = 0;
+			memset(dpath->sha1, 0, 20);
+			memset(&(dpath->parent[0]), 0,
+					sizeof(struct combine_diff_parent)*5);
 
 			while (i < entries) {
 				struct cache_entry *nce = active_cache[i];
@@ -64,11 +66,11 @@ int run_diff_files(struct rev_info *revs
 				if (2 <= stage) {
 					int mode = ntohl(nce->ce_mode);
 					num_compare_stages++;
-					memcpy(combine.p.parent[stage-2].sha1,
+					memcpy(dpath->parent[stage-2].sha1,
 					       nce->sha1, 20);
-					combine.p.parent[stage-2].mode =
+					dpath->parent[stage-2].mode =
 						canon_mode(mode);
-					combine.p.parent[stage-2].status =
+					dpath->parent[stage-2].status =
 						DIFF_STATUS_MODIFIED;
 				}
 
@@ -83,13 +85,14 @@ int run_diff_files(struct rev_info *revs
 			i--;
 
 			if (revs->combine_merges && num_compare_stages == 2) {
-				show_combined_diff(&combine.p, 2,
+				show_combined_diff(dpath, 2,
 						   revs->dense_combined_merges,
 						   revs);
-				free(combine.p.path);
+				free(dpath);
 				continue;
 			}
-			free(combine.p.path);
+			free(dpath);
+			dpath = NULL;
 
 			/*
 			 * Show the diff for the 'ce' if we found the one
-- 
1.3.3
