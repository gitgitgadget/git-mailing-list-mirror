From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 12/21] refs: allow log-only updates
Date: Fri,  5 Feb 2016 14:44:13 -0500
Message-ID: <1454701462-3817-13-git-send-email-dturner@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 05 20:45:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRmJe-0001PF-3S
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378AbcBETpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 14:45:10 -0500
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33117 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267AbcBETo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:44:57 -0500
Received: by mail-qg0-f49.google.com with SMTP id b35so75923408qge.0
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rkFR96azBiMNmLG2jST28cZ9+ADI9HbQGCkLbnLw9HA=;
        b=YQMKT8EzZ29GPdbpC6b80qr0Q7GU8SFAwmv3uUFAMdSEXEU5+/uqGp8t5etB3BziPL
         coPYF+j6YoIpFDIFEFzNMTzupHrpejEqED+m1cXbX1BIb+JoK9Kj6Ucs1Q/3zjbWKO13
         8YWLesiR0a9BExMv8q/h0J+18SPQQmWmei/x/gGudiOs4v3b2mCuQChWmUAkW7pzAJCs
         JqMUveoPNjNxk9wATYeqZlJTbDAmkAbBYG8kbr9fs6M61JD8+OUzoQ4wvXSTEOc+6USN
         x1mJswF0dGDWXoXqc/ONLdGSkBEapCCdqfCdctvGOhRWfTx8F/O2usdX4EhNIeaYufNC
         bEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rkFR96azBiMNmLG2jST28cZ9+ADI9HbQGCkLbnLw9HA=;
        b=kksZn8b/0B/kPJNt0KPYaaetz9dITpxFO3Hd8iAak4epK6UtNMaPznZWeViH42Di3n
         7qh9oljpxH1+FCHwFtNfqUh3pUuhmJo08Aaorjl4L8WMiyN8mcqR3R5Oeofbbps51Y5/
         tC8pDEsgiQ5yTyL1Ykqa3jYjdD+BdfOWh+1yPJE8Yf1OkONr9mXMWhtnxFljX6jV+fT1
         oyS2f/M5wnVB0+yDaUbIzaNcVaAQL0SshdnqBOcvwSpeSQFhYHs/RhXmRzc4Hjdva/US
         9oxCMYt/ulpPM+YN49uUYDZHzv/TFKaD91pBH3Jb3yInrtfhwRii3DHmseESy/guDpee
         70og==
X-Gm-Message-State: AG10YOQh983Fp+lC9fQaUrhlwCo7lAPW+acMzLu1Dy16eLDdJu5BfGsKIYDnQiUUk/MQOg==
X-Received: by 10.140.96.245 with SMTP id k108mr19353301qge.31.1454701496938;
        Fri, 05 Feb 2016 11:44:56 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g109sm8565535qgg.40.2016.02.05.11.44.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Feb 2016 11:44:55 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285611>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ad60bc..0fdcdc7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2845,7 +2845,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3199,7 +3199,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3229,7 +3230,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3246,7 +3249,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3266,7 +3270,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index fc5d1db..b5d0ab8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -42,6 +42,8 @@
  * value to ref_update::flags
  */
 
+#define REF_LOG_ONLY 0x80
+
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
  * deleting a loose reference by this name will not do any damage, for
-- 
2.4.2.749.g730654d-twtrsrc
