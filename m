From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Close the index file between writing and committing
Date: Sat, 8 Jul 2006 10:56:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607081055520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jul 08 10:56:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz8c5-00055K-4D
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 10:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGHI4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 04:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGHI4a
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 04:56:30 -0400
Received: from mail.gmx.de ([213.165.64.21]:14306 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750902AbWGHI4a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 04:56:30 -0400
Received: (qmail invoked by alias); 08 Jul 2006 08:56:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 08 Jul 2006 10:56:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23485>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This is just playing it safe.

	Alternatively, write_cache() could be taught to close the file
	itself, but maybe there will be a user of write_cache() who wants
	to write something after the cache data?

 builtin-add.c          |    2 +-
 builtin-apply.c        |    2 +-
 builtin-read-tree.c    |    2 +-
 builtin-rm.c           |    2 +-
 builtin-update-index.c |    2 +-
 builtin-write-tree.c   |    3 ++-
 checkout-index.c       |    2 +-
 7 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index bfbbb1b..2d25698 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -181,7 +181,7 @@ int cmd_add(int argc, const char **argv,
 
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(&lock_file))
+		    close(newfd) || commit_lock_file(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-apply.c b/builtin-apply.c
index e9ead00..c3af489 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2323,7 +2323,7 @@ int cmd_apply(int argc, const char **arg
 
 	if (write_index) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(&lock_file))
+		    close(newfd) || commit_lock_file(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 9a2099d..23a8d92 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -1038,7 +1038,7 @@ int cmd_read_tree(int argc, const char *
 	}
 
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_lock_file(&lock_file))
+	    close(newfd) || commit_lock_file(&lock_file))
 		die("unable to write new index file");
 	return 0;
 }
diff --git a/builtin-rm.c b/builtin-rm.c
index 4d56a1f..875d825 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -147,7 +147,7 @@ int cmd_rm(int argc, const char **argv, 
 
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(&lock_file))
+		    close(newfd) || commit_lock_file(&lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index ef50243..1a4200d 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -648,7 +648,7 @@ int cmd_update_index(int argc, const cha
  finish:
 	if (active_cache_changed) {
 		if (write_cache(newfd, active_cache, active_nr) ||
-		    commit_lock_file(lock_file))
+		    close(newfd) || commit_lock_file(lock_file))
 			die("Unable to write new index file");
 	}
 
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 70e9b6f..449a4d1 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -35,7 +35,8 @@ int write_tree(unsigned char *sha1, int 
 				      missing_ok, 0) < 0)
 			die("git-write-tree: error building trees");
 		if (0 <= newfd) {
-			if (!write_cache(newfd, active_cache, active_nr))
+			if (!write_cache(newfd, active_cache, active_nr)
+					&& !close(newfd))
 				commit_lock_file(lock_file);
 		}
 		/* Not being able to write is fine -- we are only interested
diff --git a/checkout-index.c b/checkout-index.c
index ea40bc2..2927955 100644
--- a/checkout-index.c
+++ b/checkout-index.c
@@ -311,7 +311,7 @@ int main(int argc, char **argv)
 
 	if (0 <= newfd &&
 	    (write_cache(newfd, active_cache, active_nr) ||
-	     commit_lock_file(&lock_file)))
+	     close(newfd) || commit_lock_file(&lock_file)))
 		die("Unable to write new index file");
 	return 0;
 }
-- 
1.4.1.rc2.g5b68a
