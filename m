From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] for-each-reflog: fix case for empty log directory
Date: Wed, 07 Feb 2007 09:21:56 -0800
Message-ID: <7v4ppx993f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 18:33:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqUb-0000Yo-TI
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:22:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbXBGRV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161393AbXBGRV6
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:21:58 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:54530 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017AbXBGRV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:21:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207172157.KYQP1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 12:21:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LhMw1W00z1kojtg0000000; Wed, 07 Feb 2007 12:21:57 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38947>

When we remove the last reflog in a directory, opendir() would
succeed and we would iterate over its dirents, expecting retval
to be initialized to zero and setting it to non-zero only upon
seeing an error.  If the directory is empty, oops!, we do not
have anybody that touches retval.

The problem is because we initialize retval to errno even on
success from opendir(), which would leave the errno unmolested.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This bug made "git fsck --full" in fully gc'ed repository to
   report dangling commits because it did not fully walk the
   reflogs.

 refs.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 03e8dfe..7e07fc4 100644
--- a/refs.c
+++ b/refs.c
@@ -1206,7 +1206,7 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 {
 	DIR *dir = opendir(git_path("logs/%s", base));
-	int retval = errno;
+	int retval = 0;
 
 	if (dir) {
 		struct dirent *de;
@@ -1246,6 +1246,8 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 		free(log);
 		closedir(dir);
 	}
+	else
+		return errno;
 	return retval;
 }
 
-- 
1.5.0.rc3.185.g302d
