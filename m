From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 6/6] Alternative patch to diff-cache.c
Date: Tue, 26 Apr 2005 23:28:45 -0700
Message-ID: <7vekcwivhe.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:23:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfxY-0000QS-Gb
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVD0G3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVD0G3A
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:29:00 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:13248 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261669AbVD0G2w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:28:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062846.XODC1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:28:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a replacement of PATCH 4, in case you have already
applied the "non-cached still looks only at cache" fix I
sent you earlier.  If you took it, PATCH 4 may not apply
cleanly, in which case this should be easier to work with.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-cache.c |   73 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
1 files changed, 63 insertions(+), 10 deletions(-)

--- k/diff-cache.c
+++ l/diff-cache.c
@@ -1,13 +1,41 @@
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
+}
+
+/* A file *may* have been added to the working tree */
+static void show_possible_local_add(struct cache_entry *new)
+{
+	static unsigned char no_sha1[20];
+	struct stat st;
+	if (stat(new->name, &st) < 0)
+		/* We signal the missing file by special mode 0 and
+		 * let diff-tree-helper notice the missing file when it
+		 * tries to open it by path.  Sneaky but works.
+		 */
+		st.st_mode = 0;
+	else if (cache_match_stat(new, &st))
+		return show_file("+", new);
+
+	if (generate_patch)
+		diff_addremove('+', st.st_mode, no_sha1, new->name, NULL);
+	else
+		printf("+%06o\tblob\t%s\t%s%c", st.st_mode,
+		       sha1_to_hex(no_sha1), new->name, line_termination);
 }
 
 static int show_modified(struct cache_entry *old, struct cache_entry *new)
@@ -35,11 +63,15 @@ static int show_modified(struct cache_en
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
 
@@ -54,20 +86,36 @@ static int diff_cache(struct cache_entry
 			/* No stage 1 entry? That means it's a new file */
 			if (!same) {
 				show_file("+", ce);
+				/* ... not so fast.  The working tree may
+				 * also not have it anymore.
+				 */
+				if (cached_only)
+					show_file("+", ce);
+				else
+					show_possible_local_add(ce);
 				break;
 			}
 			/* Show difference between old and new */
 			show_modified(ac[1], ce);
 			break;
 		case 1:
-			/* No stage 3 (merge) entry? That means it's been deleted */
+			/* No stage 3 (merge) entry? That means it's been
+			 * deleted.
+			 */
 			if (!same) {
+				/* The working tree may have it, but it does
+				 * not matter.  If you write-tree and commit
+				 * you would lose that file, so take notice.
+				 */
 				show_file("-", ce);
 				break;
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
@@ -102,7 +150,8 @@ static void mark_merge_entries(void)
 	}
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static char *diff_cache_usage =
+"diff-cache [-r] [-z] [-p] [--cached] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -119,6 +168,10 @@ int main(int argc, char **argv)
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

