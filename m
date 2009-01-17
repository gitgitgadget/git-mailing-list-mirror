From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH/RFC v3 1/6] reflog: refactor parsing and checking
Date: Sat, 17 Jan 2009 04:30:06 +0100
Message-ID: <1232163011-20088-2-git-send-email-trast@student.ethz.ch>
References: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
Cc: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:32:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1uo-0006IU-HE
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773AbZAQDaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbZAQDaR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:30:17 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31190 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988AbZAQDaL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:30:11 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 17 Jan 2009 04:30:07 +0100
X-Mailer: git-send-email 1.6.1.315.g92577
In-Reply-To: <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
In-Reply-To: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 17 Jan 2009 03:30:07.0242 (UTC) FILETIME=[E4C3B6A0:01C97853]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106018>

read_ref_at() and for_each_reflog_ent() both had parsing and error
checking routines.  Refactor into a separate function that fully
parses a single entry.  Note that this switches for_each_reflog_ent()
from silently ignoring errors to die().

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 refs.c |  197 ++++++++++++++++++++++++++++++++--------------------------------
 1 files changed, 98 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 33ced65..4571fac 100644
--- a/refs.c
+++ b/refs.c
@@ -1337,24 +1337,68 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-static char *ref_msg(const char *line, const char *endp)
+/*
+ * Check and parse a single reflog line.  Assumes that there is only
+ * one newline in the range buf[0]..buf[len-1] (but does check that it
+ * is at buf[len-1]).
+ */
+static void parse_reflog_line(const char *buf, int len,
+			      unsigned char *osha1, unsigned char *nsha1,
+			      char **email,
+			      unsigned long *timestamp, int *tz,
+			      char **message,
+			      const char *logname)
 {
-	const char *ep;
-	line += 82;
-	ep = memchr(line, '\n', endp - line);
-	if (!ep)
-		ep = endp;
-	return xmemdupz(line, ep - line);
+	static char *retbuf = NULL;
+	static int retbufsz = 0;
+	char *tzstr, *email_end;
+
+	if (len < 83 || buf[len-1] != '\n')
+		die("Log %s is corrupt (entry too short or unterminated).", logname);
+
+	if (get_sha1_hex(buf, osha1) || buf[40] != ' ')
+		die("Log %s is corrupt (malformed old sha1).", logname);
+
+	if (get_sha1_hex(buf + 41, nsha1) || buf[81] != ' ')
+		die("Log %s is corrupt (malformed new sha1).", logname);
+
+	ALLOC_GROW(retbuf, len-82+1, retbufsz);
+	memcpy(retbuf, buf+82, len-82);
+	retbuf[len-82] = '\0';
+
+	email_end = strchr(retbuf, '>');
+	if (!email_end || email_end[1] != ' ')
+		die("Log %s is corrupt (malformed email field).", logname);
+
+	*email = retbuf;
+	email_end[1] = '\0';
+
+	*timestamp = strtoul(email_end + 2, &tzstr, 10);
+	if (!(*timestamp) || !tzstr || tzstr[0] != ' ' ||
+	    (tzstr[1] != '+' && tzstr[1] != '-') ||
+	    !isdigit(tzstr[2]) || !isdigit(tzstr[3]) ||
+	    !isdigit(tzstr[4]) || !isdigit(tzstr[5]))
+		die("Log %s is corrupt (malformed timezone).", logname);
+	if (!(tzstr[6] == '\t' || tzstr[6] == '\n'))
+		die("Log %s is corrupt (bad message field separator).", logname);
+	*tz = strtoul(tzstr, NULL, 10);
+
+	if (tzstr[6] == '\t')
+		*message = tzstr+7;
+	else
+		*message = tzstr+6;
 }
 
 int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
-	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
-	char *tz_c;
+	const char *logfile, *logdata, *logend, *rec, *start;
+	char *email, *message;
 	int logfd, tz, reccnt = 0;
 	struct stat st;
 	unsigned long date;
-	unsigned char logged_sha1[20];
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	unsigned char next_sha1[20];
 	void *log_mapped;
 	size_t mapsz;
 
@@ -1370,86 +1414,55 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	logdata = log_mapped;
 	close(logfd);
 
-	lastrec = NULL;
 	rec = logend = logdata + st.st_size;
