From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 27/48] sequencer.c: use ref transactions for all ref updates
Date: Thu, 19 Jun 2014 08:53:09 -0700
Message-ID: <1403193210-6028-28-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:55:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxeg9-0007mr-F9
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933471AbaFSPzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:55:03 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:63136 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758052AbaFSPxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:35 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so692922iec.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Rw7T8xhYDqaRfRu2j1hJHlg4SIZ1vayIqKeAjk71yY=;
        b=Kyf3FUNuLIIhk9Iew+SC73/7PelB0zbR6zqIKPXgcW6ISSxLdsLs5g5iJ1/zXdVR02
         knmBfp/cCOcwEq0kDgfCCpn7pZo9V+63aexDF3Z6GBcMwnlDnpEeQ0wR0nHlKDghMZ04
         2F28pXfGpSjuwmkuZO6sKQhsoP2S/8OZxBmP+U5Kzdn0WGiIVUqIwMfTJZbRXf4K5Vh6
         lKwTVs24SigI1cXyukpcai7i8xUCdnt0aUqm0KltHhkEkvudCPmUZ18bdvzFNSf8vNJX
         rNtwdqIaTpsE93W7v8p3w2sD954kRCne2zr0O+FzuJVqSmbRJzFmXyQlzYrxXlqWnG7s
         8HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Rw7T8xhYDqaRfRu2j1hJHlg4SIZ1vayIqKeAjk71yY=;
        b=S2m4FBAZeIOfnpskRKC8GjAZcmhglBhbHw6zmpVGX2kyIiX7PJeCfymKaHuNkX6lyV
         o+A9J+yEYKmDnfKTSKQrxHO+VWXngJW5cQ12zzS7xl5eNFoLnUEty/GEttznR4gsdLMu
         +P2uT35koXyQqDRNwe+1WNv9Ytw493X5dCv7GHdhJscSiIZVDBoUj2repM2gtrQ4ZVc8
         +LNiLOKW2YX7AyZtimM9Lr7tKP68itoAr671PFjH+GlQ9UyonSNyYWjQA0ALraZlQogX
         8qAjYHH0FmyIZCdzA7mg/sNmgjGg5U5t4GGs5EfadR/PKwClescsEy4JDAyu7kr+v2Dw
         twCA==
X-Gm-Message-State: ALoCoQnkWxeDaHIIjdMa7JyKXPgN2tjnueBXuJ6m+q9DrB/23cGcdUSTwN7Rp809vy2CuC0oSkSg
X-Received: by 10.42.86.145 with SMTP id u17mr2358434icl.11.1403193213766;
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si421020yhm.0.2014.06.19.08.53.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8D94731C2E6;
	Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6C3A3E033F; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252137>

Change to use ref transactions for all updates to refs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..fd8acaf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.438.g337c581
