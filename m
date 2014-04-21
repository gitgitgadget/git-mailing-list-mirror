From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 11/13] branch.c: use ref transaction for all ref updates
Date: Mon, 21 Apr 2014 15:53:29 -0700
Message-ID: <1398120811-20284-12-git-send-email-sahlberg@google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:54:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcN6u-00007R-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbaDUWym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:54:42 -0400
Received: from mail-ve0-f201.google.com ([209.85.128.201]:51622 "EHLO
	mail-ve0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754840AbaDUWxp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:53:45 -0400
Received: by mail-ve0-f201.google.com with SMTP id jy13so823084veb.0
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+UNfyXunyQ5VthuF+x0YlhdJ96v3meg98+TT/C/ghCs=;
        b=ksi3pC5cIqhqo0pYOH9qslK3mlU6ZsJNBo7MnFUo2GZPn8Qyd7IK/VYLRtdw6GwFbX
         iaSYD+BF9uR9p8bb1ZBujWZN3K7JrHPPRgWC/713kuZixzWZ8o2KDJvzLssT/2JlRHlh
         zYLWx3Ruizrqz9G3dacfGaxIYSRxaImEwRZeLR3svHmdsuBkIN6HRmf3nfXnRY2MbXPH
         F3RPbhKMkOrN55DIHCgxqMPrIz5aiGaVtFgOuqkysZICczkzZelfkc80OdXPDAgmxQKa
         8DkNgp8/JRxXetGcAGloED2xiDknkPFeu60aFsnaL+E5oiUuu4tPmuPScPpSEu+VD3Lr
         9Qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+UNfyXunyQ5VthuF+x0YlhdJ96v3meg98+TT/C/ghCs=;
        b=NjmRr3xJUdgQnN8zgyZkXMu1w04b6SD/zXroXUZKU3VAv7ljyAPIBxJIcqlymqKdRL
         TTwSgCPWyll+o5y/2eDM0Gqxl6sRqOxeQLvRlxzV57b47vxR3adhj5ZnuR+FfYotHERP
         k4kJ2BXqa+jbO7ill1pfgaP0bCfoTnwTQa5GpDTOFezlMFIJW4+74xGJMdl6sUei8XLe
         5gcRVm7lFyav1hMN/ZjxiwfzyLA5LnMtMz9a0NjTD04omW21jW+7DB2Z/XEUbQJ1jw5i
         XVgZBkMzlEElLjfXjisSA0/QPtX5q2vKKqprRobPUSAk09v0tRBuk/bLV+UmV/w9ECTo
         R2qA==
X-Gm-Message-State: ALoCoQnBW2lVZO3C295ZoX9BvTmviRyxIz9cl4vblq6IoNaGwcEtpDbZJW1vFybGx0D7ZC8NO1g/PmuH7OjRa6QZXue+n+4qULPG/Dw4p0ZzpKfQzN7jyjezrBQX5QGtamRq2IZYCeIwGLkjxeje/D7yu/tEvCv/xuWnW0I7BnmQXcF3Wqixxgmcyrp1Apjzu2JQWBueHeHT
X-Received: by 10.58.198.3 with SMTP id iy3mr20740577vec.39.1398120825142;
        Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id e40si5369771yhf.0.2014.04.21.15.53.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Apr 2014 15:53:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F097E5A4207;
	Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B533CE06AA; Mon, 21 Apr 2014 15:53:44 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.515.g3b87021
In-Reply-To: <1398120811-20284-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246673>

Change branch.c to use ref transactions when doing updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..45c7766 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,7 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
+	struct ref_transaction *transaction;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -286,9 +286,12 @@ void create_branch(const char *head,
 	hashcpy(sha1, commit->object.sha1);
 
 	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
+		transaction = ref_transaction_begin();
+		if (!transaction)
+			die_errno(_("Failed to begin transaction"));
+		if (ref_transaction_update(transaction, ref.buf, sha1, NULL,
+				   0, 0))
+			die_errno(_("Failed to update transaction"));
 	}
 
 	if (reflog)
@@ -305,8 +308,9 @@ void create_branch(const char *head,
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
 	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
+		if (ref_transaction_commit(transaction, msg,
+				     UPDATE_REFS_DIE_ON_ERR))
+			die_errno(_("Failed to commit transaction"));
 
 	strbuf_release(&ref);
 	free(real_ref);
-- 
1.9.1.515.g3b87021
