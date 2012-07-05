From: Tom Xue <tomxue0126@gmail.com>
Subject: [PATCH] Can show relative date of the commit with future timestamp
Date: Fri,  6 Jul 2012 00:18:07 +0800
Message-ID: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
Cc: Tom Xue <tomxue0126@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 18:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smol7-0008IX-04
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab2GEQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 12:18:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab2GEQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 12:18:18 -0400
Received: by pbbrp8 with SMTP id rp8so12999394pbb.19
        for <git@vger.kernel.org>; Thu, 05 Jul 2012 09:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GgxjHLFs9Pml6c+iWGk3kBBRoOBpBOCZwFUgI+kIXjI=;
        b=o1abshTlJ3qCCwpREtwnZr4TC50U55N8LMJmCCdrrYfgG2HSQFU+7P7c+CVFZPSTJg
         KGetmJg+3cp1xghCs0MDUBEL53qkxukPWOipMhl1TvF2hMUOZhMyNWOK8ZNhbcBW8APa
         wPQrnTYFwKfM/1pbd18OMBvZjzsQ1X4LKTD5tpeaNi8qX1J4u7P4cq8Ur5CnGI9+1KEF
         Fnlx4c/9zeXLlQv14RDGjtBpthwjA4GqiTeilUCgEzZqqqkmRsG/Mt0F49VZVsOQk91Z
         Ygxl0EloghmJGxXr5bpqxthCvILuPRasOE0kZOHRqD6xFaqIOmcc//uQ2OQPu4AMQgPJ
         Hx4g==
Received: by 10.68.228.2 with SMTP id se2mr29456800pbc.109.1341505098539;
        Thu, 05 Jul 2012 09:18:18 -0700 (PDT)
Received: from localhost ([106.3.60.94])
        by mx.google.com with ESMTPS id np8sm20007642pbc.71.2012.07.05.09.18.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jul 2012 09:18:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201048>

---
 date.c | 186 ++++++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 125 insertions(+), 61 deletions(-)

