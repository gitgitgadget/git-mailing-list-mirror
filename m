From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 06/12] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 16 Jul 2014 15:23:06 -0700
Message-ID: <1405549392-27306-7-git-send-email-sahlberg@google.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Cc: gitster@pobox.com, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 00:24:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7XcT-0004X5-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 00:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbaGPWYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 18:24:00 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:64630 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234AbaGPWXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 18:23:16 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so417748pab.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/UbfLq96Y14WRN0Ii3hQHh08ThDsssIxzndOdmSwWI=;
        b=PWvZokw8uKwEKjiUuM6Janmg3ZbefyF9J7ziK7Dnqc50DvQ0WFMrBzJM2hN2W9yW7I
         SALGfOL64cWEnPkAajCooeCz7l+zWJR4ervg7TEZbcA/Sm6w7s3p5JBGGqGXKUiAFvqz
         zjXvHjP/h/wXHMTLk7YcxH7pZA3So39L1+15irtSNOkvDs4C7Hez4SK+DUQCSie2xu1T
         JgtQo5CErfG9a7KZP/zU0OoaxqQBq3Yyjha3ZqCqZUawsfQf1oAfy5U1QeLyr2+lj7iF
         e5fPjVnmO/gdefJx+V3wWilxT+wPRJWEe0r2rWcmsXCwX0q2LAVVSA8NwVUWGWLH2weI
         i2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X/UbfLq96Y14WRN0Ii3hQHh08ThDsssIxzndOdmSwWI=;
        b=Fgo35tWhslDcPKHIHyL2UM+nw4MTFY0SMsgDa3RXVBIx8tOuu2q6OUrIdRRLRrRwwt
         iB2ojfmcXkTQ28lYor/2da/UxMNvbm2C75FC6TxqfUgnyL4yrSCq86tSP6p1ogVSQcAI
         VgrpTMZj/BLl8+q6RorbbtG9qlY7CBWnIHfXvsBQ3uIUl1XAaQVbxr0tpjihyHF3ZYdM
         YIpVqv/k4ouS4xTtNsq6H65z8ZxfdxO3Uo9MOOou+D6eFTkkkUCEE2BL46j7UutMDxNG
         gc738h0K8dH+bWH8Eg9ZjJcDNuoqkvkA33WjwXIYvYNkHpMUncBozMlFuCG6jJtVZeVH
         aq/Q==
X-Gm-Message-State: ALoCoQlKMVjhkd9vfFkp5fOPxeosb0s0IgE7DxTvI9PbvcQhNlaxBD1yflMNtDuqlkaDSUSjUxyP
X-Received: by 10.66.233.100 with SMTP id tv4mr16431567pac.31.1405549396192;
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si75574yhg.1.2014.07.16.15.23.16
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Jul 2014 15:23:16 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 07D1731C2E2;
	Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95C9DE0AC8; Wed, 16 Jul 2014 15:23:15 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.527.gc6b782e
In-Reply-To: <1405549392-27306-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253709>

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
index 0df6894..f29f18a 100644
--- a/refs.c
+++ b/refs.c
@@ -2088,6 +2088,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2179,8 +2184,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.1.527.gc6b782e
