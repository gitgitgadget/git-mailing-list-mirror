From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 21/44] refs.c: ref_transaction_commit should not free the transaction
Date: Fri, 16 May 2014 10:37:09 -0700
Message-ID: <1400261852-31303-22-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5D-0007IG-4x
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbaEPRhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:37:47 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:38429 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757875AbaEPRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:38 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so521090pab.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M0OP6ZmBd/AdqJWndZJPoDculjh+SiKFWketkxhuNSE=;
        b=XTyw9rzH1D2XiAQHjWgFzMG9Jw6W+5nyVx/SdBbz6atX8eHQjRxbAPnU9VK1QIejBb
         FAuBv1gQ88/jfGS6nKUOXB2ZQfF62qXF20pQ6e/MLH+1q5SnNC11BNpWpy/+4aK7BqfV
         P1jLGvIcojweN1L9qHNEZNA5blfPIJen9yD7L39kB909wCgUt9xpPTbgyTYIyLpC0ORi
         d67hxUY1WplMs35M4fiejb68Eku2eI2fj9bcD/TKhgejkIccAcvYZXIP8hS0L6eLcFnL
         Lv1athKtK6NrdZWfQqrzA42RzUxNj/807JsCZ4gEtsBHmRXbhaTuWSVDCC3M1nfsh2UE
         cJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M0OP6ZmBd/AdqJWndZJPoDculjh+SiKFWketkxhuNSE=;
        b=MJnNVm3AJw8zr9lvoaWX3/TeGOKGwykNXJAiufdXvBOW0D5+Uo/2piumFtIHHBuAP5
         i53mVCESW9F2/Xz15cwehFVECdJLPsxFgMqGK4Js8R+OCpi13A32DIXXQToipn+w+9C+
         y55GfTPuVOzRAO4IEYjbGte6Ht8o3SD2cjTrH8v6DdfrgPRfZWHgVoyjFuBZ26xzCDfo
         jOCd9cdeMMwggB+PR0ZO6fB6wkbuAUtF7AiHSmNXeyPx7hzKAFq89zUrc3VaOfK6KJgP
         2L4mkbFPCv5WMT/4WJhgs48QkZRrW1a7uAtcc5KlhOiQ1zOD8fO/DfMoLJAIvp02dfJd
         E1tA==
X-Gm-Message-State: ALoCoQm0q24Cx2VGJyipc7arZNZYf0ecoCJBx0ViKZ6n0dsWwoapFG8WRazpK9TwvM3F8Lehgdqs
X-Received: by 10.66.163.33 with SMTP id yf1mr6594967pab.19.1400261857611;
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si442529yhq.3.2014.05.16.10.37.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5E9795A40F6;
	Fri, 16 May 2014 10:37:37 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3C9F5E0EC6; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249363>

Change ref_transaction_commit so that it does not free the transaction.
Instead require that a caller will end a transaction by calling
ref_transaction_free.

By having the transaction object remaining valid after _commit returns allows
us to write much nicer code and still be able to call ref_transaction_free
safely. Instead of this horribleness
	t = ref_transaction_begin();
	if ((!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval)) ||
	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
		ref_transaction_free(t);

we can now just do the much nicer
	t = ref_transaction_begin();
	if (!t ||
	    ref_transaction_update(t, refname, sha1, oldval, flags,
				   !!oldval) ||
	    ref_transaction_commit(&t, action, &err)) {
		ref_transaction_free(t);
		... die/return ...

	ref_transaction_free(transaction);

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c             |  1 +
 builtin/commit.c     |  1 +
 builtin/replace.c    |  1 +
 builtin/tag.c        |  1 +
 builtin/update-ref.c |  1 +
 fast-import.c        |  4 ++--
 refs.c               | 12 +++++-------
 refs.h               |  8 +++-----
 sequencer.c          |  4 ++--
 9 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/branch.c b/branch.c
index 8bf7588..f78a28b 100644
--- a/branch.c
+++ b/branch.c
@@ -304,6 +304,7 @@ void create_branch(const char *head,
 					   null_sha1, 0, !forcing, &err) ||
 		    ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
+		ref_transaction_free(transaction);
 	}
 
 	if (real_ref && track)
diff --git a/builtin/commit.c b/builtin/commit.c
index c429216..6b888f2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1726,6 +1726,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die("%s", err.buf);
 	}
+	ref_transaction_free(transaction);
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/replace.c b/builtin/replace.c
index e8932cd..af7f72d 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -164,6 +164,7 @@ static int replace_object_sha1(const char *object_ref,
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s", err.buf);
 
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/builtin/tag.c b/builtin/tag.c
index b05f9a5..30b471c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -708,6 +708,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 				   0, !is_null_sha1(prev), &err) ||
 	    ref_transaction_commit(transaction, NULL, &err))
 		die("%s", err.buf);
+	ref_transaction_free(transaction);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index cdb71a8..4c2145e 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -373,6 +373,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		if (ref_transaction_commit(transaction, msg, &err))
 			die("%s", err.buf);
+		ref_transaction_free(transaction);
 		return 0;
 	}
 
diff --git a/fast-import.c b/fast-import.c
index 60d4538..cb3f5af 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1710,13 +1710,13 @@ static int update_branch(struct branch *b)
 	if (!transaction ||
 	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
 				   0, 1, &err) ||
-	    (ref_transaction_commit(transaction, msg, &err) &&
-	     !(transaction = NULL))) {
+	    ref_transaction_commit(transaction, msg, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 2c3f070..266a792 100644
--- a/refs.c
+++ b/refs.c
@@ -3446,10 +3446,10 @@ int update_ref(const char *action, const char *refname,
 	struct strbuf err = STRBUF_INIT;
 
 	t = ref_transaction_begin();
-	if ((!t ||
+	if (!t ||
 	    ref_transaction_update(t, refname, sha1, oldval, flags,
-				   !!oldval, &err)) ||
-	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+				   !!oldval, &err) ||
+	    ref_transaction_commit(t, action, &err)) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
 		ref_transaction_free(t);
@@ -3463,6 +3463,7 @@ int update_ref(const char *action, const char *refname,
 		strbuf_release(&err);
 		return 1;
 	}
+	ref_transaction_free(t);
 	return 0;
 }
 
@@ -3497,10 +3498,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
-	if (!n) {
-		ref_transaction_free(transaction);
+	if (!n)
 		return 0;
-	}
 
 	/* Allocate work space */
 	delnames = xmalloc(sizeof(*delnames) * n);
@@ -3567,7 +3566,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index 9b978da..e0f5f67 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * eventually be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -278,9 +277,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
- * If err is non-NULL we will add an error string to it to explain why
- * the transaction failed. The string does not end in newline.
+ * problem. If err is non-NULL we will add an error string to it to explain
+ * why the transaction failed. The string does not end in newline.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, struct strbuf *err);
diff --git a/sequencer.c b/sequencer.c
index b047fb8..a2bc9e1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -286,14 +286,14 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", to, from,
 				   0, !unborn, &err) ||
-	    (ref_transaction_commit(transaction, sb.buf, &err) &&
-	     !(transaction = NULL))) {
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
 		ref_transaction_free(transaction);
 		error("%s", err.buf);
 		strbuf_release(&sb);
 		strbuf_release(&err);
 		return -1;
 	}
+	ref_transaction_free(transaction);
 
 	strbuf_release(&sb);
 	return 0;
-- 
2.0.0.rc3.510.g20c254b
