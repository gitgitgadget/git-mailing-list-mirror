From: Linus Torvalds <torvalds@osdl.org>
Subject: Relative timestamps in git log
Date: Sat, 26 Aug 2006 15:45:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608261537120.11811@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Aug 27 00:45:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GH6uY-00008R-DP
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 00:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWHZWpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWHZWpd
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 18:45:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16336 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751247AbWHZWpc (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Aug 2006 18:45:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k7QMjRnW016034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 26 Aug 2006 15:45:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k7QMjQFN006443;
	Sat, 26 Aug 2006 15:45:26 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.432 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.143 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26074>


I noticed that I was looking at the kernel gitweb output at some point 
rather than just do "git log", simply because I liked seeing the 
simplified date-format, ie the "5 days ago" rather than a full date.

This adds infrastructure to do that for "git log" too. It does NOT add the 
actual flag to enable it, though, so right now this patch is a no-op, but 
it should now be easy to add a command line flag (and possibly a config 
file option) to just turn on the "relative" date format.

The exact cut-off points when it switches from days to weeks etc are 
totally arbitrary, but are picked somewhat to avoid the "1 weeks ago" 
thing (by making it show "10 days ago" rather than "1 week", or "70 
minutes ago" rather than "1 hour ago").

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
With this, and changing the ", 0" for CMIT_FMT_MEDIUM into a ", 1", I get 
output like:

	commit a7f051987c5f020e60da1e5d6ddefc3d443d3299
	Merge: 030b520... a8e0d16...
	Author: Junio C Hamano <junkio@cox.net>
	Date:   22 hours ago
	
	    Merge branch 'gl/cleanup'
	    
	    * gl/cleanup:
	      Convert memset(hash,0,20) to hashclr(hash).
	      Convert memcpy(a,b,20) to hashcpy(a,b).
	
	commit 030b52087f0a4b7b1178d34839868ce438eb2f0e
	Author: Jakub Narebski <jnareb@gmail.com>
	Date:   20 hours ago
	
	    gitweb: git_annotate didn't expect negative numeric timezone
	    
	    Signed-off-by: Jakub Narebski <jnareb@gmail.com>
	    Signed-off-by: Junio C Hamano <junkio@cox.net>
	
	commit b22d449721b22f6ec090f22c418ae6b0a560f78d
	Author: Eric Wong <normalperson@yhbt.net>
	Date:   23 hours ago
	
	    git-svn: add the 'dcommit' command
	    
	    This is a high-level wrapper around the 'commit-diff' command
	    and used to produce cleaner history against the mirrored repository
	    through rebase/reset usage.
	    
	    It's basically a more polished version of this:
	    
	    for i in `git rev-list --no-merges remotes/git-svn..HEAD | tac`; do
	        git-svn commit-diff $i~1 $i
	    done
	    git reset --hard remotes/git-svn
	    
	    Signed-off-by: Eric Wong <normalperson@yhbt.net>
	    Signed-off-by: Junio C Hamano <junkio@cox.net>

which looks quite readable..

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 7a6fa56..6c16bfa 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -54,7 +54,7 @@ static void pprint_tag(const unsigned ch
 					write_or_die(1, tagger, sp - tagger);
 					date = strtoul(sp, &ep, 10);
 					tz = strtol(ep, NULL, 10);
-					sp = show_date(date, tz);
+					sp = show_date(date, tz, 0);
 					write_or_die(1, sp, strlen(sp));
 					xwrite(1, "\n", 1);
 					break;
diff --git a/cache.h b/cache.h
index 1f212d7..ccb83a1 100644
--- a/cache.h
+++ b/cache.h
@@ -286,7 +286,7 @@ extern void *read_object_with_reference(
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-const char *show_date(unsigned long time, int timezone);
+const char *show_date(unsigned long time, int timezone, int relative);
 const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
diff --git a/commit.c b/commit.c
index 00bc3de..c3ff9b4 100644
--- a/commit.c
+++ b/commit.c
@@ -507,14 +507,14 @@ static int add_user_info(const char *wha
 	}
 	switch (fmt) {
 	case CMIT_FMT_MEDIUM:
-		ret += sprintf(buf + ret, "Date:   %s\n", show_date(time, tz));
+		ret += sprintf(buf + ret, "Date:   %s\n", show_date(time, tz, 0));
 		break;
 	case CMIT_FMT_EMAIL:
 		ret += sprintf(buf + ret, "Date: %s\n",
 			       show_rfc2822_date(time, tz));
 		break;
 	case CMIT_FMT_FULLER:
-		ret += sprintf(buf + ret, "%sDate: %s\n", what, show_date(time, tz));
+		ret += sprintf(buf + ret, "%sDate: %s\n", what, show_date(time, tz, 0));
 		break;
 	default:
 		/* notin' */
diff --git a/date.c b/date.c
index d780846..92e3f6e 100644
--- a/date.c
+++ b/date.c
@@ -37,6 +37,16 @@ static const char *weekday_names[] = {
 	"Sundays", "Mondays", "Tuesdays", "Wednesdays", "Thursdays", "Fridays", "Saturdays"
 };
 
+static time_t gm_time_t(unsigned long time, int tz)
+{
+	int minutes;
+
+	minutes = tz < 0 ? -tz : tz;
+	minutes = (minutes / 100)*60 + (minutes % 100);
+	minutes = tz < 0 ? -minutes : minutes;
+	return time + minutes * 60;
+}
+
 /*
  * The "tz" thing is passed in as this strange "decimal parse of tz"
  * thing, which means that tz -0100 is passed in as the integer -100,
@@ -44,21 +54,56 @@ static const char *weekday_names[] = {
  */
 static struct tm *time_to_tm(unsigned long time, int tz)
 {
-	time_t t;
-	int minutes;
-
-	minutes = tz < 0 ? -tz : tz;
-	minutes = (minutes / 100)*60 + (minutes % 100);
-	minutes = tz < 0 ? -minutes : minutes;
-	t = time + minutes * 60;
+	time_t t = gm_time_t(time, tz);
 	return gmtime(&t);
 }
 
-const char *show_date(unsigned long time, int tz)
+const char *show_date(unsigned long time, int tz, int relative)
 {
 	struct tm *tm;
 	static char timebuf[200];
 
+	if (relative) {
+		unsigned long diff;
+		time_t t = gm_time_t(time, tz);
+		struct timeval now;
+		gettimeofday(&now, NULL);
+		if (now.tv_sec < t)
+			return "in the future";
+		diff = now.tv_sec - t;
+		if (diff < 90) {
+			snprintf(timebuf, sizeof(timebuf), "%lu seconds ago", diff);
+			return timebuf;
+		}
+		/* Turn it into minutes */
+		diff = (diff + 30) / 60;
+		if (diff < 90) {
+			snprintf(timebuf, sizeof(timebuf), "%lu minutes ago", diff);
+			return timebuf;
+		}
+		/* Turn it into hours */
+		diff = (diff + 30) / 60;
+		if (diff < 36) {
+			snprintf(timebuf, sizeof(timebuf), "%lu hours ago", diff);
+			return timebuf;
+		}
+		/* Turn it into days */
+		diff = (diff + 12) / 24;
+		if (diff < 14) {
+			snprintf(timebuf, sizeof(timebuf), "%lu days ago", diff);
+			return timebuf;
+		}
+		if (diff < 53) {
+			snprintf(timebuf, sizeof(timebuf), "%lu weeks ago", (diff + 3) / 7);
+			return timebuf;
+		}
+		if (diff < 365) {
+			snprintf(timebuf, sizeof(timebuf), "%lu months ago", (diff + 15) / 30);
+			return timebuf;
+		}
+		/* Else fall back on absolute format.. */
+	}
+
 	tm = time_to_tm(time, tz);
 	if (!tm)
 		return NULL;
