From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 19/22] teach ls-files.c to use cache_find_name()
Date: Mon, 12 Sep 2005 10:56:25 -0400
Message-ID: <20050912145624.28120.48523.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:00:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpjj-0000SG-9H
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbVILO4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVILO4h
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:37 -0400
Received: from citi.umich.edu ([141.211.133.111]:38331 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751308AbVILO4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:56:25 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 0045F1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:56:24 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8390>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 ls-files.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/ls-files.c b/ls-files.c
--- a/ls-files.c
+++ b/ls-files.c
@@ -216,7 +216,7 @@ static void add_name(const char *pathnam
 {
 	struct nond_on_fs *ent;
 
-	if (cache_name_pos(pathname, len) >= 0)
+	if (cache_find_entry(pathname, len, NULL))
 		return;
 
 	if (nr_dir == dir_alloc) {
@@ -349,36 +349,34 @@ static void show_killed_files(void)
 	for (i = 0; i < nr_dir; i++) {
 		struct nond_on_fs *ent = dir[i];
 		char *cp, *sp;
-		int pos, len, killed = 0;
+		int killed = 0;
 
 		for (cp = ent->name; cp - ent->name < ent->len; cp = sp + 1) {
 			sp = strchr(cp, '/');
 			if (!sp) {
+				struct cache_cursor cc;
+				struct cache_entry *ce;
 				/* If ent->name is prefix of an entry in the
 				 * cache, it will be killed.
 				 */
-				pos = cache_name_pos(ent->name, ent->len);
-				if (0 <= pos)
+				if (cache_find_name(ent->name, ent->len, &cc))
 					die("bug in show-killed-files");
-				pos = -pos - 1;
-				while (pos < active_nr &&
-				       ce_stage(active_cache[pos]))
-					pos++; /* skip unmerged */
-				if (active_nr <= pos)
+				while (!cache_eof(&cc) && ce_stage(cc_to_ce(&cc)))
+					next_cc(&cc); /* skip unmerged */
+				if (cache_eof(&cc))
 					break;
-				/* pos points at a name immediately after
+				/* cc points at a name immediately after
 				 * ent->name in the cache.  Does it expect
 				 * ent->name to be a directory?
 				 */
-				len = ce_namelen(active_cache[pos]);
-				if ((ent->len < len) &&
-				    !strncmp(active_cache[pos]->name,
-					     ent->name, ent->len) &&
-				    active_cache[pos]->name[ent->len] == '/')
+				ce = cc_to_ce(&cc);
+				if ((ent->len < ce_namelen(ce)) &&
+				    !strncmp(ce->name, ent->name, ent->len) &&
+				    ce->name[ent->len] == '/')
 					killed = 1;
 				break;
 			}
-			if (0 <= cache_name_pos(ent->name, sp - ent->name)) {
+			if (cache_find_entry(ent->name, sp - ent->name, NULL)) {
 				/* If any of the leading directories in
 				 * ent->name is registered in the cache,
 				 * ent->name will be killed.
