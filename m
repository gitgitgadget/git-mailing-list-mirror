From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH 2/2] Accept the timezone specifiers [+-]hh:mm and [+-]hh in addition to [+-]hhmm
Date: Mon, 17 May 2010 21:07:11 +0200
Message-ID: <1274123231-18482-3-git-send-email-marcus@mc.pp.se>
References: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
Cc: Marcus Comstedt <marcus@mc.pp.se>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 17 21:15:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE5mp-00039I-PY
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 21:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab0EQTPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 15:15:14 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:35815 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693Ab0EQTPN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 15:15:13 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 May 2010 15:15:12 EDT
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id DD0D8DD11;
	Mon, 17 May 2010 21:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1274123266; bh=pgJFM7kgWgLFTU9iRyTQZQz0CGsUHsnxLiQE0tPYHHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Helm
	Ox/nrhSPDrNKsWzHSpY7VzQ3DVRmr9jAAJkBXH2ak/9ms8os+6A3vsVAM31YX5jawnJ
	YOGRJcG1BRCMmVy++RSJwRZ9JFkrYIHlvCN0cZ2WI79c3CU1LWFB0eeCrOqu2kp1Jma
	WGNxswJCj1vPDgyDRga2/281KWGeXEzzM=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@chiyo>)
	id 1OE5fG-0004oq-OQ; Mon, 17 May 2010 21:07:46 +0200
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1274123231-18482-1-git-send-email-marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147255>

ISO 8601 specifies three syntaxes for timezones other than "Z".
git already supports the +-hhmm syntax.  This patch adds support
for the other two: +-hh:mm and +-hh.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
:100644 100644 6bae49c... f83e46e... M	date.c
 date.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/date.c b/date.c
index 6bae49c..f83e46e 100644
--- a/date.c
+++ b/date.c
@@ -555,6 +555,18 @@ static int match_tz(const char *date, int *offp)
 	int min, hour;
 	int n = end - date - 1;
 
+	/* Check for HH:MM format, allowed by ISO 8601 */
+	if (n == 2 && date[3] == ':') {
+		char *end2;
+		min = strtoul(date+4, &end2, 10);
+		/* If we have two digits after the colon too, assume HH:MM */
+		if (end2 == date+6) {
+			offset = offset*100 + min;
+			end = end2;
+			n = end - date - 1;
+		}
+	}
+
 	min = offset % 100;
 	hour = offset / 100;
 
@@ -570,6 +582,17 @@ static int match_tz(const char *date, int *offp)
 
 		*offp = offset;
 	}
+	/*
+	 * Also accept just the hour, allowed by ISO 8601
+	 */
+	else if (n == 2 && hour == 0 && min < 24) {
+		offset = min*60;
+		if (*date == '-')
+			offset = -offset;
+
+		*offp = offset;
+	}
+
 	return end - date;
 }
 
-- 
1.7.0.4
