From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 22/41] branch.c: use ref transaction for all ref updates
Date: Tue,  3 Jun 2014 14:37:40 -0700
Message-ID: <1401831479-3388-23-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSp-0007fk-85
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965402AbaFCVlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:17 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:59264 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934252AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-qa0-f74.google.com with SMTP id j5so808089qaq.5
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgwmbLA3qQM6yh3Fn2HqNEa9CtZO+2cc6ja/jU9N+Ho=;
        b=RVQgQ6ETX7bieAqUT+AgyjQQwg6A6yQffCCVh9ffalHg6UYMWnm8C3N8ePc0pekRHj
         AE1dc+eRRbPkCAOoUESNEdN0z9Lp2lX1ZVbSvtYYmAK4jVl20abn7eyAa2OTfPXNhdqN
         hCLhVFH/whrqHeHTIyNdnJfAJtuv29Sf89JaGgA6S13XvEzhXQBmX73HHsqMB9hvKXyh
         jd7XLa6FsAlh6zaiaSYWB8xLaV5Y8U+ipi57FTjOWYsvC0uZSSJGil2g7pm9dzk590Mq
         K1UXUMzBm8KHIfvpOsD8hucHMcxnurZR1nMH+UlooqKiZj4U2OcWA83ZRyQg9kzuz+Zn
         KgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgwmbLA3qQM6yh3Fn2HqNEa9CtZO+2cc6ja/jU9N+Ho=;
        b=akrStbcZNVU4p8a0jP0ndAW69dvCUMYIb0wQz0TGHzJ8hq8Bsx59sARWC+ogioZlpB
         5d3NKXjhDQ/B0z4gI4Z/BdJ/s6key/OQsJ8wMpvlK2Q+IrnFm7KGEJB/SlN0TFXWFrrD
         c4WZFI4pog7cUMxeaEKMao+FhLBU7530LSbs7mmUOFFryW/d9/pVcQK61YyPbETM66fP
         0Z/6zzAiKmc1lrq9ch9FHMYQ5ZrLDVMVS0Iz10e4EUTQEylAp76PxpKwRhhzpeo/iNYl
         C+ZPbXy3rDKf3zc4rchmwQV0/te0gZBY5fHXAu/EI/KTVgip5QSGlAHppnKtC4NBi3OH
         mqKQ==
X-Gm-Message-State: ALoCoQliYqCask8fw2OsZb8KIJGAHv07oTNGyrN8FlAvemLr/mYzTv2rMsuJgY/P2EdtNIZjLXiE
X-Received: by 10.224.79.212 with SMTP id q20mr17510953qak.9.1401831487904;
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si29582yhk.4.2014.06.03.14.38.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:07 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id B6FE55A43D0;
	Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 930BAE0F40; Tue,  3 Jun 2014 14:38:07 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250677>

Change create_branch to use a ref transaction when creating the new branch.

This also fixes a race condition in the old code where two concurrent
create_branch could race since the lock_any_ref_for_update/write_ref_sha1
did not protect against the ref already existing. I.e. one thread could end up
overwriting a branch even if the forcing flag is false.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..c1eae00 100644
--- a/branch.c
+++ b/branch.c
@@ -226,7 +226,6 @@ void create_branch(const char *head,
 		   int force, int reflog, int clobber_head,
 		   int quiet, enum branch_track track)
 {
-	struct ref_lock *lock = NULL;
 	struct commit *commit;
 	unsigned char sha1[20];
 	char *real_ref, msg[PATH_MAX + 20];
@@ -285,15 +284,6 @@ void create_branch(const char *head,
 		die(_("Not a valid branch point: '%s'."), start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (!dont_change_ref) {
-		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
-		if (!lock)
-			die_errno(_("Failed to lock ref for update"));
-	}
-
-	if (reflog)
-		log_all_ref_updates = 1;
-
 	if (forcing)
 		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
@@ -301,13 +291,25 @@ void create_branch(const char *head,
 		snprintf(msg, sizeof msg, "branch: Created from %s",
 			 start_name);
 
+	if (reflog)
+		log_all_ref_updates = 1;
+
+	if (!dont_change_ref) {
+		struct ref_transaction *transaction;
+		struct strbuf err = STRBUF_INIT;
+
+		transaction = ref_transaction_begin(&err);
+		if (!transaction ||
+		    ref_transaction_update(transaction, ref.buf, sha1,
+					   null_sha1, 0, !forcing, &err) ||
+		    ref_transaction_commit(transaction, msg, &err))
+			die("%s", err.buf);
+		ref_transaction_free(transaction);
+	}
+
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
-			die_errno(_("Failed to write ref"));
-
 	strbuf_release(&ref);
 	free(real_ref);
 }
-- 
2.0.0.567.g64a7adf
