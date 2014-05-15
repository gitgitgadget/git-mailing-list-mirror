From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 03/44] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Thu, 15 May 2014 10:29:18 -0700
Message-ID: <1400174999-26786-4-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzVv-0002LG-9x
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713AbaEORaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:08 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:56199 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbaEORaG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:06 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so290460iec.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlhqUfvbdN8ILf19Q7RhfeqFvEpzyWUnCyGXOvzkmbM=;
        b=PZzM3+ZLP1k4Xkx8oJI6E9puVENam+AULu5W8nbLHLdqQnWsJlAcolWmBkC8R8cGuj
         95cr51QYtI//v7ixvDiw0HRoRkIYmE0MrPWr3a/2QrMZRAoe9u4EvbNxrCVOdqW72HgL
         LKbUHU/ApgRuLa+SElUu2U9s8oB7TXJQM/Q2eN/aAp8hXEyOsibGG0Jy7YlnoD58lx8Z
         izxGoPsd6PZ0tPFjSpXZdf6pyXqxqZur90b4lMOCrhGUyy2wlqxk9zzrUg2IY3xNcv7F
         snImdxoRNL/myLPYX0TCIJ+1JIJmylxAwQMrj4X/I0KrUmxqmQbxqG4E4HkJ5ByxlxJU
         kH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlhqUfvbdN8ILf19Q7RhfeqFvEpzyWUnCyGXOvzkmbM=;
        b=BBz9eLgpR6xHbuT1fxzk2fbbf4Zqq6Jv1hib68ILgGROe0mOd07PcTnGq/UWVVTuLe
         29fJ4heZweAukFeu5sqs24DPIVO1M77BtpGFWGP46t9gxr3LN4w9SlJNgDHN5o7+3DkR
         94jDNy1OlF69JTF7wdn3rUdN89NgPv3XLoR6HflCuqW80X1/g/8E0UsZogDf8n0f1FQ6
         4+gAvOim/H46GUFr4seh0MLd94NTEEMn4+VZlqxzX+WlZ+c8cqWQXQVOYGFoSAngo2ej
         jXKGkjKcKE936uLG3bbScsRYH8c7SajGIEizrjwmTJJO3gl2Xmkww7SdZSiYBaVczFsq
         iOXg==
X-Gm-Message-State: ALoCoQn0Y4CVEnYfvP6z7Th8ntvVxSDSKgz99ngPQvrkEjNvhg3FcTrsCBCS3N63yERAtjYH5CAl
X-Received: by 10.50.50.2 with SMTP id y2mr5987067ign.1.1400175005808;
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si273156yhk.4.2014.05.15.10.30.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A31185A4263;
	Thu, 15 May 2014 10:30:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 54F86E038E; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249155>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 6 +++++-
 refs.h               | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..aaa06aa 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -367,7 +367,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg,
+		ret = ref_transaction_commit(transaction, msg, NULL,
 					     UPDATE_REFS_DIE_ON_ERR);
 		return ret;
 	}
diff --git a/refs.c b/refs.c
index 88d73c8..1a7f9d9 100644
--- a/refs.c
+++ b/refs.c
@@ -3423,7 +3423,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3452,6 +3453,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err, "Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 6d97700..25ae110 100644
--- a/refs.h
+++ b/refs.h
@@ -274,9 +274,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
2.0.0.rc3.477.g0f8edf7
