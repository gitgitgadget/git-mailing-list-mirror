From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Mon, 16 Jun 2014 11:04:14 -0700
Message-ID: <1402941859-29354-44-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:05:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbI6-0004n2-4J
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932753AbaFPSF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:05:29 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:60337 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbaFPSEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:25 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so432435pde.4
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L7viqfNe5JuFcxCe+Oq3ZYqWQDoKKo9Qu25G7YXYoU4=;
        b=H0o6mRQJ31RmJBsjH2X0w+LCZZgBZMhv4DozIp29xlyPbJlQdapNiOs48MFbLqNb+B
         7uhOKtQGENXYZB7AADrAOkSIGeLeA7tlVKVwQuZCO2XZizRwy6IZhpy7jDdp0l8WLBSd
         wRlbSJEY+/zL335jL4qfkqQLYUdJ2l8QxetHsUleSN/DLiZVJLh7QqZD8Sjr6jXZ4BNo
         toWs8tQ8JoY00mKQmCejjTAObRQ/Ct3sIno6ekvfdn0w9XgVoJr7faZnZsOWpJ2Y828b
         ATEw4x4iW3a7NhjpQFiS/YVCZUjuARnvaMR/OGMv4Sjp/PlZ/KlTaZH+2RbbFdoN0iKl
         QONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L7viqfNe5JuFcxCe+Oq3ZYqWQDoKKo9Qu25G7YXYoU4=;
        b=IsTsYvabIizBFOaixtG2QtTwJSWKRaRYkrLT7V7JckBq9e/9hErLELlZwSmdnGi3U5
         NbutOINhG1B6YnLky6A/1iuuwK8K39QGwZJmHxY7m0aTbvfmL/KF9OuoN8oWNUpyA5bz
         kAApXA8UcHCrElpMQqDZjqO+Dqe8WeV+EZi+0kQYqzE4I56PODBDAKilLbml2WsYdQwr
         55jypgabdCUmBSKwk9GEhZ/VFCBCeMQIWamY43lmuHOqnlU5ld/tl/Qe4uLzfm0K49v8
         /+zNuV825UUYcFk7/WPugCdHRME56UiaU5JVD443U2arN4ghYIxPpsC5i2y5u/SdpfA2
         jxYA==
X-Gm-Message-State: ALoCoQn6d2GL04oKjWZgiOzQzePqc7Q99M4lGyTB/tRc6cZlyppY2oS8oxi9MMJN7G7HOnV3jDPA
X-Received: by 10.66.183.142 with SMTP id em14mr2868535pac.39.1402941864151;
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si996137yhl.7.2014.06.16.11.04.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id F2A745A4911;
	Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1155E0A0A; Mon, 16 Jun 2014 11:04:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251754>

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely.

If lock_ref_sha1_basic fails the check_refname_format test, set errno to
EINVAL before returning NULL. This to guarantee that we will not return an
error without updating errno.

This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
But this wrapper is also called from an external caller and we will soon
make changes to the signature to lock_ref_sha1_basic that we do not want to
expose to that caller.

This changes semantics for lock_ref_sha1_basic slightly. With this change
it is no longer possible to open a ref that has a badly name which breaks
any codepaths that tries to open and repair badly named refs. The normal refs
API should not allow neither creating nor accessing refs with invalid names.
If we need such recovery code we could add it as an option to git fsck and have
git fsck be the only sanctioned way of bypassing the normal API and checks.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 7b80bb3..69815d9 100644
--- a/refs.c
+++ b/refs.c
@@ -2062,6 +2062,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2153,8 +2158,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.282.g3799eda.dirty