+	if (logdata < rec && *(rec-1) == '\n')
+		rec--;
 	while (logdata < rec) {
-		reccnt++;
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
+		start = memrchr(logdata, '\n', rec-logdata);
+		if (start)
+			start++;
+		else
+			start = logdata;
+		parse_reflog_line(start, rec-start+1,
+				  old_sha1, new_sha1,
+				  &email, &date, &tz, &message,
+				  logfile);
+
+		if (cutoff_time)
+			*cutoff_time = date;
+		if (cutoff_tz)
+			*cutoff_tz = tz;
+		if (cutoff_cnt)
+			*cutoff_cnt = reccnt;
+		if (msg)
+			*msg = message;
+
 		if (date <= at_time || cnt == 0) {
-			tz = strtoul(tz_c, NULL, 10);
-			if (msg)
-				*msg = ref_msg(rec, logend);
-			if (cutoff_time)
-				*cutoff_time = date;
-			if (cutoff_tz)
-				*cutoff_tz = tz;
-			if (cutoff_cnt)
-				*cutoff_cnt = reccnt - 1;
-			if (lastrec) {
-				if (get_sha1_hex(lastrec, logged_sha1))
-					die("Log %s is corrupt.", logfile);
-				if (get_sha1_hex(rec + 41, sha1))
-					die("Log %s is corrupt.", logfile);
-				if (hashcmp(logged_sha1, sha1)) {
-					fprintf(stderr,
-						"warning: Log %s has gap after %s.\n",
-						logfile, show_date(date, tz, DATE_RFC2822));
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
-					fprintf(stderr,
-						"warning: Log %s unexpectedly ended on %s.\n",
-						logfile, show_date(date, tz, DATE_RFC2822));
-				}
-			}
+			if (reccnt && hashcmp(new_sha1, next_sha1))
+				fprintf(stderr,
+					"warning: Log %s has gap after %s.\n",
+					logfile, show_date(date, tz, DATE_RFC2822));
+			if (!reccnt && date < at_time && hashcmp(new_sha1, next_sha1))
+				fprintf(stderr,
+					"warning: Log %s unexpectedly ended on %s.\n",
+					logfile, show_date(date, tz, DATE_RFC2822));
+				/* leave caller's sha1 untouched */
+			else
+				hashcpy(sha1, new_sha1);
 			munmap(log_mapped, mapsz);
 			return 0;
 		}
-		lastrec = rec;
+
+		hashcpy(next_sha1, old_sha1);
+		rec = start-1;
 		if (cnt > 0)
 			cnt--;
+		reccnt++;
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
-	if (is_null_sha1(sha1)) {
-		if (get_sha1_hex(logdata + 41, sha1))
-			die("Log %s is corrupt.", logfile);
-	}
-	if (msg)
-		*msg = ref_msg(logdata, logend);
-	munmap(log_mapped, mapsz);
+	hashcpy(sha1, new_sha1);
 
-	if (cutoff_time)
-		*cutoff_time = date;
-	if (cutoff_tz)
-		*cutoff_tz = tz;
-	if (cutoff_cnt)
-		*cutoff_cnt = reccnt;
+	munmap(log_mapped, mapsz);
 	return 1;
 }
 
@@ -1466,30 +1479,16 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 		return -1;
 	while (fgets(buf, sizeof(buf), logfp)) {
 		unsigned char osha1[20], nsha1[20];
-		char *email_end, *message;
+		char *email, *message;
 		unsigned long timestamp;
 		int len, tz;
 
-		/* old SP new SP name <email> SP time TAB msg LF */
 		len = strlen(buf);
-		if (len < 83 || buf[len-1] != '\n' ||
-		    get_sha1_hex(buf, osha1) || buf[40] != ' ' ||
-		    get_sha1_hex(buf + 41, nsha1) || buf[81] != ' ' ||
-		    !(email_end = strchr(buf + 82, '>')) ||
-		    email_end[1] != ' ' ||
-		    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
-		    !message || message[0] != ' ' ||
-		    (message[1] != '+' && message[1] != '-') ||
-		    !isdigit(message[2]) || !isdigit(message[3]) ||
-		    !isdigit(message[4]) || !isdigit(message[5]))
-			continue; /* corrupt? */
-		email_end[1] = '\0';
-		tz = strtol(message + 1, NULL, 10);
-		if (message[6] != '\t')
-			message += 6;
-		else
-			message += 7;
-		ret = fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
+		parse_reflog_line(buf, len,
+				  osha1, nsha1,
+				  &email, &timestamp, &tz, &message,
+				  logfile);
+		ret = fn(osha1, nsha1, email, timestamp, tz, message, cb_data);
 		if (ret)
 			break;
 	}
-- 
1.6.1.315.g92577
