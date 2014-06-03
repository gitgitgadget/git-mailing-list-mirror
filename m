From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v13 36/41] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue,  3 Jun 2014 14:37:54 -0700
Message-ID: <1401831479-3388-37-git-send-email-sahlberg@google.com>
References: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 23:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrwSp-0007fk-Pi
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965376AbaFCVlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:41:08 -0400
Received: from mail-pd0-f202.google.com ([209.85.192.202]:41763 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934294AbaFCViJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:38:09 -0400
Received: by mail-pd0-f202.google.com with SMTP id fp1so706437pdb.1
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D+VtZBpDSOc8iJa8ezTqzMjNd+15pX0kO13hZfPUWd0=;
        b=dWZdpRleGU8DWI/lgpm0YMXxlx+hIh4NZ/hs37nRcJ1UlMR83/Q+Ii4jjxrysoeZBZ
         kxKHPwOkcuq6jnJl59jFrBDj9JFJ34csowOmHYmXfUSkO3cbJTlx8GgU9sO/4TiJRSu2
         2ObhC16zsOzt2NfuCJnwoJCKAr2dzmrLK9pUHbPhHXh1XflXbHyjlKuH6pV/C/xbFn98
         ON9ltSCzuj8wnm7taVGnDcUk9TBa1/yc1S06uusZbt0q4NCEurkj+sE7up3qyw3ZvI4+
         IJ742o5RqDbG8A5czh4jlVvRj+J9K7qmR/Qrkbf7ohtI89cu1b3HBOnRPQXwnVTH5qFf
         Xjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D+VtZBpDSOc8iJa8ezTqzMjNd+15pX0kO13hZfPUWd0=;
        b=NcHzSaRYdkkqSs/tOYD6EEqxRxrrkvCCnnf00ES0ZTVetLkiAbIj4tQQIhirVaacm+
         K8Nlf6UUfy+NuLSlMrhSv2PeyPKFGfmshkd3vAl4+H8mDKSNCyxBEq96sBKYluY5jntt
         3xo5BkgMCPV0rWrcox9fba8fwm4k8OLc5LRaiErIh3YiOYK5/3pa+vFLK3780IIDIcEZ
         avcd2hXa88/7S7bMMs+M5dTPEYPemLxhtZBbHzFaPiDiriIbDXPH/v12/5bxQgVF+ORa
         eOACWEA2pFcPr8ervrlMBnn98b+XCPRbHRcdJG2L8qJ0GmVe2LEMHnOAr6aMZEw5pN2Y
         wJBw==
X-Gm-Message-State: ALoCoQl4FfmqJHxU2i5EqQ2gzZsEhMmieSL9Bcj4RnRDggPC2HgsqSzadRPg4JrX2auPdn4TlYmN
X-Received: by 10.68.133.138 with SMTP id pc10mr17442752pbb.5.1401831488422;
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id i65si30411yhg.2.2014.06.03.14.38.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Jun 2014 14:38:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3EC5F5A43D3;
	Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 1B4E4E07FA; Tue,  3 Jun 2014 14:38:08 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.567.g64a7adf
In-Reply-To: <1401831479-3388-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250676>

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
index 03cff59..22fb166 100644
--- a/refs.c
+++ b/refs.c
@@ -2058,6 +2058,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2149,8 +2154,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.567.g64a7adf
