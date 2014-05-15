From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 23/44] fetch.c: change s_update_ref to use a ref transaction
Date: Thu, 15 May 2014 16:15:20 -0700
Message-ID: <1400195741-22996-24-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:17:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4uP-0000IV-VF
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337AbaEOXRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:17:34 -0400
Received: from mail-ob0-f201.google.com ([209.85.214.201]:58971 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986AbaEOXPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:46 -0400
Received: by mail-ob0-f201.google.com with SMTP id wn1so388908obc.0
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzCkWARZxkQeJhAEGMTmP+vzzUgDrB6dJdCrq3ODZJw=;
        b=O4Zs5HK/3qra9FtrfbSdYr6HYAnaxQzxT3X5qLZmeFIr/eW8or6TW/KvSXRUvQ6iDS
         x/6iMW/Gcas0LwZMmX6/LWnM6gtRAhnK6n0XaVltDVPPW0EdplCWzRxePDDj+qJEnYQ7
         cXAIiy1t1uTkBu9Sk8mxlejjsE78ZSBRaaHSyvcq5ThZx0IWznoWyuS55cfLAByybTor
         gn3YEAZj8yzesaoB7CyrSr1G5Iunm0WgfyTHLdj94O49+UMNLTzBKyhfB6UUmBePTpqE
         bySGq6iskfHoXJBoAwZ7Y5tXXtryn13hcKLVvKbTChhNfU8GJoWpWTJE2+3t+x5zshiS
         rF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzCkWARZxkQeJhAEGMTmP+vzzUgDrB6dJdCrq3ODZJw=;
        b=iORObGWJgMjpopEUmT69WyjMpM4Uf85NmtUfbCRQuduuDouuzfkVQPzj0Aut1RIubW
         5wwz/voBSSZ4HfH290FAVIVx4Skf4hS4InVOoiA6da5kHOxc2OQipwv8UEy1H4RjN3Yx
         fbT9K5YCk46nvl5tFAsdPESaRuYd/ircQrXn0SOr/1z3JoXrsLr1CU2mu2AluHkMipU+
         BJCCUAmAYRdvFkRFXb+aklUEUnQ8GP7kzvJz0tkQJWbm/+1Gqn4Hr+/KbdfFmCeXfN62
         k68TADs9N3q2ExwjiU5c65qFaxAHQaaROcO8GSFPXl4/imL+gjfX0gP3ZQsznoUwASUP
         pp1w==
X-Gm-Message-State: ALoCoQnrvUeXqcV/wXJqtDd4UpupXPzGiDW/kSb+wHLxOm/2AnNzlXi8ZWn4+nh4K8HkNFPhiCpt
X-Received: by 10.182.153.68 with SMTP id ve4mr6609438obb.39.1400195745530;
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si319192yhj.2.2014.05.15.16.15.45
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 623E731C2BF;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3CBDCE0B9F; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249258>

Change s_update_ref to use a ref transaction for the ref update.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/fetch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a93c893..c9b5954 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
 {
 	char msg[1024];
 	char *rla = getenv("GIT_REFLOG_ACTION");
-	static struct ref_lock *lock;
+	struct ref_transaction *transaction;
 
 	if (dry_run)
 		return 0;
@@ -384,15 +384,16 @@ static int s_update_ref(const char *action,
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
 
 	errno = 0;
-	lock = lock_any_ref_for_update(ref->name,
-				       check_old ? ref->old_sha1 : NULL,
-				       0, NULL);
-	if (!lock)
-		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
-					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
+				   ref->old_sha1, 0, check_old, NULL) ||
+	    ref_transaction_commit(transaction, msg, NULL)) {
+		ref_transaction_rollback(transaction);
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
+	}
+	ref_transaction_free(transaction);
 	return 0;
 }
 
-- 
2.0.0.rc3.477.gffe78a2
