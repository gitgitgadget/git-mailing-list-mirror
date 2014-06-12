From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v16 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Thu, 12 Jun 2014 10:21:03 -0700
Message-ID: <1402593699-13983-13-git-send-email-sahlberg@google.com>
References: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 19:22:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv8hZ-00074t-Ow
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756334AbaFLRVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 13:21:55 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:56660 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197AbaFLRVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 13:21:43 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so185489pab.4
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=45PxfsHRJP7IkNHcXwLKmSupahMw3WfL+7VpEO9DsRE=;
        b=QZU5uzahyv9BeqcCLdx5reNM5M0aaqUvjaWIlW8XcspvtsPmDd0yswbJ2eya8FhAbP
         HgAl2w/dLDBEpyIidD38sH6guTc+6dyUEsYvR5T7QBZPkCzLVzHRkR3loCfSVybdqajl
         /CVUM1kruqX5OrkfHnOAwzrShO2F13fnmOGjYRm6+GXntKQ03rbkdSdStUAjGG4kMmVK
         jWqItsu6gFnntsNvudPHXqr5lmc7QXruK7NIWFWW0UIMzPl1FTpGJHAfPAytqFrOX/Da
         6PSC2z6NDTT5iiGXXwWt9shIB0XAa+JDnenZ1YcNZ4fMAuKdP+z2QVfzy7UloOAIaATw
         4vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=45PxfsHRJP7IkNHcXwLKmSupahMw3WfL+7VpEO9DsRE=;
        b=LgW6+HS/I1eumJFeuaS7Siy0cvzd3b9w92nyoaxqbDTOOLy6EqMs+h9z6R3c0XGryP
         Ww8qcYhELJ9d5EYqXuqh53/PXo71PvL4hI+kWsqLccrA69HUgDEvLfm2XnLA7D7R5exF
         6LZFv4wwzTm5jMblZXED90jisQBRj1rN1TiSuGNwj8mv+eWBczPjkF/gDKOk0Hn52UAc
         z5KSY6V4njfRfPBNs0wdSBczsFln7+8WI+4maj4DOm6et/p1sz2euGLreWYpy7+IsVIu
         U3qoiAOyA7VI3c7jwS7vivDnxt/XsEbBedJtaFdGDF68TIUcAxJRfRwD/qjjfRhKbEt5
         uUqg==
X-Gm-Message-State: ALoCoQmDiaCPqR1OGg3GlNlzc/LdO6cVKBbCCY9AY8/2EurTJx/awauYkiODEn64IV8EmJfk5IzZ
X-Received: by 10.66.189.163 with SMTP id gj3mr10170971pac.32.1402593703355;
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si112262yhj.5.2014.06.12.10.21.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 3010431C673;
	Thu, 12 Jun 2014 10:21:43 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DEAEDE0E5C; Thu, 12 Jun 2014 10:21:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.599.g83ced0e
In-Reply-To: <1402593699-13983-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251424>

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
2.0.0.599.g83ced0e
