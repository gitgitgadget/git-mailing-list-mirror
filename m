From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/4] add xmktime() function that always accounts for the TZ env
Date: Sat, 24 Dec 2005 04:13:39 -0800
Message-ID: <20051224121339.GB3963@mail.yhbt.net>
References: <20051224121007.GA19136@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 24 13:13:43 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eq8HO-0000Bp-Sh
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 13:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVLXMNk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Dec 2005 07:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVLXMNk
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Dec 2005 07:13:40 -0500
Received: from hand.yhbt.net ([66.150.188.102]:27523 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932519AbVLXMNk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Dec 2005 07:13:40 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 00B597DC005; Sat, 24 Dec 2005 04:13:39 -0800 (PST)
To: git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051224121007.GA19136@mail.yhbt.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14021>

This function was added because mktime in dietlibc doesn't seem to
account for the TZ env.  Also, xmktime() now shares the same
always-summer bug TZ parsing elsewhere, so at least we can
be wrong about summer consistently.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 cache.h           |    2 ++
 convert-objects.c |    4 ++--
 date.c            |   30 ++++++++++++++++++++++++++----
 3 files changed, 30 insertions(+), 6 deletions(-)

3b0763ae6fce6c69021e1216660f4c0ee301512b
diff --git a/cache.h b/cache.h
index cb87bec..c5ff4b7 100644
--- a/cache.h
+++ b/cache.h
@@ -5,6 +5,7 @@
 
 #include SHA1_HEADER
 #include <zlib.h>
+#include <time.h>
 
 #if ZLIB_VERNUM < 0x1200
 #define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
@@ -236,6 +237,7 @@ extern void *read_object_with_reference(
 
 const char *show_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
+time_t xmktime(struct tm *tm);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
 
diff --git a/convert-objects.c b/convert-objects.c
index b49bce2..0fe1229 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -178,7 +178,7 @@ static unsigned long parse_oldstyle_date
 		const char *next = strptime(buf, *fmt, &tm);
 		if (next) {
 			if (!*next)
-				return mktime(&tm);
+				return xmktime(&tm);
 			buf = next;
 		} else {
 			const char **p = timezones;
@@ -195,7 +195,7 @@ static unsigned long parse_oldstyle_date
 		fmt++;
 	} while (*buf && *fmt);
 	printf("left: %s\n", buf);
-	return mktime(&tm);				
+	return xmktime(&tm);				
 }
 
 static int convert_date_line(char *dst, void **buf, unsigned long *sp)
diff --git a/date.c b/date.c
index 3e11500..5596476 100644
--- a/date.c
+++ b/date.c
@@ -141,6 +141,28 @@ static int match_string(const char *date
 	return i;
 }
 
+time_t xmktime(struct tm *tm)
+{
+	time_t ret = my_mktime(tm);
+	char * tz = getenv("TZ");
+
+	if (tz) {
+		int i;
+		for (i = 0; i < NR_TZ; i++) {
+			int match = match_string(tz, timezone_names[i].name);
+			if (match >= 3) {
+				int off = timezone_names[i].offset;
+
+				/* This is bogus, but we like summer */
+				off += timezone_names[i].dst;
+				
+				ret += 60*off;
+			}
+		}
+	}
+	return ret;
+}
+
 static int skip_alpha(const char *date)
 {
 	int i = 0;
@@ -436,10 +458,10 @@ int parse_date(const char *date, char *r
 		date += match;
 	}
 
-	/* mktime uses local timezone */
+	/* (x)mktime uses local timezone */
 	then = my_mktime(&tm); 
 	if (offset == -1)
-		offset = (then - mktime(&tm)) / 60;
+		offset = (then - xmktime(&tm)) / 60;
 
 	if (then == -1)
 		return -1;
@@ -464,7 +486,7 @@ void datestamp(char *buf, int bufsize)
 
 static void update_tm(struct tm *tm, unsigned long sec)
 {
-	time_t n = mktime(tm) - sec;
+	time_t n = xmktime(tm) - sec;
 	localtime_r(&n, tm);
 }
 
@@ -642,5 +664,5 @@ unsigned long approxidate(const char *da
 		tm.tm_mday = number;
 	if (tm.tm_mon > now.tm_mon)
 		tm.tm_year--;
-	return mktime(&tm);
+	return xmktime(&tm);
 }
-- 
1.0.GIT
