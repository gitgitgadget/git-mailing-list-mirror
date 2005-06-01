From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff: mode bits fixes
Date: Wed, 01 Jun 2005 11:38:07 -0700
Message-ID: <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 21:46:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdZ83-0006SD-6q
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 21:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFASqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFASnn
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 14:43:43 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58567 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261162AbVFASiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2005 14:38:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050601183809.WOXU22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Jun 2005 14:38:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 01 Jun 2005 00:53:06 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The core GIT repository has trees that record regular file mode
in 0664 instead of normalized 0644 pattern.  Comparing such a
tree with another tree that records the same file in 0644
pattern without content changes with git-diff-tree causes it to
feed otherwise unmodified pairs to the diff_change() routine,
which triggers a sanity check routine and barfs.  This patch
fixes the problem, along with the fix to another caller that
uses unnormalized mode bits to call diff_change() routine in a
similar way.

Without this patch, you will see "fatal error" from diff-tree
when you run git-deltafy-script on the core GIT repository
itself.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Linus, I decided to bite the bullet and audited the callers.
*** There was only one that was not quite right, other than the
*** diff-tree one.  Please disregard the one I sent last night
*** which incorrectly said "S_ISDIR() || S_ISREG()".  Please
*** also disregard the other one that silently ignores
*** unmodified filepairs in the output routine.  Warning about
*** callers should be the most appropriate action as this
*** version does.

 diff.h       |    4 ++++
 diffcore.h   |    4 ----
 diff-files.c |    8 +++-----
 diff-tree.c  |    4 +++-
 diff.c       |   12 +++++++-----
 5 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -4,6 +4,10 @@
 #ifndef DIFF_H
 #define DIFF_H
 
+#define DIFF_FILE_CANON_MODE(mode) \
+	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
+	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
+
 extern void diff_addremove(int addremove,
 			   unsigned mode,
 			   const unsigned char *sha1,
diff --git a/diffcore.h b/diffcore.h
--- a/diffcore.h
+++ b/diffcore.h
@@ -59,10 +59,6 @@ struct diff_filepair {
 
 #define DIFF_PAIR_MODE_CHANGED(p) ((p)->one->mode != (p)->two->mode)
 
-#define DIFF_FILE_CANON_MODE(mode) \
-	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
-	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
-
 extern void diff_free_filepair(struct diff_filepair *);
 
 extern int diff_unmodified_pair(struct diff_filepair *);
diff --git a/diff-files.c b/diff-files.c
--- a/diff-files.c
+++ b/diff-files.c
@@ -88,7 +88,7 @@ int main(int argc, const char **argv)
 
 	for (i = 0; i < entries; i++) {
 		struct stat st;
-		unsigned int oldmode, mode;
+		unsigned int oldmode;
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
@@ -116,10 +116,8 @@ int main(int argc, const char **argv)
 			continue;
 
 		oldmode = ntohl(ce->ce_mode);
-		mode = (S_ISLNK(st.st_mode) ? S_IFLNK :
-			S_IFREG | ce_permissions(st.st_mode));
-
-		show_modified(oldmode, mode, ce->sha1, null_sha1,
+		show_modified(oldmode, DIFF_FILE_CANON_MODE(st.st_mode),
+			      ce->sha1, null_sha1,
 			      ce->name);
 	}
 	diffcore_std((1 < argc) ? argv + 1 : NULL,
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -44,10 +44,12 @@ static const unsigned char *extract(void
 	int len = strlen(tree)+1;
 	const unsigned char *sha1 = tree + len;
 	const char *path = strchr(tree, ' ');
+	unsigned int mode;
 
-	if (!path || size < len + 20 || sscanf(tree, "%o", modep) != 1)
+	if (!path || size < len + 20 || sscanf(tree, "%o", &mode) != 1)
 		die("corrupt tree file");
 	*pathp = path+1;
+	*modep = DIFF_FILE_CANON_MODE(mode);
 	return sha1;
 }
 
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -854,12 +854,14 @@ static void diff_resolve_rename_copy(voi
 		else if (memcmp(p->one->sha1, p->two->sha1, 20) ||
 			 p->one->mode != p->two->mode)
 			p->status = 'M';
-		else
-			/* this is a "no-change" entry.
-			 * should not happen anymore.
-			 * p->status = 'X';
+		else {
+			/* This is a "no-change" entry and should not
+			 * happen anymore, but prepare for broken callers.
 			 */
-			die("internal error in diffcore: unmodified entry remains");
+			error("feeding unmodified %s to diffcore",
+			      p->one->path);
+			p->status = 'X';
+		}
 	}
 	diff_debug_queue("resolve-rename-copy done", q);
 }
------------

