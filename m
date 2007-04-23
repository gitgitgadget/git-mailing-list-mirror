From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix handle leak in write_tree
Date: Mon, 23 Apr 2007 21:49:25 +0200
Message-ID: <20070423194925.GA5163@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 21:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg4Xi-0003QT-3r
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 21:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbXDWTta (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 15:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbXDWTt3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 15:49:29 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:52684 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbXDWTt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 15:49:28 -0400
Received: from tigra.home (Fcb75.f.strato-dslnet.de [195.4.203.117])
	by post.webmailer.de (fruni mo56) (RZmta 5.6)
	with ESMTP id H01645j3NGMtdP ; Mon, 23 Apr 2007 21:49:26 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E16C8277BD;
	Mon, 23 Apr 2007 21:49:25 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id CBA18BDDE; Mon, 23 Apr 2007 21:49:25 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsCoME=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45356>

This is a quick and dirty fix for the broken "git cherry-pick -n" on
some broken OS, which does not remove the directory entry after unlink
succeeded(!) if the file is still open somewher.
The entry is left but "protected": no open, no unlink, no stat.
Very annoying.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

That should be enough to get going, but I have to say that the
interface to lockfiles is really troublesome. Why has the caller close
a handle it didn't open? Especially if there are perfect matches for
the opening function (hold_locked_index) in form of commit and
rollback?

How about something like this (just interface):

struct lock_file
{
	struct lock_file *next;
	pid_t owner;
	int fd;
	char on_list;
	char filename[PATH_MAX];
};

struct lock_file *open_locked(const char *path, int die_on_error);
struct lock_file *open_index_locked(int die_on_error);
void commit_lock_file(struct lock_file *); /* always assuming .lock */
void rollback_lock_file(struct lock_file *);

 builtin-write-tree.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index c88bbd1..d8284b4 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -29,6 +29,7 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 
 	was_valid = cache_tree_fully_valid(active_cache_tree);
 
+	close(newfd);
 	if (!was_valid) {
 		if (cache_tree_update(active_cache_tree,
 				      active_cache, active_nr,
@@ -36,8 +37,10 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 			die("git-write-tree: error building trees");
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr)
-					&& !close(newfd))
+					&& !close(newfd)) {
 				commit_lock_file(lock_file);
+				newfd = -1;
+			}
 		}
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
@@ -55,6 +58,8 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 	else
 		hashcpy(sha1, active_cache_tree->sha1);
 
+	if (0 <= newfd)
+		close(newfd);
 	rollback_lock_file(lock_file);
 
 	return 0;
-- 
1.5.1.1.946.gdb75a
