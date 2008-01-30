From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/7] Allow run_command stdout_to_stderr when stderr is a pipe
Date: Wed, 30 Jan 2008 01:22:00 -0500
Message-ID: <20080130062200.GB15838@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK6LO-0001Rm-Q9
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 07:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYA3GWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 01:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbYA3GWF
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 01:22:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58698 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbYA3GWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 01:22:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK6Kf-0000An-Gy; Wed, 30 Jan 2008 01:22:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0FF8120FBC9; Wed, 30 Jan 2008 01:22:00 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72031>

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
1.5.4.rc5.1126.g6ba14
