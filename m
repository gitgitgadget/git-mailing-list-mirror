From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Allow removing files in a subdirectory.
Date: Sun, 01 May 2005 04:16:17 -0700
Message-ID: <7vu0lnxkla.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:11:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSCLe-0008TJ-64
	for gcvg-git@gmane.org; Sun, 01 May 2005 13:10:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVEALQe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 07:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVEALQe
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 07:16:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45469 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261593AbVEALQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 07:16:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501111618.VIEG16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 07:16:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I found this during a conflict merge testing.  The original did
not have either DF (a file) or DF/DF (a file DF/DF under a
directory DF).  One side created DF, the other created DF/DF.  I
first resolved DF as a new file by taking what the first side
did.  After that, the entry DF/DF cannot be resolved by running
git-update-cache --remove although it does not exist on the
filesystem.

    $ /bin/ls -F
    AN  DF  MN  NM  NN  SS  Z/
    $ git-ls-files --stage | grep DF
    100644 71420ab81e254145d26d6fc0cddee64c1acd4787 0 DF
    100644 68a6d8b91da11045cf4aa3a5ab9f2a781c701249 2 DF/DF
    $ git-update-cache --remove DF/DF
    fatal: Unable to add DF/DF to database

It turns out that the errno from open() in this case was not
ENOENT but ENOTDIR, which the code did not check.  Here is a
fix.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---


BTW, Linus do you want the updates to my merge-test-script-from-hell? 


update-cache.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

# - [PATCH] Resurrect diff-tree-helper -R
# + [PATCH] Allow removing files in a subdirectory.
--- k/update-cache.c
+++ l/update-cache.c
@@ -111,7 +111,7 @@ static int add_file_to_cache(char *path)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (errno == ENOENT) {
+		if (errno == ENOENT || errno == ENOTDIR) {
 			if (allow_remove)
 				return remove_file_from_cache(path);
 		}

