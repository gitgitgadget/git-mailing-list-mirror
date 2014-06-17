From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v18 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Tue, 17 Jun 2014 08:53:24 -0700
Message-ID: <1403020442-31049-11-git-send-email-sahlberg@google.com>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 17:54:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwviN-0003eu-CN
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 17:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbaFQPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 11:54:20 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:51608 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321AbaFQPyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 11:54:07 -0400
Received: by mail-vc0-f201.google.com with SMTP id ij19so962811vcb.2
        for <git@vger.kernel.org>; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=joJyFyBr6IdJgzQ9yrmn5/ejd4hRB8OOP0rRNLjwfEc=;
        b=Wsqe6Hj/4lMfidiPEsMwJvhbXttgGmXN4PqxtSySbcOdGXWak3k65J7tXb4hcQF6Z/
         GebmYK/UfZCSpAuaErNM+PN6ORv28F1qnSGpUY3yzMNRIqFwXis54m3OaGvgp6DQtC3X
         NemsWxt1tM/6cqqDewkjpZo71wnZ94p6bK+rzCSAOQ15IaIXbDn/zYeunaexmpgKWup7
         bY64dKBwtIWSnqzMocfTaPEc1wVEM1IzF/fS7L4oxTPbmfnfl3w8ZruZwpvFOyfuqXKl
         FWq18T5NSGO/KlnlvTflhzS7VOomYDXB/9uQuQNML3RFC8PBxKHpbObZTc6HJ5ucJoKf
         bxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=joJyFyBr6IdJgzQ9yrmn5/ejd4hRB8OOP0rRNLjwfEc=;
        b=aT3aeK6NAnJ0YrgnLXywb06zdWUKnEwn6/ZXKy26OSaigVdt3m/aOu+DU/i5+n8JQ0
         qvTNudzuh36oosipVQui+5QSZ8RQJp9eR4DeH8A79ylystCGNuaxMISnrU2S7VvAe7GA
         2qcmanOW2T+uQUAXjOcZ3h87sIJIlulLU5CkoXWHA6MjJh+mKuFeq9U2Kt7/n0KUztg6
         VpgaC1i7rbhUUwteGqO31bK2hLdSE/s8HM9idqJTq7sUwwimrX22anaMIQYVJBPSqJ5M
         ehD7mKQOfBDSLfojlRs4cUVNZA8s5619FIgegcLLlwaw+yX+k5s+OXZ5mJLbVH0BfMEI
         wxjQ==
X-Gm-Message-State: ALoCoQkwccA/w0aKE3o+MrbUu/qCnBZQ31OU7nwSSlqVyOGOw6a3uf+ydpuZIglcP6AHGef8Nh+D
X-Received: by 10.58.41.33 with SMTP id c1mr4105442vel.2.1403020444759;
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si1209459yhg.2.2014.06.17.08.54.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9978531C76E;
	Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3D29CE178E; Tue, 17 Jun 2014 08:54:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.gec92e5c
In-Reply-To: <1403020442-31049-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251875>

Making errno when returning from verify_lock() meaningful, which
should almost but not completely fix

 * a bug in "git fetch"'s s_update_ref, which trusts the result of an
   errno == ENOTDIR check to detect D/F conflicts

ENOTDIR makes sense as a sign that a file was in the way of a
directory we wanted to create.  Should "git fetch" also look for
ENOTEMPTY or EEXIST to catch cases where a directory was in the way
of a file to be created?

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 ++++
 refs.h | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 9ea519c..a48f805 100644
--- a/refs.c
+++ b/refs.c
@@ -1932,18 +1932,22 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+/* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
 	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
+		errno = save_errno;
 		return NULL;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
 		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
+		errno = EBUSY;
 		return NULL;
 	}
 	return lock;
diff --git a/refs.h b/refs.h
index 82cc5cb..af4fcdc 100644
--- a/refs.h
+++ b/refs.h
@@ -137,11 +137,15 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningfull.
+ */
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+/* errno is set to something meaningful on failure */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.438.gec92e5c
