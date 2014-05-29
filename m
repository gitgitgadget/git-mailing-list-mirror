From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v12 24/41] receive-pack.c: use a reference transaction for updating the refs
Date: Thu, 29 May 2014 09:07:46 -0700
Message-ID: <1401379676-9307-5-git-send-email-sahlberg@google.com>
References: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Cc: jrnieder@gmail.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 18:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq2sv-00079r-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbaE2QIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:08:51 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:38027 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461AbaE2QIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:08:00 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so96182pbc.4
        for <git@vger.kernel.org>; Thu, 29 May 2014 09:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QZm6XYdRw1f1MslzbHEtj7JiSS7zuB+Xq3xVHf3vIjw=;
        b=niODeksW/Cnc3L8jSwUDgihI+7l9JFBCkQ2xYTbp1A1FjVwFOlQbFIl6TT3TEnyTHn
         YxaMs1XhHjxBzCz66pOGQn/STYsj62hW4638RAN/7Ly/0CcX2sBryiCfQZKhCzVElAtY
         bayYxIVwBZd+ryBSMbHnedd89eLZF1Fmonf0OyOyaRpm6C976x6rGSYZTWRTO7ZqnT4Z
         2gzkZe7lowVwN/lQf5pHFeohPXWaUtnhHdde6ADMyPXZOcp4EiYFwDV1kg04mJaiS1f6
         VWVvF8hSbxyUFnSqPReVvwyEAAGicpmg9XBtJz542rq6Sc5hxfdG0IMTzMRdUBprAdCV
         TNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QZm6XYdRw1f1MslzbHEtj7JiSS7zuB+Xq3xVHf3vIjw=;
        b=kqPnodJspx4OYIGpzCSJ/4hL3qGUVLhPKf7VaUZdlDAJ3ke/6IuwlQsDctzYQQEeL0
         qFQhkcORXaCvkVU4ZocqgmCaKljlabh3djY8QngyH0tc1/pUbR4Wy95EKuge281B/fed
         jGAUaZG6iq3BbYzhdP8E/CosWhUfx+Zw7RakqMo3AEwFk/h58f3brB50KHxOZ6BETZR5
         ZbI4YJfjAEZDfgr9Yl+lUnF7ZUQ8eXLdVv8kSH3Fmn2792nGAGBeWxD3wIzsqr5BkCu8
         w44CLqbmsZQwLEUeMCKs6vLY545lt5gzqC/8SwJq3fgdIFWE0sFZZebq5OXFkfsIOlqB
         HEnQ==
X-Gm-Message-State: ALoCoQmHITWubAXjSj6shs2pYWfZdRXcyfqJli/s+FprehHssBTpdCw0aNVIqRX2T9jUiF5D8FLC
X-Received: by 10.68.133.138 with SMTP id pc10mr3154422pbb.5.1401379679548;
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si82017yhg.2.2014.05.29.09.07.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 565C25A4353;
	Thu, 29 May 2014 09:07:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EB619E1352; Thu, 29 May 2014 09:07:58 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g3833130
In-Reply-To: <1401379676-9307-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250389>

Wrap all the ref updates inside a transaction.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/receive-pack.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..13f4a63 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,7 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static struct string_list error_strings = STRING_LIST_INIT_DUP;
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -475,7 +476,6 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	const char *namespaced_name;
 	unsigned char *old_sha1 = cmd->old_sha1;
 	unsigned char *new_sha1 = cmd->new_sha1;
-	struct ref_lock *lock;
 
 	/* only refs/... are allowed */
 	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -576,19 +576,31 @@ static const char *update(struct command *cmd, struct shallow_info *si)
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
+
+			const char *str;
+			string_list_append(&error_strings, err.buf);
+			str = error_strings.items[error_strings.nr - 1].string;
+			strbuf_release(&err);
+
+			ref_transaction_free(transaction);
+			rp_error("%s", str);
+			return str;
 		}
+
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
 		return NULL; /* good */
 	}
 }
@@ -1215,5 +1227,6 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		packet_flush(1);
 	sha1_array_clear(&shallow);
 	sha1_array_clear(&ref);
+	string_list_clear(&error_strings, 0);
 	return 0;
 }
-- 
2.0.0.rc3.474.g3833130
