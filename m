From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 08/19] refs.c: change ref_transaction_update() to do error checking and return status
Date: Fri, 25 Apr 2014 09:14:43 -0700
Message-ID: <1398442494-23438-9-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:16:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdins-0000OR-2J
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbaDYQPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:15:11 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:54246 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbaDYQPE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:04 -0400
Received: by mail-qa0-f74.google.com with SMTP id w8so633930qac.1
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+Y8hmLxd2AV5AYldTXl+4hHl3eHR83X63QHZb33T2Ss=;
        b=LHS+vcFF9dYn9m44nJM/nVNXpK/FWqILrWm3wvy1mAw7xhi3VrEk6hCm6iXnUiYGRx
         D6wtsikoD4sO6a6GmtmVeHskhRiUsb2AveI7k/h7rO6KL0RyWE32RU/8f4D76GO9LxSm
         Khxiuq+jtlPKx7AA2zK1RBVrNfdBaRui5v8hkiVqaHSmb9/FFUpcaMGQOA6Y5Eemsn0U
         Uk9TdnhPqiYtG/KymLrBCw38y0Q+2+uKs5kr4V/tGqVFeOstPYzGNbK/NPKoWnkV7kxd
         WZIk7lIMFR95BJziC2bdXXS0zZdqjzKSSa7O7b1uuQsqcwGdFKrW/a01FGdkuqaJFpPU
         ap+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+Y8hmLxd2AV5AYldTXl+4hHl3eHR83X63QHZb33T2Ss=;
        b=c1Ojji40p6nnlGuIq/UX0+AtRFNKc1wBqp/KFjVflzdEtadEwdDidNpxAxbVZ1pOXu
         AJwJEctXUoSo2sJ/CoWQqMMSztMEonm/rXT7Zr7JDhPek042lmaLY2FGxIxSu33rAqJe
         ho2MKolPx6Ye2jxg797VDiVUojkyylJtu+znSAMOvHIQs7CHYb7an4aRMGh6Y6GGLZ5O
         kMfVQ9cY6c7LI1gHgDd0TPukjQMDnbEq1zCccLi13gTLEyV0ZJWMlUUiUOPUjKCvH10C
         foi9jy0SN84foceatyHU7M6NHunx3DUqaPgcapMuw9jOHgrDTDFd1N9IBrq8ZwN6RlbK
         99Cw==
X-Gm-Message-State: ALoCoQm+HpTQlLH++kRgaRXbRtsJlP8XwUYF2dAKlR2t4p8lVl75at8NOcnru/kXbVyuzCEJCz9JXn26OWax47gx6/6R8ELNTiFaCB3s6K+1YYCM/mePz7KP/IUw7Kd7iE4puijJn7Li17xiTO6lsjLx+YTXTlZ6hPcApvYdJwKxz6io3+CkNIQlrACMqLqyh/eJ3bV+V1EK
X-Received: by 10.58.105.65 with SMTP id gk1mr5416698veb.28.1398442503144;
        Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si124489yhl.7.2014.04.25.09.15.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 03D4831C25D;
	Fri, 25 Apr 2014 09:15:03 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AE92CE0855; Fri, 25 Apr 2014 09:15:02 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247057>

Update ref_transaction_update() do some basic error checking and return
true on error. Update all callers to check ref_transaction_update() for error.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 ++++++----
 refs.c               |  9 +++++++--
 refs.h               | 10 +++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index df3cd92..13d094d 100644
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
index 0e2df81..65cf407 100644
--- a/refs.c
+++ b/refs.c
@@ -3334,19 +3334,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
index f3db632..6a361d7 100644
--- a/refs.h
+++ b/refs.h
@@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
  * that the reference should have had before the update, or zeros if
  * it must not have existed beforehand.
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
1.9.1.521.g5dc89fa
