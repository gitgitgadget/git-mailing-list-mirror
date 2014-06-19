From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v19 02/48] refs.c: ref_transaction_commit should not free the transaction
Date: Thu, 19 Jun 2014 08:52:44 -0700
Message-ID: <1403193210-6028-3-git-send-email-sahlberg@google.com>
References: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 17:56:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxehj-0001Mf-9O
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 17:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758085AbaFSP4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 11:56:42 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:46123 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558AbaFSPxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 11:53:33 -0400
Received: by mail-ie0-f201.google.com with SMTP id lx4so693410iec.4
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 08:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZiUlAuoOBZGE5Zd+Znw+c8d1buwGxZaryQIP0MqXYzo=;
        b=dzT7e2i0puld3f8cVqduC6eO7f2GASK+xIW8i56AtHdaQa0kXrX2703P92v6VVn4+F
         1o42hrvJvRUEeNYmmpFDQHgMC3GorRUjsOWo77HtHNN8afgVvXvRVTMmlNhDFFSnjYq4
         uQTSRiR5ZbTtHGDsiImvDo5h5ASm4a+frXTtH7LmgzvL5bFw1NKfJTlv6XOqbHKbrUMb
         5cmpwBetOn4ELp/wRFwwpLxDWRh6LHEDgdJvaaZ3E8jTLyhCNTrZe/My/6bkL3Nf1x4s
         eRXQFqoGeVpwiHzhiCQdEOAO+ZbWLZtbHQ6lc+oVJcwmylBEPUI6u/4Ac39Y5JSwO5RW
         2L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZiUlAuoOBZGE5Zd+Znw+c8d1buwGxZaryQIP0MqXYzo=;
        b=fElDFPp/AKdtHHBMoldGGWfYr5k/mufK5muN/iwPe+1XvOWqQfALsXsnFmRv/7Tvno
         2gi/7MTKONzl1rBhI9s769r/LJOAd3goG/ACJNi5y++gcKq8a1+CvmS5shGcFqNakB33
         hb5cEchbwfxQKo5jM++vnXUNjadO8SEKTs/8sFcgFljV4I+RtSqsksbJTD/MJfy3YJVC
         Ng2XdkPcN6Y+TxZF0w+rxat8l1zQvVwMwonqjv2Q14Xw8xV9xwlQGTV4Q02HDCTPBw5g
         ui0QPo+iO8d+XOB/+YNu4u600W7MjQdsBEueVHG62eZoEoOr4AE6xv5GN/PM/qkLaV6p
         dELA==
X-Gm-Message-State: ALoCoQl21/qDZwA34Y7LiIBi2H+iLEkEYCLjtWGyKNKiji65ZHw7IOtIPwXxF758a5KxjPWsCKyj
X-Received: by 10.50.13.4 with SMTP id d4mr4538243igc.1.1403193212968;
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si418779yhp.6.2014.06.19.08.53.32
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id CA6AD31C3F5;
	Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 6D7F1E0B50; Thu, 19 Jun 2014 08:53:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.438.g337c581
In-Reply-To: <1403193210-6028-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252161>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 1 +
 refs.c               | 1 -
 refs.h               | 5 ++---
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 405267f..1fd7a89 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -369,6 +369,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		update_refs_stdin();
 		ret = ref_transaction_commit(transaction, msg,
 					     UPDATE_REFS_DIE_ON_ERR);
+		ref_transaction_free(transaction);
 		return ret;
 	}
 
diff --git a/refs.c b/refs.c
index 6d841a0..d9cac6d 100644
--- a/refs.c
+++ b/refs.c
@@ -3509,7 +3509,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	ref_transaction_free(transaction);
 	return ret;
 }
 
diff --git a/refs.h b/refs.h
index cfd1832..7d946f6 100644
--- a/refs.h
+++ b/refs.h
@@ -219,8 +219,7 @@ enum action_on_err {
 
 /*
  * Begin a reference transaction.  The reference transaction must
- * eventually be commited using ref_transaction_commit() or freed by
- * calling ref_transaction_free().
+ * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_transaction_begin(void);
 
@@ -268,7 +267,7 @@ void ref_transaction_delete(struct ref_transaction *transaction,
 /*
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
- * problem.  The ref_transaction is freed by this function.
+ * problem.
  */
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   const char *msg, enum action_on_err onerr);
-- 
2.0.0.438.g337c581
