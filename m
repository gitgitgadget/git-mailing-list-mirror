From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 24/41] receive-pack.c: use a reference transaction for updating the refs
Date: Tue, 27 May 2014 13:25:43 -0700
Message-ID: <1401222360-21175-25-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNy0-0003hN-OC
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaE0U1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:06 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:54506 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-oa0-f73.google.com with SMTP id i4so1918954oah.4
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TpYPXrj6a6lPzAWrQLgbm1QhecTRWiTDeOPZmh3W+qA=;
        b=Y8FBNtjMtKzfgpgtPlgpqtgdHoyMK5MvIVunaUFAaG28WSM4Bm2910JjE7HgdBL5VR
         eWTJiajVyVvEOSIixiFb583CwUB5iTrAN9JryX82myGsRur7qSq71Zh9p0RXYuTdJMFB
         4m0LPj4uaz6Zy6tPn9O6RIdyNxkwcJtG1HipzIKfgCG+whYSo2XXPWMP/Xd0TehFBrH0
         v9rMfzUF4KZbLkhdxgDVkdf7bpj2iv4J7qj73+MYzzIHgLJw+/6zR3OnFnloNxq03bO0
         qxGOoo1C5odmOchyG2fBvC+/17nx4XBmve2WuOC84qthV4d1J6j7z/tBK+o3ck14F0ed
         LH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TpYPXrj6a6lPzAWrQLgbm1QhecTRWiTDeOPZmh3W+qA=;
        b=YUlWzlFwDZ27PkABL/Og0xX0yQz+R6VV0e2RDy4By+MFhMFl36yiGJdhMBwdOcI6Hw
         w52FARpo2Yj85+HMHU1eDsq3LDFXBVtqWsYF4tB1eNkQIxAKjMYhLPINbJjFX0MS/KH3
         GxigtpCq4okDh46SXJCTzUGe4M9AxNj3UPKBd1klyundRmPXlYDqTkA4OrYosIv2Zxqp
         wwrnXGgYRq8wTF9KHAc0ONb62v4IJ/hujU37Qpdqz1IUaSRNilBfae8a9i+rvK92pNIQ
         j47k1K7Sb5vHhqNHH1dLolwRZ8EQP8N+DM0zujaa1gbRjEnHK5/sEdwWDM43k7n3EBA6
         24QQ==
X-Gm-Message-State: ALoCoQk+6MqXkvpJZtK6Iwi6XJTjrHfr+iT4gvS04z9RXWwt6hmLU5N+avlpojHbBmF7stfB3fGd
X-Received: by 10.182.22.133 with SMTP id d5mr14735277obf.27.1401222364828;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n59si1574269yhi.6.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id AA7712F4AC1;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 86B7FE0D62; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250218>

Wrap all the ref updates inside a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..c88dc03 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,8 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static int num_strings;
+static const char **error_strings;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -468,6 +470,13 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
+static const char *add_error_string(const char *str)
+{
+	error_strings = xrealloc(error_strings,
+				 sizeof(*error_strings) * ++num_strings);
+	return error_strings[num_strings - 1] = xstrdup(str);
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 	const char *name = cmd->ref_name;
@@ -475,7 +484,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +584,27 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return NULL; /* good */
 	}
 	else {
+		struct strbuf err = STRBUF_INIT;
+		struct ref_transaction *transaction;
+
 		if (shallow_update && si->shallow_ref[cmd->index] &&
 		    update_shallow_ref(cmd, si))
 			return "shallow error";
 
-		lock = lock_any_ref_for_update(namespaced_name, old_sha1,
-					       0, NULL);
-		if (!lock) {
-			rp_error("failed to lock %s", name);
-			return "failed to lock";
-		}
-		if (write_ref_sha1(lock, new_sha1, "push")) {
-			return "failed to write"; /* error() already called */
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, namespaced_name,
+					   new_sha1, old_sha1, 0, 1, &err) ||
+		    ref_transaction_commit(transaction, "push", &err)) {
+			const char *str = add_error_string(err.buf);
+			ref_transaction_free(transaction);
+			strbuf_release(&err);
+			rp_error("%s", str);
+			return str;
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -1120,6 +1136,14 @@ static int delete_only(struct command *commands)
 	return 1;
 }
 
+static void free_all_strings(void)
+{
+	int i;
+	for (i = 0; i < num_strings; i++)
+		free((void *)error_strings[i]);
+	free(error_strings);
+}
+
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
@@ -1166,6 +1190,7 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		usage(receive_pack_usage);
 
 	setup_path();
+	atexit(free_all_strings);
 
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
-- 
2.0.0.rc3.474.g0203784
