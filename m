From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] apply: fix infinite loop with multiple patches with --index
Date: Tue, 09 May 2006 01:08:23 -0700
Message-ID: <1147162103958-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 10:08:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdNGp-0001pJ-0O
	for gcvg-git@gmane.org; Tue, 09 May 2006 10:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWEIIIZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 04:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWEIIIZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 04:08:25 -0400
Received: from hand.yhbt.net ([66.150.188.102]:51423 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751455AbWEIIIY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 04:08:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E06132DC035;
	Tue,  9 May 2006 01:08:23 -0700 (PDT)
To: junkio@cox.net, git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19828>

When multiple patches are passed to git-apply, it will attempt
to open multiple file descriptors to an index, which means
multiple entries will be in the circular cache_file_list.

This change makes git-apply only open the index once and
write the index at exit.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 apply.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

1d0b15a178abaf7ba61085f0acc70521bd71a961
diff --git a/apply.c b/apply.c
index 269210a..ca36391 100644
--- a/apply.c
+++ b/apply.c
@@ -19,6 +19,7 @@ #include "blob.h"
 //
 static const char *prefix;
 static int prefix_length = -1;
+static int newfd = -1;
 
 static int p_value = 1;
 static int allow_binary_replacement = 0;
@@ -1873,7 +1874,6 @@ static int use_patch(struct patch *p)
 
 static int apply_patch(int fd, const char *filename)
 {
-	int newfd;
 	unsigned long offset, size;
 	char *buffer = read_patch_file(fd, &size);
 	struct patch *list = NULL, **listp = &list;
@@ -1904,12 +1904,11 @@ static int apply_patch(int fd, const cha
 		size -= nr;
 	}
 
-	newfd = -1;
 	if (whitespace_error && (new_whitespace == error_on_whitespace))
 		apply = 0;
 
 	write_index = check_index && apply;
-	if (write_index)
+	if (write_index && newfd < 0)
 		newfd = hold_index_file_for_update(&cache_file, get_index_file());
 	if (check_index) {
 		if (read_cache() < 0)
@@ -1922,12 +1921,6 @@ static int apply_patch(int fd, const cha
 	if (apply)
 		write_out_results(list, skipped_patch);
 
-	if (write_index) {
-		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_index_file(&cache_file))
-			die("Unable to write new cachefile");
-	}
-
 	if (show_index_info)
 		show_index_list(list);
 
@@ -2085,5 +2078,12 @@ int main(int argc, char **argv)
 				whitespace_error == 1 ? "" : "s",
 				whitespace_error == 1 ? "s" : "");
 	}
+
+	if (write_index) {
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_index_file(&cache_file))
+			die("Unable to write new cachefile");
+	}
+
 	return 0;
 }
-- 
1.3.2.g45f7-dirty
