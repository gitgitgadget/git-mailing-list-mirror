From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] Include annotated tags in fast-import crash reports
Date: Thu, 14 Feb 2008 01:34:36 -0500
Message-ID: <20080214063436.GB30678@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXhC-0005F9-FE
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbYBNGem (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbYBNGem
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60632 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755112AbYBNGek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXg6-0004V9-LZ; Thu, 14 Feb 2008 01:34:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 00C6D20FBAE; Thu, 14 Feb 2008 01:34:36 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73861>

If annotated tags were created they exist in a different namespace
within the fast-import process' internal memory tables so we did
not export them in the inactive branch table.  Now they are written
out after the branches, in the order that they were defined by the
frontend process.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 9b71ccc..8ef607f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -430,6 +430,19 @@ static void write_crash_report(const char *err)
 			write_branch_report(rpt, b);
 	}
 
+	if (first_tag) {
+		struct tag *tg;
+		fputc('\n', rpt);
+		fputs("Annotated Tags\n", rpt);
+		fputs("--------------\n", rpt);
+		for (tg = first_tag; tg; tg = tg->next_tag) {
+			fputs(sha1_to_hex(tg->sha1), rpt);
+			fputc(' ', rpt);
+			fputs(tg->name, rpt);
+			fputc('\n', rpt);
+		}
+	}
+
 	fputc('\n', rpt);
 	fputs("-------------------\n", rpt);
 	fputs("END OF CRASH REPORT\n", rpt);
-- 
1.5.4.1.1309.g833c2
