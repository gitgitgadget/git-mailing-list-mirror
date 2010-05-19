From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH] Accept the timezone specifiers [+-]hh:mm and [+-]hh in addition to [+-]hhmm
Date: Wed, 19 May 2010 22:49:37 +0200
Message-ID: <1274302177-3573-2-git-send-email-marcus@mc.pp.se>
References: <1274302177-3573-1-git-send-email-marcus@mc.pp.se>
Cc: Marcus Comstedt <marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 19 22:50:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEqDR-0008Hq-Nb
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970Ab0ESUuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 16:50:03 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:42001 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab0ESUuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 16:50:00 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id C9348E184;
	Wed, 19 May 2010 22:49:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274302199; bh=1AA4sv/SXcnOKVz2FvPzaKx2KMKbOHaVjDwQxbg4Vnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hmAI
	AAbIC3fZxxQZIr5X3d0ennMS7UMbsjEn0B1rX9awu6V8XtKQ8W8HEyYfGVtkIJ5KbhG
	dbllT5MIIM6QePJqTrWstLoQWhJfSodbtV6tDVpCY+FiOerR/DrDCmUcJGTcXqsk8tK
	HoRYfZgyUrF89JHeauOn57MqaURtz+7zA=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OEqDH-0000wo-Io; Wed, 19 May 2010 22:49:59 +0200
X-Mailer: git-send-email 1.7.1.95.g7c1a64.dirty
In-Reply-To: <1274302177-3573-1-git-send-email-marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147347>

ISO 8601 specifies three syntaxes for timezones other than "Z".
git already supports the +-hhmm syntax.  This patch adds support
for the other two: +-hh:mm and +-hh.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
 date.c |   39 ++++++++++++++++++++++++++-------------
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/date.c b/date.c
index 6bae49c..f2cad1f 100644
--- a/date.c
+++ b/date.c
@@ -555,21 +555,34 @@ static int match_tz(const char *date, int *offp)
 	int min, hour;
 	int n = end - date - 1;
 
-	min = offset % 100;
-	hour = offset / 100;
+	if (n == 2 && offset <= 14) {
+		/* +HH:MM (ISO 8601) or +HH (ISO 8601 abbreviated) */
+		hour = offset;
+		if (date[3] == ':') {
+			min = strtoul(date + 4, &end, 10);
+			if (end != date + 6) {
+				/* there was no minute field, but we're
+				   fine with just the hour */
+				end = (char *)date + 3;
+				min = 0;
+			}
+		} else {
+			min = 0;
+		}
+	} else if (n < 3) {
+		return end - date; /* we want at least 3 digits */
+	} else {
+		min = offset % 100;
+		hour = offset / 100;
+	}
 
-	/*
-	 * Don't accept any random crap.. At least 3 digits, and
-	 * a valid minute. We might want to check that the minutes
-	 * are divisible by 30 or something too.
-	 */
-	if (min < 60 && n > 2) {
-		offset = hour*60+min;
-		if (*date == '-')
-			offset = -offset;
+	if (60 <= min)
+		return end - date; /* invalid minute */
 
-		*offp = offset;
-	}
+	offset = hour * 60 + min;
+	if (*date == '-')
+		offset = -offset;
+	*offp = offset;
 	return end - date;
 }
 
-- 
1.7.0.4
