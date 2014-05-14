From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 06/42] refs.c: make update_ref_write update a strbuf on failure
Date: Wed, 14 May 2014 14:16:40 -0700
Message-ID: <1400102236-30082-7-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:21:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgcQ-00024e-2Z
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbaENVV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:21:26 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:44982 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbaENVRW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:22 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so40539obc.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dCZ2iEk2u5txXkeF0484YU+K+967EXCWcGo1h+cr/DQ=;
        b=TorBYU047L/zP9hTnLvuM4hV2t9isB0h8u3z8s1sYf2FYQWuMsZ/7WrpHwbxNkqT8q
         HHLSQR6JwtC9cKmGUlHrnm+nA/HSrIuVb4G6BnGBSki0RHBhiS3hTMa6pi+fEHMRER46
         u8Dd0xbGb5L4O6b4r+tQacfU3AvcP6z5/uPeVoxIVi1FFGP2uULyhVKMq+MPcH+T1zvx
         DIiwDbgt5z/m25u8fH+d0DKnh3hQpItcBQzrnb+SKTV3/B4XVk5aVIvzMZIlKNIMtEoH
         x4QsyCXhXjkv10IzgxicNvRYfA2F7RTKWgUSzCLaKU6MPtnvtzaFrR6tFY8b/8F5jnEH
         Fg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dCZ2iEk2u5txXkeF0484YU+K+967EXCWcGo1h+cr/DQ=;
        b=kLh9zluzBJ1SaXpi5ku493cuAw1vwpXX5wIqteIej6pepLBQGQfcRrOBHO/98w616K
         FbMS35IDxIUPc07pfemuOC7w74208FsPN6O3LkXweYTSn4nThEY/hHVB0WUcqwHl9gcn
         4WmqTKW6cGfeBaVeVlT1bACL6K+2ottM5+AAa7GJGLYYW3pwFSpOPgvQ0AHFz0Fy7eWK
         2ZkVYrC4XKZHlQenKmYfFGYJBJ3LOCW7cxrH+L3iMEim3vczeA8Q9btHviu6K7jqzRUU
         Sm2qG0tPVYF0npzpJW5cY7lGbVaHWajiTUvc6pNaMh7wiAhov8E19PKfD6so0uXQQEpg
         BGhg==
X-Gm-Message-State: ALoCoQkqHGh+UR2UKeTfWLMH8Fp6HVVDOox+MNdVmfmpFeZ0zFpvQwfItDunVJvBvnC74kQ1ySsP
X-Received: by 10.182.121.232 with SMTP id ln8mr2987126obb.11.1400102241677;
        Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si146327yhj.0.2014.05.14.14.17.21
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 855835A4292;
	Wed, 14 May 2014 14:17:21 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4827EE0973; Wed, 14 May 2014 14:17:21 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248997>

Change update_ref_write to also update an error strbuf on failure.
This makes the error available to ref_transaction_commit callers if the
transaction failed due to update_ref_sha1/write_ref_sha1 failures.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 364daf0..8051aac 100644
--- a/refs.c
+++ b/refs.c
@@ -3262,10 +3262,13 @@ static struct ref_lock *update_ref_lock(const char *refname,
 
 static int update_ref_write(const char *action, const char *refname,
 			    const unsigned char *sha1, struct ref_lock *lock,
-			    enum action_on_err onerr)
+			    struct strbuf *err, enum action_on_err onerr)
 {
 	if (write_ref_sha1(lock, sha1, action) < 0) {
 		const char *str = "Cannot update the ref '%s'.";
+		if (err)
+			strbuf_addf(err, str, refname);
+
 		switch (onerr) {
 		case UPDATE_REFS_MSG_ON_ERR: error(str, refname); break;
 		case UPDATE_REFS_DIE_ON_ERR: die(str, refname); break;
@@ -3391,7 +3394,7 @@ int update_ref(const char *action, const char *refname,
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3473,7 +3476,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			ret = update_ref_write(msg,
 					       update->refname,
 					       update->new_sha1,
-					       update->lock, onerr);
+					       update->lock, err, onerr);
 			update->lock = NULL; /* freed by update_ref_write */
 			if (ret)
 				goto cleanup;
-- 
2.0.0.rc3.471.g2055d11.dirty
