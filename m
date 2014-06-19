From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu, 19 Jun 2014 08:53:25 -0700
Message-ID: <1403193210-6028-44-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:54:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxefb-00074w-Jm
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933205AbaFSPyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:54:22 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:40502 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758081AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so331872vcb.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WYSwaTk66kVEO1jl/3NBY11LuPKciI9mmp3itz+eqbY=;
        b=S7WgkhvfyjbkOzrW/F5A8R/Kdirxj21pS8uAss2U67TEQuVSiR19hjN5HPa34tGgGo
         51EkMRvw0tFu/pegXye1lD+gQazo8w/j90zJB1BFABhfHZgXrBxCzjitHQ3rAX083CUq
         CfjFgcmrfL/rVGKmVKiq6ygSD7IaeBMykd+42qImTDXgmcHIENP7WhfEKWvZdFfUc1cr
         Fy6yVlx/Vce/i1PGM8bX/TvpGODN4Q4MXs6EKB8HbALtzLMtuMj6q71Y5y3jkdZ5x2id
         qb3s/cqgDlHyKBoRjlBPv25vRFeoiyUdQqmn0OgIYY06Pajwu9A5vLrhLWOMuOonqblq
         qwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WYSwaTk66kVEO1jl/3NBY11LuPKciI9mmp3itz+eqbY=;
        b=JhUt5Z+x/9CVDZS8pNpolt56MjoZx3l/4hfFL6jpj4G5AKj2dgOJ8UmxX2+HAzNkGX
         3Pn9wyNlAOhiZXgfLo83StzAXfpHc/j6ljHOmHshooteNKsHoVSW6oJdFVCE3SoliGTq
         zQKMzN/MzQpQ2AOiUKn0uM6fb7Q9wdpYZgAsHCiWIKqtLM8j8R5gmUpV1AZV9LMsSoZS
         cTEw/E/AfRO9CKBzXa6tP5RcMLZ9ADmT2n4jwZzbVfzeV62ckB6i46sYbfsHPGjOEZqz
         adFFt1WWWyw79J8N7+akX6klC2RCn9/U+HquGEPjqBNd3ytwR7tYMFoouHsiTTR2JUa/
         3FXA==
X-Gm-Message-State: ALoCoQm7GnYVcUzzPb+LgX7Gw21yaquBAKhTZr00BNnabQVDZwEuFh0xzigsE9uqU869PeESYMJL
X-Received: by 10.58.108.40 with SMTP id hh8mr2742186veb.18.1403193214578;
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si418322yhl.7.2014.06.19.08.53.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6EEDF5A42EE;
	Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4B790E033F; Thu, 19 Jun 2014 08:53:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252130>

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
index d6467c8..5a7fb34 100644
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
2.0.0.438.g337c581
