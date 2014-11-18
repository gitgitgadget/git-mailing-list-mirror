From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 01/16] refs.c: allow passing raw git_committer_info as email to _update_reflog
Date: Mon, 17 Nov 2014 17:44:42 -0800
Message-ID: <1416275097-3616-2-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:45:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXqx-0003iB-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbaKRBpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:06 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:63116 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbaKRBpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:03 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so3103073iec.39
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLuvtI08R/BisOXnQtEWL3XgrBm+MrztOdo4LILI3iw=;
        b=ZkB5EMkEOPhm5OYu4QMtLTOJVUgwFGcAKDdovePy9JFj6iAkODSy7I/SGB1MmeDTW/
         5QSMd0WSgQ1QarhzorGjyht5ol9H6fjMBE+lzYn6stkjUqordZefoASdixPuq3PGsUCD
         ywVBg6afOgX9vkoMnVj4tOQU0ILf2qo/w++C940ojMiGWKyzM8iX/3GnWU2qmxr6S9o9
         zYAJoTaO0aAHiH8x46pfY06Kf28sBVgkaWh6GQD4DwqpvdicuZTZymswVLSbw1YLlpTO
         B3p/Fwod+XISefL9MflCqN97+sSdNWp/UBzGVwu+FGXBaU7irqSBFZ9kcc4PR4kuPqlg
         2PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VLuvtI08R/BisOXnQtEWL3XgrBm+MrztOdo4LILI3iw=;
        b=RJvM/yFuDrTAULG9Be0L7GIMtUHDJsNz0l4eCbVDRD48XrUP4zJNgguPYl+Z3I62Kk
         kR71kNsj0AzhmxM2upfugQCoiYJK5LvLc/3Ueq5b1Ig44cIcNgcwVBx/GlsXDO7tPM4D
         jPwpeOlm0IHyqUCbfuNrOwcpNXNgUPZ3UTS4+obBS+cGe5K+3IdQRHhoCuPzdeJiAqRG
         gj7/DslgUCzm/hfSknDClcdOQXPMnEbbtm/a0YUJaSwg9chE7yAmAG+q91++zyFdXQ9R
         94Km9Sg2xuUlRg81Xw3zLm70Q62nn+OfhlkvAdIzvYLwuj4qKCdG1udE4LCfaBeLUAFM
         8vbA==
X-Gm-Message-State: ALoCoQkNPeuZIIz3L6NFbr0NjnFosJsSJZQW2p03MWWocTlVSty6n8MbqmR9J378z0SYCjaPaqAx
X-Received: by 10.50.25.100 with SMTP id b4mr29850267igg.17.1416275103035;
        Mon, 17 Nov 2014 17:45:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id uu4sm6867861igb.19.2014.11.17.17.45.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:02 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

In many places in the code we do not have access to the individual fields
in the committer data. Instead we might only have access to prebaked data
such as what is returned by git_committer_info() containing a string
that consists of email, timestamp, zone etc.

This makes it inconvenient to use transaction_update_reflog since it means
you would have to first parse git_committer_info before you can call
update_reflog.

Add a new flag REFLOG_COMMITTER_INFO_IS_VALID to _update_reflog to tell it
that we pass in a fully prebaked committer info string that can be used as is.

At the same time, also go over and change all references from email
to id where the code actually refers to a committer id and not just an email
address. I.e. where the string is : NAME <EMAIL>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/reflog.c | 19 +++++++++++++------
 refs.c           | 21 ++++++++++++---------
 refs.h           | 25 +++++++++++++++++++++++--
 3 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 6bb7454..be88a53 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -292,7 +292,7 @@ static int unreachable(struct expire_reflog_cb *cb, struct commit *commit, unsig
 }
 
 static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct expire_reflog_cb *cb = cb_data;
@@ -320,9 +320,14 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		goto prune;
 
 	if (cb->t) {
+		struct reflog_committer_info ci;
+
+		memset(&ci, 0, sizeof(ci));
+		ci.id = id;
+		ci.timestamp = timestamp;
+		ci.tz = tz;
 		if (transaction_update_reflog(cb->t, cb->refname, nsha1, osha1,
-					      email, timestamp, tz, message, 0,
-					      &err))
+					      &ci, message, 0, &err))
 			return -1;
 		hashcpy(cb->last_kept_sha1, nsha1);
 	}
