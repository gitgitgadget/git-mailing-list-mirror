From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3 4/6] reflog: add backwards iterator
Date: Sat, 17 Jan 2009 04:30:09 +0100
Message-ID: <1232163011-20088-5-git-send-email-trast@student.ethz.ch>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-3-git-send-email-trast@student.ethz.ch>
 <1232163011-20088-4-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:32:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1uq-0006IU-Rl
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:32:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754659AbZAQDa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754629AbZAQDa0
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:30:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31190 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbZAQDaQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:30:16 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:08 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232163011-20088-4-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2009 03:30:07.0852 (UTC) FILETIME=[E520CAC0:01C97853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106022>

Add for_each_reflog_ent_backward() which does the same as
for_each_reflog_ent(), except it traverses the reflog in backwards
(newest to oldest) order.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 refs.c |   35 +++++++++++++++++++++++++++++++++++
 refs.h |    1 +
 2 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 3848aa0..cc78f63 100644
--- a/refs.c
+++ b/refs.c
@@ -1476,6 +1476,41 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	return 1;
 }
 
+int for_each_reflog_ent_backward(const char *ref, each_reflog_ent_fn fn, void *cb_data)
+{
+	const char *log_mapped, *buf, *log_end, *logfile;
+	size_t mapsz;
+	int ret = 0;
+
+	log_mapped = open_reflog(ref, &mapsz, &logfile);
+	if (!log_mapped)
+		return -1;
+	buf = log_end = log_mapped + mapsz;
+
+	while (buf > log_mapped) {
+		unsigned char osha1[20], nsha1[20];
+		char *email, *message;
+		const char *end;
+		unsigned long timestamp;
+		int tz;
+
+		while (buf > log_mapped && buf[-1] == '\n')
+			buf--;
+		end = buf;
+		while (buf > log_mapped && buf[-1] != '\n')
+			buf--;
+		parse_reflog_line(buf, end-buf+1,
+				  osha1, nsha1,
+				  &email, &timestamp, &tz, &message,
+				  logfile);
+		ret = fn(osha1, nsha1, email, timestamp, tz, message, cb_data);
+		if (ret)
+			break;
+	}
+	munmap((void*) log_mapped, mapsz);
+	return ret;
+}
+
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 {
 	const char *log_mapped, *buf, *log_end, *logfile;
diff --git a/refs.h b/refs.h
index 06ad260..723bddc 100644
--- a/refs.h
+++ b/refs.h
@@ -60,6 +60,7 @@ struct ref_lock {
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
+int for_each_reflog_ent_backward(const char *ref, each_reflog_ent_fn fn, void *cb_data);
 
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
-- 
1.6.1.315.g92577