diff --git a/date.c b/date.c
index 1fdcf7c..f1ed2ba 100644
--- a/date.c
+++ b/date.c
@@ -92,72 +92,136 @@ void show_date_relative(unsigned long time, int tz,
 {
 	unsigned long diff;
 	if (now->tv_sec < time) {
-		strbuf_addstr(timebuf, _("in the future"));
-		return;
-	}
-	diff = now->tv_sec - time;
-	if (diff < 90) {
-		strbuf_addf(timebuf,
-			 Q_("%lu second ago", "%lu seconds ago", diff), diff);
-		return;
-	}
-	/* Turn it into minutes */
-	diff = (diff + 30) / 60;
-	if (diff < 90) {
-		strbuf_addf(timebuf,
-			 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
-		return;
-	}
-	/* Turn it into hours */
-	diff = (diff + 30) / 60;
-	if (diff < 36) {
-		strbuf_addf(timebuf,
-			 Q_("%lu hour ago", "%lu hours ago", diff), diff);
-		return;
-	}
-	/* We deal with number of days from here on */
-	diff = (diff + 12) / 24;
-	if (diff < 14) {
-		strbuf_addf(timebuf,
-			 Q_("%lu day ago", "%lu days ago", diff), diff);
-		return;
-	}
-	/* Say weeks for the past 10 weeks or so */
-	if (diff < 70) {
-		strbuf_addf(timebuf,
-			 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
-			 (diff + 3) / 7);
-		return;
-	}
-	/* Say months for the past 12 months or so */
-	if (diff < 365) {
+		strbuf_addstr(timebuf, _("in the future: "));
+		diff = time - now->tv_sec;
+		if (diff < 90) {
+			strbuf_addf(timebuf,
+				 Q_("%lu second later", "%lu seconds later", diff), diff);
+			return;
+		}
+		/* Turn it into minutes */
+		diff = (diff + 30) / 60;
+		if (diff < 90) {
+			strbuf_addf(timebuf,
+				 Q_("%lu minute later", "%lu minutes later", diff), diff);
+			return;
+		}
+		/* Turn it into hours */
+		diff = (diff + 30) / 60;
+		if (diff < 36) {
+			strbuf_addf(timebuf,
+				 Q_("%lu hour later", "%lu hours later", diff), diff);
+			return;
+		}
+		/* We deal with number of days from here on */
+		diff = (diff + 12) / 24;
+		if (diff < 14) {
+			strbuf_addf(timebuf,
+				 Q_("%lu day later", "%lu days later", diff), diff);
+			return;
+		}
+		/* Say weeks for the past 10 weeks or so */
+		if (diff < 70) {
+			strbuf_addf(timebuf,
+				 Q_("%lu week later", "%lu weeks later", (diff + 3) / 7),
+				 (diff + 3) / 7);
+			return;
+		}
+		/* Say months for the past 12 months or so */
+		if (diff < 365) {
+			strbuf_addf(timebuf,
+				 Q_("%lu month later", "%lu months later", (diff + 15) / 30),
+				 (diff + 15) / 30);
+			return;
+		}
+		/* Give years and months for 5 years or so */
+		if (diff < 1825) {
+			unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
+			unsigned long years = totalmonths / 12;
+			unsigned long months = totalmonths % 12;
+			if (months) {
+				struct strbuf sb = STRBUF_INIT;
+				strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+				/* TRANSLATORS: "%s" is "<n> years" */
+				strbuf_addf(timebuf,
+					 Q_("%s, %lu month later", "%s, %lu months later", months),
+					 sb.buf, months);
+				strbuf_release(&sb);
+			} else
+				strbuf_addf(timebuf,
+					 Q_("%lu year later", "%lu years later", years), years);
+			return;
+		}
+		/* Otherwise, just years. Centuries is probably overkill. */
 		strbuf_addf(timebuf,
-			 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
-			 (diff + 15) / 30);
-		return;
+			 Q_("%lu year later", "%lu years later", (diff + 183) / 365),
+			 (diff + 183) / 365);
 	}
-	/* Give years and months for 5 years or so */
-	if (diff < 1825) {
-		unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
-		unsigned long years = totalmonths / 12;
-		unsigned long months = totalmonths % 12;
-		if (months) {
-			struct strbuf sb = STRBUF_INIT;
-			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
-			/* TRANSLATORS: "%s" is "<n> years" */
+	else {
+		diff = now->tv_sec - time;
+		if (diff < 90) {
+			strbuf_addf(timebuf,
+				 Q_("%lu second ago", "%lu seconds ago", diff), diff);
+			return;
+		}
+		/* Turn it into minutes */
+		diff = (diff + 30) / 60;
+		if (diff < 90) {
+			strbuf_addf(timebuf,
+				 Q_("%lu minute ago", "%lu minutes ago", diff), diff);
+			return;
+		}
+		/* Turn it into hours */
+		diff = (diff + 30) / 60;
+		if (diff < 36) {
 			strbuf_addf(timebuf,
-				 Q_("%s, %lu month ago", "%s, %lu months ago", months),
-				 sb.buf, months);
-			strbuf_release(&sb);
-		} else
+				 Q_("%lu hour ago", "%lu hours ago", diff), diff);
+			return;
+		}
+		/* We deal with number of days from here on */
+		diff = (diff + 12) / 24;
+		if (diff < 14) {
 			strbuf_addf(timebuf,
-				 Q_("%lu year ago", "%lu years ago", years), years);
-		return;
+				 Q_("%lu day ago", "%lu days ago", diff), diff);
+			return;
+		}
+		/* Say weeks for the past 10 weeks or so */
+		if (diff < 70) {
+			strbuf_addf(timebuf,
+				 Q_("%lu week ago", "%lu weeks ago", (diff + 3) / 7),
+				 (diff + 3) / 7);
+			return;
+		}
+		/* Say months for the past 12 months or so */
+		if (diff < 365) {
+			strbuf_addf(timebuf,
+				 Q_("%lu month ago", "%lu months ago", (diff + 15) / 30),
+				 (diff + 15) / 30);
+			return;
+		}
+		/* Give years and months for 5 years or so */
+		if (diff < 1825) {
+			unsigned long totalmonths = (diff * 12 * 2 + 365) / (365 * 2);
+			unsigned long years = totalmonths / 12;
+			unsigned long months = totalmonths % 12;
+			if (months) {
+				struct strbuf sb = STRBUF_INIT;
+				strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
+				/* TRANSLATORS: "%s" is "<n> years" */
+				strbuf_addf(timebuf,
+					 Q_("%s, %lu month ago", "%s, %lu months ago", months),
+					 sb.buf, months);
+				strbuf_release(&sb);
+			} else
+				strbuf_addf(timebuf,
+					 Q_("%lu year ago", "%lu years ago", years), years);
+			return;
+		}
+		/* Otherwise, just years. Centuries is probably overkill. */
+		strbuf_addf(timebuf,
+			 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
+			 (diff + 183) / 365);
 	}
-	/* Otherwise, just years. Centuries is probably overkill. */
-	strbuf_addf(timebuf,
-		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
-		 (diff + 183) / 365);
 }
 
 const char *show_date(unsigned long time, int tz, enum date_mode mode)
-- 
1.7.11.GIT
