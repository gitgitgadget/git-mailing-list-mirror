From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 22/48] refs.c: update ref_transaction_delete to check for error and return status
Date: Mon, 16 Jun 2014 11:03:53 -0700
Message-ID: <1402941859-29354-23-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:07:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbK1-00072f-A3
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbaFPSHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:07:22 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:53244 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639AbaFPSEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:24 -0400
Received: by mail-oa0-f73.google.com with SMTP id eb12so1129918oac.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F+qHqhpL91m+kABrNYHO6jx4LCwKo2pqonBIlAcs5mg=;
        b=m5zsl0Hg6XO8lG5UlUCwUdyEj3c3Etpp89uLWNE3FyXhslTACuXwCvGt/07tbylO7x
         nDkBzuPCrzE60vg8vprIFGNOKc8lpe3rus0GcQMdDlvhBEch+sZgSYOfS7TZq3aaFGbb
         LArzifpxmPvcwmqxbxtd8O8zEOa/SVVa2kg36beDHKe/rVSfqIe8luMvRn14V44Xl6Sh
         cvxS/oZauOj/3rIBNcTi6dEmFoYUgJjbd61MxJJEhuW43Arw3Mt/i9RUzS89+sW9zQP9
         HWc3b9k+lMSmnQQBaGEr/YDEYfSYsRrcGr8cSQ6r7+JnopwjJiA9VIL9fNRsSTLMOKXD
         rA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F+qHqhpL91m+kABrNYHO6jx4LCwKo2pqonBIlAcs5mg=;
        b=mf+LX1uvKYKJdL3P567qwsj6VuN5hxzuTs1HGEUucKonUCUwYyx+wbx7d8pAYNMmgA
         OlrHAsnv/mt9l8Em+JPW4Mz9NoVtK/SgWh/D0YSJ75OJx8/2mExpMV4xKKqewKz+b2+E
         4aqZ0EFmWw0grvrSlWb8McbcjOdP5pOPZe1tVBOLpJttYVST6jHii8/4ClB7MnPSyshI
         zjJA0pdn4MwTfK6zU4khqS0dmqOL31ylm881HWrnK/8sz1b6+XCY2Bp20w4TPxvXrS4I
         QtCtcvvokrnY07hmALOZ4fg0mDFsRrwP7H+5OXSkSxBA5aK6tb+9jL9Yrm5OvE7MG9Tl
         dVUg==
X-Gm-Message-State: ALoCoQmsKnHq5bgwxzpsP9fE6+Y9AceGO5OQ0XH3RCr/DMLO9BpRVJcRD546cy0/Iz2QHWU3YgE8
X-Received: by 10.182.121.232 with SMTP id ln8mr355434obb.11.1402941863095;
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id c50si996130yhl.7.2014.06.16.11.04.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id EB7B531C8AC;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id CA075E0A0A; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251770>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future. Add an err argument that
will be updated on failure.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 16 +++++++++++-----
 refs.h               | 12 ++++++++----
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 41121fa..7c9c248 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old, &err))
+		die("%s", err.buf);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index 3dab75c..e544b35 100644
--- a/refs.c
+++ b/refs.c
@@ -3466,19 +3466,25 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
index 27c470c..193c818 100644
--- a/refs.h
+++ b/refs.h
@@ -311,11 +311,15 @@ int ref_transaction_create(struct ref_transaction *transaction,
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
+			   int flags, int have_old,
+			   struct strbuf *err);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.282.g3799eda.dirty
