From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 36/41] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Tue, 27 May 2014 13:25:55 -0700
Message-ID: <1401222360-21175-37-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:26:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxU-0002p8-44
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbaE0U0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:26:33 -0400
Received: from mail-yh0-f74.google.com ([209.85.213.74]:48402 "EHLO
	mail-yh0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbaE0U0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:06 -0400
Received: by mail-yh0-f74.google.com with SMTP id 29so1647054yhl.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/YGR1EjuQKk0ohWejc9+ZPM9g8I1gA/CVQ0qH8Hry8=;
        b=RuMCNL5uIZ5PaS34IPymMcH/MKEbwopVOnNCZQTIqvFkCJPAe0gCrtkZVcfSGuwnQc
         SLy3vXxXsakRTk65e3zdjTcSDfkxhjQWZC7r4NAUr76ggmaUk5SFwN0GxRaVkOzz9X+w
         SyUtAqHyVqd0f1T196K2Ga+KthNgsqDRNXdaVxSFhGNVDyxenheECARJqOCU3gj0c7Dw
         VBPXzm0QCZ1oweft2hdhDnXulLAyBf4S4ll8Dc5GWw2OklTtRe9/WVTv295uiN5EPj3o
         MDi8KZpxcsvlNv0SPOmDTzCYObdW4MGs8SYMLcXEnGvRx+14ZIPE9o9e1tFkXb3syKNQ
         Kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/YGR1EjuQKk0ohWejc9+ZPM9g8I1gA/CVQ0qH8Hry8=;
        b=GIuw9ScMBbM9rlpatDRU5UkS3iZwYiiQ7ITqvzS+anAaD52p7RUFYSCb8JJoP6WGkA
         oiK1YWQqB9h8cRhhsU3AC5VtHdQKKxy3YCwHakEDTNKn64dMOM3A953cEFSmVoKdkwGJ
         /LWbUASt6iozbmIENIpvp8etcIguVuJL8KUmHK4YV34jmTTRFx2N8OwmgkAjtya7V28n
         BnRts55kYuC3BeK4rV+i1W6OSHLUKKL2hUppVGn+gerkLECa6l2nSuk8irOIy5R+7qU1
         yT2TQ9RWxLpwAPTk5Lg9DAXGVwTQcZibQEdgN/ixuwYOequPs8FRTESiO+U22dgmrhIo
         CofA==
X-Gm-Message-State: ALoCoQkQtpQy4WEBCLgdFatTmDN0z0AoMtRCC0yCAxuh648Vmmb0RUbU6VOtSg1UXOetlg3yxtPj
X-Received: by 10.236.128.195 with SMTP id f43mr12355929yhi.45.1401222365368;
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h13si137573yhj.0.2014.05.27.13.26.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3D15F2F4ACE;
	Tue, 27 May 2014 13:26:05 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 194E4E1081; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250208>

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
index 08dde5b..2952871 100644
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
2.0.0.rc3.474.g0203784
