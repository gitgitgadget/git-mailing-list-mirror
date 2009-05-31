From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] refuse to merge during a merge
Date: Sun, 31 May 2009 12:43:59 +0200
Message-ID: <20090531104359.GA19094@localhost>
References: <20090527210410.GA14742@localhost> <43d8ce650905280912q71c749bn7146210a5838a453@mail.gmail.com> <20090530083721.GA12963@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dave Olszewski <cxreg@pobox.com>,
	John Tapsell <johnflux@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 12:51:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAid4-0003ZX-0G
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 12:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757244AbZEaKoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 06:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756602AbZEaKoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 06:44:16 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:9548 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZEaKoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 06:44:16 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 May 2009 12:44:17 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAiWF-00052o-W3; Sun, 31 May 2009 12:43:59 +0200
Content-Disposition: inline
In-Reply-To: <20090530083721.GA12963@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 May 2009 10:44:17.0664 (UTC) FILETIME=[BF612800:01C9E1DC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120396>

The following is an easy mistake to make for users coming from version
control systems with an "update and commit"-style workflow.

        1. git pull
        2. resolve conflicts
        3. git pull

Step 3 overrides MERGE_HEAD, starting a new merge with dirty index.
IOW, probably not what the user intented. Instead, refuse to merge
again if a merge is in progress and present the user with his options.

"git reset --hard" is not suggested, because it potentially removes
changes unrelated to the merge (if the work tree was dirty prior to
the merge).

Reported-by: Dave Olszewski <cxreg@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

Ok, since I'm not seeing any more objections. Here's the code.

Clemens

 builtin-merge.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..8169ded 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -834,10 +834,16 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list *common = NULL;
 	const char *best_strategy = NULL, *wt_strategy = NULL;
 	struct commit_list **remotes = &remoteheads;
+	int unmerged;
 
 	setup_work_tree();
-	if (read_cache_unmerged())
-		die("You are in the middle of a conflicted merge.");
+	unmerged = read_cache_unmerged();
+	if (unmerged || file_exists(git_path("MERGE_HEAD")))
+		die("You are in the middle of a %smerge. To complete "
+			"the merge %scommit the changes. To abort, "
+			"use \"git reset HEAD\".",
+			unmerged ? "conflicted " : "",
+			unmerged ? "resolve conflicts and " : "");
 
 	/*
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
-- 
1.6.3.1.147.g637c3
