From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v11 23/41] refs.c: change update_ref to use a transaction
Date: Tue, 27 May 2014 13:25:42 -0700
Message-ID: <1401222360-21175-24-git-send-email-sahlberg@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 22:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpNxk-0003CU-1s
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 22:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbaE0U1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 16:27:04 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:43276 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbaE0U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 16:26:05 -0400
Received: by mail-vc0-f202.google.com with SMTP id hq11so845146vcb.1
        for <git@vger.kernel.org>; Tue, 27 May 2014 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6XP5UNtJ/rRICsqD2WMOLPOKDNXyoBmoiwG2ECdFv4w=;
        b=djAC3XYgQUruZhynXXJihefFxYoHgq6GGn30pQzl1Zj4mt+hL/PeZenWsWDxDBcB/n
         IHWuHaMa13vGZZ/ttYukXzrtPi7LZYZ9eGxr4/w/VJwjJ78Ca5apoon3Y+OWtnH2B2Yp
         OrcRmgAWqCLPK49QtDTAcKOqasI9B1+uD/h9BzPxGafTdGacP32s1RlaQARz+KhMMdX5
         npw8CoN8DCkAAV0ctguQuATnLXkh2MqGrjZd1ONVFbvB9AOzGG7bzeWoxQuy+Lc4EH+G
         BCIChU7cPfxVenHZPDgAdm3ly9ejvcxnIqcxD1VRlA9TSo815+iJkSCsdZsYmKIXYfdW
         4QIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6XP5UNtJ/rRICsqD2WMOLPOKDNXyoBmoiwG2ECdFv4w=;
        b=lTqOnOm3CRSlwaXuvx7/m+FNjxD62sAsmcZjyvGaqZcvHEPPFB7v4NADFxQFYTQsQ5
         qaeAymzgcaW2CUOJgfjBvyBlLNgZrbyIWdcQ5E8bjGRKIoiZS4yYN3KwBnnE6ZkfuJ29
         XhJubEujq04Pq4WRh3up8aY4XiMYqBBn8xBSZ99PZdpWAXSs472B7HQ89FQmZAxSvZ2r
         TWydDh2LXyoDXVISFlKfm9QHY3AaC2Av/gIycXRcytJHYI8DcrtYqSE56ymSPbtO+xsn
         nq7I9suvgKkGjJQY8UjrHOYIT5J56wvezBOAriq5C2EfpK+kbOKtyL482mEnLa4Q5k5n
         9IMw==
X-Gm-Message-State: ALoCoQn6sEDuA5zvvM+ap6KPx8ShriYyQ2PdyN3gOKy0xzWg1TQ1TSXc4xao0QFCBedOlOxLFSui
X-Received: by 10.58.30.108 with SMTP id r12mr13798384veh.17.1401222364739;
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id c50si1573751yhl.7.2014.05.27.13.26.04
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 937A12F4AB9;
	Tue, 27 May 2014 13:26:04 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 73B63E15EE; Tue, 27 May 2014 13:26:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.474.g0203784
In-Reply-To: <1401222360-21175-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250215>

Change the update_ref helper function to use a ref transaction internally.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 9992da4..fd8f3cf 100644
--- a/refs.c
+++ b/refs.c
@@ -3474,11 +3474,28 @@ int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
 	       int flags, enum action_on_err onerr)
 {
-	struct ref_lock *lock;
-	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
-	if (!lock)
+	struct ref_transaction *t;
+	struct strbuf err = STRBUF_INIT;
+
+	t = ref_transaction_begin(&err);
+	if ((!t ||
+	    ref_transaction_update(t, refname, sha1, oldval, flags,
+				   !!oldval, &err)) ||
+	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
+		const char *str = "update_ref failed for ref '%s': %s";
+
+		ref_transaction_free(t);
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf); break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf); break;
+		case UPDATE_REFS_QUIET_ON_ERR: break;
+		}
+		strbuf_release(&err);
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
+	}
+	return 0;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
-- 
2.0.0.rc3.474.g0203784
