From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 4/6] pseudorefs: create and use pseudoref update and delete functions
Date: Tue, 28 Jul 2015 14:12:22 -0400
Message-ID: <1438107144-24293-5-git-send-email-dturner@twopensource.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Cc: mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 20:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9N3-0004nU-JQ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753164AbbG1SMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:12:49 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34240 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbbG1SMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:12:48 -0400
Received: by qgeu79 with SMTP id u79so80267544qge.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f1XdE68wsNdErM3zY1RJfqFnaUHs7nvZCHPpI3YNDuI=;
        b=OHUPAYXJ905faw0wHDg/mL+hwmWMifa4O+Y/Uc8s48vEV8gEBZ0SQW9IwBdhiJ1HuI
         MaX17zybdfBfETiEkXVnSg1gIrPvZmQ3IHYeKxcKfi9wqpvHa/dbHTvWYTm/vdqILWKg
         8s5pJCGBIil+l9tMZpOtRc9B9kI/B/f4w3pLxHpuIYm2yeDQka8r41JB9LSz1dkKLJyH
         3utxmJHPk80qB67wMKnujxMZSroZv0iqniB+1lj5TloMKqrP2Ag5XEUaO8OukEW7nfJ3
         oyuF6OhYlFzRW9vlu54uzoZCCWeOv91iCQPwtuMZFdf4D55Yrawp2ePdmPrqDVVaXF1J
         YsQw==
X-Gm-Message-State: ALoCoQkS3Z6qczteyOvaFTDPkyXT3dy71Lk35QOyQB0/hrtMxKp3Q/p/g8l2BLLyy4sHqp89J0Bg
X-Received: by 10.140.88.80 with SMTP id s74mr50868034qgd.59.1438107167105;
        Tue, 28 Jul 2015 11:12:47 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm11653540qkz.38.2015.07.28.11.12.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 11:12:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274805>

Pseudorefs should not be updated through the ref transaction
API, because alternate ref backends still need to store pseudorefs
in GIT_DIR (instead of wherever they store refs).  Instead,
change update_ref and delete_ref to call pseudoref-specific
functions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 553ae8b..2bd6aa6 100644
--- a/refs.c
+++ b/refs.c
@@ -2877,12 +2877,87 @@ enum ref_type ref_type(const char *refname)
        return REF_TYPE_NORMAL;
 }
 
+static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
+			   const unsigned char *old_sha1, struct strbuf *err)
+{
+	const char *filename;
+	int fd;
+	static struct lock_file lock;
+	struct strbuf buf = STRBUF_INIT;
+	int ret = -1;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+
+	filename = git_path("%s", pseudoref);
+	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (fd < 0) {
+		strbuf_addf(err, "Could not open '%s' for writing: %s",
+			    filename, strerror(errno));
+		return -1;
+	}
+
+	if (old_sha1) {
+		unsigned char actual_old_sha1[20];
+		read_ref(pseudoref, actual_old_sha1);
+		if (hashcmp(actual_old_sha1, old_sha1)) {
+			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
+			rollback_lock_file(&lock);
+			goto done;
+		}
+	}
+
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
+		strbuf_addf(err, "Could not write to '%s'", filename);
+		rollback_lock_file(&lock);
+		goto done;
+	}
+
+	commit_lock_file(&lock);
+	ret = 0;
+done:
+	strbuf_release(&buf);
+	return ret;
+}
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
 int delete_ref(const char *refname, const unsigned char *old_sha1,
 	       unsigned int flags)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF)
+		return delete_pseudoref(refname, old_sha1);
+
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
@@ -3976,17 +4051,25 @@ int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr)
 {
-	struct ref_transaction *t;
+	struct ref_transaction *t = NULL;
 	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
 
-	t = ref_transaction_begin(&err);
-	if (!t ||
-	    ref_transaction_update(t, refname, new_sha1, old_sha1,
-				   flags, msg, &err) ||
-	    ref_transaction_commit(t, &err)) {
+	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
+		ret = write_pseudoref(refname, new_sha1, old_sha1, &err);
+	} else {
+		t = ref_transaction_begin(&err);
+		if (!t ||
+		    ref_transaction_update(t, refname, new_sha1, old_sha1,
+					   flags, msg, &err) ||
+		    ref_transaction_commit(t, &err)) {
+			ret = 1;
+			ref_transaction_free(t);
+		}
+	}
+	if (ret) {
 		const char *str = "update_ref failed for ref '%s': %s";
 
-		ref_transaction_free(t);
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR:
 			error(str, refname, err.buf);
@@ -4001,7 +4084,8 @@ int update_ref(const char *msg, const char *refname,
 		return 1;
 	}
 	strbuf_release(&err);
-	ref_transaction_free(t);
+	if (t)
+		ref_transaction_free(t);
 	return 0;
 }
 
-- 
2.0.4.315.gad8727a-twtrsrc
