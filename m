From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 15/41] refs.c: make ref_transaction_begin take an err argument
Date: Tue,  3 Jun 2014 14:37:33 -0700
Message-ID: <1401831479-3388-16-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:42:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwTL-000847-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965432AbaFCVl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:58 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:38587 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934160AbaFCViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:08 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so1533239obc.4
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gaYb17ilwEuq1zEdk95jLFt+318HWYwNxaKl2pzthhY=;
        b=dZwGLAGMJFs69xWNzAVpEkkWXn+mCKaMG0ZUIvB72JmF/I11SrELXNqtyBrSeKukXg
         dTq7OIJyUPZab6m7VJx6FdAgDbMXaDs8AJilY2kVmYx/wleXvkfMltKrdimFxaV1qeEH
         SMCWEuX3K20X98tAh05hhBlZKpIygq5muEhtqMy9WVeU9mhFmcoQqqSQjQQvgdLuIQtB
         vdVI4HJojMdvdVYsYxlEan7+iz2PZ9dkkEJ5SrinHm3YP3U76Z3H07LJAQH9mwRVO04N
         alfsPftrxRcSFKO5BkpkQSSRxGvHeE77UTaEjxzM8rQ9tCvaDZCFMw0q1yUCuQFyZfbE
         2uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gaYb17ilwEuq1zEdk95jLFt+318HWYwNxaKl2pzthhY=;
        b=c1B8Z0tTGOaY3z1FK83k2ZfGq+1bRUgIl5wxK15Gqljff1QijO5Fg0y50wYkM1cb3k
         VmgrnRopsd+3jUkRub5/xStpm80T59WfSb4RtmEZ3eKSobpgtMAjvZSaJdZj7FVdlGYm
         os3km5x1Umo0OHF8zJriwMRcPtBRDJqTKAxyAbymIJV4U6snea5iGlEk0BXLmgZO1pzr
         K9SOIQYHYRdXcAjdHy+8stok79LIDwJuUSIEjCh3MTdEug4YPxYmpQSwTHvdFPM/0rNS
         oRbOCYNpqmzNrtHAa1udHaEpuZ2ZNvbQAXL6iF0aG28PluXPOQstP8ny13ml85vdQ/I1
         tWyg==
X-Gm-Message-State: ALoCoQmkLLVC0ekCmZFtBdiOZkFvoqJxuXZFi3L8E6RCqG8HJ2pYzX1cfWUEHwBXCQNLXL9dfwfd
X-Received: by 10.43.103.136 with SMTP id di8mr16043492icc.14.1401831487368;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c22si30642yhe.1.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 382D731C462;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 14697E043A; Tue,  3 Jun 2014 14:38:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250687>

Add an err argument to _begin so that on non-fatal failures in future ref
backends we can report a nice error back to the caller.
While _begin can currently never fail for other reasons than OOM, in which
case we die() anyway, we may add other types of backends in the future.
For example, a hypothetical MySQL backend could fail in _being with
"Can not connect to MySQL server. No route to host".

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 2 +-
 refs.c               | 2 +-
 refs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 7c9c248..c6ad0be 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -365,7 +365,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		transaction = ref_transaction_begin();
+		transaction = ref_transaction_begin(&err);
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
diff --git a/refs.c b/refs.c
index d9b99c7..ee87eda 100644
--- a/refs.c
+++ b/refs.c
@@ -3387,7 +3387,7 @@ struct ref_transaction {
 	size_t nr;
 };
 
-struct ref_transaction *ref_transaction_begin(void)
+struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
diff --git a/refs.h b/refs.h
index 58ba365..743358f 100644
--- a/refs.h
+++ b/refs.h
@@ -257,7 +257,7 @@ enum action_on_err {
  * Begin a reference transaction.  The reference transaction must
  * be freed by calling ref_transaction_free().
  */
-struct ref_transaction *ref_transaction_begin(void);
+struct ref_transaction *ref_transaction_begin(struct strbuf *err);
 
 /*
  * The following functions add a reference check or update to a
-- 
2.0.0.567.g64a7adf
