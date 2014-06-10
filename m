From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v15 12/48] refs.c: commit_packed_refs to return a meaningful errno on failure
Date: Tue, 10 Jun 2014 15:29:00 -0700
Message-ID: <1402439376-25839-13-git-send-email-sahlberg@google.com>
References: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 00:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuUYB-0004cL-Ok
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 00:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaFJW3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 18:29:44 -0400
Received: from mail-pb0-f74.google.com ([209.85.160.74]:48035 "EHLO
	mail-pb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753131AbaFJW3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 18:29:40 -0400
Received: by mail-pb0-f74.google.com with SMTP id rr13so602731pbb.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v10+UfAzxyggvHHhe23R0Pqr5Z8yP9hKButO4uesgXU=;
        b=K5v91sukXrdLB+BGdRZrOpjz9hDwYwZMusNcm1SyBCLN6PSMNxlhtG3+3DusYKVjcA
         dfNpq/BzhG4oKWu+GJOmEuY8BYIRqGyYVJd3SHTWTINJMVkwhMglpUA4UDNmj1l+Xm3R
         c4q03mg1w9qLNbaJ1NBxy/0O0p0v2w0ulhruGv9a3ifmynG40hYsFRe2Kq7rqIy1QabS
         dfhiAbjqapkH70b7oZ5E6XyPZPbWt0kReKzpaxnRSXDDNu01yyMzta4Zrl0wMS6EHz2M
         nNjITBAygd3WHrjfcDOUn9FKsTAzC736pXV206Po/KC0msDmWgbpbOoz17l6aqByggsI
         /uXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v10+UfAzxyggvHHhe23R0Pqr5Z8yP9hKButO4uesgXU=;
        b=BqYpJ6TVngfg1zDEQDyEhTx3C5uIZTKvKWt7+gpTTshj9jq5537gPNXFArh+YFBh1P
         ow9rrKsyRIe0pSOrZP5IdEmBAfF7tA8MDm28RMPt4K/i+x3d7wKPMWLDv8uDdctJ+CND
         aIAVRcu7XaBrpUPfmw5hbw9hwYpR0uLyaEBcPdWqPCxIPgCMt0mYBqBqzA9eSKs6rH5m
         SWykiOfNiRVFzD/wXdxwIVFtfKukmupuPedOxV9Nk7enI6uuajVqXaAU600Fld2fLSUK
         iTTTu+bTJe4d2no00AFlGsDtuTpb22MkaJfR9wDb3LGK9RXt/hp64fkemdZGSq7lSA2i
         NEwQ==
X-Gm-Message-State: ALoCoQmhVPZM03MqnqmsZuwt6nkTBK4kMs+yFX/TA1XouDy6RC915AQaUnJBEsRTMJ1LueDHIgXG
X-Received: by 10.66.122.101 with SMTP id lr5mr91552pab.19.1402439380501;
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id t4si1374936yhm.0.2014.06.10.15.29.40
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 51E4E31C741;
	Tue, 10 Jun 2014 15:29:40 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id EA46FE0CCA; Tue, 10 Jun 2014 15:29:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.574.g30c2c5e
In-Reply-To: <1402439376-25839-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251272>

Making errno when returning from commit_packed_refs() meaningful,
which should fix

 * a bug in "git clone" where it prints strerror(errno) based on
   errno, despite errno possibly being zero and potentially having
   been clobbered by that point
 * the same kind of bug in "git pack-refs"

and prepares for repack_without_refs() to get a meaningful
error message when commit_packed_refs() fails without falling into
the same bug.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 10 +++++++++-
 refs.h |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index dd28214..dc9de2c 100644
--- a/refs.c
+++ b/refs.c
@@ -2211,11 +2211,16 @@ int lock_packed_refs(int flags)
 	return 0;
 }
 
+/*
+ * Commit the packed refs changes.
+ * On error we must make sure that errno contains a meaningful value.
+ */
 int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
 	int error = 0;
+	int save_errno = 0;
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed-refs not locked");
@@ -2225,10 +2230,13 @@ int commit_packed_refs(void)
 	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
 				 0, write_packed_entry_fn,
 				 &packed_ref_cache->lock->fd);
-	if (commit_lock_file(packed_ref_cache->lock))
+	if (commit_lock_file(packed_ref_cache->lock)) {
+		save_errno = errno;
 		error = -1;
+	}
 	packed_ref_cache->lock = NULL;
 	release_packed_ref_cache(packed_ref_cache);
+	errno = save_errno;
 	return error;
 }
 
diff --git a/refs.h b/refs.h
index 3ddd618..86f0984 100644
--- a/refs.h
+++ b/refs.h
@@ -97,6 +97,7 @@ extern void add_packed_ref(const char *refname, const unsigned char *sha1);
  * Write the current version of the packed refs cache from memory to
  * disk.  The packed-refs file must already be locked for writing (see
  * lock_packed_refs()).  Return zero on success.
+ * Sets errno to something meaningful on error.
  */
 extern int commit_packed_refs(void);
 
-- 
2.0.0.574.g30c2c5e
