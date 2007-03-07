From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/5] Move post-update hook to after all other activity
Date: Wed, 7 Mar 2007 16:50:24 -0500
Message-ID: <20070307215024.GA28649@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP41n-00041X-Eq
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 22:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965689AbXCGVu2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 16:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965694AbXCGVu2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 16:50:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53821 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965689AbXCGVu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 16:50:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP41Y-0003It-W0; Wed, 07 Mar 2007 16:50:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0F12E20FBAE; Wed,  7 Mar 2007 16:50:24 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41691>

As the post-update hook is meant to run after we have completed the
receipt of the pushed changes, and it might actually try to kick off
a `repack -a -d`, we should delay on invoking it until after we have
removed the *.keep file on the uploaded pack (if we kept the pack).

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index dda9854..d39aeba 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -206,12 +206,10 @@ static void run_update_post_hook(struct command *cmd)
 static void execute_commands(void)
 {
 	struct command *cmd = commands;
-
 	while (cmd) {
 		update(cmd);
 		cmd = cmd->next;
 	}
-	run_update_post_hook(commands);
 }
 
 static void read_head_info(void)
@@ -456,6 +454,7 @@ int main(int argc, char **argv)
 			unlink(pack_lockfile);
 		if (report_status)
 			report(unpack_status);
+		run_update_post_hook(commands);
 	}
 	return 0;
 }
-- 
1.5.0.3.895.g09890
