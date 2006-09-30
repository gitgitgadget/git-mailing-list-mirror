From: Jeff King <peff@peff.net>
Subject: [PATCH] refs: refactor reflog reading code to be reusable
Date: Sat, 30 Sep 2006 17:29:18 -0400
Message-ID: <20060930212918.GA7100@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 23:29:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTmOk-0007FQ-8G
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 23:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWI3V3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 17:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbWI3V3W
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 17:29:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:12964 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751977AbWI3V3V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Sep 2006 17:29:21 -0400
Received: (qmail 12647 invoked from network); 30 Sep 2006 17:29:19 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Sep 2006 17:29:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Sep 2006 17:29:18 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28153>

This just moves code around; the behavior of read_ref_at (currently the
only user) should be identical.

Signed-off-by: Jeff King <peff@peff.net>
---
This patch is in preparation for doing more interesting things with
reflogs, like git-describe.

 refs.c |  176 +++++++++++++++++++++++++++++++++++++++------------------------
 refs.h |   21 ++++++++
 2 files changed, 130 insertions(+), 67 deletions(-)

diff --git a/refs.c b/refs.c
index 3d4cdd1..f5dfe4d 100644
--- a/refs.c
+++ b/refs.c
@@ -615,83 +615,125 @@ int write_ref_sha1(struct ref_lock *lock
 	return 0;
 }
 
-int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
+int reflog_open(struct reflog *log, const char *ref)
 {
-	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
-	char *tz_c;
-	int logfd, tz;
+	int logfd;
 	struct stat st;
-	unsigned long date;
-	unsigned char logged_sha1[20];
 
-	logfile = git_path("logs/%s", ref);
-	logfd = open(logfile, O_RDONLY, 0);
+	log->file = xstrdup(git_path("logs/%s", ref));
+	logfd = open(log->file, O_RDONLY, 0);
 	if (logfd < 0)
-		die("Unable to read log %s: %s", logfile, strerror(errno));
+		return -1;
 	fstat(logfd, &st);
-	if (!st.st_size)
-		die("Log %s is empty.", logfile);
-	logdata = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, logfd, 0);
+	log->size = st.st_size;
+	log->data = mmap(NULL, log->size, PROT_READ, MAP_PRIVATE, logfd, 0);
 	close(logfd);
+	return 0;
+}
 
