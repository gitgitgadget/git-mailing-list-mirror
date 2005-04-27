From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/6] Add -p (patch) to diff-tree.
Date: Tue, 26 Apr 2005 23:25:41 -0700
Message-ID: <7vy8b4ivmi.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfv0-0000CC-I4
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:21:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVD0G0W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVD0G0W
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:26:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50093 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261648AbVD0G0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:26:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062541.VQXH22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:25:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch uses the reworked diff interface to generate patches
directly out of diff-tree when -p is specified.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree.c |   35 ++++++++++++++++++++++++++---------
1 files changed, 26 insertions(+), 9 deletions(-)

To be tested with the following:

    GIT_INDEX_FILE=junk
    export GIT_INDEX_FILE
    rm -f junk
    date >trash ; update-cache --add trash
    t1=$(write-tree)
    date >>trash; update-cache trash
    t2=$(write-tree)    
    GIT_EXTERNAL_DIFF=echo ./diff-tree -p $t1 $t2

--- k/diff-tree.c
+++ l/diff-tree.c
@@ -1,7 +1,9 @@
 #include "cache.h"
+#include "diff.h"
 
 static int recursive = 0;
 static int line_termination = '\n';
+static int generate_patch = 0;
 
 // What paths are we interested in?
 static int nr_paths = 0;
@@ -79,10 +81,15 @@ static void show_file(const char *prefix
 		return;
 	}
 
-	printf("%s%o\t%s\t%s\t%s%s%c", prefix, mode,
-	       S_ISDIR(mode) ? "tree" : "blob",
-	       sha1_to_hex(sha1), base, path,
-	       line_termination);
+	if (generate_patch) {
+		if (!S_ISDIR(mode))
+			diff_addremove(prefix[0], mode, sha1, base, path);
+	}
+	else
+		printf("%s%06o\t%s\t%s\t%s%s%c", prefix, mode,
+		       S_ISDIR(mode) ? "tree" : "blob",
+		       sha1_to_hex(sha1), base, path,
+		       line_termination);
 }
 
 static int compare_tree_entry(void *tree1, unsigned long size1, void *tree2, unsigned long size2, const char *base)
@@ -128,11 +135,17 @@ static int compare_tree_entry(void *tree
 		return retval;
 	}
 
-	strcpy(old_sha1_hex, sha1_to_hex(sha1));
-	printf("*%o->%o\t%s\t%s->%s\t%s%s%c", mode1, mode2,
-	       S_ISDIR(mode1) ? "tree" : "blob",
-	       old_sha1_hex, sha1_to_hex(sha2), base, path1,
-	       line_termination);
+	if (generate_patch) {
+		if (!S_ISDIR(mode1))
+			diff_change(mode1, mode2, sha1, sha2, base, path1);
+	}
+	else {
+		strcpy(old_sha1_hex, sha1_to_hex(sha1));
+		printf("*%06o->%06o\t%s\t%s->%s\t%s%s%c", mode1, mode2,
+		       S_ISDIR(mode1) ? "tree" : "blob",
+		       old_sha1_hex, sha1_to_hex(sha2), base, path1,
+		       line_termination);
+	}
 	return 0;
 }
 
@@ -255,6 +268,10 @@ int main(int argc, char **argv)
 			recursive = 1;
 			continue;
 		}
+		if (!strcmp(arg, "-p")) {
+			generate_patch = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-z")) {
 			line_termination = '\0';
 			continue;

