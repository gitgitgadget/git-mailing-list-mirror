From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git status: do not require write permission
Date: Wed, 20 Jan 2010 01:06:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001200105230.3164@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 01:06:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXO5Y-0003Po-7P
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 01:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881Ab0ATAGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819Ab0ATAGU
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 19:06:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:50144 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750925Ab0ATAGU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 19:06:20 -0500
Received: (qmail invoked by alias); 20 Jan 2010 00:06:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 20 Jan 2010 01:06:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+valEVoViv6o570PjDQ8Kphp/eLzQVwVMBcqJjPY
	o0xV36sjVbeMxK
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137504>


Today, git status played violin on my nerves for the very last time.
There is no good reason, really none, for git status to require
write permissions.  If the index is not up-to-date, so be it, I
cannot commit anyway.

But in most cases, the index _is_ up-to-date, and now I can tell
my fellow former users that their repository XYZ.git does not have any
uncommitted changes, so can they please delete it to free up some disk
space, thank you very much.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 55676fd..9eccc51 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -325,11 +325,13 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	 * We still need to refresh the index here.
 	 */
 	if (!pathspec || !*pathspec) {
-		fd = hold_locked_index(&index_lock, 1);
-		refresh_cache_or_die(refresh_flags);
-		if (write_cache(fd, active_cache, active_nr) ||
-		    commit_locked_index(&index_lock))
-			die("unable to write new_index file");
+		fd = hold_locked_index(&index_lock, 0);
+		if (fd >= 0) {
+			refresh_cache_or_die(refresh_flags);
+			if (write_cache(fd, active_cache, active_nr) ||
+			    commit_locked_index(&index_lock))
+				die("unable to write new_index file");
+		}
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
-- 
1.6.4.297.gcb4cc
