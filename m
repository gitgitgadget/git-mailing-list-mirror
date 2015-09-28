From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 07/43] refs.c: move read_ref_at to the common refs file
Date: Mon, 28 Sep 2015 18:01:42 -0400
Message-ID: <1443477738-32023-8-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:03:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggVq-0000Zd-98
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:03:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbbI1WDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:03:06 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36830 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253AbbI1WDE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:04 -0400
Received: by qgx61 with SMTP id 61so133692966qgx.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WvvPb3JUzvpZX1ChKeW/lBxC1/hwcowUsLtLD6KFrFY=;
        b=Dfu8DahWE9gceBI6ms95s5i4heA5L1FI/CA+WqGPyKqztIgItRfSr6MuZr6NZyrJV8
         iDdcp+W+5aXvkXdKcShhY7GLBlORBlLhVua1NPEFjP7WYejUErbRyFgkYVgpqvV170Wt
         j4YdKE6s6Kt1m/0R7JpBXoNVKZ8h3wvpPTpOT2+v5G48s5WonCCNQcCtNEyePSJpXgY4
         RcLztH/gNipzCcXJ7kYlQ4uSgiIZV0PIG8rlQw5b/HBqD7h8S63XPp1ZRDB2Ok4oBzav
         biwvwqZUPhaKSkEGsiGcUt7teQjbVOL/NvOzz3fpIeSJ7iFSVD2MXHgdJOmIcKcPjEDx
         aOtA==
X-Gm-Message-State: ALoCoQl3XfUDTIWKptVQthQpQmsT3u7PNktz6PHGrABS7Ps1UuMlFFN/fW0KlTse2uHM3IbBS8rn
X-Received: by 10.140.31.37 with SMTP id e34mr25378889qge.17.1443477783426;
        Mon, 28 Sep 2015 15:03:03 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278758>

From: Ronnie Sahlberg <sahlberg@google.com>

Move read_ref_at() to the refs.c file since this function does not
contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs-be-files.c | 118 --------------------------------------------------------
 refs.c          | 118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 666ba7f..f6cdea9 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3436,124 +3436,6 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	return 0;
 }
 
-struct read_ref_at_cb {
-	const char *refname;
-	unsigned long at_time;
-	int cnt;
-	int reccnt;
-	unsigned char *sha1;
-	int found_it;
-
-	unsigned char osha1[20];
-	unsigned char nsha1[20];
-	int tz;
-	unsigned long date;
-	char **msg;
-	unsigned long *cutoff_time;
-	int *cutoff_tz;
-	int *cutoff_cnt;
-};
-
-static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
-		const char *message, void *cb_data)
-{
-	struct read_ref_at_cb *cb = cb_data;
-
-	cb->reccnt++;
-	cb->tz = tz;
-	cb->date = timestamp;
-
-	if (timestamp <= cb->at_time || cb->cnt == 0) {
-		if (cb->msg)
-			*cb->msg = xstrdup(message);
-		if (cb->cutoff_time)
-			*cb->cutoff_time = timestamp;
-		if (cb->cutoff_tz)
-			*cb->cutoff_tz = tz;
-		if (cb->cutoff_cnt)
-			*cb->cutoff_cnt = cb->reccnt - 1;
-		/*
-		 * we have not yet updated cb->[n|o]sha1 so they still
-		 * hold the values for the previous record.
-		 */
-		if (!is_null_sha1(cb->osha1)) {
-			hashcpy(cb->sha1, nsha1);
-			if (hashcmp(cb->osha1, nsha1))
-				warning("Log for ref %s has gap after %s.",
-					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
-		}
-		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, nsha1);
-		else if (hashcmp(nsha1, cb->sha1))
-			warning("Log for ref %s unexpectedly ended on %s.",
-				cb->refname, show_date(cb->date, cb->tz,
-						       DATE_MODE(RFC2822)));
-		hashcpy(cb->osha1, osha1);
-		hashcpy(cb->nsha1, nsha1);
-		cb->found_it = 1;
-		return 1;
-	}
-	hashcpy(cb->osha1, osha1);
-	hashcpy(cb->nsha1, nsha1);
-	if (cb->cnt > 0)
-		cb->cnt--;
-	return 0;
-}
-
-static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
-				  int tz, const char *message, void *cb_data)
-{
-	struct read_ref_at_cb *cb = cb_data;
-
-	if (cb->msg)
-		*cb->msg = xstrdup(message);
-	if (cb->cutoff_time)
-		*cb->cutoff_time = timestamp;
-	if (cb->cutoff_tz)
-		*cb->cutoff_tz = tz;
-	if (cb->cutoff_cnt)
-		*cb->cutoff_cnt = cb->reccnt;
-	hashcpy(cb->sha1, osha1);
-	if (is_null_sha1(cb->sha1))
-		hashcpy(cb->sha1, nsha1);
-	/* We just want the first entry */
-	return 1;
-}
-
-int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
-		unsigned char *sha1, char **msg,
-		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
-{
-	struct read_ref_at_cb cb;
-
-	memset(&cb, 0, sizeof(cb));
-	cb.refname = refname;
-	cb.at_time = at_time;
-	cb.cnt = cnt;
-	cb.msg = msg;
-	cb.cutoff_time = cutoff_time;
-	cb.cutoff_tz = cutoff_tz;
-	cb.cutoff_cnt = cutoff_cnt;
-	cb.sha1 = sha1;
-
-	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
-
-	if (!cb.reccnt) {
-		if (flags & GET_SHA1_QUIETLY)
-			exit(128);
-		else
-			die("Log for %s is empty.", refname);
-	}
-	if (cb.found_it)
-		return 0;
-
-	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
-
-	return 1;
-}
-
 int reflog_exists(const char *refname)
 {
 	struct stat st;
diff --git a/refs.c b/refs.c
index 205a899..5a8ef0c 100644
--- a/refs.c
+++ b/refs.c
@@ -210,3 +210,121 @@ out:
 	strbuf_release(&err);
 	return result;
 }
+
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
+					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
+		}
+		else if (cb->date == cb->at_time)
+			hashcpy(cb->sha1, nsha1);
+		else if (hashcmp(nsha1, cb->sha1))
+			warning("Log for ref %s unexpectedly ended on %s.",
+				cb->refname, show_date(cb->date, cb->tz,
+						       DATE_MODE(RFC2822)));
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
+int read_ref_at(const char *refname, unsigned int flags, unsigned long at_time, int cnt,
+		unsigned char *sha1, char **msg,
+		unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
+{
+	struct read_ref_at_cb cb;
+
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
+	if (!cb.reccnt) {
+		if (flags & GET_SHA1_QUIETLY)
+			exit(128);
+		else
+			die("Log for %s is empty.", refname);
+	}
+	if (cb.found_it)
+		return 0;
+
+	for_each_reflog_ent(refname, read_ref_at_ent_oldest, &cb);
+
+	return 1;
+}
-- 
2.4.2.644.g97b850b-twtrsrc
