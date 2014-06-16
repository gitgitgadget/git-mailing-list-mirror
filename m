From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Mon, 16 Jun 2014 11:03:33 -0700
Message-ID: <1402941859-29354-3-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:09:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbL5-00089r-Bv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbaFPSIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:53 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:56255 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so1153573iec.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=78zzImt93KiHwRvK3C7361ivE3AEobdzvXx/qeuIyYA=;
        b=GMdcDw7cUQMJhGdrgEHX0Yca6eboAJ8PUtjs03FP8xK3D4kKbOix215CxEeDZPTeg7
         OqcK1PV6OdiV4UfRnDrp9C2PIYQ2f1KKfjSoWRetSRhfUURghTNGhANMxon265t7/8Gr
         PTePqpr1xruVnQM1EWFiQmLUg1QYDgx1iXy51TUEBLuZLtpOrbpixSznae+T+jpOGdaW
         +ZbYIx4UEB9/vtFJrdDNKRSZHCeOByS9lHbOoh2/wlKQ2kSwD56j5nO/nd1atkGSWCQ1
         9Ppka2J2yg9GgbiU9y7R0EOBI3Z+ncnZM9tWhzq8OeKm9swpbjF0H/grmiFO0NjL5cJB
         QF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=78zzImt93KiHwRvK3C7361ivE3AEobdzvXx/qeuIyYA=;
        b=YFsq6fEz4Goc0tzl1i7QSI9mYiqQfepC5OlY6cHlAN6VQ7mfCxhb6phFVZrU+gX5s1
         qDVLVhRRfr6iXkJXcCHU7S8O9em71TUzmcbg0c9rNbbXDTQmfeCWWTY/joJy9CA/7P5O
         i+fUIcx+LA1udCBZdRE+Aie6PiM4XEo3MgpU1n519FKxLIJtkZWhS+FyHGG8KCU0akCA
         eeOg63dj46Ojo4nlPZaepQ8ThA1OqiEngb6y1U5IEvKX2DiGkwSHsPgNI58o1stOT0MB
         TlwUa/vGQs6RDN9PKbx+6T9QPipdniyw7syRyZa7X263Dh4IH2mp28tEVTzLN8wyFoHf
         qMDQ==
X-Gm-Message-State: ALoCoQnM6r1Gx1RJPFAy1QmqwdwCWThweEHq4kPx0Na1em88WldcXHGZSW84XxojsZq0dL//Ihud
X-Received: by 10.50.67.38 with SMTP id k6mr363482igt.8.1402941862460;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si996723yhp.6.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 4A9F831C8AD;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EC7CFE0AF7; Mon, 16 Jun 2014 11:04:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251789>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 48573e3..33541f4 100644
--- a/refs.c
+++ b/refs.c
@@ -3483,7 +3483,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index a07a5d0..306d833 100644
--- a/refs.h
+++ b/refs.h
@@ -216,8 +216,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -265,7 +264,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.282.g3799eda.dirty
