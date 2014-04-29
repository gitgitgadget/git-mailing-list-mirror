From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 03/30] refs.c: add a strbuf argument to ref_transaction_commit for error logging
Date: Tue, 29 Apr 2014 15:18:48 -0700
Message-ID: <1398809955-32008-4-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:21:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGP9-0003nO-QO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbaD2WVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:21:32 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:58783 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965260AbaD2WTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:20 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so140243qcv.3
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyulC4/TTBUbwIgP5T7mtxR4luWYIrkcFJxSy3fOGbk=;
        b=A31UNso/u73dh/gDNO/VKLDYDmRijT6paEuKE9e/XrdpaH2dI7grWgUBRy7867LTLs
         8Z31FKrqSuXrN6FHbMjQ0ru1NeeBFsSfe2W904QlITPrClS7u5ROMsPdqujXL0k9nQmF
         jQtWRtGmgu9LwBSNW6jz0dWe7eKzOHLGZdLFRcMheuZCabvkZP8VCSESsnOWAYr90njR
         Zpnw+cmTInKkm8suxPYt7AvGE6gW2S9K31SKr/bMI63xXVxPRQiKgmNsgNJCMhZp6U7P
         TOvPkY2fHcxoB+8NE1kpzkct/L2bzNg30YLzOC9Eng2W1cmjqc/U0u5bbgZssMf/3MOi
         +QmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyulC4/TTBUbwIgP5T7mtxR4luWYIrkcFJxSy3fOGbk=;
        b=T8rNNcIG5A47ss0w8nEZi5Be72AwRob9R//MGOYHQL6Mocgt5AJ/aLpMrpVzmQYrU2
         j5fL6Qofb/w8pKalvrIvkBwtFBygBXvZeTUi3yHG9gf5XsFuZmzVkn5b3xx+EKu1ejpf
         Q+Wkb7by0pwopMkJ4oPJhs+eULDctwfjJj7OKl+3g+R6kAy21Khxr6jVwU/sysw8rjGR
         GAq0ivsDT++GPILniBB9uLAtVxDmcpG/A29dHYAiWP8ygGa49jDLBqgskJTTQLjyf48D
         i0QcjfeoP/l6eT7PeNxm+v920XpOEJQXt2gQZTDZHS9ygYo+0wyuQDVNYgyEeR/rbJEu
         k1hw==
X-Gm-Message-State: ALoCoQn1EWSxZ9fMmaEawCoSplJPsHglR/uTzU71q9kjabGMdAKjtJck1kx1GGtJdZ0ufCzfCtxQWvBBb0w5Wa4UgEmvpXl6lgiTaSh03PAd+LhRYezKjGqJ5RQnR0GQxSsxaN3CR5sykAj2xkDTz0GiETThlV/kwaFn52fvX0zXi+ZtrOlixaX4YODj7mkz/5WiPLAv7c6t
X-Received: by 10.58.94.232 with SMTP id df8mr280036veb.23.1398809958996;
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id r64si1400093yhh.0.2014.04.29.15.19.18
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id C85955A4121;
	Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 70763E0A5B; Tue, 29 Apr 2014 15:19:18 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247652>

Add a strbuf argument to _commit so that we can pass an error string back to
the caller. So that we can do error logging from the caller instead of from
_commit.

Longer term plan is to first convert all callers to use onerr==QUIET_ON_ERR
and craft any log messages from the callers themselves and finally remove the
onerr argument completely.

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
index 2d83ef6..64e8feb 100644
--- a/refs.c
+++ b/refs.c
@@ -3414,7 +3414,8 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 }
 
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr)
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr)
 {
 	int ret = 0, delnum = 0, i;
 	const char **delnames;
@@ -3443,6 +3444,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					       update->flags,
 					       &update->type, onerr);
 		if (!update->lock) {
+			if (err)
+				strbuf_addf(err ,"Cannot lock the ref '%s'.",
+					    update->refname);
 			ret = 1;
 			goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 892c5b6..ff87e14 100644
--- a/refs.h
+++ b/refs.h
@@ -268,9 +268,12 @@ void ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.  The ref_transaction is freed by this function.
+ * If err is non-NULL we will add an error string to it to explain why
+ * the transaction failed.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
-			   const char *msg, enum action_on_err onerr);
+			   const char *msg, struct strbuf *err,
+			   enum action_on_err onerr);
 
 /** Lock a ref and then write its file */
 int update_ref(const char *action, const char *refname,
-- 
1.9.1.532.gf8485a6
