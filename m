From: David Turner <dturner@twopensource.com>
Subject: [PATCH 3/5] pseudorefs: create and use pseudoref update and delete functions
Date: Mon, 27 Jul 2015 16:08:38 -0400
Message-ID: <1438027720-23074-4-git-send-email-dturner@twopensource.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
X-From: git-owner@vger.kernel.org Mon Jul 27 22:08:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJohl-00043a-V7
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 22:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736AbbG0UIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 16:08:53 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33783 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680AbbG0UIu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 16:08:50 -0400
Received: by qged69 with SMTP id d69so60328378qge.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 13:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ikaCM8lCawb4Wb23r8Iq54goapdQGnGNPskKTuXtHp4=;
        b=IU8nh00k+fNLNO8WySP8ibNGxs7rwH6YbdXCingOJ4wU4GLkIkwlBTbRnLxh3g8/PU
         eBbxDsEWLEcxIcHesVdYOugDtZTORJDQwSezhZvVJfiR0oC/W637Ep5cLSDHWazlnX3o
         dTH4HJnRxRfEWG/rkLXTokECqetA32ynGPiGz95xv7ZgD4qgMt9oiHHWztMusielpu7w
         XcBpmjufTFFdnwGr1gbWIGPrQADLx+c5LfSG++npiJt3XRa7krp1CJHkdDDiy9769mZ/
         ud3+rGdlAHDCIeT2mXn5JTps8AlzSg25Fs5qgZ4bhQFhd0R9/BgS0MAluajqk1OuTXMP
         jyKA==
X-Gm-Message-State: ALoCoQk5jfOXKitrdq7ymw801uCOZsgqRbchR8Xstph6XLsqhG+iIC0sxf0YjNVGkr8r1Khz1/KK
X-Received: by 10.140.85.208 with SMTP id n74mr43004337qgd.67.1438027729539;
        Mon, 27 Jul 2015 13:08:49 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 34sm9893690qkz.38.2015.07.27.13.08.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jul 2015 13:08:48 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274703>

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
index 0d10b7b..119ac9c 100644
--- a/refs.c
+++ b/refs.c
@@ -2871,12 +2871,87 @@ static int is_pseudoref(const char *refname)
 	return 1;
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
 
+	if (is_pseudoref(refname))
+		return delete_pseudoref(refname, old_sha1);
+
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
@@ -3970,17 +4045,25 @@ int update_ref(const char *msg, const char *refname,
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
+	if (is_pseudoref(refname) && 0) {
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
@@ -3995,7 +4078,8 @@ int update_ref(const char *msg, const char *refname,
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
