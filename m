From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Catch write_ref_sha1 failure in receive-pack
Date: Wed, 7 Mar 2007 12:04:24 -0500
Message-ID: <20070307170424.GA27980@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bill Lear <rael@zopyra.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 18:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOzZM-0003To-Re
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 18:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965426AbXCGRE3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965412AbXCGRE3
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 12:04:29 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43538 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965380AbXCGRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 12:04:28 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOzYq-0001nP-6a; Wed, 07 Mar 2007 12:04:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C56EC20FBAE; Wed,  7 Mar 2007 12:04:24 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41677>

This failure to catch the failure of write_ref_sha1 was noticed
by Bill Lear.  The ref will not update if the log file could not
be appended to (due to file permissions problems).  Such a failure
should be flagged as a failure to update the ref, so that the client
knows the push did not succeed.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 receive-pack.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 7f1dcc0..dda9854 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -158,7 +158,10 @@ static int update(struct command *cmd)
 			cmd->error_string = "failed to lock";
 			return error("failed to lock %s", name);
 		}
-		write_ref_sha1(lock, new_sha1, "push");
+		if (write_ref_sha1(lock, new_sha1, "push")) {
+			cmd->error_string = "failed to write";
+			return -1; /* error() already called */
+		}
 		fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
 	}
 	return 0;
-- 
1.5.0.3.895.g09890
