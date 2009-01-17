From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3 2/6] reflog: refactor log open+mmap
Date: Sat, 17 Jan 2009 04:30:07 +0100
Message-ID: <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:32:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1uq-0006IU-69
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbZAQDa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbZAQDaY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:30:24 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31190 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754108AbZAQDaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:30:13 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2009 03:30:07.0383 (UTC) FILETIME=[E4D93A70:01C97853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106020>

Move the open+mmap code from read_ref_at() to a separate function for
the next patch.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 refs.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index 4571fac..0a57896 100644
--- a/refs.c
+++ b/refs.c
@@ -1389,12 +1389,31 @@ static void parse_reflog_line(const char *buf, int len,
 		*message = tzstr+6;
 }
 
+static char *open_reflog(const char *ref, size_t *mapsz, const char **logfile)
+{
+	struct stat st;
+	int logfd;
+	char *map;
+
+	*logfile = git_path("logs/%s", ref);
+	logfd = open(*logfile, O_RDONLY, 0);
+	if (logfd < 0)
+		return NULL;
+	if (fstat(logfd, &st))
+		return NULL;
+
+	*mapsz = xsize_t(st.st_size);
+	map = xmmap(NULL, *mapsz, PROT_READ, MAP_PRIVATE, logfd, 0);
+	close(logfd);
+	return map;
+}
+
+
 int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
-	const char *logfile, *logdata, *logend, *rec, *start;
+	const char *logfile, *logdata, *logend, *rec, *end;
 	char *email, *message;
-	int logfd, tz, reccnt = 0;
-	struct stat st;
+	int tz, reccnt = 0;
 	unsigned long date;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
@@ -1402,28 +1421,20 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	void *log_mapped;
 	size_t mapsz;
 
-	logfile = git_path("logs/%s", ref);
-	logfd = open(logfile, O_RDONLY, 0);
-	if (logfd < 0)
+	logdata = log_mapped = open_reflog(ref, &mapsz, &logfile);
+	if (!logdata)
 		die("Unable to read log %s: %s", logfile, strerror(errno));
-	fstat(logfd, &st);
-	if (!st.st_size)
+	if (!mapsz)
 		die("Log %s is empty.", logfile);
-	mapsz = xsize_t(st.st_size);
-	log_mapped = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, logfd, 0);
-	logdata = log_mapped;
-	close(logfd);
 
-	rec = logend = logdata + st.st_size;
-	if (logdata < rec && *(rec-1) == '\n')
-		rec--;
+	rec = logend = logdata + mapsz;
 	while (logdata < rec) {
-		start = memrchr(logdata, '\n', rec-logdata);
-		if (start)
-			start++;
-		else
-			start = logdata;
-		parse_reflog_line(start, rec-start+1,
+		if (logdata < rec && rec[-1] == '\n')
+			rec--;
+		end = rec;
+		while (logdata < rec && rec[-1] != '\n')
+			rec--;
+		parse_reflog_line(rec, end-rec+1,
 				  old_sha1, new_sha1,
 				  &email, &date, &tz, &message,
 				  logfile);
@@ -1454,7 +1465,6 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 		}
 
 		hashcpy(next_sha1, old_sha1);
-		rec = start-1;
 		if (cnt > 0)
 			cnt--;
 		reccnt++;
-- 
1.6.1.315.g92577
