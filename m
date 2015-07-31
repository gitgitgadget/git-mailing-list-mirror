From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 3/5] pseudorefs: create and use pseudoref update and delete functions
Date: Fri, 31 Jul 2015 02:06:19 -0400
Message-ID: <1438322781-21181-3-git-send-email-dturner@twopensource.com>
References: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 08:06:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZL3Ss-0002GR-QI
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 08:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbbGaGGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 02:06:35 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35470 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbbGaGGc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 02:06:32 -0400
Received: by qgii95 with SMTP id i95so39535470qgi.2
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 23:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIckhnKVkwA3f/RvB8ZQh66CAJfASczRaozhiJM8Xgg=;
        b=guuNknKQHyIsTcK9jpbgDgRWOjmJP+Kx8amPYPhZDZcJhiDr4u2DJFHYoPihGfCcOE
         CuOBrIEXLCv2b+/Fiij3SFhQfsxqNTazUD7KFlvIzpau/vOPCFu61PDRji/4pl+D6nyq
         iUyH5l77BunOlsTlx48F2BADsMHooMCVlR8RR0DFtnkxY+6eTpclS5aoWVhEJ3K3wNjq
         xxyrvB+9qgqLKEF7TQucLLLOTw0AFcX8zBSz1nbaVyJoHi+GRknUtU8Xk/bQN1/DVVjv
         93E5nEcEiRJ7gjG4GC2kfM3on8gs4Y6fHxqZDCha8CkkBTrHA9QV1rT/gMhr3NVyEEyw
         /sHw==
X-Gm-Message-State: ALoCoQmMjtfIZLeaR6FLxrgnrdAD58/Cynz61sKcMxtgzzt+lwyGeZomLoVPRahCUQLRqZDQGb9L
X-Received: by 10.140.91.66 with SMTP id y60mr1592087qgd.90.1438322791241;
        Thu, 30 Jul 2015 23:06:31 -0700 (PDT)
Received: from ubuntu.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id c35sm1737073qgc.47.2015.07.30.23.06.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2015 23:06:30 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438322781-21181-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275038>

Pseudorefs should not be updated through the ref transaction
API, because alternate ref backends still need to store pseudorefs
in GIT_DIR (instead of wherever they store refs).  Instead,
change update_ref and delete_ref to call pseudoref-specific
functions.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 0f87884..e6fc3fe 100644
--- a/refs.c
+++ b/refs.c
@@ -2874,12 +2874,88 @@ enum ref_type ref_type(const char *refname)
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
@@ -3973,17 +4049,25 @@ int update_ref(const char *msg, const char *refname,
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
@@ -3998,7 +4082,8 @@ int update_ref(const char *msg, const char *refname,
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
