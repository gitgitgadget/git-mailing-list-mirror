From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 14/42] sequencer.c: use ref transactions for all ref updates
Date: Wed, 14 May 2014 14:16:48 -0700
Message-ID: <1400102236-30082-15-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgaT-0005tc-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbaENVRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:31 -0400
Received: from mail-ie0-f201.google.com ([209.85.223.201]:35156 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbaENVRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:25 -0400
Received: by mail-ie0-f201.google.com with SMTP id rp18so40769iec.4
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R4emTUteUY6B9/NYKfyjjo9YyE1eLM9G0Zu4Gu5vHK4=;
        b=XYE6MgneEc1TjgOUEV8CZAiAhZ/XzAcXPaMAsYD2HOXD51oyfqEAh904Wdv3u7ryBG
         Qz5ItiNH/wiqrT4yn7f4uj6bvPK6fxTDPYIVKiUh7Qk25TCcZo7al0ZFcPNxTcDb2OdR
         WzFswv8dMLycOP8pBTwQ+xZ3PF8dYy4S6YFOrE2aGswuJ081mKvRl6puvT3+FbJ4nnF/
         gZh6MNVTDWWMB1iae3Vf5hbUN6gGCjw1THuUxDXycC3atSHO0IN4K31iD7nY+YiSMfzB
         8jlWeKzuVelcYtZ+JZnMWnSOx7UCIM+roSaWlDRBh4tsNnOVRxbY6/xBFXjzJAKyAxbD
         RhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R4emTUteUY6B9/NYKfyjjo9YyE1eLM9G0Zu4Gu5vHK4=;
        b=U4akiLl6VoeWC00SCW7UZ7W/vMRcKi3/6uNxSb3WCjejSsOCTUxm8HaRIerTAC47os
         q97ujMEUJbE1gg9963Z62InneGEQxRoN3Yzv+NalKiYiemB/dJwJQVMLpNR2ZvJX2nMi
         UHNVCWPQtBBCtAOlTYrsxfzRuGdAXIaJDvd8o+uaG08okuuJnL+c7VXSRna0F4+n1BVC
         d3n6XB4rBo4tPp0CA1qiriUIDm/nSuQLu0u0Qf+a+4hcuxZw3dcSUhFAJ/EkNgKLmRWH
         JTbEQ9HjFtJg6iqxsOSIq/Zqu4yP5rm/bw043GKBeefW6cdpCWZwTZyFRFHrEpprIh1g
         WcDQ==
X-Gm-Message-State: ALoCoQnTQWUYASSLnALJt4VU5FTSTDOp+7h8qArtGKw3IdMtLwierQJE3HbkmFKbHNJaBZlPEhOz
X-Received: by 10.42.46.207 with SMTP id l15mr2683785icf.5.1400102244718;
        Wed, 14 May 2014 14:17:24 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id h18si146334yhj.0.2014.05.14.14.17.24
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:24 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 8BF7A31C1F8;
	Wed, 14 May 2014 14:17:24 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4E9E8E0973; Wed, 14 May 2014 14:17:24 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248971>

Change to use ref transactions for all updates to refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 0a80c58..9282a12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
 static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 			int unborn, struct replay_opts *opts)
 {
-	struct ref_lock *ref_lock;
+	struct ref_transaction *transaction;
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
+	struct strbuf err = STRBUF_INIT;
 
 	read_cache();
 	if (checkout_fast_forward(from, to, 1))
 		exit(1); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin();
+	if ((!transaction ||
+	    ref_transaction_update(transaction, "HEAD", to, from,
+				   0, !unborn)) ||
+	    (ref_transaction_commit(transaction, sb.buf, &err) &&
+	     !(transaction = NULL))) {
+		ref_transaction_rollback(transaction);
+		error(_("HEAD: Could not fast-forward: %s\n"), err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.0.rc3.471.g2055d11.dirty
