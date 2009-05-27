From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] refuse to merge during a merge
Date: Wed, 27 May 2009 23:04:10 +0200
Message-ID: <20090527210410.GA14742@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Olszewski <cxreg@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 23:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9QIV-0003o6-Ex
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548AbZE0VEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbZE0VEP
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 17:04:15 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:3214 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbZE0VEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 17:04:14 -0400
Received: from darc.dnsalias.org ([84.154.120.211]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 23:04:15 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M9QIE-0003wQ-8B; Wed, 27 May 2009 23:04:10 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 27 May 2009 21:04:15.0280 (UTC) FILETIME=[B13BEB00:01C9DF0E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120106>

The following is an easy mistake to make for users coming from version
control systems with an "update and commit"-style workflow.

	1. git merge
	2. resolve conflicts
	3. git pull, instead of commit

This overrides MERGE_HEAD, starting a new merge with dirty index. IOW,
probably not what the user intented. Instead, refuse to merge again if a
merge is in progress.

Reported-by: Dave Olszewski <cxreg@pobox.com>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

 builtin-merge.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 0b58e5e..74a8c8f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -836,7 +836,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	struct commit_list **remotes = &remoteheads;
 
 	setup_work_tree();
-	if (read_cache_unmerged())
+	if (read_cache_unmerged() || file_exists(git_path("MERGE_HEAD")))
 		die("You are in the middle of a conflicted merge.");
 
 	/*
-- 
1.6.3.1.147.g637c3
