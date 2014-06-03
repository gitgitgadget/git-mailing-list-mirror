From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Tue,  3 Jun 2014 09:09:59 -0700
Message-ID: <1401811799-5332-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jun 03 18:10:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrrI4-0004h3-2r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 18:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbaFCQKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 12:10:12 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:54476 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbaFCQKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 12:10:06 -0400
Received: by mail-oa0-f73.google.com with SMTP id g18so1386134oah.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=tW6kNGVZrRgMQ7GVmTWiynYzfI2BSxpmKW+qyum425k=;
        b=n1RIZ9lGyxXFBymi/13rCHi0tQ2YZ14eNBcq1cIX7gSK8m6qgHJNudygxSDcGmT+88
         ebajycWn0PismIP7c73YTABKcJWRyCpiI2QX4o81IxHvnSk9h5AlIJteUOsnctLr8NTj
         wGUB17eZdatdQV0NH3HhF5nJXvhtPJaMnPu1uU4kHUWB0y8TGD78KdnO/YoVZTHpHIps
         uOcR8CNqbgfsx8NXG1IhID1kA76cImz5um9vKUmIHY9961hSrVaHUPYYHD745P0QEITE
         FqEC9jyZ0W0y1N4acSq2s1epGCAMw9XeatPNfZVV3+4MS5SsM+MWRoJpyJ3FBedCWOiE
         z+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tW6kNGVZrRgMQ7GVmTWiynYzfI2BSxpmKW+qyum425k=;
        b=cx/pP0IAeZkFPHjGaaeXjqiwtT7Wrmqd0AVXasktTMzmEF89MFtkuyqWHHhlp6fu6S
         0meDwwo1jZoAUlC2na7TI7vU9Lf8rgT4iSbocmJMdA7RLnkT/5lyFFbXLIQEQC5NOZ2q
         UlJdUmDz7a8b1Hf0sWw/KvebkAlrEM+5Fu0iVlDZZ+PnwTn8re3mUYrQZlIl+iDoQ9No
         Z5kL0VDoOKcpGdxgvvrCCJJZ5yU2G8pbuTtCpAtcJglpaV9Ho+Lon75rbjtqNlHnjhcK
         NoP07QStPxUrgUHlqOA9gOErGeuEYJHUOQ1ZeWPS8teSUiFtvQN+LZtmNKPQLvLu8VWh
         9U7g==
X-Gm-Message-State: ALoCoQlzc9lD4WqvtU/ndO5dZAtIrPk56zeL4Z1RUP2BPRpZWOUmVtDpGHxUAQFjwatKKMj9gSlR
X-Received: by 10.182.28.136 with SMTP id b8mr18572628obh.19.1401811805531;
        Tue, 03 Jun 2014 09:10:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si585538yhp.6.2014.06.03.09.10.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 09:10:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 5052B31C3F0;
	Tue,  3 Jun 2014 09:10:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id E1203E0A04; Tue,  3 Jun 2014 09:10:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.527.g539d2ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250628>

read_ref_at has its own parsing of the reflog file for no really good reason
so lets change this to use the existing reflog iterators. This removes one
instance where we manually unmarshall the reflog file format.

Remove the now redundant ref_msg function.

Log messages for errors are changed slightly. We no longer print the file
name for the reflog, instead we refer to it as 'Log for ref <refname>'.
This might be a minor useability regression, but I don't really think so, since
experienced users would know where the log is anyway and inexperienced users
would not know what to do about/how to repair 'Log ... has gap ...' anyway.

Adapt the t1400 test to handle the change in log messages.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c                | 208 +++++++++++++++++++++++++-------------------------
 t/t1400-update-ref.sh |   4 +-
 2 files changed, 105 insertions(+), 107 deletions(-)

