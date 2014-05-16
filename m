From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 39/44] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Fri, 16 May 2014 10:37:27 -0700
Message-ID: <1400261852-31303-40-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:38:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM5l-0000Oy-3P
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757825AbaEPRik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:38:40 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:55964 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758094AbaEPRhk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:40 -0400
Received: by mail-qc0-f202.google.com with SMTP id x3so490316qcv.5
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HeK+A3iwW1ELftKuHasbPzXspsGo8/H/0Pfe9qcJdrc=;
        b=Ev1HcItry1J3fseBTQZA67D3Wm2wQMwJIjhpQhTTI7nuPdcO9AejqtK7IHAKfSICw8
         Avp2A6RsQf/Q/QcQhOkr9d6e49DREQJ3ui4qwo7Nbio3BhhtpC85Yd83RqHdsyoX5sDp
         NN/UMqra/mVR6uJyrBhZR2PHg8vflwPraMyWX6oMwozyVhUdReJickS+XTWJL5peZmry
         FvpJ4Yw/A/qMubPRgS12V8bcLXVTVdXMKnpu6JnZeBxgM1UUUWLEQUkp+V3SUZNt0es3
         sFsZZ/az/zeuQiftBzGxHjJeeGeBqJElDqRqpch/iUtOpMzZBK+MmGTvfNe3RtK6IX6K
         6+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HeK+A3iwW1ELftKuHasbPzXspsGo8/H/0Pfe9qcJdrc=;
        b=GgBkzLx9UQsNx21UpOm2Gf+YvJnJebnSRQlhh4ABWh6C/u4QQFrlvGBpBGigDKTDP/
         PkuImbIjeX07rytxS/g+gjuyWxeZaVsBqxN6B/yEo5cTa1hzqpUXvvEi/TKIdenL0Hhf
         kbSXEslTFlm6MFRXmVR4ImB3VLaPSclpAZlYh3gkogp76lVXz1xPhGMR5dyWpU/SpCuq
         KUt2alT9xOCSpzEzBfN52SfEWErAx72XNgqOTJqSrnoF7mqmTuIxPCdkYvbpmodtr3D8
         BsrwcQ2szEdQPnMkFSLTLDEDH9VbEbxQau1AKfaV8xNXeEeXRtlT0tsi6dC3yxIl4Q0I
         ExeA==
X-Gm-Message-State: ALoCoQl1K8HNnGdg5E8ykRU/uwoAZNhfKN61n9xYDtdb/I3gPd7rFSjpF6AHS9Ffd/NB4ITaGF/g
X-Received: by 10.58.77.104 with SMTP id r8mr1229683vew.40.1400261858550;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si368520yhj.5.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 6749F5A40F6;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4335EE0A04; Fri, 16 May 2014 10:37:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249370>

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
index f4899e0..f63a356 100644
--- a/refs.c
+++ b/refs.c
@@ -2044,6 +2044,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return NULL;
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2135,8 +2138,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.0.0.rc3.510.g20c254b