@@ -356,6 +361,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	struct expire_reflog_cb cb;
 	struct commit *tip_commit;
 	struct commit_list *tips;
+	struct reflog_committer_info ci;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
@@ -368,9 +374,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		status |= error("%s", err.buf);
 		goto cleanup;
 	}
+
+	memset(&ci, 0, sizeof(ci));
 	if (transaction_update_reflog(cb.t, cb.refname, null_sha1, null_sha1,
-				      NULL, 0, 0, NULL, REFLOG_TRUNCATE,
-				      &err)) {
+				      &ci, NULL, REFLOG_TRUNCATE, &err)) {
 		status |= error("%s", err.buf);
 		goto cleanup;
 	}
@@ -672,7 +679,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 }
 
 static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
diff --git a/refs.c b/refs.c
index d75af6c..f30512f 100644
--- a/refs.c
+++ b/refs.c
@@ -3226,7 +3226,7 @@ struct read_ref_at_cb {
 };
 
 static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
-		const char *email, unsigned long timestamp, int tz,
+		const char *id, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3273,7 +3273,7 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 }
 
 static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
-				  const char *email, unsigned long timestamp,
+				  const char *id, unsigned long timestamp,
 				  int tz, const char *message, void *cb_data)
 {
 	struct read_ref_at_cb *cb = cb_data;
@@ -3625,8 +3625,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err)
 {
@@ -3654,13 +3653,17 @@ int transaction_update_reflog(struct transaction *transaction,
 	hashcpy(update->new_sha1, new_sha1);
 	hashcpy(update->old_sha1, old_sha1);
 	update->reflog_fd = -1;
-	if (email) {
+	if (flags & REFLOG_COMMITTER_INFO_IS_VALID) {
+		if (!ci->committer_info)
+			die("BUG: committer_info is NULL in reflog update");
+		update->committer = xstrdup(ci->committer_info);
+	} else if (ci->id) {
 		struct strbuf buf = STRBUF_INIT;
-		char sign = (tz < 0) ? '-' : '+';
-		int zone = (tz < 0) ? (-tz) : tz;
+		char sign = (ci->tz < 0) ? '-' : '+';
+		int zone = (ci->tz < 0) ? (-ci->tz) : ci->tz;
 
-		strbuf_addf(&buf, "%s %lu %c%04d", email, timestamp, sign,
-			    zone);
+		strbuf_addf(&buf, "%s %lu %c%04d", ci->id,
+			    ci->timestamp, sign, zone);
 		update->committer = xstrdup(buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/refs.h b/refs.h
index 2e97f4f..9153e1d 100644
--- a/refs.h
+++ b/refs.h
@@ -318,6 +318,28 @@ int transaction_delete_ref(struct transaction *transaction,
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REFLOG_TRUNCATE 0x01
+#define REFLOG_COMMITTER_INFO_IS_VALID 0x02
+
+/*
+ * Committer data provided to reflog updates.
+ * If flags contain REFLOG_COMMITTER_DATA_IS_VALID then the structure
+ * contains a prebaked committer string just like git_committer_info()
+ * would return.
+ *
+ * If flags does not contain REFLOG_COMMITTER_DATA_IS_VALID
+ * then the committer info string will be generated using the passed
+ * email, timestamp and tz fields.
+ * This is useful for example from reflog iterators where you are passed
+ * these fields individually and not as a prebaked git_committer_info()
+ * string.
+ */
+struct reflog_committer_info {
+	const char *committer_info;
+
+	const char *id;
+	unsigned long timestamp;
+	int tz;
+};
 /*
  * Append a reflog entry for refname. If the REFLOG_TRUNCATE flag is set
  * this update will first truncate the reflog before writing the entry.
@@ -327,8 +349,7 @@ int transaction_update_reflog(struct transaction *transaction,
 			      const char *refname,
 			      const unsigned char *new_sha1,
 			      const unsigned char *old_sha1,
-			      const char *email,
-			      unsigned long timestamp, int tz,
+			      struct reflog_committer_info *ci,
 			      const char *msg, int flags,
 			      struct strbuf *err);
 
-- 
2.2.0.rc2.5.gf7b9fb2
