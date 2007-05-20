From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] branch: fix segfault when resolving an invalid HEAD
Date: Sun, 20 May 2007 14:19:17 +0200
Message-ID: <20070520121917.GA18850@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 20 14:19:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpkNj-0004a0-IN
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178AbXETMTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755064AbXETMTU
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:19:20 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:37594 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbXETMTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:19:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id AFCA3770008;
	Sun, 20 May 2007 14:19:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CqENDG3q9hZI; Sun, 20 May 2007 14:19:17 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 91418770002;
	Sun, 20 May 2007 14:19:17 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 86F7F6DF835; Sun, 20 May 2007 14:17:31 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 76B4B62A5D; Sun, 20 May 2007 14:19:17 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47829>

Caused by return value of resolve_ref being passed directly
to xstrdup whereby the sanity checking was never reached.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 builtin-branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

 Discovered while renaming a ref from "a/b" to "a" while redoing some
 changes. After a `git push --all`, `git branch` in the remote repo
 segfaulted, since its HEAD was still pointing to "a/b".

diff --git a/builtin-branch.c b/builtin-branch.c
index 6bd5843..a5b6bbe 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -623,9 +623,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	    (rename && force_create))
 		usage(builtin_branch_usage);
 
-	head = xstrdup(resolve_ref("HEAD", head_sha1, 0, NULL));
+	head = resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die("Failed to resolve HEAD as a valid ref.");
+	head = xstrdup(head);
 	if (!strcmp(head, "HEAD")) {
 		detached = 1;
 	}
-- 
1.5.2.rc3.800.ga489e-dirty

-- 
Jonas Fonseca
