From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Support output ISO 8601 format dates
Date: Sat, 14 Jul 2007 01:00:42 +0200
Message-ID: <20070713225836.17922.32546.stgit@lathund.dewire.com>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Jul 14 01:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9U8j-0007qF-6L
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 01:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759749AbXGMXBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 19:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757574AbXGMXBV
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 19:01:21 -0400
Received: from [83.140.172.130] ([83.140.172.130]:4981 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759714AbXGMXBU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 19:01:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 38FAF8026E5;
	Sat, 14 Jul 2007 00:54:13 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 25131-10; Sat, 14 Jul 2007 00:54:12 +0200 (CEST)
Received: from lathund.dewire.com (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id BC212800199;
	Sat, 14 Jul 2007 00:54:12 +0200 (CEST)
Received: from localhost (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id 2E1E728CC4;
	Sat, 14 Jul 2007 01:02:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost.localdomain
Received: from lathund.dewire.com ([127.0.0.1])
	by localhost (lathund.dewire.com [127.0.0.1]) (amavisd-new, port 10025)
	with LMTP id VOQuXl-h7YmS; Sat, 14 Jul 2007 01:00:45 +0200 (CEST)
Received: from lathund.dewire.com (lathund.dewire.com [127.0.0.1])
	by lathund.dewire.com (Postfix) with ESMTP id C557D28913;
	Sat, 14 Jul 2007 01:00:42 +0200 (CEST)
In-Reply-To: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net>
User-Agent: StGIT/0.12
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52420>

Support output of full ISO 8601 style dates in e.g. git log
and other places that use interpolation for formatting.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

Updated docs too. The show --date is not included because I didn't know
about it.

 Documentation/pretty-formats.txt |    2 ++
 cache.h                          |    2 +-
 commit.c                         |    6 +++++-
 date.c                           |    7 +++++++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index d922e8e..1296b31 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -106,12 +106,14 @@ The placeholders are:
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
+- '%ai': author date, ISO 8601 format
 - '%cn': committer name
 - '%ce': committer email
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
+- '%ci': committer date, ISO 8601 format
 - '%e': encoding
 - '%s': subject
 - '%b': body
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
