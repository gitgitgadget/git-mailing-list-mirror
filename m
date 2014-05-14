From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 08/42] refs.c: change ref_transaction_update() to do error checking and return status
Date: Wed, 14 May 2014 14:16:42 -0700
Message-ID: <1400102236-30082-9-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkgc2-0001Ck-2J
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbaENVVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:14 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:57410 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbaENVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:23 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so36549pbc.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=edpt6bC0uYtn5A/45jFQyjaxLLV74k44mXzvqkTcohU=;
        b=d+vCqppR8xyBrQ19VrhLKbFFkaL04CFiwdmgHdod3EqKxsAf353I1yHFyDCyte5XVA
         34ESvFvNe34VrlDxJpqdwRIOMZUTeYq/dn/wIRXW83r2DzTpFJO0ogaNNY/OaYGdVcYR
         mci5m+ynrsKrs1qc5/PbpX5PMky2S6LXFHKOY9EXU1jFeEel2W4N9KHLETET0YBGbtj/
         UIG716owfZLbgRUKGSZvFKSJQD/5Y+qHeYOiFqVQh9jBiSyPJdm9w8HQqBWpqbGQj2qY
         AjaCooyQA6VSlqPCqCUcc94h0ZB46ypl7RBbMmvqVsiYaSgnITerDBCraWwM9ZmCTTzA
         a/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=edpt6bC0uYtn5A/45jFQyjaxLLV74k44mXzvqkTcohU=;
        b=BXZNGYr4kcyO2qOoTZyhsjZakbqK2ifENngfBBrD1YsuFOd6ObejBde6W9q/XdGkLZ
         zgub2Xi9ctn3akRd5h//cyi7nIJD4OiT9BRy9DejGUeW9zBNn3wtj9MNztaJ1p4Ti3L1
         QKvObTsR8sI6xFGksx+1Iuppsm/VuXygGcm/No1Us9STJ0JV36S9VZU8eJBDVIQIvRjx
         3vxJNqAzNesj8QUtzSL4ItmThZK7JsAYdWx8Fd7hI5TVUPoJ37j9zRGuMkSPDULeLB6k
         hrV0nU5cYuveg/VMUfMtlgYpRFm8EfeXYK+dAz9dwHvGK4PcFoRn26L4Mgha92GIvxT3
         heGA==
X-Gm-Message-State: ALoCoQkUb4E2FZ48ejkJOp41fozKAiK/aF52pPG4V6lpfhiZzFVIPG6Yca0vdQhQWN/5/AdhcETi
X-Received: by 10.66.190.202 with SMTP id gs10mr3108483pac.0.1400102242738;
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si145551yhq.3.2014.05.14.14.17.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 712555A4292;
	Wed, 14 May 2014 14:17:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1BCE6E0CB6; Wed, 14 May 2014 14:17:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248990>

Update ref_transaction_update() do some basic error checking and return
non-zero on error. Update all callers to check ref_transaction_update() for
error. There are currently no conditions in _update that will return error but
there will be in the future.

Also check for BUGs during update and die(BUG:...) if we are calling
_update with have_old but the old_sha1 pointer is NULL.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 11 ++++++-----
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 2bef2a0..59c4d6b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("update %s: failed", refname);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction update for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index bfba348..77b27ce 100644
--- a/refs.c
+++ b/refs.c
@@ -3342,19 +3342,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
+int ref_transaction_update(struct ref_transaction *transaction,
 			    const char *refname,
 			    const unsigned char *new_sha1,
 			    const unsigned char *old_sha1,
 			    int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
 
+	update = add_update(transaction, refname);
 	hashcpy(update->new_sha1, new_sha1);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old)
 		hashcpy(update->old_sha1, old_sha1);
+	return 0;
 }
 
 void ref_transaction_create(struct ref_transaction *transaction,
diff --git a/refs.h b/refs.h
index 555ee59..57103aa 100644
--- a/refs.h
+++ b/refs.h
@@ -242,12 +242,13 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure.
  */
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.rc3.471.g2055d11.dirty
