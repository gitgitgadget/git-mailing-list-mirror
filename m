From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 12 Jun 2014 10:21:34 -0700
Message-ID: <1402593699-13983-44-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8i7-0007gA-C3
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933413AbaFLRWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:22:24 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:38804 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287AbaFLRVq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:46 -0400
Received: by mail-pa0-f74.google.com with SMTP id lj1so180861pab.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SKKXCbywc88cHaNaUYe6q+Xz7VAd5g0QJJIgMOAvgI4=;
        b=iusjvY0u64Pn7KoN/gkyZhiVIUBt746olR2q2e6kOehtpCjN22n79H4/AEWoh1XOnz
         lavpsOXsFqmkT/FO47L6+qjBMZ3TcAWu1PHlwdiaHpAa+ZMWssxjMIoIXI8JY4TxBxI0
         SiHCyGpbFGmj5bwe3uMngoXVbymyt78WsNbrPYiMdk11q43Jyh7sR1ZAF1xOXa4wUZri
         Q396Do3eNMnaBjcwgMymntAsl+RWB2GiNZ3ew92ANQM1cpbXIEIZ4ky8Lai3iRUrPk9K
         1TbMpqoYqQVooIjQV0vJ4Wljbn8NNQlX72KE07iDPi/VpZDLeW20HpN7rnwPcgWnznj3
         TONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SKKXCbywc88cHaNaUYe6q+Xz7VAd5g0QJJIgMOAvgI4=;
        b=OSK8tcyMNqAiy1yr3w05tg4QVYO6sxKVJypNy0BeQX0nfdPhjs875oup3yw+lUZQvr
         /Z7cmdMQHJ3QsCkX55XMjnYB3v78LvW6v6SPJTi/yRgC8mFxaC7KFUYq2uZTvZOuGWV7
         ax2QDBZm0EX0SAhR7IWSHHQgvrtghGr9dFiBpI24qdgMfajI7la8W48adkVAPWndLaoi
         PrvCcIrD/SqldHkJveq0p3ue9gvH9cawY0/cD4YCPlR62zvuyV5NKR255yHb7MkW+vKX
         JWfVm748V9ED0cUQ4V9KHojYiY2qKjarUUaWTKGRa1AyfOEaWjCUCxIQvV7yaYgby5GU
         cvQg==
X-Gm-Message-State: ALoCoQkh9ryO594zI7xaCMi8Zr8DaBKGLDSxksC0tVMEgHUp2E/YMWVNAe2vvowWN5863ZK8DEl+
X-Received: by 10.66.66.196 with SMTP id h4mr6009830pat.22.1402593704917;
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id y50si112568yhk.4.2014.06.12.10.21.44
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B904131C66C;
	Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 95AE5E0961; Thu, 12 Jun 2014 10:21:44 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251431>

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
index 4b32924..be618e8 100644
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
2.0.0.599.g83ced0e
