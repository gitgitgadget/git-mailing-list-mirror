From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 10:58:59 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281058190.19665@iabervon.org>
References: <87wsop188j.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUlAi-0004j1-ED
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759398AbYB1P7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757601AbYB1P7B
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:59:01 -0500
Received: from iabervon.org ([66.92.72.58]:46605 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757609AbYB1P7A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:59:00 -0500
Received: (qmail 3612 invoked by uid 1000); 28 Feb 2008 15:58:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 15:58:59 -0000
In-Reply-To: <87wsop188j.fsf@wine.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75418>

We need to rewrite the index file when we check out files, even if we
haven't modified the blob info by reading from another tree, so that
we get the stat cache to include the fact that we just modified the
file so it doesn't need to be refreshed.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-checkout.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 4a4bb8b..7c620e6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -67,17 +67,8 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 
 static int read_tree_some(struct tree *tree, const char **pathspec)
 {
-	int newfd;
-	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
-	newfd = hold_locked_index(lock_file, 1);
-	read_cache();
-
 	read_tree_recursive(tree, "", 0, 0, pathspec, update_some);
 
-	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(lock_file))
-		die("unable to write new index file");
-
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
 	 * with any non-zero return code.
@@ -85,7 +76,7 @@ static int read_tree_some(struct tree *tree, const char **pathspec)
 	return 0;
 }
 
-static int checkout_paths(const char **pathspec)
+static int checkout_paths(const char **pathspec, int newfd, struct lock_file *lock_file)
 {
 	int pos;
 	struct checkout state;
@@ -116,6 +107,10 @@ static int checkout_paths(const char **pathspec)
 		}
 	}
 
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock_file))
+		die("unable to write new index file");
+
 	resolve_ref("HEAD", rev, 0, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
 
@@ -554,11 +549,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			}
 		}
 
+		int newfd;
+		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+		newfd = hold_locked_index(lock_file, 1);
+		read_cache();
+
 		if (source_tree)
 			read_tree_some(source_tree, pathspec);
-		else
-			read_cache();
-		return checkout_paths(pathspec);
+		return checkout_paths(pathspec, newfd, lock_file);
 	}
 
 	if (new.name && !new.commit) {
-- 
1.5.4.3.328.gcaed
