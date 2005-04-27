From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] Reactivate show-diff patch generation
Date: Tue, 26 Apr 2005 23:25:12 -0700
Message-ID: <7v4qdska7r.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:21:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfuP-00008p-TJ
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVD0GZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbVD0GZg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:25:36 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44191 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261644AbVD0GZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:25:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062512.BWUK20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:25:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch uses the reworked diff interface to generate patches
directly out of show-diff when -p is specified.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

show-diff.c |   56 ++++++++++++++++++++++++++++++++++++++++++--------------
1 files changed, 42 insertions(+), 14 deletions(-)

To be tested with the following:

    GIT_INDEX_FILE=junk
    export GIT_INDEX_FILE
    rm -f junk
    date >trash ; update-cache --add trash
    date >>trash;
    GIT_EXTERNAL_DIFF=echo ./show-diff -p
    update-cache --refresh
    GIT_EXTERNAL_DIFF=echo ./show-diff -p

--- k/show-diff.c
+++ l/show-diff.c
@@ -4,10 +4,11 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "diff.h"
 
-static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [paths...]";
+static const char *show_diff_usage = "show-diff [-q] [-s] [-z] [-p] [paths...]";
 
-static int recursive = 0;
+static int generate_patch = 0;
 static int line_termination = '\n';
 static int silent = 0;
 static int silent_on_nonexisting_files = 0;
@@ -27,27 +28,57 @@ static int matches_pathspec(struct cache
 	return 0;
 }
 
-static void show_file(const char *prefix, struct cache_entry *ce)
+static void show_unmerge(const char *path)
 {
-	printf("%s%o\t%s\t%s\t%s%c", prefix, ntohl(ce->ce_mode), "blob",
-		sha1_to_hex(ce->sha1), ce->name, line_termination);
+	if (generate_patch)
+		diff_unmerge(path);
+	else
+		printf("U %s%c", path, line_termination);
+}
+
+static void show_file(int pfx, struct cache_entry *ce)
+{
+	if (generate_patch)
+		diff_addremove(pfx, ntohl(ce->ce_mode), ce->sha1,
+			       ce->name, NULL);
+	else
+		printf("%c%06o\t%s\t%s\t%s%c",
+		       pfx, ntohl(ce->ce_mode), "blob",
+		       sha1_to_hex(ce->sha1), ce->name, line_termination);
+}
+
+static void show_modified(int oldmode, int mode,
+			  const char *old_sha1, const char *sha1,
+			  char *path)
+{
+	char old_sha1_hex[41];
+	strcpy(old_sha1_hex, sha1_to_hex(old_sha1));
+
+	if (generate_patch)
+		diff_change(oldmode, mode, old_sha1, sha1, path, NULL);
+	else
+		printf("*%06o->%06o\tblob\t%s->%s\t%s%c",
+		       oldmode, mode, old_sha1_hex, sha1_to_hex(sha1), path,
+		       line_termination);
 }
 
 int main(int argc, char **argv)
 {
-	static const char null_sha1_hex[] = "0000000000000000000000000000000000000000";
+	static const char null_sha1[20] = { 0, };
 	int entries = read_cache();
 	int i;
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-s"))
 			silent_on_nonexisting_files = silent = 1;
+		else if (!strcmp(argv[1], "-p"))
+			generate_patch = 1;
 		else if (!strcmp(argv[1], "-q"))
 			silent_on_nonexisting_files = 1;
 		else if (!strcmp(argv[1], "-z"))
 			line_termination = 0;
 		else if (!strcmp(argv[1], "-r"))
-			recursive = 1;		/* No-op */
+			; /* no-op */
 		else
 			usage(show_diff_usage);
 		argv++; argc--;
@@ -72,8 +103,7 @@ int main(int argc, char **argv)
 			continue;
 
 		if (ce_stage(ce)) {
-			printf("U %s%c", ce->name, line_termination);
-
+			show_unmerge(ce->name);
 			while (i < entries &&
 			       !strcmp(ce->name, active_cache[i]->name))
 				i++;
@@ -88,7 +118,7 @@ int main(int argc, char **argv)
 			}	
 			if (silent_on_nonexisting_files)
 				continue;
-			show_file("-", ce);
+			show_file('-', ce);
 			continue;
 		}
 		changed = cache_match_stat(ce, &st);
@@ -98,10 +128,8 @@ int main(int argc, char **argv)
 		oldmode = ntohl(ce->ce_mode);
 		mode = S_IFREG | ce_permissions(st.st_mode);
 
-		printf("*%o->%o\t%s\t%s->%s\t%s%c",
-			oldmode, mode, "blob",
-			sha1_to_hex(ce->sha1), null_sha1_hex,
-			ce->name, line_termination);
+		show_modified(oldmode, mode, ce->sha1, null_sha1,
+			      ce->name);
 	}
 	return 0;
 }

