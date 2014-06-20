From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v20 10/48] refs.c: verify_lock should set errno to something meaningful
Date: Fri, 20 Jun 2014 07:42:51 -0700
Message-ID: <1403275409-28173-11-git-send-email-sahlberg@google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 16:47:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wy05o-0004LJ-QS
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 16:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825AbaFTOq6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 10:46:58 -0400
Received: from mail-ie0-f202.google.com ([209.85.223.202]:43100 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbaFTOnd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 10:43:33 -0400
Received: by mail-ie0-f202.google.com with SMTP id tr6so979049ieb.1
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eOwbBsrcAYG/G64LHlUjxAQcMI/D4iC1I69mat8oK3o=;
        b=VOk/hTlIKDTX4HdACm5dyV1CAnRrFMZn4j84Ww7dTu/fhXOTV9LDS2LsOXjckAc5Rr
         pfX9iTViwc6IetrOmO6RvNgGjcPN6W4Tj2tCGNM0fzQaYSLKkk/AcUWSgEqU700rQmN3
         kyIk26sHqBEtVWlOocFBP23RjFVeRMaCERFvbBP6RpG0u/3vQ4zD31ovNCiL9c7E62RC
         Oho3YdNWW3wxX+5Zf7hqdiOn55wCDQpFz370OACgsWRpuldOfPnaC2wZNvaMTGpSpmq3
         TGFNoJ7bc8Vvi8vGS7nInK4wUeNKdok/L04eYuOfIn+HppDswaPHHkLKldD/0s2VMymK
         cdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eOwbBsrcAYG/G64LHlUjxAQcMI/D4iC1I69mat8oK3o=;
        b=CMont8CvlGCRg3NUERoQuAtD+KTnhbD02llrH1MCZsFeE2dzW81TO8+mQJ+7gg/YxF
         TUvwGkbyq8VzauYmMpSqVstF5EYeyw3WHI/c/IgdUXaimhcQ+3N1KtaQU7MDV4YUKl0O
         kdnuvwbZwJwpJQUSfMhgOT5RoZxy1duKRcVv3GbrOEhDVJ67XumiImsDzH/idueDtFyG
         4AXSFHkSort+XOi3bSSNHw0U8T9BnwOXtGrigknt3r4vO/ECnaJ6GL0L5IVKpjZvcoMN
         e88bWXraUGRGeh+4ayyg6AykKEyR0ZvQjS+t9f8ssPVKOQErm6ZYxG3iUxT4Lx7CrsSO
         OEWQ==
X-Gm-Message-State: ALoCoQmS6CKWdypv8ivJ+DByhOMmSriWkd8uP4G9v8tzxtpM/Th1OXnuzyDLFGfDIId2Ir2wdMhp
X-Received: by 10.182.115.133 with SMTP id jo5mr1562417obb.38.1403275412478;
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id j43si432417yhh.5.2014.06.20.07.43.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 52FB45A43E3;
	Fri, 20 Jun 2014 07:43:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 0B3C4E0769; Fri, 20 Jun 2014 07:43:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.420.g181e020.dirty
In-Reply-To: <1403275409-28173-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252268>

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
index 82cc5cb..8d6cac7 100644
--- a/refs.h
+++ b/refs.h
@@ -137,11 +137,15 @@ extern int ref_exists(const char *);
  */
 extern int peel_ref(const char *refname, unsigned char *sha1);
 
-/** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
+/*
+ * Locks a "refs/" ref returning the lock on success and NULL on failure.
+ * On failure errno is set to something meaningful.
+ */
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
 #define REF_NODEREF	0x01
+/* errno is set to something meaningful on failure */
 extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
-- 
2.0.0.420.g181e020.dirty
