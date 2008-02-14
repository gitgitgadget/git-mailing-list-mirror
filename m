From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/5] Include the fast-import marks table in crash reports
Date: Thu, 14 Feb 2008 01:34:40 -0500
Message-ID: <20080214063440.GC30678@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXhD-0005F9-4p
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759614AbYBNGeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758536AbYBNGeo
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60638 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbYBNGem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXg9-0004VD-Gt; Thu, 14 Feb 2008 01:34:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2DDC220FBC9; Thu, 14 Feb 2008 01:34:40 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73860>

If fast-import was not run with --export-marks but we are crashing
the frontend application developer may still benefit from having
that information available to them.  We now include the marks table
as part of the crash report if --export-marks was not supplied on
the command line.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 8ef607f..117f38c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -372,6 +372,8 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 	fputc('\n', rpt);
 }
 
+static void dump_marks_helper(FILE *, uintmax_t, struct mark_set *);
+
 static void write_crash_report(const char *err)
 {
 	char *loc = git_path("fast_import_crash_%d", getpid());
@@ -444,6 +446,14 @@ static void write_crash_report(const char *err)
 	}
 
 	fputc('\n', rpt);
+	fputs("Marks\n", rpt);
+	fputs("-----\n", rpt);
+	if (mark_file)
+		fprintf(rpt, "  exported to %s\n", mark_file);
+	else
+		dump_marks_helper(rpt, 0, marks);
+
+	fputc('\n', rpt);
 	fputs("-------------------\n", rpt);
 	fputs("END OF CRASH REPORT\n", rpt);
 	fclose(rpt);
-- 
1.5.4.1.1309.g833c2
