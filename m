From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 10/27] refs.c: ref_transaction_delete to check for error and return status
Date: Mon, 28 Apr 2014 15:54:25 -0700
Message-ID: <1398725682-30782-11-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuTH-0007I9-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756303AbaD1W4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:18 -0400
Received: from mail-oa0-f74.google.com ([209.85.219.74]:64340 "EHLO
	mail-oa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbaD1Wyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:50 -0400
Received: by mail-oa0-f74.google.com with SMTP id i7so89843oag.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DpX8D0SmcwPlZ0GFUiAiSOaHwEI6WmL1GsCAR5oBl/E=;
        b=e9xWXDMPJJ0mv/lMqcNgXHmb2tLonGhyycZ79CuarvyrITK4ZM9bO0nYAoFUY04WQp
         WpZrgZa1RbAOHXb7mf1D2lIA8agslpoRUWJC3at8m4kd/HxA4DOgYHrnwcc9vywv5ykS
         CeN0hNYfhL5Ec8JBIgHRs5YhGq4bFE80iyBIIw55AkrCSjjGzMgMTVmYMrhN/mKTDqob
         o0g0JTQLrLzaJzUgZ7BcTbCXfNDtgN1/ibDSY5juclPB22tGJDkl3aQNAab699xoz7Jb
         tZG3qBWPadpZPr8fMiC2e3+CgQHi8xZ4HaUn7g98YgSstIzycC33exi1RgOX5kRWXM52
         zD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DpX8D0SmcwPlZ0GFUiAiSOaHwEI6WmL1GsCAR5oBl/E=;
        b=buJHsHFxjI6hh72KhE3T7AL+cRT1hu8WDEeWPvBstNCccmwyqDQ0rSeVeLNiBHg73c
         Rn9shLNllfs1XT2r+7olVYvQr6/J8n5rPg2CP5mbsBeSb/gxMte+EJUGnCpZRvv9VP8v
         Usnw+6JVqebGDOL0tNtCeSDQ0KEE5rV0x+K/Z3yBmogTKv5avipgGU3MTevgU4KruaYR
         tMPG72/iKurMjwqt9U3MhHbZv3ee5GHgqeiekDm7UI6P6SVaNNKpp/wKGUhZTFqXCkne
         lYSm5ACAv6sL6SxmyWQ6Q7m+0RKuqSj29yWDSYYt2zm78vvP0lLfSTOK1e/02+TU0wIO
         uTdg==
X-Gm-Message-State: ALoCoQmEpijeUKjhzVBGvg2Tk2Xvr1KNWR8VAYK6Z/I96IYno6/yKqd1dfw3c1/UCPrEzm9d7E/a3OwmjlgYSYixOnm/XPF3lZYMPYH9q8wMuRTAswm6Wyh7swYg3oKv5QoYMg697flyaXxn/JmbMMFlTC3ZgbKrLSl9/aTN6MkcRMcuNOB+G0XjPINE5wh1rc6ZOmSutLec
X-Received: by 10.182.28.36 with SMTP id y4mr4883709obg.46.1398725689926;
        Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r64si1011500yhh.0.2014.04.28.15.54.49
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B7AAC31C20B;
	Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 475E9E080D; Mon, 28 Apr 2014 15:54:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247482>

Change ref_transaction_delete() to do basic error checking and return
status. Update all callers to check the return for ref_transaction_delete()

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  8 ++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3fab810..fc3512f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,8 +257,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 27db737..0a4e28e 100644
--- a/refs.c
+++ b/refs.c
@@ -3372,19 +3372,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index 01d773c..5eb500e 100644
--- a/refs.h
+++ b/refs.h
@@ -259,10 +259,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
1.9.1.528.g98b8868.dirty
