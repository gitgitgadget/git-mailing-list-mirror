From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 08/20] sequencer.c: use ref transactions for all ref updates
Date: Tue, 15 Jul 2014 16:34:06 -0700
Message-ID: <1405467258-24102-9-git-send-email-sahlberg@google.com>
References: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 01:34:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7CFP-0003Pj-9R
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 01:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbaGOXes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 19:34:48 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:39559 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934067AbaGOXeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 19:34:44 -0400
Received: by mail-qc0-f202.google.com with SMTP id i17so21422qcy.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 16:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F0bosn358W5u+PYHSaq8cuK1eUKX40VmmS0t4QEeO2w=;
        b=AgmFjlJEFv0ZAzCiL8hNcZ4oMLoAwVXmJHcuc5pQ5H1kqghvXaeN99eUJYjGLcfN6+
         NQry5/OzAu7vciPfTVsJuWMsccRaZ1pveoi7VlttBfJ1Mq31DUM5jQAZ8viAGrsP/hz6
         /99Rh0vsIoGLR+a3fnA36OICsUOIuxAAI6jmSv0t33Ol+W81VU9i/ydIG+g1zPkb811c
         C0UxyhxRK7munqddVE/uP27Rr8L7TvR/ZxhXVETXMA7nHUvk8b07EKdY7SF+eDX/+11o
         0KxdGKosp6jNXSdqgsLBsGS4RkstVfZbzs03X4bu377nbcaor0YmQGc+GcMVdHn5MbgN
         u3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F0bosn358W5u+PYHSaq8cuK1eUKX40VmmS0t4QEeO2w=;
        b=CDl0XQ5gMxbHxbRkKnxC7LFU9hiv7usLueaUqKx+gcd+UjVrMQvIV0LSKiDpJQEEk0
         clXIppxTWWjuA5205SlScP6gAia22gNZJGlaZf6BvNQXIjfv/FciN8eckGA4nIh7ZMEs
         miw//U7uirJHPNLptmxM6G0VEXfTYKHGz7T6vXfiDkESe+aGe/uLMnxdTMH/dSPdvyqF
         0RiyR1k/upt2M1R8mw2tDAvJNtHsVQZH9hQ/yC4ssPsQsaMvAzYYKSLekVaM3X56y2Cg
         1cP39lROQ17H75Y9k7C9CKCVrfmo+9L2hLUWyj9bX/zUA4R9zK6pCSM/FTAJds2eXnKJ
         IzFA==
X-Gm-Message-State: ALoCoQnE8YGubFa+PgupEliUL0XzGyhz5zRNSQ3B9xo1fmiMfdM/zGeTQ/OOLy4Me+T8CDhcqV2E
X-Received: by 10.236.128.112 with SMTP id e76mr10766388yhi.38.1405467263689;
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id z50si1060585yhb.3.2014.07.15.16.34.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 844015A4407;
	Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 59E6EE0CE0; Tue, 15 Jul 2014 16:34:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.481.gb244468
In-Reply-To: <1405467258-24102-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253631>

Change to use ref transactions for all updates to refs.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 sequencer.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9230474..cf17c69 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -272,23 +272,32 @@ static int error_dirty_index(struct replay_opts *opts)
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
-		exit(128); /* the callee should have complained already */
-	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
-					   0, NULL);
-	if (!ref_lock)
-		return error(_("Failed to lock HEAD during fast_forward_to"));
+		exit(1); /* the callee should have complained already */
 
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
-	ret = write_ref_sha1(ref_lock, to, sb.buf);
+
+	transaction = ref_transaction_begin(&err);
+	if (!transaction ||
+	    ref_transaction_update(transaction, "HEAD",
+				   to, unborn ? null_sha1 : from,
+				   0, 1, &err) ||
+	    ref_transaction_commit(transaction, sb.buf, &err)) {
+		ref_transaction_free(transaction);
+		error("%s", err.buf);
+		strbuf_release(&sb);
+		strbuf_release(&err);
+		return -1;
+	}
 
 	strbuf_release(&sb);
-	return ret;
+	ref_transaction_free(transaction);
+	return 0;
 }
 
 static int do_recursive_merge(struct commit *base, struct commit *next,
-- 
2.0.1.442.g7fe6834.dirty
