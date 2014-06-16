From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 20/48] refs.c: change ref_transaction_update() to do error checking and return status
Date: Mon, 16 Jun 2014 11:03:51 -0700
Message-ID: <1402941859-29354-21-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKH-0007JM-HM
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbaFPSHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:16 -0400
Received: from mail-yh0-f73.google.com ([209.85.213.73]:65420 "EHLO
	mail-yh0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-yh0-f73.google.com with SMTP id f10so854997yha.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZNDmHaU4zIhoSkWTzN2t4yOIUXZvMnz5RLchojyujS0=;
        b=I8Iep0ihsKTVCX7ZM+Ne2iJ/BbdKdYClFCvzTApKu/Zk+bc8E3T7Al/WNDxDttXAFa
         3Jcd3+td9yA2UQO6WESrhCPQjmbnK7DYGxhB36UGUH1v/Wp8FtSzpQtmbX7CoghgjmGM
         Ti7wI83kQtIP4Gk/cbjLu5ZK7Rdj9ORS1/rJcyOEy1Vhkwv0KRYH5sBz6W2R26b5Pv9i
         wnyCpr0ZElPXHmiGs4mgdsIYnKLi64VnwGYhGnZXkcBk6ce9+z46CBr8+4Jb9idYjhkG
         whrr3eXqCqz7pSyCXcgbyin+eFhZVqxi5ds0h7lmse+I8BkU2jHUtmjFA0brZNzDw6LM
         V0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZNDmHaU4zIhoSkWTzN2t4yOIUXZvMnz5RLchojyujS0=;
        b=hKoeYvvCE7PrAFBNlPvHH4S5g0guYG32Od1GLO6ivucMZ8u4SWLVP0JIyNeQwi+4tJ
         N3ySphoyJ/XGbSWboNR6vgHDdPzC2pyJUYuuQCAXGrllid17ImA0kR7hA/5sVT68K+99
         spSPs4Ts/C2BL6V2cHNVzQUfExJv0MjcMvLrGfWUWPsybtY14UXD30vaFgRyys7hlNMF
         909s7PSKVZrL0+Ry4BsJKr5Z9ydjHuvNKKtPh3BkBrrxvNJELKOcdy9WqRJ8rpQ+T3MX
         lAvGUX0OE3HKmhSJKGTLR6SlPIuDzxX/ElIhK6gMoVkP8nB7LXZGZZUSCYR3LQuNVhNC
         6r6g==
X-Gm-Message-State: ALoCoQm7iq8AnWeJUPcI7e89Qp8YblrI2Ux7VejU0Bccu/dFMhYll2V3gKK2T+ZoM6uAyfuDAtKZ
X-Received: by 10.52.175.3 with SMTP id bw3mr1327744vdc.5.1402941862926;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si998235yhe.1.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B351B5A4912;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95BBDE05A0; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251776>

Update ref_transaction_update() do some basic error checking and return
non-zero on error. Update all callers to check ref_transaction_update() for
error. There are currently no conditions in _update that will return error but
there will be in the future. Add an err argument that will be updated on
failure. In future patches we will start doing both locking and checking
for name conflicts in _update instead of _commit at which time this function
will start returning errors for these conditions.

Also check for BUGs during update and die(BUG:...) if we are calling
_update with have_old but the old_sha1 pointer is NULL.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 12 +++++++-----
 refs.c               | 18 ++++++++++++------
 refs.h               | 14 +++++++++-----
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 88ab785..3067b11 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,6 +16,7 @@ static struct ref_transaction *transaction;
 
 static char line_termination = '\n';
 static int update_flags;
+static struct strbuf err = STRBUF_INIT;
 
 /*
  * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
@@ -197,8 +198,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
@@ -342,7 +345,6 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
-	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
diff --git a/refs.c b/refs.c
index fdbd107..9c02687 100644
--- a/refs.c
+++ b/refs.c
@@ -3425,19 +3425,25 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
 	return update;
 }
 
-void ref_transaction_update(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *new_sha1,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_update(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *new_sha1,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old,
+			   struct strbuf *err)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
+
+	if (have_old && !old_sha1)
+		die("BUG: have_old is true but old_sha1 is NULL");
 
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
index 1eb447d..f7a5e42 100644
--- a/refs.h
+++ b/refs.h
@@ -242,12 +242,16 @@ struct ref_transaction *ref_transaction_begin(void);
  * be deleted.  If have_old is true, then old_sha1 holds the value
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
+ * Function returns 0 on success and non-zero on failure. A failure to update
+ * means that the transaction as a whole has failed and will need to be
+ * rolled back. On failure the err buffer will be updated.
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
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Add a reference creation to transaction.  new_sha1 is the value
-- 
2.0.0.282.g3799eda.dirty
