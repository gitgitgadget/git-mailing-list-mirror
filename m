From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 12/44] refs.c: ref_transaction_delete to check for error and return status
Date: Thu, 15 May 2014 16:15:09 -0700
Message-ID: <1400195741-22996-13-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uC-00087D-0s
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbaEOXRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:36 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:33776 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbaEOXPp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:45 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so388988iec.4
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0CnSTtMq8ROcZq85na7F/5qq01GW2BC8sSxI0eIQQhQ=;
        b=KiMM3KY9KbQHYhNjk+IrjpL9oliBQ1fop44HGN2kvoDLXSQ0k4jq5ZZzYfWyFJICYO
         06czWw3YmSII2R77zK3yTwRtM1RneOQ0Svr6X4Gc8RI2uDCl3x26vNbj270Mnp8YLlQ3
         TKmTnKhXpkAmREv2a7dOweksTsPltnLJ8qgKG5zpOzocREJ9tGT8tof+CE7PVLWmj8WG
         C0IzIYvjAW8QVR4GhKs/Qy+tEaO0a6H/LYFeeLiZD+QiopKthwUtKYI+v/Os1o94Wm+t
         33U1MyQ8Fw3DnumD6tXfbuWRapPcndBUEvem7fDv+79tGzNMIU+9oLSBz36/Cm3/j8yP
         fwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0CnSTtMq8ROcZq85na7F/5qq01GW2BC8sSxI0eIQQhQ=;
        b=IqXt9JCG7K9SPdZArOvMVYKrrveC0Jy54yyeHYZyYExoefWstIU0HjF1/TFvoJsOsO
         CHSNcCn6JtOnGlRr8838YvwLcG0UXjE1q3LDz6CQR8/f5SCKNXiYzxQoizEf/WBVM9KT
         qtcL9ADYuUaXgUn8gBLaourkYQYbICQzoAbkszhXFmvUmqUmCPGZP8k2VPBQ0GKsiTTU
         ham4uw9NgIjVrvZ9TkpCrYKVtGXlTEWsJR+Z+STHLk4JURkiFeBZ0I6q6GRud51ZmJdT
         DY3tr5lrKl4g8BZAGYntGEE4KO98y+mGU5I+6AMOu1NWlptHiqPRKfGmqiCx72J30+Xy
         TUbQ==
X-Gm-Message-State: ALoCoQmav9Gwut5jiex/xdgo3vr6a76tUt6CvoUtkBiQozqbvKspeFqoq270Nmp7liv51aJDHQF6
X-Received: by 10.182.255.225 with SMTP id at1mr6680161obd.29.1400195745054;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n43si67807yhe.1.2014.05.15.16.15.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id D6D6C31C318;
	Thu, 15 May 2014 16:15:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95625E1747; Thu, 15 May 2014 16:15:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249255>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index e9c216e..cdb71a8 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, NULL))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 344e27a..7276b9f 100644
--- a/refs.c
+++ b/refs.c
@@ -3422,19 +3422,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
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
index 0af5ba7..2c2e694 100644
--- a/refs.h
+++ b/refs.h
@@ -272,11 +272,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure. A failure to delete
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.rc3.477.gffe78a2
