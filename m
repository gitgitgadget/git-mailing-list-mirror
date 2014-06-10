From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 10 Jun 2014 15:29:31 -0700
Message-ID: <1402439376-25839-44-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:38:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUZg-0005yY-5x
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbaFJWbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:31:01 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:47628 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbaFJW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:42 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so6968igi.3
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UVeBrw2dcmKuNFxByt2iCzv3ymLrP5VhFx71HqoUf98=;
        b=A6N3/DjmrwF3fnfUgZovfR0JvJ6PDxlTGND73xwmp2gON19K1Dd5AWSRaCavmWkuy2
         INki6wfj6WpTk0IZZX8Z6odswtv7wrgCpq1RauWWG2hP1OFhIx5+UxYAfHThxn+tqEem
         WRPOTjLtephKL5IV6cntF+jdtS0BGleL5xislOgtzu3lOD54M067CR7aP5HKF0CB4Dzo
         zOFtDh+ywVUEX7vV25OHAViPAajkKSWidgkAMSpqkoSE0/zMupLyAG6BOifmhmAKgYNJ
         8VbABVqIy5U6NUdA01TgEyKe5c6uNbDXrhkRnZpFUn7ilSq17jU2feBmRRnmxOrPTxnE
         z/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UVeBrw2dcmKuNFxByt2iCzv3ymLrP5VhFx71HqoUf98=;
        b=CofAb3A0H0ivE6u3Boq7Rn839OVwDApCpeOp3DfiOsVFXzBI3uOoP/PWlBPT8fNIM/
         0N4dlSWz/qy2mcGpn2gYgU7l9N2v/WTqXSS6lk4ux302CKBBnT3x+rFDRcvQ9OEScYgx
         03HH6hZXHO5e4256AsYyJEAknG9yA6vo5SgD2f49+qMpUQAqIjTENja3IC5hBZ3aau0L
         fmwD5G08QCRJJ2RNsYbiwMdWqGWkn9Vwms27Z+ogWy15tnfaOi0HuyQHMmSOoVzGlCTM
         FgkvJg1vgxrmDGy3w/NCuU29oRa9cvff4Z7tj4MbGGxTuyqf1TgME/kiqRtC8niji1Aq
         GwYQ==
X-Gm-Message-State: ALoCoQlXIJ9QPd9xKI2IKtsNFuzwrSdMBrPIiKyQZgY9GKalq/8ql3pX79NLFXZGfL0ZxZmxtXND
X-Received: by 10.182.128.234 with SMTP id nr10mr5993522obb.0.1402439382011;
        Tue, 10 Jun 2014 15:29:42 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si1395398yhk.4.2014.06.10.15.29.41
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D45855A46F1;
	Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF106E0616; Tue, 10 Jun 2014 15:29:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251293>

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
index d1c501e..5d35e2e 100644
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
2.0.0.574.g30c2c5e
