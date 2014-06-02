From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] refs.c: change read_ref_at to use the reflog iterators
Date: Mon,  2 Jun 2014 11:15:41 -0700
Message-ID: <1401732941-6498-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 20:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrWm8-0005hD-T5
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 20:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbaFBSPq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 14:15:46 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:59144 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbaFBSPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 14:15:44 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1034377yhl.5
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=w+jY016CAp3PZ/hyWNkZ8zkb3MPhAAptpoORv6fYOoo=;
        b=LMLBcEhCXzwkn8NT6Ud0q1of0N3D/xqD/lTfTAvnbCOwnu9jbXTMuk4S3oxr2XzQjN
         W8jzeWK3eU97BZfM/YueD3hDBXpYqeKCKjYv0YhKIIy3vderZTagjAYkQ7teCQAhzmjt
         GJxIN03uBq+toB5GmitliLMp6NjaLMLznWT5QqKJlReLDU9RnfWZWIaTWvOwqBX/0qtS
         N9CIGt6W2LgA9+ijP3B8VhH5NeJqchgV7oHsm63RzjQhraWVgER4SovrIqHJSj8dIN3r
         ERVvUB6RkS70Yu5PxJWeF4uj3XDBEDCkfls18Rejo1esv08lGvIAuVbpkyymJBimfpt9
         wFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w+jY016CAp3PZ/hyWNkZ8zkb3MPhAAptpoORv6fYOoo=;
        b=fL44UQaAJAVeCoKQceu/iBWJU1YuSCxdugnHfx8UCFhLdIzMyH5m3eyx5whHbsGQ7E
         fLS9k1Yh6igIayDqgLTseuPMQZlZLrRmsaFtHPalsx8JXnNVDEcit3+2c6/hPi3rALGC
         +iD+LjsS2tTlN9ccCC4kwWQj8CifpIy+/T6pfS3F7+y+3eu2iYQuynBFy8erdiOw330l
         zv4Vx1ttipT2OQowQ073ehwA0TjfW3vsU2yCkqda3Q4CaZai4osTfLYJpp3CwsSQQsT0
         XeRYwF6y1kIU2pIyvLcV7KZSJQFF739hXgHY5PHrhhCB3sjWGiCSeFcMvnjlK330wqYs
         eqxQ==
X-Gm-Message-State: ALoCoQm+BF16jCxvuhw+8Fll59e1TvFDksBqoWfgjIvHp+Ys5d81mw/dbEmuYJzpzk//+Jx4Fi4X
X-Received: by 10.236.176.225 with SMTP id b61mr11516994yhm.48.1401732943929;
        Mon, 02 Jun 2014 11:15:43 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si900881yhk.4.2014.06.02.11.15.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jun 2014 11:15:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B41225A4416;
	Mon,  2 Jun 2014 11:15:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1E938E0699; Mon,  2 Jun 2014 11:15:43 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.527.g539d2ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250578>

read_ref_at has its own parsing of the reflog file for no really good reason
so lets change this to use the existing reflog iterators. This removes one
instance where we manually unmarshall the reflog file format.

Log messages for errors are changed slightly. We no longer print the file
name for the reflog, instead we refer to it as 'Log for ref <refname>'.
This might be a minor useability regression, but I don't really think so, since
experienced users would know where the log is anyway and inexperienced users
would not know what to do about/how to repair 'Log ... has gap ...' anyway.

Adapt the t1400 test to handle the change in log messages.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c                | 202 ++++++++++++++++++++++++++------------------------
 t/t1400-update-ref.sh |   4 +-
 2 files changed, 107 insertions(+), 99 deletions(-)

diff --git a/refs.c b/refs.c
index 6898263..b45bb2f 100644
--- a/refs.c
+++ b/refs.c
@@ -2936,109 +2936,117 @@ static char *ref_msg(const char *line, const char *endp)
 	return xmemdupz(line, ep - line);
 }
 
+struct read_ref_at_cb {
+	const char *refname;
+	unsigned long at_time;
+	int cnt;
+	int reccnt;
+	unsigned char *sha1;
+	int found_it;
+
+	char osha1[20];
+	char nsha1[20];
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
+}
+
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
