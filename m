From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 09/42] refs.c: change ref_transaction_create to do error checking and return status
Date: Thu,  1 May 2014 13:37:09 -0700
Message-ID: <1398976662-6962-10-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmb-0003pn-JA
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297AbaEAUkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:24 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:56521 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbaEAUht (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:49 -0400
Received: by mail-ob0-f202.google.com with SMTP id gq1so798562obb.1
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ugDuu4qNsFlbUbAnNk9I71Xjc54PWX871plr2+ADG58=;
        b=Yvwhz/8ZGeAK6FoiXvKOnNxbjJP3IbPt9ONn8+ocQZmeH1Zdc/5D4gMHpMG+DZF10i
         b2NQgklrWlxCKWMVp65fnZ3cb4mD0utrbQGhOUmuVmhQY3A0QstJbUC6BIuegN/lQqKp
         vJN4ULYX99CpxT2oh69dj+bezGVYPX2GkE6r/SpsDmwQjMQhvkqWrW0cMmtBmjBJJBmM
         IdA+E4t3s2JevyY8zCk7ihTzijL5qc/AmxfFOG1e4yVontGPKnlOoMCxjgxNUKkJEqMI
         +l1rd5WMal0l5kVVq2CKYT6Kvbsn4ZFtuMYkal0YE6Abdd5WceQZ5KUIVj14komMe0Nn
         S7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ugDuu4qNsFlbUbAnNk9I71Xjc54PWX871plr2+ADG58=;
        b=ZDlbpQ42hPh7e9AEJkpTegBaIzPcQyx1TYGelPSKuVeGDjU9cNF+lKu0Ed/Q6W5x3M
         GOkB4ECcmsybFtBfb8w5qf/Tpr+sWCfZet1linJpb+bzVkHJOnQ5IHKsn5aWfythJyn7
         uzohhFQ1ijUg0qEkZGNLvHPDkc7AAMloV9jVUlNk5xFnLz8gVdwU/0uhjTnj2hennHYH
         3KfIWHEnldCt2xmtRD1U2d6Q4i7I6EIJOEpP1Bi8rAc3SHqImDueFshd86BmhEW+1WIT
         DxPUoR055vx0p25qV8c0dK04XbDPDPwuw9qKfuTnuOv+JrTeuX2AvZUsYtGkM5h7w0Xu
         137g==
X-Gm-Message-State: ALoCoQmyXnxEGPpcP605Pw/mj2aZat6kN+oK3itdQek0i4Eqi6xMxvUcQ+eCNqdhAKGSAHHNUM/K
X-Received: by 10.43.79.196 with SMTP id zr4mr6318473icb.3.1398976668661;
        Thu, 01 May 2014 13:37:48 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l7si2126342yho.1.2014.05.01.13.37.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:48 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 7E90531C2C1;
	Thu,  1 May 2014 13:37:48 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 436EDE097F; Thu,  1 May 2014 13:37:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247874>

Do basic error checking in ref_transaction_create() and make it return
status. Update all callers to check the result of ref_transaction_create()
There are currently no conditions in _create that will return error but there
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
2.0.0.rc1.351.g4d2c8e4
