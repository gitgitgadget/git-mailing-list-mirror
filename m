From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/6] Allow run_command stdout_to_stderr when stderr is a pipe
Date: Thu, 14 Feb 2008 01:22:19 -0500
Message-ID: <20080214062219.GA30516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 14 07:23:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXUr-0002uF-NM
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbYBNGWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752955AbYBNGWX
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:22:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58324 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbYBNGWW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:22:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXUC-0003my-Um
	for git@vger.kernel.org; Thu, 14 Feb 2008 01:22:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 64C4E20FBAE; Thu, 14 Feb 2008 01:22:19 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73850>

To allow receive-pack hooks to have their stdout and stderr streams
redirected to the same pipe we need to setup the pipe on fd 2 before
we dup fd 2 over to fd 1.  This way we can use a single pipe to
capture both stdout and stderr and redirect it to a sideband channel,
or elsewhere.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 run-command.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/run-command.c b/run-command.c
index 476d00c..52f80be 100644
--- a/run-command.c
+++ b/run-command.c
@@ -75,6 +75,13 @@ int start_command(struct child_process *cmd)
 			close(cmd->in);
 		}
 
+		if (cmd->no_stderr)
+			dup_devnull(2);
+		else if (need_err) {
+			dup2(fderr[1], 2);
+			close_pair(fderr);
+		}
+
 		if (cmd->no_stdout)
 			dup_devnull(1);
 		else if (cmd->stdout_to_stderr)
@@ -87,13 +94,6 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
-		if (cmd->no_stderr)
-			dup_devnull(2);
-		else if (need_err) {
-			dup2(fderr[1], 2);
-			close_pair(fderr);
-		}
-
 		if (cmd->dir && chdir(cmd->dir))
 			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
 			    cmd->dir, strerror(errno));
-- 
1.5.4.1.1309.g833c2
