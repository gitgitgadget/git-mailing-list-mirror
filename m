From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 02/15] refs.c: return error instead of dying when locking fails during transaction
Date: Tue, 21 Oct 2014 13:36:47 -0700
Message-ID: <1413923820-14457-3-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:37:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggBA-0000eP-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933211AbaJUUhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:37:08 -0400
Received: from mail-pd0-f201.google.com ([209.85.192.201]:49718 "EHLO
	mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933060AbaJUUhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:37:04 -0400
Received: by mail-pd0-f201.google.com with SMTP id y10so367336pdj.4
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xvLq3cfJbg0buEFcXpRIQXafFACescjpWoBSzSvHeuQ=;
        b=P6QdICpfhEuANwGaRJwETFdRVSVedxRuYR6PpICQHC/YntLZZ8DdxyAW1y5COaZiXt
         5tKx0Kt/KpVeaQua08ww9ndPI90BNLqAQOMdXnTC3wrijYcV5vfdRJNyunTI0dCeYYYd
         mwMKKjLbxcMCBCSa8l7qfbEAQCXVOvF1AbVbYnQwlWVwzPmR1pZmJTZI9BellesWOLXR
         JercKDdvIYuJqzrf1fjlq9nqP3CEoZ9hLlngWPoVVdPUIMYPmUgRn41Ye2xMr89TewWI
         lp/3s3MASpzZNx06wd/iDl0i/wK9aD4A+ZJvBbKcSJACsnQSQ98tCdgML6D3XeLL3XzM
         9dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xvLq3cfJbg0buEFcXpRIQXafFACescjpWoBSzSvHeuQ=;
        b=DfMkd0K1WT+Y7vXgE+GWGilbaVRZyG2XCx+yJ2pD6ZninKvW/i67FZ075KbwS6iJPv
         hat+4B/kO4ffZ2L9417E0h8AnqD8tdDJnxFzVaYHsBOUkyqx4yWywyUh0pC3TGZ8KsQ3
         FlL7nrh4xsp9+n+jd+3QLNNLr09T7lOoFC4Iz3DV9gO7VFpY0+FJc3y1r6/78dvwC3j/
         O3vdt8Vgvx/eOU4nkDA5yENeFyKG97N0RoJIAOYL5vsRosymWK3v8eeUjwR/q6aS9uWU
         e8Js8jfBHQCGdYdwAL4ELXod+ODXL5P4y6mNb0NCTqTWMmPEPWkeEOkr1Gm4pKDzzEWV
         xQjA==
X-Gm-Message-State: ALoCoQmXk7reHgiF/lofYUtLizLj87RIKo2eFSLGQCX1Rc3PJ870oH1z9IPmyDQPh2JXWxlKios6
X-Received: by 10.68.132.234 with SMTP id ox10mr1961602pbb.8.1413923823495;
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si594001yho.5.2014.10.21.13.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:37:03 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id s9atD0sh.1; Tue, 21 Oct 2014 13:37:03 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AD559E0CC5; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit e193c10fc4f9274d1e751cfcdcc4507818e8d498 upstream.

Change lock_ref_sha1_basic to return an error instead of dying when
we fail to lock a file during a transaction.
This function is only called from transaction_commit() and it knows how
to handle these failures.

Change-Id: Ie830b7970412d9299e76a86f08633ce721130aed
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e49fbe9..c088d36 100644
--- a/refs.c
+++ b/refs.c
@@ -2340,6 +2340,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 
 	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	if (lock->lock_fd < 0) {
+		last_errno = errno;
 		if (errno == ENOENT && --attempts_remaining > 0)
 			/*
 			 * Maybe somebody just deleted one of the
@@ -2347,8 +2348,13 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			 * again:
 			 */
 			goto retry;
-		else
-			unable_to_lock_die(ref_file, errno);
+		else {
+			struct strbuf err = STRBUF_INIT;
+			unable_to_lock_message(ref_file, errno, &err);
+			error("%s", err.buf);
+			strbuf_reset(&err);
+			goto error_return;
+		}
 	}
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
-- 
2.1.0.rc2.206.gedb03e5
