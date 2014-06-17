From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 17 Jun 2014 08:53:57 -0700
Message-ID: <1403020442-31049-44-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviX-0003rn-Hv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbaFQPyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:33 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:58231 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756349AbaFQPyI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:08 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so1026916qcz.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ilBoHKwKKSUE8qXfXKTx29Bcz1H1cMzDYo+THAxbvU=;
        b=DkYTzeHp4QbeTH7+QkyyZExhq6O6dYeQNcPOZa/7wLHiRdD89jy5BIXasDGeThwbow
         pqLgsYJW6ZXzYLwBy5CiMSvP87zrF0DKiiMGS+7lh7whsVYffF10Dm9Yiiy5F06WDn21
         lZLwaLq4xKlID+tshldRo16YZD8ilM+WDd1nA3m/zxH4fKB2sZP2nyQu3jU0u78+1omz
         /b+KCqB5QxoP5CiEPQqG1zIkLJmJMsv1nF4eDdWzTuqff4QJU5RIu2ppzA9lv8SU+WDw
         MmcbAfCswnZZSFKV0ZTjZef+6zsJnalU0eRNDIolwOqg1yCmXd2kujAX/FGTeQsEo2bN
         TSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ilBoHKwKKSUE8qXfXKTx29Bcz1H1cMzDYo+THAxbvU=;
        b=cc+hjH3ySld7Q9UqXXAzblIKxeK/0ipJqLjLQ1gvC5SOks07xXxRTsi2jw8wmuqIQw
         rJEGGgux9GXMl5YolyCFrXgoMlwl5HK8bd8OTa+LfL6+QZxR468S5he03c6LyVrHvQ6Z
         YcISIoUOCX8gvzGqss6agq2MaLr8RE1VCqj3kHChTWmq4UqMiyNTuRj2LOVuySPXN/gk
         niM1u3ROsAonkG5MNmeHqcLivTOtXPxA4zQCmS6GzLA/qlwNXE1ZYVdzcIGc9OKcU7gB
         sssInBG4PUEgxSlOPhC66/xXiHLOwiKKyPo2uO0WZXpn1FUtCUACtaDCIVCNMGpQckx5
         x4DA==
X-Gm-Message-State: ALoCoQnlI+XipVZG/STvRX7sL12NCx6EeD2amuMVKXz3MPCj9UlcKWntETsRsXPSDoQkHdtW1E2i
X-Received: by 10.58.136.10 with SMTP id pw10mr2428752veb.8.1403020446074;
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si1209469yhg.2.2014.06.17.08.54.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id E6A1E5A4367;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id C5033E1158; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251878>

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
index 24c6e8a..31d41fb 100644
--- a/refs.c
+++ b/refs.c
@@ -2089,6 +2089,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2180,8 +2185,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.438.gec92e5c
