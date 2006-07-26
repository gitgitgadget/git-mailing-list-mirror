From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] builtin git-mv: support moving directories
Date: Wed, 26 Jul 2006 19:47:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607261941210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 26 19:48:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5nUG-0007Xl-5Y
	for gcvg-git@gmane.org; Wed, 26 Jul 2006 19:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWGZRr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 13:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWGZRr4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 13:47:56 -0400
Received: from mail.gmx.net ([213.165.64.21]:27846 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030242AbWGZRrz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jul 2006 13:47:55 -0400
Received: (qmail invoked by alias); 26 Jul 2006 17:47:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 26 Jul 2006 19:47:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	junkio@cox.net, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24227>


This fixes the builtin mv for the test which Josef provided, and also
fixes moving directories into existing directories, as noted by Jon Smirl.
In case the destination exists, fail early (this cannot be overridden
by -f).

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Josef, this passes your test.

	Jon, if I understood your problem, then this fixes that, too.

	Everyone: it would be cleaner to use "goto next" everywhere, 
	instead of all these "if (!bad && ..." constructs, but I'll leave 
	that for other people ;-)

 builtin-mv.c  |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 t/t7001-mv.sh |    4 +++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 593ff9e..e660a9f 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -42,6 +42,18 @@ static void show_list(const char *label,
 	}
 }
 
+static const char *add_slash(const char *path)
+{
+	int len = strlen(path);
+	if (path[len - 1] != '/') {
+		char *with_slash = xmalloc(len + 2);
+		memcpy(with_slash, path, len);
+		strcat(with_slash + len, "/");
+		return with_slash;
+	}
+	return path;
+}
+
 static struct lock_file lock_file;
 
 int cmd_mv(int argc, const char **argv, char **envp)
@@ -50,6 +62,7 @@ int cmd_mv(int argc, const char **argv, 
 	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0;
 	const char *prefix = setup_git_directory();
 	const char **source, **destination, **dest_path;
+	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
 	struct stat st;
 	struct path_list overwritten = {NULL, 0, 0, 0};
 	struct path_list src_for_dst = {NULL, 0, 0, 0};
@@ -94,11 +107,14 @@ int cmd_mv(int argc, const char **argv, 
 		usage(builtin_mv_usage);
 
 	source = copy_pathspec(prefix, argv + i, count, 0);
+ 	modes = xcalloc(count, sizeof(enum update_mode));
 	dest_path = copy_pathspec(prefix, argv + argc - 1, 1, 0);
 
-	if (!lstat(dest_path[0], &st) && S_ISDIR(st.st_mode))
+	if (!lstat(dest_path[0], &st) &&
+			S_ISDIR(st.st_mode)) {
+ 		dest_path[0] = add_slash(dest_path[0]);
 		destination = copy_pathspec(dest_path[0], argv + i, count, 1);
-	else {
+	} else {
 		if (count != 1)
 			usage(builtin_mv_usage);
 		destination = dest_path;
@@ -114,7 +130,64 @@ int cmd_mv(int argc, const char **argv, 
 
 		if (lstat(source[i], &st) < 0)
 			bad = "bad source";
-		else if (lstat(destination[i], &st) == 0) {
+
+		if (S_ISDIR(st.st_mode)) {
+			const char *dir = source[i], *dest_dir = destination[i];
+			int first, last, len = strlen(dir);
+
+			if (lstat(dest_dir, &st) == 0) {
+				bad = "cannot move directory over file";
+				goto next;
+			}
+
+			modes[i] = WORKING_DIRECTORY;
+
+			first = cache_name_pos(source[i], len);
+			if (first >= 0)
+				die ("Huh? %s/ is in index?", dir);
+
+			first = -1 - first;
+			for (last = first; last < active_nr; last++) {
+				const char *path = active_cache[last]->name;
+				if (strncmp(path, dir, len) || path[len] != '/')
+					break;
+			}
+
+			if (last - first < 1)
+				bad = "source directory is empty";
+			else if (!bad) {
+				int j, dst_len = strlen(dest_dir);
+
+				if (last - first > 0) {
+					source = realloc(source,
+							(count + last - first)
+							* sizeof(char *));
+					destination = realloc(destination,
+							(count + last - first)
+							* sizeof(char *));
+					modes = realloc(modes,
+							(count + last - first)
+							* sizeof(enum update_mode));
+				}
+
+				dest_dir = add_slash(dest_dir);
+
+				for (j = 0; j < last - first; j++) {
+					const char *path =
+						active_cache[first + j]->name;
+					source[count + j] = path;
+					destination[count + j] =
+						prefix_path(dest_dir, dst_len,
+							path + len);
+					modes[count + j] = INDEX;
+				}
+				count += last - first;
+			}
+
+			goto next;
+		}
+
+		if (!bad && lstat(destination[i], &st) == 0) {
 			bad = "destination exists";
 			if (force) {
 				/*
@@ -147,6 +220,7 @@ int cmd_mv(int argc, const char **argv, 
 				path_list_insert(destination[i], &src_for_dst);
 		}
 
+next:
 		if (bad) {
 			if (ignore_errors) {
 				if (--count > 0) {
@@ -157,7 +231,7 @@ int cmd_mv(int argc, const char **argv, 
 						(count - i) * sizeof(char *));
 				}
 			} else
-				die ("Error: %s, source=%s, destination=%s",
+				die ("%s, source=%s, destination=%s",
 				     bad, source[i], destination[i]);
 		}
 	}
@@ -166,12 +240,15 @@ int cmd_mv(int argc, const char **argv, 
 		if (show_only || verbose)
 			printf("Renaming %s to %s\n",
 			       source[i], destination[i]);
-		if (!show_only &&
+		if (!show_only && modes[i] != INDEX &&
 		    rename(source[i], destination[i]) < 0 &&
 		    !ignore_errors)
 			die ("renaming %s failed: %s",
 			     source[i], strerror(errno));
 
+ 		if (modes[i] == WORKING_DIRECTORY)
+ 			continue;
+ 
 		if (cache_name_pos(source[i], strlen(source[i])) >= 0) {
 			path_list_insert(source[i], &deleted);
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 322eaad..900ca93 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -74,4 +74,8 @@ test_expect_success \
      git-diff-tree -r -M --name-status  HEAD^ HEAD | \
      grep -E "^R100.+path2/README.+path1/path2/README"'
 
+test_expect_failure \
+    'do not move directory over existing directory' \
+    'mkdir path0 && mkdir path0/path2 && git-mv path2 path0'
+
 test_done
-- 
1.4.2.rc2.g96f2-dirty
