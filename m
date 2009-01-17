From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3 3/6] reflog: make for_each_reflog_ent use mmap
Date: Sat, 17 Jan 2009 04:30:08 +0100
Message-ID: <1232163011-20088-4-git-send-email-trast@student.ethz.ch>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
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
	id 1LO1ur-0006IU-IV
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:32:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbZAQDac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754217AbZAQDa2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:30:28 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31190 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbZAQDaO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:30:14 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:08 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2009 03:30:07.0711 (UTC) FILETIME=[E50B46F0:01C97853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106021>

Now that all building blocks have been refactored, we can implement
for_each_reflog_ent in terms of them, so that it uses mmap.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 refs.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 0a57896..3848aa0 100644
--- a/refs.c
+++ b/refs.c
@@ -1478,22 +1478,28 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 {
-	const char *logfile;
-	FILE *logfp;
-	char buf[1024];
+	const char *log_mapped, *buf, *log_end, *logfile;
+	size_t mapsz;
 	int ret = 0;
 
-	logfile = git_path("logs/%s", ref);
-	logfp = fopen(logfile, "r");
-	if (!logfp)
+	buf = log_mapped = open_reflog(ref, &mapsz, &logfile);
+	if (!log_mapped)
 		return -1;
-	while (fgets(buf, sizeof(buf), logfp)) {
+	log_end = buf + mapsz;
+
+	while (buf < log_end) {
 		unsigned char osha1[20], nsha1[20];
 		char *email, *message;
+		const char *next;
 		unsigned long timestamp;
 		int len, tz;
 
-		len = strlen(buf);
+		next = memchr(buf, '\n', log_end - buf);
+		if (next)
+			next++;
+		else
+			next = log_end;
+		len = next - buf;
 		parse_reflog_line(buf, len,
 				  osha1, nsha1,
 				  &email, &timestamp, &tz, &message,
@@ -1501,8 +1507,9 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 		ret = fn(osha1, nsha1, email, timestamp, tz, message, cb_data);
 		if (ret)
 			break;
+		buf = next;
 	}
-	fclose(logfp);
+	munmap((void*) log_mapped, mapsz);
 	return ret;
 }
 
-- 
1.6.1.315.g92577
