From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 06/26] refs.c: move delete_pseudoref and delete_ref to the common code
Date: Thu, 15 Oct 2015 15:46:30 -0400
Message-ID: <1444938410-2345-7-git-send-email-dturner@twopensource.com>
References: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 15 21:48:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmoVk-0007kB-Fb
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 21:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbbJOTsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 15:48:16 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35534 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbbJOTrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 15:47:12 -0400
Received: by qgt47 with SMTP id 47so80817166qgt.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 12:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NDh1/ceyETBB7033euMSoUN1B9f9LrAF0PsB0p1sy1I=;
        b=QW2KQLUjGgxkfQx1OtZ4kz/WjFboIecrf4+YvyEBdDapHpjAkbimUtNfZNNW9hlwLK
         y7KOUMnxhzwbVSMVNMF45H/iGV0MT+0Z0Jauo4TsKlTbRYjcgX97UPmWA0UX7i1pycjp
         YmlEiGjBSgTnQXe4iXkgp7AVAH2uXeSse8is/ix+LJq7O4iD5hzk4XlNRIBa46hXOmRN
         kOLl6GqF5yp9hntLkyMHn+V/FAiptuIhDlqP0m/IwaJT9vl3MdtKMk2R2onv6Qrq8uHW
         wXMP9Macp+Ig4yozHyh4lCC8FrIU4H/j68ncp7YVDuKgjFcj0HSGfhG7jEu+V8lREoTw
         qDnQ==
X-Gm-Message-State: ALoCoQmZAmR7GFXC+2gHhhZcs+1v/Ro7WHaDjw+ZrZv1GnwmMVHbP/OhO8mZYPs6klP6tvQqe+DX
X-Received: by 10.140.144.8 with SMTP id 8mr14612534qhq.54.1444938431760;
        Thu, 15 Oct 2015 12:47:11 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p193sm6054142qha.29.2015.10.15.12.47.10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 12:47:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444938410-2345-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279703>

From: Ronnie Sahlberg <sahlberg@google.com>

Move delete_pseudoref() and delete_ref() to the refs.c file since
these functions do not contain any backend specific code.  We can't
move delete_refs yet because it depends on the files-backend-specific
repack_without_refs.

Based on a patch by Ronnie Sahlberg.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs-be-files.c | 56 --------------------------------------------------------
 refs.c          | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 72a9bc4..d969066 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2885,62 +2885,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 	return 0;
 }
 
-static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
-{
-	static struct lock_file lock;
-	const char *filename;
-
-	filename = git_path("%s", pseudoref);
-
-	if (old_sha1 && !is_null_sha1(old_sha1)) {
-		int fd;
-		unsigned char actual_old_sha1[20];
-
-		fd = hold_lock_file_for_update(&lock, filename,
-					       LOCK_DIE_ON_ERROR);
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"), filename);
-		if (read_ref(pseudoref, actual_old_sha1))
-			die("could not read ref '%s'", pseudoref);
-		if (hashcmp(actual_old_sha1, old_sha1)) {
-			warning("Unexpected sha1 when deleting %s", pseudoref);
-			rollback_lock_file(&lock);
-			return -1;
-		}
-
-		unlink(filename);
-		rollback_lock_file(&lock);
-	} else {
-		unlink(filename);
-	}
-
-	return 0;
-}
-
-int delete_ref(const char *refname, const unsigned char *old_sha1,
-	       unsigned int flags)
-{
-	struct ref_transaction *transaction;
-	struct strbuf err = STRBUF_INIT;
-
-	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
-		return delete_pseudoref(refname, old_sha1);
-
-	transaction = ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_delete(transaction, refname, old_sha1,
-				   flags, NULL, &err) ||
-	    ref_transaction_commit(transaction, &err)) {
-		error("%s", err.buf);
-		ref_transaction_free(transaction);
-		strbuf_release(&err);
-		return 1;
-	}
-	ref_transaction_free(transaction);
-	strbuf_release(&err);
-	return 0;
-}
-
 int delete_refs(struct string_list *refnames)
 {
 	struct strbuf err = STRBUF_INIT;
diff --git a/refs.c b/refs.c
index 610fab0..f4f0677 100644
--- a/refs.c
+++ b/refs.c
@@ -117,3 +117,60 @@ int update_ref(const char *msg, const char *refname,
 		ref_transaction_free(t);
 	return 0;
 }
+
+
+static int delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
+{
+	static struct lock_file lock;
+	const char *filename;
+
+	filename = git_path("%s", pseudoref);
+
+	if (old_sha1 && !is_null_sha1(old_sha1)) {
+		int fd;
+		unsigned char actual_old_sha1[20];
+
+		fd = hold_lock_file_for_update(&lock, filename,
+					       LOCK_DIE_ON_ERROR);
+		if (fd < 0)
+			die_errno(_("Could not open '%s' for writing"), filename);
+		if (read_ref(pseudoref, actual_old_sha1))
+			die("could not read ref '%s'", pseudoref);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			warning("Unexpected sha1 when deleting %s", pseudoref);
+			rollback_lock_file(&lock);
+			return -1;
+		}
+
+		unlink(filename);
+		rollback_lock_file(&lock);
+	} else {
+		unlink(filename);
+	}
+
+	return 0;
+}
+
+int delete_ref(const char *refname, const unsigned char *old_sha1,
+	       unsigned int flags)
+{
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
+
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+		return delete_pseudoref(refname, old_sha1);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_delete(transaction, refname, old_sha1,
+				   flags, NULL, &err) ||
+	    ref_transaction_commit(transaction, &err)) {
+		error("%s", err.buf);
+		ref_transaction_free(transaction);
+		strbuf_release(&err);
+		return 1;
+	}
+	ref_transaction_free(transaction);
+	strbuf_release(&err);
+	return 0;
+}
-- 
2.4.2.644.g97b850b-twtrsrc
