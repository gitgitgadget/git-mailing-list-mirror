From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 17/19] refs.c: change update_ref to use a transaction
Date: Fri, 25 Apr 2014 09:14:52 -0700
Message-ID: <1398442494-23438-18-git-send-email-sahlberg@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 25 18:16:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdint-0000OR-6b
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 18:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaDYQQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 12:16:21 -0400
Received: from mail-qc0-f201.google.com ([209.85.216.201]:42491 "EHLO
	mail-qc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbaDYQPI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 12:15:08 -0400
Received: by mail-qc0-f201.google.com with SMTP id c9so631945qcz.4
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L8CY51bulaSaFyZf8wgnoO8bCdDlxK2+LORAenX2Xao=;
        b=D8YP/+uYSjRDexoAUXv87zqH1WJTvtWCNy2KMXh1KQgLSHO7WScTdDZf6Ilruub+rU
         6TdfYnBw67g+ObrOEPmuo4hS+4k5OHkoCeHlfQZ6PiHPbD3WPBgqDldO4snkc4VrG2NL
         JHTlpMfL2kbVWIMAdkfJg0Exj+HuZUWFRrDEf1pv6W8gw96EJICSfoTPwn8EpUzSHgiz
         cs6K87UQvFnBE/N9lASzbf2Sc1vL1CinxJaGLvbmeoTnP3ihDCguyHVawASajqPpHZJO
         Pu8Tkog0Ju+oWsKnoZKkaV44Wx6ms4pMSz4FF3mPxfHNiyqpnWOPW0n1tFADQQEaopt2
         NMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L8CY51bulaSaFyZf8wgnoO8bCdDlxK2+LORAenX2Xao=;
        b=YRZRKeWuoNq3stt38fgA/uROjGjO9sY2pk3rCQz0nP0CbbN3F9/pw6H+DAN/5itsNB
         QlJXiFSbFcHJWd4KKHiuc/NAPi5SHC6yNO8Jk9hpbcZm3S/ZOTAbfwqtQOaVxGP8M6wT
         /3VYnTzrIcfKzA3z1L7ebZ0EAtQjs104et3PbcGc/+w8Ts3XUgP9Pv3KHscIpAMMzaqT
         urmQbsSlpCgOxlMECZksiCH0JFk36YXQLKOeAfAifL2SfEYiFc3HF2AMgbukp5dSTaEM
         bpn1AFYQ/7P35F4Hoi6hDu2mP5Q5fllNZ3+ZwmUTQKeSu0hNZVu6P0rLaLZagfsAfwy1
         6ntQ==
X-Gm-Message-State: ALoCoQkJ3VsL7SG2+PiZ073v0aEP7VKoAAqvyKlRc9gCsVSLrjRa7AV1S/mYahLIM1VP2z+A2Z/VM4xtROTpsW++yz7EToQi/C76EqYhjs1kybeCqishn84AcibCkNwVoF/Pp+3NCymcPsOOw/pVW0zjTXfTgSg8q0OUzM6cud1rHmhJ5jNWsKsoTC5R7MNLjMSPhbMxc8o5
X-Received: by 10.236.128.112 with SMTP id e76mr4455701yhi.38.1398442508224;
        Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si1049904yhb.6.2014.04.25.09.15.08
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 18ADF31C1B6;
	Fri, 25 Apr 2014 09:15:08 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BF3E9E0855; Fri, 25 Apr 2014 09:15:07 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.521.g5dc89fa
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247058>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 1557c3c..95df4a9 100644
--- a/refs.c
+++ b/refs.c
@@ -3397,11 +3397,26 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	char *err = NULL;
+
+	t = ref_transaction_begin();
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+	     const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_rollback(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR: error(str, refname, err); break;
+		case UPDATE_REFS_DIE_ON_ERR: die(str, refname, err); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		free(err);
+		}
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
1.9.1.521.g5dc89fa
