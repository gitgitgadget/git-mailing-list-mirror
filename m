From: Nikolai Weibull <now@bitwi.se>
Subject: [PATCH] Simplify code outputting relative timestamps in git log
Date: Sun, 27 Aug 2006 16:23:28 +0200
Message-ID: <11566886081901-git-send-email-now@bitwi.se>
Cc: Nikolai Weibull <now@puritan.pcp.ath.cx>,
	Nikolai Weibull <now@bitwi.se>
X-From: git-owner@vger.kernel.org Sun Aug 27 16:23:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHLY8-00062w-4b
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 16:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWH0OXa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 10:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWH0OXa
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 10:23:30 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:39660 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932116AbWH0OX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 10:23:29 -0400
Received: from puritan.pcp.ath.cx ([83.227.79.197] [83.227.79.197])
          by mxfep02.bredband.com with ESMTP
          id <20060827142327.ZFGR11843.mxfep02.bredband.com@puritan.pcp.ath.cx>;
          Sun, 27 Aug 2006 16:23:27 +0200
Received: by puritan.pcp.ath.cx (Postfix, from userid 1000)
	id 7ACE0180D064; Sun, 27 Aug 2006 16:23:28 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26098>

From: Nikolai Weibull <now@puritan.pcp.ath.cx>

The code that outputs relative timestamps is repetitive and can be
simplified by using an array to deal with the various cutoffs.  This makes
it easier to modify and remove the cutoffs if we in the future desire to do
so.

Signed-off-by: Nikolai Weibull <now@bitwi.se>
---
 date.c |   63 +++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/date.c b/date.c
index e387dcd..5891fa8 100644
--- a/date.c
+++ b/date.c
@@ -64,6 +64,29 @@ const char *show_date(unsigned long time
 	static char timebuf[200];
 
 	if (relative) {
+		static struct {
+			char name[8];
+			unsigned long cutoff;
+			unsigned long factor;
+			unsigned long term;
+		} cutoffs[] = {
+#define CUTOFF(name, cutoff, factor, ceiling) \
+			{ (name), (cutoff) * (factor), (factor), (ceiling) }
+#define MINUTES(minutes)        ((minutes) * 60)
+#define HOURS(hours)            ((hours) * MINUTES(60))
+#define DAYS(days)              ((days) * HOURS(24))
+			CUTOFF("seconds", 90, 1, 0),
+			CUTOFF("minutes", 90, MINUTES(1), 30),
+			CUTOFF("hours", 36, HOURS(1), MINUTES(30)),
+			CUTOFF("days", 14, DAYS(1), HOURS(12)),
+			CUTOFF("weeks", 12, DAYS(7), HOURS(12)),
+			CUTOFF("months", 12, DAYS(30), HOURS(12))
+#undef MINUTES
+#undef DAYS
+#undef HOURS
+#undef CUTOFF
+		};
+		int i;
 		unsigned long diff;
 		time_t t = gm_time_t(time, tz);
 		struct timeval now;
@@ -71,39 +94,15 @@ const char *show_date(unsigned long time
 		if (now.tv_sec < t)
 			return "in the future";
 		diff = now.tv_sec - t;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
-			return timebuf;
-		}
-		/* Turn it into minutes */
-		diff = (diff + 30) / 60;
-		if (diff < 90) {
-			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
-			return timebuf;
-		}
-		/* Turn it into hours */
-		diff = (diff + 30) / 60;
-		if (diff < 36) {
-			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
-			return timebuf;
-		}
-		/* We deal with number of days from here on */
-		diff = (diff + 12) / 24;
-		if (diff < 14) {
-			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
-			return timebuf;
-		}
-		/* Say weeks for the past 10 weeks or so */
-		if (diff < 70) {
-			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
-			return timebuf;
-		}
-		/* Say months for the past 12 months or so */
-		if (diff < 360) {
-			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
-			return timebuf;
+		for (i = 0; i < ARRAY_SIZE(cutoffs); i++) {
+			if (diff < cutoffs[i].cutoff) {
+				snprintf(timebuf, sizeof(timebuf), "%lu %s ago",
+					(diff + cutoffs[i].term) / cutoffs[i].factor,
+					cutoffs[i].name);
+				return timebuf;
+			}
 		}
-		/* Else fall back on absolute format.. */
+		/* If we went beyond the month cutoff, use absolute format. */
 	}
 
 	tm = time_to_tm(time, tz);
-- 
1.4.2.GIT-dirty
