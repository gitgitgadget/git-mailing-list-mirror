From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v21 12/19] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Mon, 14 Jul 2014 13:58:54 -0700
Message-ID: <1405371541-32121-13-git-send-email-sahlberg@google.com>
References: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:59:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6nLR-0002z1-BV
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170AbaGNU7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:59:24 -0400
Received: from mail-qa0-f73.google.com ([209.85.216.73]:38431 "EHLO
	mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756878AbaGNU7H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:59:07 -0400
Received: by mail-qa0-f73.google.com with SMTP id s7so450729qap.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LCh42mLM/fxQ59+6JfA85/zyqsA04ieZp0pCIFbL2M=;
        b=YKAWvGkMy6j/zvfODZgumyIh+YYbX1Akq1LuhDTMDSgv5Uk0YeIWLLQ82MdVLPR6vo
         +2Icn57ifozanLlYXOtLYdTvxg4flP1NSc6QP1FCLRwPAyKpZRvVGF9wEDMPsaqMO/gs
         WJi7aRyWJl1HQwJFkrjWkvgkNBIyAGjRCnVt4FZsc25mj69TGbDHpKBfDUZyIBHCPC2Q
         5ZH04FpIpIIwR8Yzr8N1SgiPet6uo+NZeClFcHbasjKJgfHtsKuiAJ9XNpGXmPvLkP6g
         mzY/DEKJPg0RntOi9deRQnx73hb4Y7Zqq7VmkuswkYUj3Sk42hlslek+4ozMbZ26zFIE
         Z6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LCh42mLM/fxQ59+6JfA85/zyqsA04ieZp0pCIFbL2M=;
        b=SFbZ9LkgTy2mNm+M4KikV8jGKTmW0PrwAdFcJwZvbiWfAGgxX/fUGR/kG5/rGFzW8A
         lOhmRYcMpnu/IwP0y+torhotk5jqf3QCU/pMDsEPemxiddAW1GTcI59rcTS9JFsCzBh+
         3lGm5u0yYRbav6ENTOqXCDR1igjAZk8OwaS98GZnOczQ69ftm5R8yjmn3dNcObH4i4bH
         1c1L7GyT/rqGbc3OJTHodzdEc0sp3Nlz9qmDgmIUMUFguLlBXVoNqoX+tNdXfG2kxunl
         wovgWuoJU5BaBodRB5VuWRY+T4t109oBUlpeeZeFK0wOi2w3zNyE+3AT5hJAv+64cRXX
         Rh3Q==
X-Gm-Message-State: ALoCoQnvc01poafF3orMgRzw8/Y6tTVr1uQz7xUcNlN9/0OCagP4HbJZMfroAqBLfsiKmM/yeF+G
X-Received: by 10.236.25.234 with SMTP id z70mr7927215yhz.48.1405371545930;
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si820541yhp.6.2014.07.14.13.59.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id C29D931C481;
	Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 84BEFE07CD; Mon, 14 Jul 2014 13:59:05 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.546.gf603308
In-Reply-To: <1405371541-32121-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253522>

Making errno when returning from commit_packed_refs() meaningful,
which should fix

 * a bug in "git clone" where it prints strerror(errno) based on
   errno, despite errno possibly being zero and potentially having
   been clobbered by that point
 * the same kind of bug in "git pack-refs"

and prepares for repack_without_refs() to get a meaningful
error message when commit_packed_refs() fails without falling into
the same bug.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 10 +++++++++-
 refs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cc69581..7a815be 100644
--- a/refs.c
+++ b/refs.c
@@ -2239,11 +2239,16 @@ int lock_packed_refs(int flags)
 	return 0;
 }
 
+/*
+ * Commit the packed refs changes.
+ * On error we must make sure that errno contains a meaningful value.
+ */
 int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
+	int save_errno = 0;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2253,10 +2258,13 @@ int commit_packed_refs(void)
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn,
 				 &packed_ref_cache->lock->fd);
-	if (commit_lock_file(packed_ref_cache->lock))
+	if (commit_lock_file(packed_ref_cache->lock)) {
+		save_errno = errno;
 		error = -1;
+	}
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
+	errno = save_errno;
 	return error;
 }
 
diff --git a/refs.h b/refs.h
index 8d6cac7..e588ff8 100644
--- a/refs.h
+++ b/refs.h
@@ -98,6 +98,7 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
  * Write the current version of the packed refs cache from memory to
  * disk.  The packed-refs file must already be locked for writing (see
  * lock_packed_refs()).  Return zero on success.
+ * Sets errno to something meaningful on error.
  */
 extern int commit_packed_refs(void);
 
-- 
2.0.1.546.gf603308
