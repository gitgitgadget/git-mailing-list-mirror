From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-mv: readability patch
Date: Sat, 19 Aug 2006 16:52:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608191651110.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Aug 19 16:52:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GESBZ-0000ZA-7M
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 16:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWHSOwY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 10:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWHSOwY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 10:52:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:46809 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751755AbWHSOwX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 10:52:23 -0400
Received: (qmail invoked by alias); 19 Aug 2006 14:52:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp020) with SMTP; 19 Aug 2006 16:52:22 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25724>


The old version was not liked at all. This is hopefully better. Oh, and it 
gets rid of the goto.

Note that it does not change any functionality.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-mv.c |  104 +++++++++++++++++++++++++---------------------------------
 1 files changed, 44 insertions(+), 60 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index c0c8764..1fdb0c7 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -126,48 +126,43 @@ int cmd_mv(int argc, const char **argv, 
 
 	/* Checking */
 	for (i = 0; i < count; i++) {
-		int length;
+		const char *src = source[i], *dst = destination[i];
+		int length, src_is_dir;
 		const char *bad = NULL;
 
 		if (show_only)
-			printf("Checking rename of '%s' to '%s'\n",
-				source[i], destination[i]);
+			printf("Checking rename of '%s' to '%s'\n", src, dst);
 
-		if (lstat(source[i], &st) < 0)
+		length = strlen(src);
+		if (lstat(src, &st) < 0)
 			bad = "bad source";
-
-		if (!bad &&
-		    (length = strlen(source[i])) >= 0 &&
-		    !strncmp(destination[i], source[i], length) &&
-		    (destination[i][length] == 0 || destination[i][length] == '/'))
+		else if (!strncmp(src, dst, length) &&
+				(dst[length] == 0 || dst[length] == '/')) {
 			bad = "can not move directory into itself";
-
-		if (S_ISDIR(st.st_mode)) {
-			const char *dir = source[i], *dest_dir = destination[i];
-			int first, last, len = strlen(dir);
-
-			if (lstat(dest_dir, &st) == 0) {
-				bad = "cannot move directory over file";
-				goto next;
-			}
+		} else if ((src_is_dir = S_ISDIR(st.st_mode))
+				&& lstat(dst, &st) == 0)
+			bad = "cannot move directory over file";
+		else if (src_is_dir) {
+			int first, last;
 
 			modes[i] = WORKING_DIRECTORY;
 
-			first = cache_name_pos(source[i], len);
+			first = cache_name_pos(src, length);
 			if (first >= 0)
-				die ("Huh? %s/ is in index?", dir);
+				die ("Huh? %s/ is in index?", src);
 
 			first = -1 - first;
 			for (last = first; last < active_nr; last++) {
 				const char *path = active_cache[last]->name;
-				if (strncmp(path, dir, len) || path[len] != '/')
+				if (strncmp(path, src, length)
+						|| path[length] != '/')
 					break;
 			}
 
 			if (last - first < 1)
 				bad = "source directory is empty";
-			else if (!bad) {
-				int j, dst_len = strlen(dest_dir);
+			else {
+				int j, dst_len;
 
 				if (last - first > 0) {
 					source = realloc(source,
@@ -181,24 +176,21 @@ int cmd_mv(int argc, const char **argv, 
 							* sizeof(enum update_mode));
 				}
 
-				dest_dir = add_slash(dest_dir);
+				dst = add_slash(dst);
+				dst_len = strlen(dst) - 1;
 
 				for (j = 0; j < last - first; j++) {
 					const char *path =
 						active_cache[first + j]->name;
 					source[count + j] = path;
 					destination[count + j] =
-						prefix_path(dest_dir, dst_len,
-							path + len);
+						prefix_path(dst, dst_len,
+							path + length);
 					modes[count + j] = INDEX;
 				}
 				count += last - first;
 			}
-
-			goto next;
-		}
-
-		if (!bad && lstat(destination[i], &st) == 0) {
+		} else if (lstat(dst, &st) == 0) {
 			bad = "destination exists";
 			if (force) {
 				/*
@@ -210,24 +202,17 @@ int cmd_mv(int argc, const char **argv, 
 							" will overwrite!\n",
 							bad);
 					bad = NULL;
-					path_list_insert(destination[i],
-							&overwritten);
+					path_list_insert(dst, &overwritten);
 				} else
 					bad = "Cannot overwrite";
 			}
-		}
-
-		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
+		} else if (cache_name_pos(src, length) < 0)
 			bad = "not under version control";
+		else if (path_list_has_path(&src_for_dst, dst))
+			bad = "multiple sources for the same target";
+		else
+			path_list_insert(dst, &src_for_dst);
 
-		if (!bad) {
-			if (path_list_has_path(&src_for_dst, destination[i]))
-				bad = "multiple sources for the same target";
-			else
-				path_list_insert(destination[i], &src_for_dst);
-		}
-
-next:
 		if (bad) {
 			if (ignore_errors) {
 				if (--count > 0) {
@@ -239,33 +224,32 @@ next:
 				}
 			} else
 				die ("%s, source=%s, destination=%s",
-				     bad, source[i], destination[i]);
+				     bad, src, dst);
 		}
 	}
 
 	for (i = 0; i < count; i++) {
+		const char *src = source[i], *dst = destination[i];
+		enum update_mode mode = modes[i];
 		if (show_only || verbose)
-			printf("Renaming %s to %s\n",
-			       source[i], destination[i]);
-		if (!show_only && modes[i] != INDEX &&
-		    rename(source[i], destination[i]) < 0 &&
-		    !ignore_errors)
-			die ("renaming %s failed: %s",
-			     source[i], strerror(errno));
-
-		if (modes[i] == WORKING_DIRECTORY)
+			printf("Renaming %s to %s\n", src, dst);
+		if (!show_only && mode != INDEX &&
+				rename(src, dst) < 0 && !ignore_errors)
+			die ("renaming %s failed: %s", src, strerror(errno));
+
+		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		if (cache_name_pos(source[i], strlen(source[i])) >= 0) {
-			path_list_insert(source[i], &deleted);
+		if (cache_name_pos(src, strlen(src)) >= 0) {
+			path_list_insert(src, &deleted);
 
 			/* destination can be a directory with 1 file inside */
-			if (path_list_has_path(&overwritten, destination[i]))
-				path_list_insert(destination[i], &changed);
+			if (path_list_has_path(&overwritten, dst))
+				path_list_insert(dst, &changed);
 			else
-				path_list_insert(destination[i], &added);
+				path_list_insert(dst, &added);
 		} else
-			path_list_insert(destination[i], &added);
+			path_list_insert(dst, &added);
 	}
 
         if (show_only) {
-- 
1.4.2.gd3f3-dirty
