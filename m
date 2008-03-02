From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make the exit code of add_file_to_index actually useful
Date: Sun, 2 Mar 2008 16:42:38 +0100
Message-ID: <20080302154238.GD2973@steel.home>
References: <47C95E34.1050306@dirk.my1.cc> <20080302154154.GC2973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Dirk =?iso-8859-15?Q?S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 02 16:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqLQ-0002TR-9A
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 16:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbYCBPmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 10:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYCBPmn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 10:42:43 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:44594 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYCBPmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 10:42:42 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJKcp6o=
Received: from tigra.home (Fab7c.f.strato-dslnet.de [195.4.171.124])
	by post.webmailer.de (klopstock mo11) (RZmta 16.8)
	with ESMTP id 003f18k22F7IVE ; Sun, 2 Mar 2008 16:42:38 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C8DE6277BD;
	Sun,  2 Mar 2008 16:42:38 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id BDC2056D24; Sun,  2 Mar 2008 16:42:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080302154154.GC2973@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75789>

Update the programs which used the function (as add_file_to_cache).

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-add.c    |    6 ++++--
 builtin-commit.c |    7 ++++---
 builtin-mv.c     |    3 ++-
 read-cache.c     |    8 ++++----
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 820110e..abfe473 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -94,7 +94,8 @@ static void update_callback(struct diff_queue_struct *q,
 		case DIFF_STATUS_UNMERGED:
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			add_file_to_cache(path, verbose);
+			if (add_file_to_cache(path, verbose))
+				exit(1);
 			break;
 		case DIFF_STATUS_DELETED:
 			remove_file_from_cache(path);
@@ -266,7 +267,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < dir.nr; i++)
-		add_file_to_cache(dir.entries[i]->name, verbose);
+		if (add_file_to_cache(dir.entries[i]->name, verbose))
+			exit(1);
 
  finish:
 	if (active_cache_changed) {
diff --git a/builtin-commit.c b/builtin-commit.c
index f49c22e..fb1e588 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -176,9 +176,10 @@ static void add_remove_files(struct path_list *list)
 	int i;
 	for (i = 0; i < list->nr; i++) {
 		struct path_list_item *p = &(list->items[i]);
-		if (file_exists(p->path))
-			add_file_to_cache(p->path, 0);
-		else
+		if (file_exists(p->path)) {
+			if (add_file_to_cache(p->path, 0))
+				exit(1);
+		} else
 			remove_file_from_cache(p->path);
 	}
 }
diff --git a/builtin-mv.c b/builtin-mv.c
index 68aa2a6..ec6e09d 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -260,7 +260,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 		for (i = 0; i < added.nr; i++) {
 			const char *path = added.items[i].path;
-			add_file_to_cache(path, verbose);
+			if (add_file_to_cache(path, verbose))
+				exit(1);
 		}
 
 		for (i = 0; i < deleted.nr; i++)
diff --git a/read-cache.c b/read-cache.c
index 657f0c5..4a4f511 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -461,10 +461,10 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_RACY_IS_DIRTY;
 
 	if (lstat(path, &st))
-		die("%s: unable to stat (%s)", path, strerror(errno));
+		return error("%s: unable to stat (%s)", path, strerror(errno));
 
 	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode) && !S_ISDIR(st.st_mode))
-		die("%s: can only add regular files, symbolic links or git-directories", path);
+		return error("%s: can only add regular files, symbolic links or git-directories", path);
 
 	namelen = strlen(path);
 	if (S_ISDIR(st.st_mode)) {
@@ -501,9 +501,9 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	}
 
 	if (index_path(ce->sha1, path, &st, 1))
-		die("unable to index file %s", path);
+		return error("unable to index file %s", path);
 	if (add_index_entry(istate, ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE))
-		die("unable to add %s to index",path);
+		return error("unable to add %s to index",path);
 	if (verbose)
 		printf("add '%s'\n", path);
 	return 0;
-- 
1.5.4.3.391.gf5a0c

