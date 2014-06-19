From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Thu, 19 Jun 2014 08:52:54 -0700
Message-ID: <1403193210-6028-13-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxehc-0001G2-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758064AbaFSP41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:27 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:58166 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757678AbaFSPxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:34 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so692919iec.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YSNw6N04pa3f7BJE3w+LlsQXj3Q4KQtq/RwOubt0pPw=;
        b=fPBXoXGVQP1MuNmZ2pqZgRzAIn789tiivA8vgtt3CyyTn2+Ci9Ask402FCutQsYm13
         Q4KkP552/W6rNYEoRD32Lr+98FiEIf293+hR0QHo9eAAy+Il0aGLVsnpybQXua1lsHq8
         IrblnD/VG0UFs+aV7DqBEa3WwPN6N8DS8ThbI0H9I9qc3TRiMFBCe/wv7ZS9HCUhlPB1
         tinE2KWmndjym3DLTL8hGB2bpbUEfJfISx9QbHIiOdiS9c9wW+oeFCzkGOw0DKeLudy9
         p5yOQvGz2xJgpGYR6cflEoapudwShu9qOC1Ykgw8nl8zisuU/DaBJNH+55PC958i2QT3
         OB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YSNw6N04pa3f7BJE3w+LlsQXj3Q4KQtq/RwOubt0pPw=;
        b=YoGDBVj47jD+AR9rlEeTtEgCuFRXvqgUi3R91G7iVL/Te76a0t5mVerLVHzf8DyWHy
         lECUOTsnA8lKCTQwpo3y4bTnk2XSt370emuDyq6/fjJksGfDgnq2YoJOPHN8tTqGxKaQ
         jIfntATIrYGVBNtMyaK/BXxqRlPh0vlzwPBxDwK8saCWPqUtYG3s+031EK0j2CfmI5el
         e6ryWyhzefL3gL+BKB9gomnp4fgf5ZapvyIja47Ci6H9qKQQxV5Rb5QGSKARAFqE9W32
         y6CVia5pthYqq5z8OtQPFK5YSd9qqwpOdpb2cnsJ0CLVzKRmqj5Usr1Jx/8RKHfbqKU+
         OxtA==
X-Gm-Message-State: ALoCoQkSEwJpkrUrW5oOlHsjSzmnrTQPnfe9p/8e6RGoMEFxnlrnxW4tnYv/vJb1QzmCzq7cCwNf
X-Received: by 10.182.128.234 with SMTP id nr10mr2792595obb.0.1403193213273;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id t4si421013yhm.0.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 229675A4435;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id B1D51E033F; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252160>

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
2.0.0.438.g337c581
