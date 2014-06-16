From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v17 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Mon, 16 Jun 2014 11:03:43 -0700
Message-ID: <1402941859-29354-13-git-send-email-sahlberg@google.com>
References: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 20:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwbKr-0007ty-AE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 20:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbaFPSI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 14:08:26 -0400
Received: from mail-ig0-f202.google.com ([209.85.213.202]:54441 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbaFPSEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 14:04:23 -0400
Received: by mail-ig0-f202.google.com with SMTP id r2so241066igi.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLKZYd7nJ70/4KNv1gZrSi6a1h8FNymjit2qks51ATE=;
        b=iHZ8HASR17xiwY6/qoVM0m+uvDz1YbUV6LB7O4cW2+MgBO3VEl7yCkA7yE0gnWZv7A
         2W/eNoQMclQTyt0FyismFQ8SqpxyXCRtWh06thSL1+3QVmrGYPDRsEcgPUSP7IM/lwMY
         kBj5xidDPfCTtorqKvgjvXtWsrrmdYbW3Vlo3IhX7Fw7V5pCFbVR2w5wA71nyNtjmqUJ
         cNDE1HOhodk2lZi5tFBvBJPXVehEIBgsraQKnz/och9FI7Ee9QvnReR25Cj60u4Qhu53
         uDTTHwK5BCeWcPOhHm6POK+WDHO+s0uXdNwZn9uVudk1Q8BzuRxuTb/ZlCssWUbEutg8
         7Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLKZYd7nJ70/4KNv1gZrSi6a1h8FNymjit2qks51ATE=;
        b=MwDUvboG7zkvqhPmOSVnroXp0idv7Oa2TB8/fL07cXjwOJhX7An017kHIFuWiRnVal
         3moh/rnmc7Usea7HF7DbF/97H1cKgUj9oti4YlREc7ax2Ixby880Vt4qkvLIA12F/CNV
         mbZTKfMwHW5x2v/ZBU+K3TWtKsiFRBWSTzY5Jw44JnHxWhcEHYKtm0PxPzeAiu4CYcXw
         hPoKhJsCseXf7YiK2tIq4h/7lJoU/t67ATT/JNonTvIdME37zztcAu3Yxqc/hMoyFN4y
         tOXcNqqSqGCp9B4ht5PNRZrOtGyiUSucqgccRl1HwD3tdUE2G3xUrZKwuPiD+I+QbQpY
         i2TQ==
X-Gm-Message-State: ALoCoQkYJJR6t3/BRkfoy3WwpxHF9AxfulkCFa4qyi8mC3q0s4LwEjzxCtvhixxD64yI9uarefGj
X-Received: by 10.43.12.67 with SMTP id ph3mr99449icb.28.1402941862690;
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c22si998233yhe.1.2014.06.16.11.04.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 872375A4916;
	Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3E9F9E0961; Mon, 16 Jun 2014 11:04:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.282.g3799eda.dirty
In-Reply-To: <1402941859-29354-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251787>

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
---
 refs.c | 10 +++++++++-
 refs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index dd28214..dc9de2c 100644
--- a/refs.c
+++ b/refs.c
@@ -2211,11 +2211,16 @@ int lock_packed_refs(int flags)
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
@@ -2225,10 +2230,13 @@ int commit_packed_refs(void)
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
index 3ddd618..86f0984 100644
--- a/refs.h
+++ b/refs.h
@@ -97,6 +97,7 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
  * Write the current version of the packed refs cache from memory to
  * disk.  The packed-refs file must already be locked for writing (see
  * lock_packed_refs()).  Return zero on success.
+ * Sets errno to something meaningful on error.
  */
 extern int commit_packed_refs(void);
 
-- 
2.0.0.282.g3799eda.dirty
