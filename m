From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH v2] Write index file on any checkout of files
Date: Thu, 28 Feb 2008 16:52:44 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802281652160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqgx-00038n-DE
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755346AbYB1Vws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755100AbYB1Vws
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:52:48 -0500
Received: from iabervon.org ([66.92.72.58]:38921 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754372AbYB1Vwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:52:47 -0500
Received: (qmail 29053 invoked by uid 1000); 28 Feb 2008 21:52:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Feb 2008 21:52:44 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75466>

We need to rewrite the index file when we check out files, even if we
haven't modified the blob info by reading from another tree, so that
we get the stat cache to include the fact that we just modified the
file so it doesn't need to be refreshed.

While we're at it, move everything that needs to be done to check out
some paths from a tree (or the current index) into checkout_paths().

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-checkout.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 4a4bb8b..007572e 100644
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
+static int checkout_paths(struct tree *source_tree, const char **pathspec)
 {
 	int pos;
 	struct checkout state;
@@ -94,6 +85,15 @@ static int checkout_paths(const char **pathspec)
 	int flag;
 	struct commit *head;
 
+	int newfd;
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+
+	newfd = hold_locked_index(lock_file, 1);
+	read_cache();
+
+	if (source_tree)
+		read_tree_some(source_tree, pathspec);
+
 	for (pos = 0; pathspec[pos]; pos++)
 		;
 	ps_matched = xcalloc(1, pos);
@@ -116,6 +116,10 @@ static int checkout_paths(const char **pathspec)
 		}
 	}
 
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock_file))
+		die("unable to write new index file");
+
 	resolve_ref("HEAD", rev, 0, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
 
@@ -554,11 +558,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			}
 		}
 
-		if (source_tree)
-			read_tree_some(source_tree, pathspec);
-		else
-			read_cache();
-		return checkout_paths(pathspec);
+		return checkout_paths(source_tree, pathspec);
 	}
 
 	if (new.name && !new.commit) {
-- 
1.5.4.3.327.g614d7.dirty
