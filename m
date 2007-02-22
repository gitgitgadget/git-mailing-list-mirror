From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] update-index: do not die too early in a read-only repository.
Date: Thu, 22 Feb 2007 00:30:45 -0800
Message-ID: <7vhctek30q.fsf_-_@assigned-by-dhcp.cox.net>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
	<7vmz36k33y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 22 09:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK9Lu-00085Q-VE
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 09:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbXBVIas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 03:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbXBVIar
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 03:30:47 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33454 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXBVIaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 03:30:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070222083045.XREU2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 22 Feb 2007 03:30:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SYWl1W00A1kojtg0000000; Thu, 22 Feb 2007 03:30:46 -0500
In-Reply-To: <7vmz36k33y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 22 Feb 2007 00:28:49 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40340>

This delays the error exit from hold_lock_file_for_update() in
update-index, so that "update-index --refresh" in a read-only
repository can still report what paths are stat-dirty before
exiting.

Also it makes -q to squelch the error message.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-update-index.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1ac613a..3fbdc67 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -486,6 +486,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	char set_executable_bit = 0;
 	unsigned int refresh_flags = 0;
+	int lock_error = 0;
 	struct lock_file *lock_file;
 
 	git_config(git_default_config);
@@ -493,7 +494,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 1);
+	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 0);
+	if (newfd < 0)
+		lock_error = errno;
 
 	entries = read_cache();
 	if (entries < 0)
@@ -650,6 +653,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 
  finish:
 	if (active_cache_changed) {
+		if (newfd < 0) {
+			if (refresh_flags & REFRESH_QUIET)
+				exit(128);
+			die("unable to create '%s.lock': %s",
+			    get_index_file(), strerror(lock_error));
+		}
 		if (write_cache(newfd, active_cache, active_nr) ||
 		    close(newfd) || commit_lock_file(lock_file))
 			die("Unable to write new index file");
-- 
1.5.0.1.619.g04c5c
