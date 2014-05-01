From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 37/42] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Thu,  1 May 2014 13:37:37 -0700
Message-ID: <1398976662-6962-38-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:38:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxkf-0001Qi-SD
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbaEAUic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:38:32 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:40511 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbaEAUiA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:38:00 -0400
Received: by mail-ie0-f202.google.com with SMTP id lx4so799477iec.5
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=69u5xj1EYJ9Btc4AfLmLLHVtKXJgaVD7jXxMshrfke0=;
        b=KU0yAuTNwrghUVdZ0bwB9+gXoMRQaPY002NNSdyBy/WXfgeLQ5WvsJkIliOBHsJ8Rj
         GVrXhHj9ZrmLtg8zSuNy2g3SbuBsOpaMXaIElCPzgv2Dw8ykhjLunxmDwJuaYWvwjs31
         esGLJWKoHTulad8q5C9HTArr+MtkonMbINQC6Fv6UHMI0mOGe9/M0mXESuGGmKxPDEiT
         TJZW5m67ja4t/Z9kkohHLMr8vRAFbGY10GxzWn9GCoX32TLdUAsJTz1jbbiWh2ofE6Fx
         fx8+Z0aprYuhkemBNidw+s5veBKv4SSz66M4QN7bkflixtAB5utNoemBeIWgzQybid8g
         1BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=69u5xj1EYJ9Btc4AfLmLLHVtKXJgaVD7jXxMshrfke0=;
        b=f/26wO/zIas6mRHasg/MwJF/CEgJljACA7ap4qunIvt2UmeIKxLGHyi8xmeYy0yOWQ
         7Vcnu25X7sn+WeJQsnU9NjhpVcrcWWN1M2UrtC7ufokkXlg8A6l7FLcp4Lr85fJxSpsK
         +rXI0J+EhhfPuh7ZA4o40nVvwMalu851I9ZSHZW4gUgGeuziQ9SKT8e4se8rV5Q9pb1g
         eM2GzQIfkwV+GxlD/CW62KpHqeahUKzA9nx7Wi6gJSR+MTMbRdvd0Up1/8kTH1gE2GQy
         NFpL1TC+2rQ92cG9yFl1rEwH+ibimxtyPlpRI4QMy0bQduknukYKsN7hSXBMaJ9L6/64
         LvNw==
X-Gm-Message-State: ALoCoQkpKWsDhLPi+jCTKoWiYEjJR+GgtwipNr6mhXryfnKeZMytF9czwjn5wcCJtFMWKp63D6Eu
X-Received: by 10.182.51.228 with SMTP id n4mr4308736obo.28.1398976679923;
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id r79si3104444yhj.2.2014.05.01.13.37.59
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:59 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id B862031C2C7;
	Thu,  1 May 2014 13:37:59 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 7CB40E097F; Thu,  1 May 2014 13:37:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247849>

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely.

This leaves lock_any_ref_for_updates as a no-op wrapper which could be removed.
But this wrapper is also called from an external caller and we will soon
make changes to the signature to lock_ref_sha1_basic that we do not want to
expose to that caller.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 14d1573..8d82742 100644
--- a/refs.c
+++ b/refs.c
@@ -2043,6 +2043,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2134,8 +2137,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.rc1.351.g4d2c8e4
