From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Fri, 20 Jun 2014 07:42:53 -0700
Message-ID: <1403275409-28173-13-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:43:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy02g-00017d-K8
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbaFTOnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:43:39 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:40926 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-pa0-f73.google.com with SMTP id kq14so449610pab.0
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS/RoN0v7YMc/IOkRuZOrhnt+R4lIs46nXv1Us+aUqE=;
        b=l5HHdZl0Lmu1SHMNe7zxwI1mo+PNCf1E/pPPUEIWUuxwvL97n19Den04TnYSr/fR2X
         SSpKULW6DO3O1JoNGFWMm6eLg3TxXCkncr8uYfn+901rlM7L3X8egRfgdO21txc+SU7V
         yXSA6qDU/vP51ggVp0TFbejUiHReY2Fv7sEOGccBaqiph8mexCtzQoZim1HnoteAsOJ9
         lTIf7vmem3lFpcCUZG1T/dBg2l6a2lC0rg4VieTl6APvH5CJlp8vWvV5WAhCxT2ptcv3
         MhMF0kiqeD2HZc0yYGzNHF73efWZgNq1lErpvRshaNgZ3sPVfqWyysYZkX6HblPPfC35
         Gqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VS/RoN0v7YMc/IOkRuZOrhnt+R4lIs46nXv1Us+aUqE=;
        b=ZwTjg81FaDYLnPyDfx/JrYKFKSZe0uckCCKcNpfoOmov3JBfe1h5KCvZKL3A1e/BHx
         tvBXZgLcloFO5W5+TOgKn7xTpMUJTGlYSv7FtNNobqM2lF+m0L5SzDTALoRGTL1YtyXl
         0FmhGpJuX2W5MvakLADKMkXptygEdld/oY4sS97SfBCzaouZGZPgadLK+WlOdae4jzw1
         8hbX1i6jgq85e5hNnTLago9ZlzTgAfncWcMzzIL1kl6TCz9CnsUXsyhXcug/t5Wa1qJy
         RETUvQq4EPjNTN/+ejWRsfrRj3f0RuN+4XbK4cU4zDL5n9FuTfDf7tetACOuNwGpQ8+u
         biig==
X-Gm-Message-State: ALoCoQn0+2S/Pmf+Pz8mbBhYbepfG+UTDC8XlL/KsiRN8gtSXXesUs9tC3oFYk7Qfuuv0jz0Qcrs
X-Received: by 10.68.135.200 with SMTP id pu8mr1500095pbb.9.1403275412547;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id o69si663693yhp.6.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 5E25A5A44A6;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 17B3FE15A5; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252232>

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
2.0.0.420.g181e020.dirty
