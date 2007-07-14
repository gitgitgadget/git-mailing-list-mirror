From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Make show_rfc2822_date() just another date output format.
Date: Fri, 13 Jul 2007 23:42:41 -0700
Message-ID: <7vsl7rlc4e.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
	<20070713225836.17922.32546.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 08:42:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9bLF-0003D3-Jz
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 08:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbXGNGmn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 02:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbXGNGmn
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 02:42:43 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40487 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbXGNGmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 02:42:42 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070714064242.VXPI1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Jul 2007 02:42:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PJih1X00A1kojtg0000000; Sat, 14 Jul 2007 02:42:41 -0400
In-Reply-To: <20070713225836.17922.32546.stgit@lathund.dewire.com> (Robin
	Rosenberg's message of "Sat, 14 Jul 2007 01:00:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52444>

These days, show_date() takes a date_mode parameter to specify
the output format, and a separate specialized function for dates
in E-mails does not make much sense anymore.

This retires show_rfc2822_date() function and make it just
another date output format.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Robin Rosenberg <robin.rosenberg@dewire.com> writes:

 > Updated docs too. The show --date is not included because I didn't know
 > about it.

 Thanks.  Here is what I had in mind when I "wondered" aloud earlier...

 cache.h     |   11 +++++++++--
 commit.c    |    8 ++++----
 date.c      |   20 +++++---------------
 refs.c      |    4 ++--
 sha1_name.c |    2 +-
 5 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/cache.h b/cache.h
index b39557d..328c1ad 100644
--- a/cache.h
+++ b/cache.h
@@ -409,9 +409,16 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT, DATE_LOCAL, DATE_ISO8601 };
+enum date_mode {
+	DATE_NORMAL = 0,
+	DATE_RELATIVE,
+	DATE_SHORT,
+	DATE_LOCAL,
+	DATE_ISO8601,
+	DATE_RFC2822
+};
+
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
-const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
diff --git a/commit.c b/commit.c
index d11941c..4c5dfa9 100644
--- a/commit.c
+++ b/commit.c
@@ -585,7 +585,7 @@ static int add_user_info(const char *what, enum cmit_fmt fmt, char *buf,
 		break;
 	case CMIT_FMT_EMAIL:
 		ret += sprintf(buf + ret, "Date: %s\n",
-			       show_rfc2822_date(time, tz));
+			       show_date(time, tz, DATE_RFC2822));
 		break;
 	case CMIT_FMT_FULLER:
 		ret += sprintf(buf + ret, "%sDate: %s\n", what,
@@ -778,9 +778,9 @@ static void fill_person(struct interp *table, const char *msg, int len)
 			tz = -tz;
 	}
 
-	interp_set_entry(table, 2, show_date(date, tz, 0));
-	interp_set_entry(table, 3, show_rfc2822_date(date, tz));
-	interp_set_entry(table, 4, show_date(date, tz, 1));
+	interp_set_entry(table, 2, show_date(date, tz, DATE_NORMAL));
+	interp_set_entry(table, 3, show_date(date, tz, DATE_RFC2822));
+	interp_set_entry(table, 4, show_date(date, tz, DATE_RELATIVE));
 	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
 
diff --git a/date.c b/date.c
index 735d8f3..45b0b1d 100644
--- a/date.c
+++ b/date.c
@@ -144,6 +144,11 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				tz);
+	else if (mode == DATE_RFC2822)
+		sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+			weekday_names[tm->tm_wday], tm->tm_mday,
+			month_names[tm->tm_mon], tm->tm_year + 1900,
+			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
 	else
 		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
@@ -156,21 +161,6 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	return timebuf;
 }
 
-const char *show_rfc2822_date(unsigned long time, int tz)
-{
-	struct tm *tm;
-	static char timebuf[200];
-
-	tm = time_to_tm(time, tz);
-	if (!tm)
-		return NULL;
-	sprintf(timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
-		weekday_names[tm->tm_wday], tm->tm_mday,
-		month_names[tm->tm_mon], tm->tm_year + 1900,
-		tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
-	return timebuf;
-}
-
 /*
  * Check these. And note how it doesn't do the summer-time conversion.
  *
diff --git a/refs.c b/refs.c
index 4dc7e8b..2694e70 100644
--- a/refs.c
+++ b/refs.c
@@ -1300,7 +1300,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (hashcmp(logged_sha1, sha1)) {
 					fprintf(stderr,
 						"warning: Log %s has gap after %s.\n",
-						logfile, show_rfc2822_date(date, tz));
+						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
 			else if (date == at_time) {
@@ -1313,7 +1313,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (hashcmp(logged_sha1, sha1)) {
 					fprintf(stderr,
 						"warning: Log %s unexpectedly ended on %s.\n",
-						logfile, show_rfc2822_date(date, tz));
+						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
 			munmap(log_mapped, mapsz);
diff --git a/sha1_name.c b/sha1_name.c
index 858f08c..2d727d5 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -370,7 +370,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 				fprintf(stderr,
 					"warning: Log for '%.*s' only goes "
 					"back to %s.\n", len, str,
-					show_rfc2822_date(co_time, co_tz));
+					show_date(co_time, co_tz, DATE_RFC2822));
 			else
 				fprintf(stderr,
 					"warning: Log for '%.*s' only has "
-- 
1.5.3.rc1.4.gaf83