-	lastrec = NULL;
-	rec = logend = logdata + st.st_size;
-	while (logdata < rec) {
-		if (logdata < rec && *(rec-1) == '\n')
-			rec--;
-		lastgt = NULL;
-		while (logdata < rec && *(rec-1) != '\n') {
-			rec--;
-			if (*rec == '>')
-				lastgt = rec;
-		}
-		if (!lastgt)
-			die("Log %s is corrupt.", logfile);
-		date = strtoul(lastgt + 1, &tz_c, 10);
-		if (date <= at_time) {
-			if (lastrec) {
-				if (get_sha1_hex(lastrec, logged_sha1))
-					die("Log %s is corrupt.", logfile);
-				if (get_sha1_hex(rec + 41, sha1))
-					die("Log %s is corrupt.", logfile);
-				if (hashcmp(logged_sha1, sha1)) {
-					tz = strtoul(tz_c, NULL, 10);
-					fprintf(stderr,
-						"warning: Log %s has gap after %s.\n",
-						logfile, show_rfc2822_date(date, tz));
-				}
-			}
-			else if (date == at_time) {
-				if (get_sha1_hex(rec + 41, sha1))
-					die("Log %s is corrupt.", logfile);
-			}
-			else {
-				if (get_sha1_hex(rec + 41, logged_sha1))
-					die("Log %s is corrupt.", logfile);
-				if (hashcmp(logged_sha1, sha1)) {
-					tz = strtoul(tz_c, NULL, 10);
-					fprintf(stderr,
-						"warning: Log %s unexpectedly ended on %s.\n",
-						logfile, show_rfc2822_date(date, tz));
-				}
-			}
-			munmap((void*)logdata, st.st_size);
+void reflog_close(struct reflog *log)
+{
+	free(log->file);
+	munmap((void *)log->data, log->size);
+}
+
+int reflog_next(struct reflog *log, struct reflog_entry *out)
+{
+	const char *rec, *lastgt;
+	char *tz_c;
+
+	rec = log->rec;
+	if (rec == log->data)
+		return 0;
+
+	lastgt = NULL;
+	if (log->data < rec && *(rec-1) == '\n')
+		rec--;
+	while (log->data < rec && *(rec-1) != '\n') {
+		rec--;
+		if (*rec == '>')
+			lastgt = rec;
+	}
+	if (log->data == rec - 1)
+		rec--;
+	if (!lastgt)
+		die("Log %s is corrupt (nolastgt).", log->file);
+
+	out->date = strtoul(lastgt + 1, &tz_c, 10);
+	out->tz = strtoul(tz_c, NULL, 10);
+	out->rec = rec;
+	out->log = log;
+	log->rec = rec;
+
+	return 1;
+}
+
+void reflog_start(struct reflog *log)
+{
+	log->rec = log->data + log->size;
+}
+
+void reflog_entry_from(const struct reflog_entry *e, unsigned char *sha1)
+{
+	if (get_sha1_hex(e->rec, sha1))
+		die("Log %s is corrupt.", e->log->file);
+}
+
+void reflog_entry_to(const struct reflog_entry *e, unsigned char *sha1)
+{
+	if (get_sha1_hex(e->rec+41, sha1))
+		die("Log %s is corrupt.", e->log->file);
+}
+
+int read_ref_at(const char *ref, unsigned long at_time, unsigned char *sha1)
+{
+	struct reflog log;
+	struct reflog_entry cur, last;
+	int last_is_valid;
+	unsigned char sha1_from[20];
+	unsigned char sha1_to[20];
+
+	if (reflog_open(&log, ref) < 0)
+		die("Unable to read log %s: %s", log.file, strerror(errno));
+
+	last_is_valid = 0;
+	reflog_start(&log);
+	do {
+		if (!reflog_next(&log, &cur)) {
+			if (!last_is_valid)
+				die("Log %s is empty.", log.file);
+			reflog_entry_to(&last, sha1);
+			fprintf(stderr,
+				"warning: Log %s only goes back to %s.\n",
+				log.file,
+				show_rfc2822_date(last.date, last.tz));
+			reflog_close(&log);
 			return 0;
 		}
-		lastrec = rec;
+		last = cur;
+		last_is_valid = 1;
+	} while (at_time < cur.date);
+
+	reflog_entry_to(&cur, sha1_to);
+	if (last_is_valid) {
+		reflog_entry_from(&last, sha1_from);
+		if (hashcmp(sha1_to, sha1_from)) {
+			fprintf(stderr,
+				"warning: Log %s has gap after %s.\n",
+				log.file,
+				show_rfc2822_date(cur.date, cur.tz));
+		}
+	}
+	else if(cur.date != at_time) {
+		if (hashcmp(sha1_to, sha1)) {
+			fprintf(stderr,
+				"warning: Log %s unexpectedly ended on %s.\n",
+				log.file,
+				show_rfc2822_date(cur.date, cur.tz));
+		}
 	}
 
-	rec = logdata;
-	while (rec < logend && *rec != '>' && *rec != '\n')
-		rec++;
-	if (rec == logend || *rec == '\n')
-		die("Log %s is corrupt.", logfile);
-	date = strtoul(rec + 1, &tz_c, 10);
-	tz = strtoul(tz_c, NULL, 10);
-	if (get_sha1_hex(logdata, sha1))
-		die("Log %s is corrupt.", logfile);
-	munmap((void*)logdata, st.st_size);
-	fprintf(stderr, "warning: Log %s only goes back to %s.\n",
-		logfile, show_rfc2822_date(date, tz));
+	reflog_close(&log);
+	hashcpy(sha1, sha1_to);
 	return 0;
 }
diff --git a/refs.h b/refs.h
index 0d4d79e..9f2667b 100644
--- a/refs.h
+++ b/refs.h
@@ -10,6 +10,20 @@ struct ref_lock {
 	int force_write;
 };
 
+struct reflog {
+	char *file;
+	const char *data;
+	unsigned long size;
+	const char *rec;
+};
+
+struct reflog_entry {
+	unsigned long date;
+	unsigned tz;
+	const char *rec;
+	const struct reflog *log;
+};
+
 /*
  * Calls the specified function for each ref file until it returns nonzero,
  * and returns the value
@@ -44,4 +58,11 @@ extern int read_ref_at(const char *ref, 
 /** Returns 0 if target has the right format for a ref. **/
 extern int check_ref_format(const char *target);
 
+int reflog_open(struct reflog *log, const char *ref);
+void reflog_close(struct reflog *log);
+void reflog_start(struct reflog *log);
+int reflog_next(struct reflog *log, struct reflog_entry *out);
+void reflog_entry_from(const struct reflog_entry *e, unsigned char *sha1);
+void reflog_entry_to(const struct reflog_entry *e, unsigned char *sha1);
+
 #endif /* REFS_H */
-- 
1.4.2.1.g67e7-dirty
