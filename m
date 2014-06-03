From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 24/41] receive-pack.c: use a reference transaction for updating the refs
Date: Tue,  3 Jun 2014 14:37:42 -0700
Message-ID: <1401831479-3388-25-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSR-0007P1-6d
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965398AbaFCVlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:16 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:40359 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934269AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-vc0-f202.google.com with SMTP id id10so1372684vcb.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=glNvzHp1BDMufzjJYcbkkLCFDw1lkMD3MWOEseHr3/g=;
        b=FfTXhmLeY0741NZNf7zJFe3UzdgAO8ktEBfHE3v/DSXdJI05s90H3OjSKumrt1Hpek
         8WAqVTC4jg9QZW6W18/G2rO/AS2dDyU7is58VSc04Dr+0IbY2r2AZXmj2+2SNMZSpIoM
         L5PWwEwPL9+vcoI5BD4wsy9HuN8znFDw3FNlWvV1veq2uYG5sCVFWBfabQYRqsCq4KRX
         z56PEJ3dj+wGZrwmH+tPGpWBuLmXuVtozceiy50LDcmIZGQNbYnep4ItmiZMv1281M4E
         D+QTULs+PhqvKZzDLdoMpeAZEtKVXoEvsxfYiM2FVnsL4iVucGu8VnMsx8ShOgMmN4OT
         caaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=glNvzHp1BDMufzjJYcbkkLCFDw1lkMD3MWOEseHr3/g=;
        b=TwACqjI1u+VO4jSMzqbIu2RyNOMInYGjOG5/oUm5RAvS7exy8v/QYDWOcmD3ZDMaZX
         5hFgNFnt1s3WJlv7YuPxsl5Yxu0fYpe/XxhQar9e1JHismotmP4NIQwemM6LRhF6a/++
         /rKyzwkffAm/+FY2EKAD+1cv3p4/6JeAuIkA72TYzZZmppPrQ3uFKVQUfp3NGJBMznSM
         NR3KpkCx0PEyxrn8Df8ZOxEb53VMIMcJtE2NdfMviRAEv6dSYm1mU427NUISw3VnY/7c
         4bylzEHDwZJGHNusfwIldN7h4ol8Z3b28fbwLVI3cWjywuTy87y23inbnRneX2JeLsfz
         93XA==
X-Gm-Message-State: ALoCoQk7ttTMSuUL3aPS4PRYowgRuOSc20c90McatMGS4UHr8QlA1TaauJjCaf0bwv08woUBBXgA
X-Received: by 10.236.127.35 with SMTP id c23mr16312870yhi.51.1401831487800;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si8969yhm.0.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 9DF1F5A43C6;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7A31FE0CC8; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250670>

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
2.0.0.567.g64a7adf
