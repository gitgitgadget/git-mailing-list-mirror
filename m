From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-checkout: use struct lock_file correctly
Date: Thu, 14 Feb 2008 18:17:05 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141816120.30505@racer.site>
References: <alpine.LNX.1.00.0802071137490.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 19:18:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPieX-0001AF-2c
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 19:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYBNSRJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 13:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754058AbYBNSRI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 13:17:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:42687 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754535AbYBNSRH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 13:17:07 -0500
Received: (qmail invoked by alias); 14 Feb 2008 18:17:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 14 Feb 2008 19:17:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19lr6xBtN5lq2X6xvAiYp82dTVqhUpZSyOZsgjiLW
	kSqu3mIxUjCZtf
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802071137490.13593@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73901>


A lock_file instance must not be cleaned up, since an atexit() handler
will try to access even correctly committed lock_files, since it has
to make sure that they were correctly committed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I am using builtin checkout since quite some time, but this is the 
	first time it crashed... That fix helps; you might want to amend 
	your patch 11/11.

 builtin-checkout.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 0894eae..12000b1 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -67,14 +67,14 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 static int read_tree_some(struct tree *tree, const char **pathspec)
 {
 	int newfd;
-	struct lock_file lock_file;
-	newfd = hold_locked_index(&lock_file, 1);
+	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
+	newfd = hold_locked_index(lock_file, 1);
 	read_cache();
 
 	read_tree_recursive(tree, "", 0, 0, pathspec, update_some);
 
 	if (write_cache(newfd, active_cache, active_nr) ||
-	    commit_locked_index(&lock_file))
+	    commit_locked_index(lock_file))
 		die("unable to write new index file");
 
 	/* update the index with the given tree's info
-- 
1.5.4.1.1353.g0d5dd
