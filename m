From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 15/27] refs: allow log-only updates
Date: Thu, 18 Feb 2016 00:17:38 -0500
Message-ID: <1455772670-21142-16-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzP-0001Nb-F7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424914AbcBRFSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:50 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34456 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424900AbcBRFSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:48 -0500
Received: by mail-qk0-f178.google.com with SMTP id x1so14777216qkc.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GfICKHzuOv/iR9702A1i389Pm0ZOBFEpyJb7uqP3F6E=;
        b=IGezJ5eclfhf5M3ynoh3n3+BVhceWQcSBSdrc1GFmifY+t0GCJuXihPP6eXEbaq5mZ
         V4NpUw84w0kOBWfAdwFOGtN7Fh3EAwS+cpmem7a7M6/P4JzuwZEcJhF4VBkAG7t8KkiZ
         P4Wn/wK/MqrMSoNAg/KL4Mnv0iB04tUv5PpskVSHgUgDpgimbL7QDjMii/mXIa7cEIRp
         GLCxljDXoP65xESWJBMiuuTo+hAVexS4geLLrsVGLPVcmuSKeQ6SDQqppDSfkUuNzseA
         +ZMrjNj6DDzQhSfl056VTKD0OoBO3128mEV94UGv2mbI9mcF1dExVjyBQGyJCG3fTH0+
         ykLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GfICKHzuOv/iR9702A1i389Pm0ZOBFEpyJb7uqP3F6E=;
        b=XEL3HZUh5MdaOutnyYGSGWv9LZXpgjpP4/l08DDWvBTAii7ckDvpsyGRmIArzwDYWQ
         X+Hsn+NRWhbwbHPpXNHHbEO9Ed+jLKfDPbwGcsYw+Z2isM8iZchUdttP1U5AYODlGa4y
         aEI3FSlBx5bj5WLLI3kWOl8/lOv3PhTNu2tD6HctjIFr+BDHO4HDojkeNx41uk19P8dn
         MKy74VzCTn9wh5FgFxc0E6tTmxO3JH/98ZQbB0Fl2QqNRUXDPdIGpCTBHUy2rkm2tPkU
         hVMJOcrTvu/KhkbBDBROkeF8pFvbTnoCFqczhsJYRgRKRyXn3kFchIQTJ7pkdk65CS/N
         zLOQ==
X-Gm-Message-State: AG10YORmgG30PlC/z+UtkREsW7I0Sjwmx9e1Dt9kq72hQ9fPkYKLqtAZQG9Q4T8Rf0XnZQ==
X-Received: by 10.55.198.84 with SMTP id b81mr6935665qkj.4.1455772727475;
        Wed, 17 Feb 2016 21:18:47 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:46 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286581>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  7 +++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index da06408..592d0ff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2767,7 +2767,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3121,7 +3121,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3151,7 +3152,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 				update->flags |= REF_NEEDS_COMMIT;
 			}
 		}
-		if (!(update->flags & REF_NEEDS_COMMIT)) {
+
+		if (!(update->flags & REF_LOG_ONLY) &&
+		    !(update->flags & REF_NEEDS_COMMIT)) {
 			/*
 			 * We didn't have to write anything to the lockfile.
 			 * Close it to free up the file descriptor:
@@ -3168,7 +3171,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3188,7 +3192,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index efdde82..283f71f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -43,6 +43,13 @@
  */
 
 /*
+ * Used as a flag in ref_update::flags when we want to log a ref
+ * update but not actually perform it.  This is used when a symbolic
+ * ref update is split up.
+ */
+#define REF_LOG_ONLY 0x80
+
+/*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
  * example by causing a file that is not a reference to be deleted.
-- 
2.4.2.767.g62658d5-twtrsrc
