From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 06/44] refs.c: move delete_ref and delete_refs to the common code
Date: Mon, 12 Oct 2015 17:51:26 -0400
Message-ID: <1444686725-27660-7-git-send-email-dturner@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Oct 12 23:54:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zll3D-0006Ne-I5
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 23:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbbJLVyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 17:54:32 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34868 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbJLVwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 17:52:20 -0400
Received: by qkap81 with SMTP id p81so63248896qka.2
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 14:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=irj0bNacuPqKLKIgSxUiSokAVy9rmAaIjHWdv1sjEx0=;
        b=RdCLO1mGccIB9GknGT7xVcRp1u5sUYtZGm7Ujq1f74+tfJEl8n6F+WgcznopLFimgq
         qRaJ5PQyppSUycd3SGLpBIOiOcibRsRX79jYB/konx1XopuymcPBZiGRogoSg4J2inOC
         rvcaQfq751pA9s++QRrAh8qwDtXjcisMp+7xed32xuFqnghCvekGUlmsMeIg2wV9gZxe
         dSWAhsEIUnayTpGpULT/x9VR7ClHD0plN0OIJLfltWMtEqWIcF8pOhQm4MZvXMvg/1Sj
         XL9qQjtBzdrPQFub0zam/fP8ztORGkigdSyXprQAkavsDCDAfh8AboxGwXRrfSOLe3pt
         K2WQ==
X-Gm-Message-State: ALoCoQkM87zChgTNH83/Vz/cphhaAr3SteLb9CwvKtk4jwW+2eB6oxxhfU0vDB82LAzzZ85hAP12
X-Received: by 10.55.40.224 with SMTP id o93mr35002267qko.106.1444686739504;
        Mon, 12 Oct 2015 14:52:19 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id q140sm7865647qha.5.2015.10.12.14.52.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Oct 2015 14:52:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.644.g97b850b-twtrsrc
In-Reply-To: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279463>

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
index 7fe4931..099df75 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2877,100 +2877,6 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
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
