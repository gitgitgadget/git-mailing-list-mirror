From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Support output ISO 8601 format dates
Date: Fri, 13 Jul 2007 22:22:58 +0200
Message-ID: <20070713202258.14107.18196.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 13 22:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9S5v-0005jc-Ep
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 22:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbXGMUu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761134AbXGMUu0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 16:50:26 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3922 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756419AbXGMUuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 16:50:25 -0400
X-Greylist: delayed 1644 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2007 16:50:25 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 057358026F4;
	Fri, 13 Jul 2007 22:15:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23672-01; Fri, 13 Jul 2007 22:15:54 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 6AFED8026DB;
	Fri, 13 Jul 2007 22:15:54 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id D546728E51;
	Fri, 13 Jul 2007 22:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id R0yigXY+9uz6; Fri, 13 Jul 2007 22:23:02 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 8EAC828A3F;
	Fri, 13 Jul 2007 22:22:58 +0200 (CEST)
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52414>

Support output of full ISO 8601 style dates in e.g. git log
and other places that use interpolation for formatting.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

 cache.h  |    2 +-
 commit.c |    6 +++++-
 date.c   |    7 +++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 5dff2f1..3dc0def 100644
--- a/cache.h
+++ b/cache.h
@@ -389,7 +389,7 @@ extern void *read_object_with_reference(const unsigned char *sha1,
 					unsigned long *size,
 					unsigned char *sha1_ret);
 
-enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT, DATE_LOCAL };
+enum date_mode { DATE_NORMAL = 0, DATE_RELATIVE, DATE_SHORT, DATE_LOCAL, DATE_ISO8601 };
 const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 const char *show_rfc2822_date(unsigned long time, int timezone);
 int parse_date(const char *date, char *buf, int bufsize);
diff --git a/commit.c b/commit.c
index 5632e32..68df3b4 100644
--- a/commit.c
+++ b/commit.c
@@ -773,6 +773,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	interp_set_entry(table, 2, show_date(date, tz, 0));
 	interp_set_entry(table, 3, show_rfc2822_date(date, tz));
 	interp_set_entry(table, 4, show_date(date, tz, 1));
+	interp_set_entry(table, 6, show_date(date, tz, DATE_ISO8601));
 }
 
 static long format_commit_message(const struct commit *commit,
@@ -791,12 +792,14 @@ static long format_commit_message(const struct commit *commit,
 		{ "%aD" },	/* author date, RFC2822 style */
 		{ "%ar" },	/* author date, relative */
 		{ "%at" },	/* author date, UNIX timestamp */
+		{ "%ai" },	/* author date, ISO 8601 */
 		{ "%cn" },	/* committer name */
 		{ "%ce" },	/* committer email */
 		{ "%cd" },	/* committer date */
 		{ "%cD" },	/* committer date, RFC2822 style */
 		{ "%cr" },	/* committer date, relative */
 		{ "%ct" },	/* committer date, UNIX timestamp */
+		{ "%ci" },	/* committer date, ISO 8601 */
 		{ "%e" },	/* encoding */
 		{ "%s" },	/* subject */
 		{ "%b" },	/* body */
@@ -813,10 +816,11 @@ static long format_commit_message(const struct commit *commit,
 		IPARENTS, IPARENTS_ABBREV,
 		IAUTHOR_NAME, IAUTHOR_EMAIL,
 		IAUTHOR_DATE, IAUTHOR_DATE_RFC2822, IAUTHOR_DATE_RELATIVE,
-		IAUTHOR_TIMESTAMP,
+		IAUTHOR_TIMESTAMP, IAUTHOR_ISO8601,
 		ICOMMITTER_NAME, ICOMMITTER_EMAIL,
 		ICOMMITTER_DATE, ICOMMITTER_DATE_RFC2822,
 		ICOMMITTER_DATE_RELATIVE, ICOMMITTER_TIMESTAMP,
+		ICOMMITTER_ISO8601,
 		IENCODING,
 		ISUBJECT,
 		IBODY,
diff --git a/date.c b/date.c
index 4690371..5155bb2 100644
--- a/date.c
+++ b/date.c
@@ -137,6 +137,13 @@ const char *show_date(unsigned long time, int tz, enum date_mode mode)
 	if (mode == DATE_SHORT)
 		sprintf(timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
+	else if (mode == DATE_ISO8601)
+		sprintf(timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+				tm->tm_year + 1900,
+				tm->tm_mon + 1,
+				tm->tm_mday,
+				tm->tm_hour, tm->tm_min, tm->tm_sec,
+				tz);
 	else
 		sprintf(timebuf, "%.3s %.3s %d %02d:%02d:%02d %d%c%+05d",
 				weekday_names[tm->tm_wday],
