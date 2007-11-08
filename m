From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] run-command: Support sending stderr to /dev/null
Date: Thu, 8 Nov 2007 03:00:22 -0500
Message-ID: <20071108080022.GA16690@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 09:00:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq2Je-0004Is-PU
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 09:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXKHIA1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 03:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbXKHIA0
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 03:00:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60827 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbXKHIA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 03:00:26 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iq2JK-00089x-Cf; Thu, 08 Nov 2007 03:00:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 492FF20FBAE; Thu,  8 Nov 2007 03:00:22 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63950>

Some callers may wish to redirect stderr to /dev/null in some
contexts, such as if they are executing a command only to get
the exit status and don't want users to see whatever output it
may produce as a side-effect of computing that exit status.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This series replaces my earlier single patch for git-fetch to bypass
 copying objects from local alternates.  It includes (I believe)
 all comments made on the prior version.

 run-command.c |    6 ++++--
 run-command.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/run-command.c b/run-command.c
index d99a6c4..476d00c 100644
--- a/run-command.c
+++ b/run-command.c
@@ -41,7 +41,7 @@ int start_command(struct child_process *cmd)
 		cmd->close_out = 1;
 	}
 
-	need_err = cmd->err < 0;
+	need_err = !cmd->no_stderr && cmd->err < 0;
 	if (need_err) {
 		if (pipe(fderr) < 0) {
 			if (need_in)
@@ -87,7 +87,9 @@ int start_command(struct child_process *cmd)
 			close(cmd->out);
 		}
 
-		if (need_err) {
+		if (cmd->no_stderr)
+			dup_devnull(2);
+		else if (need_err) {
 			dup2(fderr[1], 2);
 			close_pair(fderr);
 		}
diff --git a/run-command.h b/run-command.h
index 94e1e9d..1fc781d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -23,6 +23,7 @@ struct child_process {
 	unsigned close_out:1;
 	unsigned no_stdin:1;
 	unsigned no_stdout:1;
+	unsigned no_stderr:1;
 	unsigned git_cmd:1; /* if this is to be git sub-command */
 	unsigned stdout_to_stderr:1;
 };
-- 
1.5.3.5.1590.gfadfad
