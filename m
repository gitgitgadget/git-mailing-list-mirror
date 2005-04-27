From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/6] Add -p (patch) to diff-cache.
Date: Tue, 26 Apr 2005 23:26:17 -0700
Message-ID: <7vr7gwivli.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:21:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfv8-0000Cn-Qm
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVD0G0d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVD0G0d
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:26:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:499 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261667AbVD0G0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:26:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062617.JATG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:26:17 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch uses the reworked diff interface to generate patches
directly out of diff-cache when -p is specified.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |   37 ++++++++++++++++++++++++++++---------
1 files changed, 28 insertions(+), 9 deletions(-)

To be tested with the following:

    GIT_INDEX_FILE=junk
    export GIT_INDEX_FILE
    rm -f junk
    date >trash ; update-cache --add trash
    t1=$(write-tree)
    date >>trash;
    GIT_EXTERNAL_DIFF=echo ./diff-cache -p $t1
    GIT_EXTERNAL_DIFF=echo ./diff-cache -p --cached $t1
    update-cache trash
    GIT_EXTERNAL_DIFF=echo ./diff-cache -p --cached $t1

./diff-cache -p $(cat .git/HEAD) | filterdiff -i ?/diff-cache.c
--- k/diff-cache.c
+++ l/diff-cache.c
@@ -1,13 +1,20 @@
 #include "cache.h"
+#include "diff.h"
 
 static int cached_only = 0;
+static int generate_patch = 0;
 static int line_termination = '\n';
 
 /* A file entry went away or appeared */
 static void show_file(const char *prefix, struct cache_entry *ce)
 {
-	printf("%s%o\t%s\t%s\t%s%c", prefix, ntohl(ce->ce_mode), "blob",
-	       sha1_to_hex(ce->sha1), ce->name, line_termination);
+	if (generate_patch)
+		diff_addremove(prefix[0], ntohl(ce->ce_mode),
+			       ce->sha1, ce->name, NULL);
+	else
+		printf("%s%06o\tblob\t%s\t%s%c", prefix, ntohl(ce->ce_mode),
+		       sha1_to_hex(ce->sha1), ce->name,
+		       line_termination);
 }
 
 static int show_modified(struct cache_entry *old, struct cache_entry *new)
@@ -35,11 +42,15 @@ static int show_modified(struct cache_en
 	if (mode == oldmode && !memcmp(sha1, old->sha1, 20))
 		return 0;
 
-	strcpy(old_sha1_hex, sha1_to_hex(old->sha1));
-	printf("*%o->%o\t%s\t%s->%s\t%s%c", oldmode, mode,
-	       "blob",
-	       old_sha1_hex, sha1_to_hex(sha1),
-	       old->name, line_termination);
+	if (generate_patch)
+		diff_change(oldmode, mode,
+			    old->sha1, sha1, old->name, NULL);
+	else {
+		strcpy(old_sha1_hex, sha1_to_hex(old->sha1));
+		printf("*%06o->%06o\tblob\t%s->%s\t%s%c", oldmode, mode,
+		       old_sha1_hex, sha1_to_hex(sha1),
+		       old->name, line_termination);
+	}
 	return 0;
 }
 
@@ -67,7 +78,10 @@ static int diff_cache(struct cache_entry
 			}
 			/* Otherwise we fall through to the "unmerged" case */
 		case 3:
-			printf("U %s%c", ce->name, line_termination);
+			if (generate_patch)
+				diff_unmerge(ce->name);
+			else
+				printf("U %s%c", ce->name, line_termination);
 			break;
 
 		default:
@@ -102,7 +116,8 @@ static void mark_merge_entries(void)
 	}
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static char *diff_cache_usage =
+"diff-cache [-r] [-z] [-p] [--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -119,6 +134,10 @@ int main(int argc, char **argv)
 			/* We accept the -r flag just to look like diff-tree */
 			continue;
 		}
+		if (!strcmp(arg, "-p")) {
+			generate_patch = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;


