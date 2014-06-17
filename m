From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Tue, 17 Jun 2014 08:53:26 -0700
Message-ID: <1403020442-31049-13-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:57:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvlb-0007vr-79
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbaFQP4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:56:18 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:34581 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756315AbaFQPyG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:06 -0400
Received: by mail-qc0-f202.google.com with SMTP id x13so880932qcv.5
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7hljtGSZ8ZImsTJioI2lVBjrhC7YmwZUcOPRLW5gEk=;
        b=oPtC4YuaSP81xiXi54U0ggE5hyUqQmp/9S4zvn/qu2v7QH2SM/DFmbKL+Hp1hHSMBz
         JqE8sIxWSLhxATvBsLnRMxR85zOF2TEaqdDNDpzS+F+OGD3hI2S6rogajdu7TFyrEBda
         WMSDxRfm5BZzmeHvA8W7ZQ23yvXwt90Orrxbchqexxve2crfUBdc9cW5oAw0KZP/t+PH
         /KKI5ifH3TOmJzHHqgAsvybTj2h8Y/4FT6Sydt20/p3+RrdCFI7EqEsfZyaqd31py7f5
         +lCB/HaSk4UKKDhz9pNOp3FWRNmaNNC+OkoPKKAdoMOtf8/K1oA1PXMrUcB41XArshLP
         z47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7hljtGSZ8ZImsTJioI2lVBjrhC7YmwZUcOPRLW5gEk=;
        b=g57DHr76Y9XXliHEeFCp5s0kzrta1Ea2oJtgTq2TF9IilSVx5IMG7HmmPgcKV6Ubht
         eWa3LIZll3h+tt4yUEhFt52rDCWrBE2ZrQlQc1TgLoIElzIDFrvo3YfxPDTZl6afmTb0
         1Hz61cQvN1wo8x5rWKDuuTi32vH0V3fFsTAUFKQl3yTtQF5hCBko7DQtUec44/McibNn
         kI/21LUYdxdfDVujd8Di6Tnffhn6EbR9wVqGk7oYACXzuDmHj12JCLCq3Safv8V5tdam
         l/J+9Y2u/5Po/Hh3YyUJXVt0muOhTdc7P7HtXLaMJmwW06HI1SrEmJUNO69rS13f/Vpt
         aO0Q==
X-Gm-Message-State: ALoCoQkToM7KnIhYIY+zT7yeYh1RaPBACxOZ/bPc523iH3wzuj+9rcmInCobj2y0ZvAr37im4uob
X-Received: by 10.52.230.71 with SMTP id sw7mr2201773vdc.9.1403020444706;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id j5si69090yhi.1.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8B8E931C76B;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 2A5BCE148C; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251911>

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
index af4fcdc..593a459 100644
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
2.0.0.438.gec92e5c