diff --git a/refs.c b/refs.c
index 6898263..29eb7eb 100644
--- a/refs.c
+++ b/refs.c
@@ -2926,119 +2926,117 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-static char *ref_msg(const char *line, const char *endp)
-{
-	const char *ep;
-	line += 82;
-	ep = memchr(line, '\n', endp - line);
-	if (!ep)
-		ep = endp;
-	return xmemdupz(line, ep - line);
+struct read_ref_at_cb {
+	const char *refname;
+	unsigned long at_time;
+	int cnt;
+	int reccnt;
+	unsigned char *sha1;
+	int found_it;
+
+	unsigned char osha1[20];
+	unsigned char nsha1[20];
+	int tz;
+	unsigned long date;
+	char **msg;
+	unsigned long *cutoff_time;
+	int *cutoff_tz;
+	int *cutoff_cnt;
+};
+
+static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct read_ref_at_cb *cb = cb_data;
+
+	cb->reccnt++;
+	cb->tz = tz;
+	cb->date = timestamp;
+
+	if (timestamp <= cb->at_time || cb->cnt == 0) {
+		if (cb->msg)
+			*cb->msg = xstrdup(message);
+		if (cb->cutoff_time)
+			*cb->cutoff_time = timestamp;
+		if (cb->cutoff_tz)
+			*cb->cutoff_tz = tz;
+		if (cb->cutoff_cnt)
+			*cb->cutoff_cnt = cb->reccnt - 1;
+		/*
+		 * we have not yet updated cb->[n|o]sha1 so they still
+		 * hold the values for the previous record.
+		 */
+		if (!is_null_sha1(cb->osha1)) {
+			hashcpy(cb->sha1, nsha1);
+			if (hashcmp(cb->osha1, nsha1))
+				warning("Log for ref %s has gap after %s.",
+					cb->refname, show_date(cb->date, cb->tz, DATE_RFC2822));
+		}
+		else if (cb->date == cb->at_time)
+			hashcpy(cb->sha1, nsha1);
+		else if (hashcmp(nsha1, cb->sha1))
+			warning("Log for ref %s unexpectedly ended on %s.",
+				cb->refname, show_date(cb->date, cb->tz,
+						   DATE_RFC2822));
+		hashcpy(cb->osha1, osha1);
+		hashcpy(cb->nsha1, nsha1);
+		cb->found_it = 1;
+		return 1;
+	}
+	hashcpy(cb->osha1, osha1);
+	hashcpy(cb->nsha1, nsha1);
+	if (cb->cnt > 0)
+		cb->cnt--;
+	return 0;
+}
+
+static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
+				  const char *email, unsigned long timestamp,
+				  int tz, const char *message, void *cb_data)
+{
+	struct read_ref_at_cb *cb = cb_data;
+
+	if (cb->msg)
+		*cb->msg = xstrdup(message);
+	if (cb->cutoff_time)
+		*cb->cutoff_time = timestamp;
+	if (cb->cutoff_tz)
+		*cb->cutoff_tz = tz;
+	if (cb->cutoff_cnt)
+		*cb->cutoff_cnt = cb->reccnt;
+	hashcpy(cb->sha1, osha1);
+	if (is_null_sha1(cb->sha1))
+		hashcpy(cb->sha1, nsha1);
+	/* We just want the first entry */
+	return 1;
 }
 
 int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 		unsigned char *sha1, char **msg,
 		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
-	const char *logfile, *logdata, *logend, *rec, *lastgt, *lastrec;
-	char *tz_c;
-	int logfd, tz, reccnt = 0;
-	struct stat st;
-	unsigned long date;
-	unsigned char logged_sha1[20];
-	void *log_mapped;
-	size_t mapsz;
+	struct read_ref_at_cb cb;
 
-	logfile = git_path("logs/%s", refname);
-	logfd = open(logfile, O_RDONLY, 0);
-	if (logfd < 0)
-		die_errno("Unable to read log '%s'", logfile);
-	fstat(logfd, &st);
-	if (!st.st_size)
-		die("Log %s is empty.", logfile);
-	mapsz = xsize_t(st.st_size);
-	log_mapped = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, logfd, 0);
-	logdata = log_mapped;
-	close(logfd);
+	memset(&cb, 0, sizeof(cb));
+	cb.refname = refname;
+	cb.at_time = at_time;
+	cb.cnt = cnt;
+	cb.msg = msg;
+	cb.cutoff_time = cutoff_time;
+	cb.cutoff_tz = cutoff_tz;
+	cb.cutoff_cnt = cutoff_cnt;
+	cb.sha1 = sha1;
+
+	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
+
+	if (!cb.reccnt)
+		die("Log for %s is empty.", refname);
+	if (cb.found_it)
+		return 0;
+
+	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
 
-	lastrec = NULL;
-	rec = logend = logdata + st.st_size;
-	while (logdata < rec) {
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
-		if (date <= at_time || cnt == 0) {
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
-					warning("Log %s has gap after %s.",
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
-					warning("Log %s unexpectedly ended on %s.",
-						logfile, show_date(date, tz, DATE_RFC2822));
-				}
-			}
-			munmap(log_mapped, mapsz);
-			return 0;
-		}
-		lastrec = rec;
-		if (cnt > 0)
-			cnt--;
-	}
-
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
-
-	if (cutoff_time)
-		*cutoff_time = date;
-	if (cutoff_tz)
-		*cutoff_tz = tz;
-	if (cutoff_cnt)
-		*cutoff_cnt = reccnt;
 	return 1;
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4e2459a..0218e96 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -235,7 +235,7 @@ test_expect_success \
 	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-26 23:33:01}" >o 2>e &&
 	 test '"$B"' = $(cat o) &&
-	 test "warning: Log .git/logs/'"$m has gap after $gd"'." = "$(cat e)"'
+	 test "warning: Log for ref '"$m has gap after $gd"'." = "$(cat e)"'
 test_expect_success \
 	'Query "master@{2005-05-26 23:38:00}" (middle of history)' \
 	'rm -f o e &&
@@ -253,7 +253,7 @@ test_expect_success \
 	'rm -f o e &&
 	 git rev-parse --verify "master@{2005-05-28}" >o 2>e &&
 	 test '"$D"' = $(cat o) &&
-	 test "warning: Log .git/logs/'"$m unexpectedly ended on $ld"'." = "$(cat e)"'
+	 test "warning: Log for ref '"$m unexpectedly ended on $ld"'." = "$(cat e)"'
 
 
 rm -f .git/$m .git/logs/$m expect
-- 
2.0.0.527.g539d2ad
