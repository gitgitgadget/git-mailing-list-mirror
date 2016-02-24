From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 18/32] refs: allow log-only updates
Date: Wed, 24 Feb 2016 17:58:50 -0500
Message-ID: <1456354744-8022-19-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:01:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQb-0004iM-1N
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759270AbcBXXAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:00:53 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33005 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759091AbcBXW7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:34 -0500
Received: by mail-qk0-f174.google.com with SMTP id s5so13257888qkd.0
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/UOHGHbtJAXUVZhRjG1icwB8WXSYjTQKs+4/OPd7ri0=;
        b=ILkn0K2aHxMdb6MapvUNhwDvxVtpRKTS9xEas3Elq1sjPmlF2VhyLUXMEENZGnZpBr
         asO+tLfOqqvpxm4OLHVvZETjHhJIjmgfj7pdRTuCCODM4a5bWPbF2U3UUbcm9xxQDAN0
         od0ZMQIFlR3qgS+Nos+WK5lnikY3Vx7LRaLg/lhz72ApJP3IUDqUXf8zgNvWAso4H/Zh
         qI3nDzpLJ6bbic6UwYQcyPJJ0d2tuo3tdDTiz6GUNwu/6/f20xvdb45h4hpPahLNamuF
         HjnOcgN9ns3I3K1WVNTQUMnpnZGP/zRr1ETKNee1LzBXNoHYoU78J7NVBZAksO8Ulqfo
         NJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/UOHGHbtJAXUVZhRjG1icwB8WXSYjTQKs+4/OPd7ri0=;
        b=hdAwfMmGOOqPz6dOQ10ZGxxFY3O6N+MbDJTmTfAJo9QxC/Mguop4dN6JH+7yp0jSL2
         NulnOUCtYWoAYpcrGXIE9izV8g2dM7xRP5dEqVCp+s2A1v6QlXHuFbqgumg0UQlCLCBR
         qh0yUVS59DIoCXZEkRsSA0tAMzEg3u7iJQqQOLPOeL/WHbZ1VU2+oFtBoapydsRSaqWJ
         RSHYMSjh49hGVJ37w2bO1IH9SsSlotNFd4Iv/vTdZIVwVy0ct8lxuwBKKWP5PblYKKxM
         U7XOSPklPtYRr1pcsU0Q80pmPSvljrIZ9hm3dSL6a75rnxqMbA3k1IhryR/bpHljsS+i
         PfUw==
X-Gm-Message-State: AG10YOTB4rN8RC7GG9YG58y5NT45tdMtlv2W0BbF5W7u04/nbCgjSF3s755GePgB38YGDg==
X-Received: by 10.55.55.138 with SMTP id e132mr31060638qka.11.1456354773815;
        Wed, 24 Feb 2016 14:59:33 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:32 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287271>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  7 +++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 413db22..8dc80e2 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2711,7 +2711,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3065,7 +3065,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3095,7 +3096,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3112,7 +3115,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3132,7 +3136,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 94d162e..dd76246 100644
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
