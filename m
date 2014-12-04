From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/23] struct expire_reflog_cb: a new callback data type
Date: Fri,  5 Dec 2014 00:08:26 +0100
Message-ID: <1417734515-11812-15-git-send-email-mhagger@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:09:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwfWh-0003Cj-GE
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933336AbaLDXJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:09:04 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42800 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754847AbaLDXJB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 18:09:01 -0500
X-AuditID: 12074413-f79f26d0000030e7-ab-5480e98de98a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 6E.A0.12519.D89E0845; Thu,  4 Dec 2014 18:09:01 -0500 (EST)
Received: from michael.fritz.box (p5DDB0B3C.dip0.t-ipconnect.de [93.219.11.60])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB4N8deB027614
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 4 Dec 2014 18:09:00 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqNv7siHE4M8cbouuK91MFg29V5gt
	3t5cwmhxe8V8Zovevk+sFps3t7M4sHn8ff+ByWPnrLvsHgs2lXpcvKTs8XmTXABrFLdNUmJJ
	WXBmep6+XQJ3xqlT5QXX5CsW/3JvYNwv2cXIySEhYCLx+msrK4QtJnHh3nq2LkYuDiGBy4wS
	8w+vgnKOMUlsXvodrIpNQFdiUU8zE4gtIqAmMXPVbLAiZoETjBK/JnczgiSEBTwk2qZsYe9i
	5OBgEVCV2LwlGiTMK+Aqceb3ZDaQsISAnMTWdd4gYU6g8NSZrWCdQgIuEs82LWSfwMi7gJFh
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIWAnvYNx1Uu4QowAHoxIPb8Hu
	+hAh1sSy4srcQ4ySHExKorxnnzaECPEl5adUZiQWZ8QXleakFh9ilOBgVhLhNT4ClONNSays
	Si3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfCWvgBqFCxKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAdFRXwxMC5AUjxAe8tA2nmLCxJzgaIQracYFaXEeetBEgIgiYzS
	PLixsGTxilEc6EthiO08wEQD1/0KaDAT0OCzDbUgg0sSEVJSDYyeOnaWAZYlv8V6fz1X/iYe
	m7LkXdiDu1nvTjCvzveZGfDtyf6wyq+/WPa5q/htWJFwm8dhtfkNwWsH5HgvSlQeXflKehbP
	490bj798pbM8eNqD12p+yud8a45b5k3xeiRSw3Ytx/7L5iec5729d5z+naDZw5Tn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260824>

Add a new data type, "struct expire_reflog_cb", for holding the data
that expire_reflog() passes to expire_reflog_ent() via
for_each_reflog_ent(). For now it only holds a pointer to "struct
expire_reflog_policy_cb". In future commits we will move some data
from the latter to the former.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/reflog.c | 43 ++++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 3538e4b..5dfa53a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -45,10 +45,15 @@ struct expire_reflog_policy_cb {
 	struct commit_list *tips;
 };
 
+struct expire_reflog_cb {
+	void *policy_cb;
+};
+
 struct collected_reflog {
 	unsigned char sha1[20];
 	char reflog[FLEX_ARRAY];
 };
+
 struct collect_reflog_cb {
 	struct collected_reflog **e;
 	int alloc;
@@ -323,28 +328,29 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	struct expire_reflog_policy_cb *cb = cb_data;
+	struct expire_reflog_cb *cb = cb_data;
+	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
 
-	if (cb->cmd->rewrite)
-		osha1 = cb->last_kept_sha1;
+	if (policy_cb->cmd->rewrite)
+		osha1 = policy_cb->last_kept_sha1;
 
 	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
-				     message, cb_data)) {
-		if (!cb->newlog)
+				     message, policy_cb)) {
+		if (!policy_cb->newlog)
 			printf("would prune %s", message);
-		else if (cb->cmd->verbose)
+		else if (policy_cb->cmd->verbose)
 			printf("prune %s", message);
 	} else {
-		if (cb->newlog) {
+		if (policy_cb->newlog) {
 			char sign = (tz < 0) ? '-' : '+';
 			int zone = (tz < 0) ? (-tz) : tz;
-			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
+			fprintf(policy_cb->newlog, "%s %s %s %lu %c%04d\t%s",
 				sha1_to_hex(osha1), sha1_to_hex(nsha1),
 				email, timestamp, sign, zone,
 				message);
-			hashcpy(cb->last_kept_sha1, nsha1);
+			hashcpy(policy_cb->last_kept_sha1, nsha1);
 		}
-		if (cb->cmd->verbose)
+		if (policy_cb->cmd->verbose)
 			printf("keep %s", message);
 	}
 	return 0;
@@ -423,12 +429,15 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 			 unsigned int flags, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cmd = cb_data;
-	struct expire_reflog_policy_cb cb;
+	struct expire_reflog_cb cb;
+	struct expire_reflog_policy_cb policy_cb;
 	struct ref_lock *lock;
 	char *log_file;
 	int status = 0;
 
 	memset(&cb, 0, sizeof(cb));
+	memset(&policy_cb, 0, sizeof(policy_cb));
+	cb.policy_cb = &policy_cb;
 
 	/*
 	 * we take the lock for the ref itself to prevent it from
@@ -446,16 +455,16 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
 			goto failure;
-		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
-		if (!cb.newlog)
+		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
+		if (!policy_cb.newlog)
 			goto failure;
 	}
 
-	cb.cmd = cmd;
+	policy_cb.cmd = cmd;
 
-	reflog_expiry_prepare(refname, sha1, &cb);
+	reflog_expiry_prepare(refname, sha1, &policy_cb);
 	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
-	reflog_expiry_cleanup(&cb);
+	reflog_expiry_cleanup(&policy_cb);
 
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		if (close_lock_file(&reflog_lock)) {
@@ -463,7 +472,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
 					strerror(errno));
 		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			(write_in_full(lock->lock_fd,
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
 			 close_ref(lock) < 0)) {
 			status |= error("Couldn't write %s",
-- 
2.1.3
