From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 12/44] refs.c: ref_transaction_delete to check for error and return status
Date: Thu, 15 May 2014 10:29:27 -0700
Message-ID: <1400174999-26786-13-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:32:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzWD-0002mh-IH
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbaEORc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:32:28 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:41523 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbaEORaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:07 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so257150pab.5
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8/DFUq0RcIbu/w1/XA4oXutjJCQvOIj3pHVC9EqLQ0=;
        b=S6gIr/JVMM31QObbL/6WXfXya1Re7u4nBVtX8tG4FvVvL7i9OZWDTkj2Dv7Z0rRdhL
         nmnhB4Al9VYJjsXGIdnKoncAblGjg+Q35uK/1DjOO/wJojp3LFfW3xrnPJDSXTMmiITw
         wkPAOKjbcpG//arCbCsq4Iwk5U5fwPGdHo0AnPyi+i56ePG2Gl2IE1Kp0DCLD5XViiHL
         dD4+q2qBudZrThsC4t55F3wYxS4w65Gv6SjPc5suIpIQeUc61oYaSWoVrrPqZn41zW+4
         xm4vSCB/u34TXrEF0MrtrfMpvaEfja3M9vLFM1Yr/E3MjHwSTI3C3FHWlYs1uzAYuHRn
         B7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8/DFUq0RcIbu/w1/XA4oXutjJCQvOIj3pHVC9EqLQ0=;
        b=T5iMYl6P9YFmB9j9uVNY9jFPjX/HzZscj7W0ArHzglUKSoM9VamVFQs00Ba/JcUxKJ
         uzOc6iQ/NQG4MUzySe3xa5MCCfeF4vLCYHsm/+ZudnquF4PZxbQQlbspJGrW0XDlWbTt
         Xn1Vv1AY75QQdd7cZdIZXBfBGFIpqUIws76/WI29Ui+n5R2JiqJA4trCpU9NoJ+PtYNK
         2dA+IqfRRvujT2pXGyBh4+29W54OW8aUjTuNheiCPcnBEqgc4IXMQNzxNpadNqIgRDO8
         RTZgQby67AjL6o8dGCV1LLik/wGDRIJOf6ZucPjfVvrsje6M9GLFd10Z4UI6bTR4nuLa
         aYNA==
X-Gm-Message-State: ALoCoQkYxRkU85uJ4XQOqB8ioevRfh1hp6Kdar33Ryou/P9GnKkg4nD8teqsV+aBDzENBF40KEzE
X-Received: by 10.68.197.73 with SMTP id is9mr5618537pbc.0.1400175006285;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si272069yhl.7.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 1F29831C1CD;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D4DC2E11CC; Thu, 15 May 2014 10:30:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249158>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               | 11 +++++++----
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0924502..2a51df1 100644
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
index f38d3d6..6e5e940 100644
--- a/refs.c
+++ b/refs.c
@@ -3392,19 +3392,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
+		die("BUG: have_old is true but old_sha1 is NULL");
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
index e3bdd57..cba2f3d 100644
--- a/refs.h
+++ b/refs.h
@@ -270,11 +270,14 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back.
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
2.0.0.rc3.477.g0f8edf7
