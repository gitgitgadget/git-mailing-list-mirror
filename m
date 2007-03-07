From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] Don't run post-update hook unless a ref changed
Date: Wed, 7 Mar 2007 16:50:43 -0500
Message-ID: <20070307215043.GB28649@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:50:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP428-0004Cv-F8
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965687AbXCGVus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965686AbXCGVus
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:50:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53843 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965687AbXCGVur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:50:47 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP41s-0003RR-NB; Wed, 07 Mar 2007 16:50:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F16A120FBAE; Wed,  7 Mar 2007 16:50:43 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41692>

There is little point in executing the post-update hook if all refs
had an error and were unable to be updated.  In this case nothing
new is reachable within the repository, and there is no state change
for the post-update hook to be interested in.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index d39aeba..e32e301 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -175,14 +175,14 @@ static void run_update_post_hook(struct command *cmd)
 	int argc;
 	const char **argv;
 
-	if (access(update_post_hook, X_OK) < 0)
-		return;
-	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
+	for (argc = 0, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
 		if (cmd_p->error_string)
 			continue;
 		argc++;
 	}
-	argv = xmalloc(sizeof(*argv) * (1 + argc));
+	if (!argc || access(update_post_hook, X_OK) < 0)
+		return;
+	argv = xmalloc(sizeof(*argv) * (2 + argc));
 	argv[0] = update_post_hook;
 
 	for (argc = 1, cmd_p = cmd; cmd_p; cmd_p = cmd_p->next) {
-- 
1.5.0.3.895.g09890
