From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Add --strict switch to diff-cache to force SHA1 checking
Date: Sun, 24 Apr 2005 05:35:54 +0200
Message-ID: <20050424033554.GA23293@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 05:31:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPXpz-0003L8-N9
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 05:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVDXDgF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 23:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVDXDgF
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 23:36:05 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:37058 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262240AbVDXDfz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Apr 2005 23:35:55 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 093316E29CD; Sun, 24 Apr 2005 05:35:04 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BAD976E29B9; Sun, 24 Apr 2005 05:35:03 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 85C1761FDD; Sun, 24 Apr 2005 05:35:54 +0200 (CEST)
To: torvalds@osdl.org, pasky@ucw.cz
Mail-Followup-To: torvalds@osdl.org, pasky@ucw.cz,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Level: 
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It seems by far the easiest to let diff-cache take care of skipping
files which have not been modified. The alternative is to keep
diff-cache's lazy checking and make cogito's diff jump through hoops.
Note, although the new SHA1 signature is derived, diff-cache still
prints the special no-SHA1 for the modified file.
-

Add --strict switch to diff-cache to force it to check the SHA1
signature of modified files so files are only listed if the mode or
content changed.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

--- 3b4a5bb703599458ce8fe504f37f8e28b77bd6ca/diff-cache.c  (mode:100644 sha1:2ec6c29ab6b79a10277a2ff9021a2032d656abf0)
+++ uncommitted/diff-cache.c  (mode:100644)
@@ -1,6 +1,7 @@
 #include "cache.h"
 
 static int cached_only = 0;
+static int strict_checking = 0;
 static int line_termination = '\n';
 
 /* A file entry went away or appeared */
@@ -10,6 +11,26 @@
 	       sha1_to_hex(ce->sha1), ce->name, line_termination);
 }
 
+static int check_modified_signature(struct cache_entry *old, struct stat *st)
+{
+	void *map;
+	int ret = -1;
+	int fd = open(old->name, O_RDONLY);
+
+	if (fd < 0)
+		return -1;
+
+	map = mmap(NULL, st->st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map != MAP_FAILED) {
+		ret = check_sha1_signature(old->sha1, map, st->st_size, "blob");
+		munmap(map, st->st_size);
+	}
+
+	close(fd);
+
+	return ret;
+}
+
 static int show_modified(struct cache_entry *old, struct cache_entry *new)
 {
 	unsigned int mode = ntohl(new->ce_mode), oldmode;
@@ -27,6 +48,12 @@
 		changed = cache_match_stat(new, &st);
 		if (changed) {
 			mode = st.st_mode;
+
+			if (strict_checking
+			    && mode == ntohl(old->ce_mode)
+			    && check_modified_signature(old, &st) == 0)
+				return 0;
+
 			sha1 = no_sha1;
 		}
 	}
@@ -85,7 +112,7 @@
 	}
 }
 
-static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] <tree sha1>";
+static char *diff_cache_usage = "diff-cache [-r] [-z] [--cached] [--strict] <tree sha1>";
 
 int main(int argc, char **argv)
 {
@@ -110,6 +137,10 @@
 			cached_only = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--strict")) {
+			strict_checking = 1;
+			continue;
+		}
 		usage(diff_cache_usage);
 	}
 

-- 
Jonas Fonseca
