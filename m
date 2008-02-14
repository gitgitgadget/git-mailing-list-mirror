From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/5] Finish current packfile during fast-import crash handler
Date: Thu, 14 Feb 2008 01:34:43 -0500
Message-ID: <20080214063443.GD30678@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:35:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXhD-0005F9-Qd
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762119AbYBNGet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761492AbYBNGes
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:34:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60659 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756910AbYBNGeq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:34:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXgC-0004Vg-VV; Thu, 14 Feb 2008 01:34:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A0CE020FBAE; Thu, 14 Feb 2008 01:34:43 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73857>

If fast-import is in the middle of crashing due to a protocol error
or something like that then it can be very useful to have the mark
table and all objects up until that point be available for a new
import to resume from.

Currently we just close the active packfile, unkeep all of our
newly created packfiles (so they can be deleted), and dump the
marks table to a temporary file.

We don't attempt to update the refs/tags that the process has in
memory as much of that data can be found in the crash report and I'm
not sure it would be the right thing to do under every type of crash.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 fast-import.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 117f38c..0d3449f 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -459,6 +459,10 @@ static void write_crash_report(const char *err)
 	fclose(rpt);
 }
 
+static void end_packfile(void);
+static void unkeep_all_packs(void);
+static void dump_marks(void);
+
 static NORETURN void die_nicely(const char *err, va_list params)
 {
 	static int zombie;
@@ -472,6 +476,9 @@ static NORETURN void die_nicely(const char *err, va_list params)
 	if (!zombie) {
 		zombie = 1;
 		write_crash_report(message);
+		end_packfile();
+		unkeep_all_packs();
+		dump_marks();
 	}
 	exit(128);
 }
-- 
1.5.4.1.1309.g833c2
