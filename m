From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v5 09/30] refs.c: change ref_transaction_create to do error checking and return status
Date: Tue, 29 Apr 2014 15:18:54 -0700
Message-ID: <1398809955-32008-10-git-send-email-sahlberg@google.com>
References: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 00:19:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfGN9-0001eT-MO
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 00:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbaD2WT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 18:19:26 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:33597 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965256AbaD2WTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 18:19:22 -0400
Received: by mail-pd0-f202.google.com with SMTP id y10so162980pdj.1
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOhoKr0G23atfusm5dVI2cFEQ1HQtN+phm8pZuAEh/c=;
        b=BldcBgW7f+T8mtjOjBdly6wVFLBKGOIgWLqRBhoxSLOFc0Jxd2Sx4yAmv2M167X7PU
         pJDuwA7dLb2LT9H1uDNPUav3UQmKdt92mVxB5oYBpxtSKLykPLFklINI4wG/cDA1jnpf
         mGtJrg0yM+61fUCUkxViRavfnc9HOlTorR/dTZHHdR8X+U8Gr8xNkIbWOyarPRzzVyDn
         cxefKnxvmrhDR8tAbMEbmWGSituJKUoID3Mr8aV/mMCXtcxGTk8kmb7JrQ3VsSmcixhS
         ke5fJCyMIcrU3O9/KQ8yPDXIN5ZmwsJZBtdK7jpb053izxU5pUgBPvcxgMy6L24TlMZN
         d1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOhoKr0G23atfusm5dVI2cFEQ1HQtN+phm8pZuAEh/c=;
        b=QQNuP9pzOb++C6qZSPMEIfSUNTE5dRDu5Bq/fZ9jmR5C0MNF5aUJwboy58JqVKUyBn
         tN+5+VqTO91rDQrezQP0CpKEvUyWHHOA0w3LDRY8Mvh39T4u1VjLRaTOkRUEzy4QBxh/
         tzQOiuh7VYsd15zVJnWFIB17TAVBu0VNceEo8qgfMhCMss4EtujWnJdf1hWm3NUMXosY
         0CnpqJXP5rsIm1GZ3K0lxpWc2GhCmBKG20gP4Y/+0ijR5uMH26GVFuzQ4UnDIT4m11lO
         ru/X2oGJVafy9KNoS1X1fqTpwtv6Hes8wWqkQIsZX5eYmC2SmtEvK4Q+rOfuhfyraAnH
         if0w==
X-Gm-Message-State: ALoCoQntxNNgLHfsT98LTnBR/xOp9eRuJOTwBAiXoMkcp/sIi6hjJHooTZwvOXpJ9JS/G4zbCKU/u93tJEJT3clFV+kIM5pEv1ne29y4Q6S6kFjW5v975upAd7yL5MBb/5UdEeH4O7BZJ89+RgSY/QTjd7mZwFK3Jm7hQq+qsKDE3D0/rtuaRB+AmZljsaHvkpdt+bfrhWaf
X-Received: by 10.66.121.195 with SMTP id lm3mr343858pab.24.1398809961459;
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1813106yhl.7.2014.04.29.15.19.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 47B855A4121;
	Tue, 29 Apr 2014 15:19:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 021E6E0A5B; Tue, 29 Apr 2014 15:19:20 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.532.gf8485a6
In-Reply-To: <1398809955-32008-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247629>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()
There are currently no conditions in _update that will return error but there
will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  4 +++-
 refs.c               | 17 +++++++++++------
 refs.h               |  8 ++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 59c4d6b..3fab810 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -225,7 +225,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	ref_transaction_create(transaction, refname, new_sha1, update_flags);
+	if (ref_transaction_create(transaction, refname, new_sha1,
+				   update_flags))
+		die("failed transaction create for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 1a903fb..27db737 100644
--- a/refs.c
+++ b/refs.c
@@ -3353,18 +3353,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags)
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (!new_sha1 || is_null_sha1(new_sha1))
+		die("create ref with null new_sha1");
+
+	update = add_update(transaction, refname);
 
-	assert(!is_null_sha1(new_sha1));
 	hashcpy(update->new_sha1, new_sha1);
 	hashclr(update->old_sha1);
 	update->flags = flags;
 	update->have_old = 1;
+	return 0;
 }
 
 void ref_transaction_delete(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 0364a3e..01d773c 100644
--- a/refs.h
+++ b/refs.h
@@ -249,10 +249,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
  * null SHA-1.  It is verified that the reference does not exist
  * already.
  */
-void ref_transaction_create(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    int flags);
+int ref_transaction_create(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   int flags);
 
 /*
  * Add a reference deletion to transaction.  If have_old is true, then
-- 
1.9.1.532.gf8485a6
