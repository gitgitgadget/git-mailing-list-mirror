From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/8] Switch to run_command_v_opt in revert
Date: Sat, 10 Mar 2007 03:27:28 -0500
Message-ID: <20070310082728.GA4133@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwvT-0003HZ-W3
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933564AbXCJI1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933572AbXCJI1e
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:27:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60110 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933564AbXCJI1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:27:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwvJ-0003Yv-9q; Sat, 10 Mar 2007 03:27:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B0A4A20FBAE; Sat, 10 Mar 2007 03:27:28 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41854>

Another change by me is removing the va_list variants of run_command,
one of which is used by builtin-revert.c.  To avoid compile errors
I'm refactoring builtin-revert to use the char** variant instead,
as that variant is staying.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is on top of Dscho's builtin revert topic, currently in next.
 The rest of this series is however on top of master.

 builtin-revert.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 2f2dc1b..652eece 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -207,6 +207,7 @@ static int merge_recursive(const char *base_sha1,
 		const char *next_sha1, const char *next_name)
 {
 	char buffer[256];
+	const char *argv[6];
 
 	sprintf(buffer, "GITHEAD_%s", head_sha1);
 	setenv(buffer, head_name, 1);
@@ -219,10 +220,14 @@ static int merge_recursive(const char *base_sha1,
 	 * and $prev on top of us (when reverting), or the change between
 	 * $prev and $commit on top of us (when cherry-picking or replaying).
 	 */
-
-	return run_command_opt(RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
-			"merge-recursive", base_sha1, "--",
-			head_sha1, next_sha1, NULL);
+	argv[0] = "merge-recursive";
+	argv[1] = base_sha1;
+	argv[2] = "--";
+	argv[3] = head_sha1;
+	argv[4] = next_sha1;
+	argv[5] = NULL;
+
+	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
 }
 
 static int revert_or_cherry_pick(int argc, const char **argv)
-- 
1.5.0.3.942.g299f
