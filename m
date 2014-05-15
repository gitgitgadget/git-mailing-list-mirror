From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v9 34/44] refs.c: make prune_ref use a transaction to delete the ref
Date: Thu, 15 May 2014 16:15:31 -0700
Message-ID: <1400195741-22996-35-git-send-email-sahlberg@google.com>
References: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 01:16:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4t4-0005L1-Tr
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 01:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756245AbaEOXQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 19:16:24 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:64960 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755094AbaEOXPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 19:15:47 -0400
Received: by mail-ve0-f202.google.com with SMTP id pa12so326355veb.1
        for <git@vger.kernel.org>; Thu, 15 May 2014 16:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QMSzLnMxRtF/OcqWzTFlbjuS2uYJL7oadDtMuUs03gs=;
        b=HRHYiH9PxoErRtgunshtdEiahjyHvZhWmmKNdoQ/zc6d7sHziCqt6qtfpEIUNA07C4
         8QHA+OWmvVieqVJiYDJwJuNSXInjNH7j6WUYIHMGeknpYGAjG1+AGvHsUtP1YLUc2AV5
         J76qENSsAWqC3r8F/a4RR3R6S1Y0rj99tOXestBwYdUbgQS47LBffm4ax42IkBxPW/Ro
         bDoRVYy0yfv2tAe6YrIEDeioftc4CzgX6xRmGo9FsbIWM5Fj3Wy+GSxOA6p9qXfFKwaX
         vo3sDYEF/VHmBjzaC9ocp6dcF5NrBDMJDSHOXB9If+CuJtT41rJV3Rd/8hLRyF6/DWto
         NXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QMSzLnMxRtF/OcqWzTFlbjuS2uYJL7oadDtMuUs03gs=;
        b=ceiDPDUveR/Etnh0nw6svyqYXck03ts3XYUt2YW5nxuGhPFW0VgYGC5YlabEOaAJSQ
         o+ckx0kP/mX7qpTsXLCQP9oNOdoithgX+n4ApTd8gco+Mt6oAiBVa70brbv4h38NHE0s
         9m5zhGwaEjZ2g0dMd6z14QMkCu1dkMLLto6nMv/BGU4ptkZt/ltLg/FQFTnx5juUWBAg
         iiezSsGGVPdTWC+ReUJ2wwPnagqbG3MR/WQObMMKj4DKlWRP0ftfEn2y2vX32fUO2R5P
         M6tT9hmRKuKbTh2QbcO/BnfbI9VtqZdmig5RyIBW8cgRzBF3q9Ax9saB4ebWsQS13PhY
         2JQg==
X-Gm-Message-State: ALoCoQlnHTRJMzJskHP6csEoQWCUhLI2HIatuLTUa05kzrTajhimhYrxf1lNu/LBIozrY+GXRSff
X-Received: by 10.58.43.170 with SMTP id x10mr6381852vel.36.1400195746066;
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id a44si318075yhb.6.2014.05.15.16.15.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 16:15:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id E4F5431C1ED;
	Thu, 15 May 2014 16:15:45 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BF2BAE0F39; Thu, 15 May 2014 16:15:45 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.gffe78a2
In-Reply-To: <1400195741-22996-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249231>

Change prune_ref to delete the ref using a ref transaction. To do this we also
need to add a new flag REF_ISPRUNING that will tell the transaction that we
do not want to delete this ref from the packed refs. This flag is private to
refs.c and not exposed to external callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 99b110f..f88263e 100644
--- a/refs.c
+++ b/refs.c
@@ -29,6 +29,11 @@ static inline int bad_ref_char(int ch)
 	return 0;
 }
 
+/** Used as a flag to ref_transaction_delete when a loose ref is beeing
+ *  pruned.
+ */
+#define REF_ISPRUNING	0x0100
+
 /*
  * Try to read one refname component from the front of refname.  Return
  * the length of the component found, or -1 if the component is not
@@ -2330,17 +2335,24 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock;
+	struct ref_transaction *transaction;
+	struct strbuf err = STRBUF_INIT;
 
 	if (check_refname_format(r->name + 5, 0))
 		return;
 
-	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
-	if (lock) {
-		unlink_or_warn(git_path("%s", r->name));
-		unlock_ref(lock);
-		try_remove_empty_parents(r->name);
+	transaction = ref_transaction_begin();
+	if (!transaction ||
+	    ref_transaction_delete(transaction, r->name, r->sha1,
+				   REF_ISPRUNING, 1, &err) ||
+	    ref_transaction_commit(transaction, NULL, &err)) {
+		ref_transaction_rollback(transaction);
+		warning("prune_ref: %s", err.buf);
+		strbuf_release(&err);
+		return;
 	}
+	ref_transaction_free(transaction);
+	try_remove_empty_parents(r->name);
 }
 
 static void prune_refs(struct ref_to_prune *r)
@@ -3543,9 +3555,10 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			delnames[delnum++] = update->lock->ref_name;
 			ret |= delete_ref_loose(update->lock, update->type,
 						err);
+			if (!(update->flags & REF_ISPRUNING))
+				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-- 
2.0.0.rc3.477.gffe78a2
