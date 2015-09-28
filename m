From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 06/43] refs.c: move delete_ref and delete_refs to the common code
Date: Mon, 28 Sep 2015 18:01:41 -0400
Message-ID: <1443477738-32023-7-git-send-email-dturner@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 29 00:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZggXo-000332-GT
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 00:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982AbbI1WFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 18:05:04 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33822 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbbI1WDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 18:03:03 -0400
Received: by qgez77 with SMTP id z77so134276665qge.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 15:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4nHcmwrGnVuwjh86AYDkX+7Jhu5hnBw+VQ0W1Ro4T0s=;
        b=jCGl08Pp+cTxGG5rqP8BNoH4hmQOSko4NLoFJTOicX0hn59I1ki1sHvh+3XugJGLA5
         suKNuwFlMI9gGV77nt+EwdaEIDgiRRNFrBi/rweZFMGpGWRlkhsr3vjFEoxdXzhCwBwk
         faTSd6j81XgPpXi9EfBAjbkLPdDTDh+XaaJoNYlo3VClVjtU/VkgeaQvqfRyUzxiYptR
         t4tlaw4HnUkHvVklLXCrabvsZJWGPMqKIv2Wo4olbzYd/6Wg98806OdJLnZdceeXk0CC
         3zNB8/IcFFMekyw+zFrH0qUSjJ1MwuO1et4DSGbL2LsyuBohabCDjWc8Qt4Jq7NZds+j
         boHA==
X-Gm-Message-State: ALoCoQl4jhhAAO9vyPcSpqft1WCo0E5dYQHqUao6HFJjiTdWaTd1tmvQFNWRNx6eZxhGLnpUgZkT
X-Received: by 10.140.82.199 with SMTP id h65mr25145336qgd.52.1443477782557;
        Mon, 28 Sep 2015 15:03:02 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 128sm7949979qhe.9.2015.09.28.15.03.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Sep 2015 15:03:01 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278793>

From: Ronnie Sahlberg <sahlberg@google.com>

Move delete_pseudoref, delete_ref() and delete_refs() to the refs.c
file since these functions do not contain any backend specific code.

Based on a patch by Ronnie Sahlberg.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 94 ---------------------------------------------------------
 refs.c          | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 2e8079e..666ba7f 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2889,100 +2889,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
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
-int delete_refs(struct string_list *refnames)
-{
-	struct strbuf err = STRBUF_INIT;
-	int i, result = 0;
-
-	if (!refnames->nr)
-		return 0;
-
-	result = repack_without_refs(refnames, &err);
-	if (result) {
-		/*
-		 * If we failed to rewrite the packed-refs file, then
-		 * it is unsafe to try to remove loose refs, because
-		 * doing so might expose an obsolete packed value for
-		 * a reference that might even point at an object that
-		 * has been garbage collected.
-		 */
-		if (refnames->nr == 1)
-			error(_("could not delete reference %s: %s"),
-			      refnames->items[0].string, err.buf);
-		else
-			error(_("could not delete references: %s"), err.buf);
-
-		goto out;
-	}
-
-	for (i = 0; i < refnames->nr; i++) {
-		const char *refname = refnames->items[i].string;
-
-		if (delete_ref(refname, NULL, 0))
-			result |= error(_("could not remove reference %s"), refname);
-	}
-
-out:
-	strbuf_release(&err);
-	return result;
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
diff --git a/refs.c b/refs.c
index 2d10708..205a899 100644
--- a/refs.c
+++ b/refs.c
@@ -116,3 +116,97 @@ int update_ref(const char *msg, const char *refname,
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
+		read_ref(pseudoref, actual_old_sha1);
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
+
+int delete_refs(struct string_list *refnames)
+{
+	struct strbuf err = STRBUF_INIT;
+	int i, result = 0;
+
+	if (!refnames->nr)
+		return 0;
+
+	result = repack_without_refs(refnames, &err);
+	if (result) {
+		/*
+		 * If we failed to rewrite the packed-refs file, then
+		 * it is unsafe to try to remove loose refs, because
+		 * doing so might expose an obsolete packed value for
+		 * a reference that might even point at an object that
+		 * has been garbage collected.
+		 */
+		if (refnames->nr == 1)
+			error(_("could not delete reference %s: %s"),
+			      refnames->items[0].string, err.buf);
+		else
+			error(_("could not delete references: %s"), err.buf);
+
+		goto out;
+	}
+
+	for (i = 0; i < refnames->nr; i++) {
+		const char *refname = refnames->items[i].string;
+
+		if (delete_ref(refname, NULL, 0))
+			result |= error(_("could not remove reference %s"), refname);
+	}
+
+out:
+	strbuf_release(&err);
+	return result;
+}
-- 
2.4.2.644.g97b850b-twtrsrc
