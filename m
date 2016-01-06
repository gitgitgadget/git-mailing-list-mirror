From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC v2 1/3] refs: allow log-only updates
Date: Wed,  6 Jan 2016 18:41:57 -0500
Message-ID: <1452123719-22634-1-git-send-email-dturner@twopensource.com>
References: <567A5516.9070209@alum.mit.edu>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Jan 07 00:42:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGxiq-000380-Az
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 00:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcAFXm2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 18:42:28 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33497 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcAFXm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 18:42:27 -0500
Received: by mail-qk0-f177.google.com with SMTP id p186so87653091qke.0
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qch+KX1TsP+BsIA6rrgdPgupyWozhuPdtToVoxqi7uc=;
        b=fnKlf/ny1sOC5nwZ5VTluAa82RJ3LU9v/tehWJ+xyA1zFXSiCk9uqT/Mf6ScIaD0rt
         NEg2ek64g9C/PGEFuJcsInqWvTHKBGwFZSxN/am3fNgYf/FxX9+ZbZcutp1vA/YTTxPT
         76lZOkPuEuJ3Oj7AZZ2pGGCyXIlXAwS5gol92Er4J2Friq5n/93ftKJPN99rwER8HSSI
         drfhSoS/JY8JAqJoNP/od5JdbxS2sNXkLOGSypkZve9WNr+zSyGmXkfDbwfXOw0Tcdiy
         Il2O0PBthLZAz53XS/PXz8nabb+7oXCMcP9PtGPBZqLk1X9sfz2Hq3d5/5mGs3govq2x
         7qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qch+KX1TsP+BsIA6rrgdPgupyWozhuPdtToVoxqi7uc=;
        b=i4EEa0/UkGCNsMSUSxg25eCW4D99Zum1WZgqyRB2MSqGFjnH5nHUjO8lQojiZjCeTd
         8GgTzXvtg/vrEHLHsBZusyQiE/KwXHazyZ4D5AYgx6gQ8ArYHdW8Pb3Wb7+oRPe8CWlW
         1bV4+RvapXSO0FlxZvgcODYLvq4r/+9IpURBGTSZdaOKbG0xyNZaInft9SsVRAwuhM37
         woYCfyb9iLgEUZpDBCBVvepVhmNV2YJ7WlGCELzl8udZI3odAlG4Pu+pA6oSlVIr34qw
         Syy7S7v3bktq3BqFjq5zS4VyjbZhvz0EIDt29pJrI85Is1D1mU5Du+ovaWcyUqsJjki8
         r71w==
X-Gm-Message-State: ALoCoQmjNvD2US7XnLdIesIaHqj4X5WvC265TnwE5ZeYKHZ46ik9OGqFvyfvJAPRmX+oMO6YVD5H+Cvb5X/a64Lctx//AMTVhw==
X-Received: by 10.55.72.77 with SMTP id v74mr86767419qka.88.1452123746551;
        Wed, 06 Jan 2016 15:42:26 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f132sm27113524qhe.6.2016.01.06.15.42.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 15:42:25 -0800 (PST)
X-Mailer: git-send-email 2.4.2.749.g730654d-twtrsrc
In-Reply-To: <567A5516.9070209@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283459>

The refs infrastructure learns about log-only ref updates, which only
update the reflog.  Later, we will use this to separate symbolic
reference resolution from ref updating.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c | 15 ++++++++++-----
 refs/refs-internal.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 176cf65..0800a57 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2821,7 +2821,7 @@ static int commit_ref_update(struct ref_lock *lock,
 			}
 		}
 	}
-	if (commit_ref(lock)) {
+	if (!(flags & REF_LOG_ONLY) && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3175,7 +3175,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 			goto cleanup;
 		}
 		if ((update->flags & REF_HAVE_NEW) &&
-		    !(update->flags & REF_DELETING)) {
+		    !(update->flags & REF_DELETING) &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			int overwriting_symref = ((update->type & REF_ISSYMREF) &&
 						  (update->flags & REF_NODEREF));
 
@@ -3205,7 +3206,9 @@ static int files_transaction_commit(struct ref_transaction *transaction,
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
@@ -3222,7 +3225,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 	for (i = 0; i < n; i++) {
 		struct ref_update *update = updates[i];
 
-		if (update->flags & REF_NEEDS_COMMIT) {
+		if (update->flags & REF_NEEDS_COMMIT ||
+		    update->flags & REF_LOG_ONLY) {
 			if (commit_ref_update(update->backend_data,
 					      update->new_sha1, update->msg,
 					      update->flags, err)) {
@@ -3242,7 +3246,8 @@ static int files_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 		struct ref_lock *lock = update->backend_data;
 
-		if (update->flags & REF_DELETING) {
+		if (update->flags & REF_DELETING &&
+		    !(update->flags & REF_LOG_ONLY)) {
 			if (delete_ref_loose(lock, update->type, err)) {
 				ret = TRANSACTION_GENERIC_ERROR;
 				goto cleanup;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 21ac680..649ba63 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -42,6 +42,8 @@
  * value to ref_update::flags
  */
 
+#define REF_LOG_ONLY 0x80
+
 /* Include broken references in a do_for_each_ref*() iteration */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
-- 
2.4.2.749.g730654d-twtrsrc
