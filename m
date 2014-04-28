From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v4 15/27] fast-import.c: change update_branch to use ref transactions
Date: Mon, 28 Apr 2014 15:54:30 -0700
Message-ID: <1398725682-30782-16-git-send-email-sahlberg@google.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 29 00:56:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuT0-0006zr-Or
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbaD1W4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 18:56:02 -0400
Received: from mail-oa0-f73.google.com ([209.85.219.73]:43201 "EHLO
	mail-oa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944AbaD1Wyw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 18:54:52 -0400
Received: by mail-oa0-f73.google.com with SMTP id m1so1613444oag.4
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iys1d6a1YpnNAN8lSGtwZu+lXzTFlnTDX1RwLewoxkc=;
        b=F1EVyK2MHNGY3KKU9+IIXZBamnJDfIkIHCywbLCjGT19Ak71KqhDyciNzO9vqcoLfi
         Lg/Qs30003+z0Mvsy3mLp0Zw5Ju0M00S5keaJk6NzLeooSG3iIT042h82vFOu6llK43W
         sx7+Fq6woUlBHYRLZGQFCwcBdIFXWlqofBSZLq65cnxVfqlFgDZ6Dh1tBuLLqz7JnjIE
         79ghEELmAMG0vqv+dfztYmcdlByyLRD1Vu2QkIM0uBNR37GdTOITtU1KfShs+viK8HAm
         PeKqe8rbGB/4C1UokMEGEmYaNTA7rMYvDhLkCbJWEmJhQmMmdaqYKpMC1pHIsF621hNg
         SG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iys1d6a1YpnNAN8lSGtwZu+lXzTFlnTDX1RwLewoxkc=;
        b=dTQbliZbcjEGlXKE4hzjQrBo4EHelQjF6fYxPvK47xDqTQDRGQcSjW4ijpWoEbsTor
         5WhFVEYWpuvYQCxvcUBKOZphxWfN43ak8GWlTOeXjltWZlpnEJLsa5v1DInYt/hrXW57
         PkwmLXTWssLoENqTK24QzEFSe+TVcrJBp1EeI4GiO9DP2+UmJBPHLGgaUaEYhqiiMrJF
         t/QTA+vvH072yf7IDlRWa9aNBmvHVhDmtbRbUT4rglIIUxRlOBLsC+F7DF6x+4AcP+5g
         HtSyHvPNjsEh/eU0Xdg3dqU4B35qD2G+7/SVgiVRhilsQUrL0Xke0eWa2GGVi+5tnHs2
         uyGg==
X-Gm-Message-State: ALoCoQnDttw6i3yap/EtKC2jW8VpXKwap83qT000OPA8OujsdlHy4eCwcCwDLNOKxt3lw2Rh46Aoy2eh82f2Y63/9N7eRWnHZrRcxRee5K9P6Isaz2WTbtZMmcb3l6dWuKs0in7nL9Hgg8ijttZRz1jfNzUUu1ncc6IAZkt3r7nEhimUg72INn9bduQhcWzn0uw+4qTAHwgj
X-Received: by 10.182.135.200 with SMTP id pu8mr14427353obb.24.1398725692117;
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si2349966yhb.6.2014.04.28.15.54.52
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Apr 2014 15:54:52 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id ECACE5A41EE;
	Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 901B4E080D; Mon, 28 Apr 2014 15:54:51 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.528.g98b8868.dirty
In-Reply-To: <1398725682-30782-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247478>

Change update_branch() to use ref transactions for updates.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index fb4738d..300c8dc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1678,36 +1678,40 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (is_null_sha1(b->sha1))
 		return 0;
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
 		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
 			return error("Branch %s is missing commits.", b->name);
 		}
 
 		if (!in_merge_bases(old_cmit, new_cmit)) {
-			unlock_ref(lock);
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1)) ||
+	    (ref_transaction_commit(transaction, msg, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		return error("Unable to update branch %s: %s", b->name,
+			     strbuf_detach(&err, NULL));
+	}
 	return 0;
 }
 
-- 
1.9.1.528.g98b8868.dirty
