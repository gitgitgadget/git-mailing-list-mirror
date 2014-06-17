From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 29/48] fast-import.c: change update_branch to use ref transactions
Date: Tue, 17 Jun 2014 08:53:43 -0700
Message-ID: <1403020442-31049-30-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:56:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wwvk4-0005sn-JM
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933533AbaFQPzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:55:54 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:53506 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756337AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-pd0-f201.google.com with SMTP id v10so601257pde.0
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u/zBvUYqvo+tWtjIk0/EdIeTvWcY+VGwXrMsdpIcXaE=;
        b=mGeaMObZ47I9RJwODxDJddu6dLl+/Ptl7GO1Yl9OyLGRorooPVH463rhRhWnYCyZwu
         +r/mPgt2lzIhl0IBlJSAHw4eY8zsmfoKccyqe++DfLLQRr1IYdTIASP9QAhl75nLX+NW
         X+dxttxNW/VLjpgLtMYQxdiM6ad49sMmVihR9p3/7QgVvls95oHh5ls/hyS4mABqBh9d
         TW80R7YXsqpXdjs+cBKy+rOib95eeO507wSuQUMgKh5c4Ds7j2P6FuLOwPhVe6OZSyfJ
         uarSo0lQX5qfTomLwHGf1uGfX0ctR8OIx3Ia9VSouekWn4h3jLpnRNEWS56NQj6i2Z8V
         K6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u/zBvUYqvo+tWtjIk0/EdIeTvWcY+VGwXrMsdpIcXaE=;
        b=NUh4CxYhBBR/0LV2qB0dptKpcIPSu75MBpUDci5kH9QoCJFthMsxMzyWVO+quuYGen
         EYr7Ds6kn02IoKkLl+mXYDx/xBczsSdzj0vFEWhxj9PuFQYupx7PbNeaOAdurQMfXQbd
         EJ3sEb/ZeLX1YkiM2wGMnKoW6ARc2JOPbETp2EBD1HWM+PHarJZX8jtzZH4eQDM4YEdk
         qz3HlM9EA4fv7d/UqjR4FHIGfb2/9drjQDyfza6SwpOeuuLoVG3W5CHHmOLPIVhKFAgJ
         FRnuAj4lTOPlsBzpTKJUchFnPeyJIwhw8gPPtserI/ibDYa8xMRBRQ1BOrJPVOyarYzV
         ssjg==
X-Gm-Message-State: ALoCoQnrsImHPexW2RVQvr59nQDazbu+rQtsDy68tL6xFGxe/xCKFrFnWG0F4NJp1KtPg0xMY7UP
X-Received: by 10.68.202.99 with SMTP id kh3mr1432392pbc.8.1403020445591;
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1207441yhl.7.2014.06.17.08.54.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 61B435A4367;
	Tue, 17 Jun 2014 08:54:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3E1D4E1648; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251900>

Change update_branch() to use ref transactions for updates.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 fast-import.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6707a66..cd929dc 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1679,8 +1679,9 @@ found_entry:
 static int update_branch(struct branch *b)
 {
 	static const char *msg = "fast-import";
-	struct ref_lock *lock;
-	unsigned char old_sha1[20];
+	struct ref_transaction *transaction;
+ 	unsigned char old_sha1[20];
+	struct strbuf err = STRBUF_INIT;
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
@@ -1689,29 +1690,32 @@ static int update_branch(struct branch *b)
 			delete_ref(b->name, old_sha1, 0);
 		return 0;
 	}
-	lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
-	if (!lock)
-		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
 		struct commit *old_cmit, *new_cmit;
 
 		old_cmit = lookup_commit_reference_gently(old_sha1, 0);
 		new_cmit = lookup_commit_reference_gently(b->sha1, 0);
-		if (!old_cmit || !new_cmit) {
-			unlock_ref(lock);
+		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
-		}
 
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
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, msg, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.438.gec92e5c
