From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 10/42] refs.c: ref_transaction_delete to check for error and return status
Date: Wed, 14 May 2014 14:16:44 -0700
Message-ID: <1400102236-30082-11-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYM-0002Gl-61
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753061AbaENVR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:26 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:35318 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967AbaENVRX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:23 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so37080pbc.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/h1aGdkSq0uVZZRuhgkCFMENxwsskt9gaZdICJBxzY=;
        b=Oj2CYBkSuX870w7TLNNSH/7/qH1iRynJSWX8kWENIGEIX/2G4CzJ5Tvta1ebzaWNNJ
         axe5HOjicFhy2/2K0BKI+/IO2MRQw0AdnEP7IBn/tvWbD1NNAQona51cd+DmzS8zoEuw
         5GmSV7V6koHNbNCxNSzzJTcuEVG58GjYxveYTgnLtHqtoXMDQebSSbuPvtmS7qFqgPCm
         XgmslcM9Lo/lYiw1bfKLflysKZgwNzJCcqBBkmP+LZBM3qWJ4gCjoLKbnnLv7v966mET
         2iwXwhWo4/2j6ifMis7kJ7LSpPzDEwMG66eeo/SMHK7kGY+pMkPCG0F50S6jaFDxX4ol
         QeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/h1aGdkSq0uVZZRuhgkCFMENxwsskt9gaZdICJBxzY=;
        b=SgLUOkjF6CtWifRk1M+yLuUjY6GUYPqfIZjIfKtwt3tiIOCQivN+fwnXMPuj9Vhfpc
         MNRuM8Z2kCJYj8qKCZfatNcXHIxnd3Mg4R6H0Inn4A8zKKQcQFxiJctgLsli00VLbi2K
         SgOThYejB/m/ilTzyrY9sF5Uc8qVJAeFx5UDxZRv5vsR3kkDj8U3TBHeao259HGwhwyb
         mvfHNPWC88yXoZp8Raz01anNJ80iIsvFdYuSfyjBFx0P8Rtm9iUvtaAo/yEawLcoBY5B
         DSaUGFYDs20Y795wsy5OBxqB1/GMGe5wDqRde6yg15ubL0EXA9EkQKWG3Ry5UXH42GQG
         WioQ==
X-Gm-Message-State: ALoCoQkca+Qw6FUr+xNSwO4PMwFImvliQE6sNcADPsYY/o0jNslMork7eI/1c+IPuIDAMebv7FDj
X-Received: by 10.66.169.231 with SMTP id ah7mr3164840pac.40.1400102243332;
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id k43si145552yhq.3.2014.05.14.14.17.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 2A8415A4292;
	Wed, 14 May 2014 14:17:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id DA3A0E0CB6; Wed, 14 May 2014 14:17:22 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248954>

Change ref_transaction_delete() to do basic error checking and return
non-zero of error. Update all callers to check the return for
ref_transaction_delete(). There are currently no conditions in _delete that
will return error but there will be in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c |  5 +++--
 refs.c               | 15 ++++++++++-----
 refs.h               |  9 +++++----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3fab810..fc3512f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -257,8 +257,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 	if (*next != line_termination)
 		die("delete %s: extra input: %s", refname, next);
 
-	ref_transaction_delete(transaction, refname, old_sha1,
-			       update_flags, have_old);
+	if (ref_transaction_delete(transaction, refname, old_sha1,
+				   update_flags, have_old))
+		die("failed transaction delete for %s", refname);
 
 	update_flags = 0;
 	free(refname);
diff --git a/refs.c b/refs.c
index df376fa..64e3d53 100644
--- a/refs.c
+++ b/refs.c
@@ -3381,19 +3381,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
 	return 0;
 }
 
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old)
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old)
 {
-	struct ref_update *update = add_update(transaction, refname);
+	struct ref_update *update;
 
+	if (have_old && !old_sha1)
+		die("have_old is true but old_sha1 is NULL");
+
+	update = add_update(transaction, refname);
 	update->flags = flags;
 	update->have_old = have_old;
 	if (have_old) {
 		assert(!is_null_sha1(old_sha1));
 		hashcpy(update->old_sha1, old_sha1);
 	}
+	return 0;
 }
 
 int update_ref(const char *action, const char *refname,
diff --git a/refs.h b/refs.h
index d4c068d..6026edf 100644
--- a/refs.h
+++ b/refs.h
@@ -266,11 +266,12 @@ int ref_transaction_create(struct ref_transaction *transaction,
  * Add a reference deletion to transaction.  If have_old is true, then
  * old_sha1 holds the value that the reference should have had before
  * the update (which must not be the null SHA-1).
+ * Function returns 0 on success and non-zero on failure.
  */
-void ref_transaction_delete(struct ref_transaction *transaction,
-			    const char *refname,
-			    const unsigned char *old_sha1,
-			    int flags, int have_old);
+int ref_transaction_delete(struct ref_transaction *transaction,
+			   const char *refname,
+			   const unsigned char *old_sha1,
+			   int flags, int have_old);
 
 /*
  * Commit all of the changes that have been queued in transaction, as
-- 
2.0.0.rc3.471.g2055d11.dirty
